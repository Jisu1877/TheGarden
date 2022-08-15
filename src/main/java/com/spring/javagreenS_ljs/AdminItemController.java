package com.spring.javagreenS_ljs;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.Gson;
import com.spring.javagreenS_ljs.pagination.PageVO;
import com.spring.javagreenS_ljs.pagination.PagingProcess;
import com.spring.javagreenS_ljs.service.CategoryAdminService;
import com.spring.javagreenS_ljs.service.ItemAdminService;
import com.spring.javagreenS_ljs.service.OrderService;
import com.spring.javagreenS_ljs.service.UserService;
import com.spring.javagreenS_ljs.vo.CategoryGroupVO;
import com.spring.javagreenS_ljs.vo.CategoryVO;
import com.spring.javagreenS_ljs.vo.ItemImageVO;
import com.spring.javagreenS_ljs.vo.ItemOptionVO;
import com.spring.javagreenS_ljs.vo.ItemVO;
import com.spring.javagreenS_ljs.vo.OrderListVO;
import com.spring.javagreenS_ljs.vo.UserVO;

@Controller
@RequestMapping("/admin/item")
public class AdminItemController {
	
	@Autowired
	ItemAdminService itemAdminService;
	
	@Autowired
	CategoryAdminService categoryAdminService;
	
	@Autowired
	UserService userService;
	
	@Autowired
	PagingProcess pagingProcess;
	
	@Autowired
	OrderService orderService;
	
	@RequestMapping(value = "/itemInsert", method = RequestMethod.GET)
	public String itemInsertGet(Model model, HttpSession session) {
		String user_id = (String)session.getAttribute("sUser_id");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInfor(user_id);
		model.addAttribute("userVO", userVO);
		//대분류 카테고리 가져오기
		ArrayList<CategoryGroupVO> categoryGroupVOS = categoryAdminService.getCategoryGroupInforOnlyUse();
		
		model.addAttribute("categoryVOS", categoryGroupVOS);
		return "admin/item/itemInsert";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getCategory", method = RequestMethod.POST)
	public ArrayList<CategoryVO> getCategoryPost(int category_group_idx) {
		//중분류 카테고리 가져오기
		ArrayList<CategoryVO> categoryVOS = categoryAdminService.getCategoryInfor(category_group_idx);
		return categoryVOS;
	}
	
	//상품등록 처리
	@RequestMapping(value = "/itemInsert", method = RequestMethod.POST)
	public String itemInsertPost(ItemVO itemVO, MultipartHttpServletRequest multipart, HttpSession session) {
		//관리자 ID 저장
		String adminID = (String)session.getAttribute("sUser_id");
		itemVO.setCreated_admin_id(adminID);
		
		//content에 이미지가 저장되어있다면, 저장된 이미지만을 /resources/data/ckeditor/itemContent/ 폴더에 저장시켜준다.
		itemAdminService.imgCheck(itemVO.getDetail_content());
		
		//이미지 복사작업이 끝나면, itemContent폴더에 실제로 저장될 파일명을 DB에 저장시켜준다.
		itemVO.setDetail_content(itemVO.getDetail_content().replace("/data/ckeditor/", "/data/ckeditor/itemContent/"));
		
		//상품등록 처리를 위한 작업들
		itemAdminService.setItemInsert(itemVO, multipart);
		
		return "redirect:/msg/itemInsertOk";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getItemInforCopy", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String getItemInforCopy(String item_name) {
		ArrayList<ItemVO> vos = itemAdminService.getItemSearch("item_name" , item_name);
		Gson gson = new Gson();
		String vosJson = gson.toJson(vos);
		return vosJson;
	}
	
	@RequestMapping(value = "/itemList", method = RequestMethod.GET)
	public String itemListGet(@ModelAttribute("searchVO") ItemVO searchVO, Model model, HttpSession session) {
		String user_id = (String)session.getAttribute("sUser_id");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInfor(user_id);
		model.addAttribute("userVO", userVO);
		
		//페이징처리
		int total = itemAdminService.totRecCnt(searchVO);
		pagingProcess.pageProcess3(searchVO, total);
		
		//상품 목록 불러오기
		ArrayList<ItemVO> vos = itemAdminService.getItemListSearch(searchVO);
		
		model.addAttribute("vos", vos);
		return "admin/item/itemList";
	}
	
	//상품 조회 창 호출
	@RequestMapping(value = "/itemInquire", method = RequestMethod.GET)
	public String itemInquireGet(Model model, @RequestParam(name="item_code", defaultValue = "NO", required = false) String item_code, HttpSession session) {
		if(item_code.equals("NO")) {
			return "redirect:/msg/itemInquireNo";
		}
		//상품정보 + 상품정보고시 정보 가져오기
		ItemVO itemVO = itemAdminService.getItemSameSearch("item_code", item_code);
		
		//상품카테고리 코드 분리
		String[] code = item_code.split("_");
		int category_idx = Integer.parseInt(code[1]);
		
		//카테고리 검색(카테고리 명을 알아오기 위함)
		CategoryGroupVO categoryGroupVO = categoryAdminService.getCategoryGroupInfor(code[0]);
		itemVO.setCategory_group_name(categoryGroupVO.getCategory_group_name());
		//중분류가 존재하면..
		if(category_idx != 0) {
			CategoryVO categoryVO = categoryAdminService.getCategoryInfor2(category_idx);	
			itemVO.setCategory_name(categoryVO.getCategory_name());
		}
		else {
			itemVO.setCategory_name("NO");
		}
		
		//옵션정보 가져와서 Set
		ArrayList<ItemOptionVO> optionList = itemAdminService.getItemOptionInfor(itemVO.getItem_idx());
		itemVO.setItemOptionList(optionList);
		
		//이미지정보 가져와서 Set
		ArrayList<ItemImageVO> imageList = itemAdminService.getItemImageInfor(itemVO.getItem_idx());
		itemVO.setItemImageList(imageList);
		
		String user_id = (String)session.getAttribute("sUser_id");
		int user_idx = (int) session.getAttribute("sUser_idx");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInfor(user_id);
		model.addAttribute("userVO", userVO);
		
		model.addAttribute("itemVO" ,itemVO);
		return "admin/item/itemInquire";
	}
	
	//상품 수정 창 호출
	@RequestMapping(value = "/itemUpdate", method = RequestMethod.GET)
	public String itemUpdateGet(Model model, @RequestParam(name="item_code", defaultValue = "NO", required = false) String item_code, HttpSession session) {
		if(item_code.equals("NO")) {
			return "redirect:/msg/itemUpdateNo";
		}
		//상품정보 + 상품정보고시 정보 가져오기
		ItemVO itemVO = itemAdminService.getItemSameSearch("item_code", item_code);
		
		//수정창으로 들어올 때 원본파일에 그림파일이 존재한다면, 현재폴더(itemContent)의 그림파일을 ckeditor폴더로 복사시켜둔다.
		if(itemVO.getDetail_content().indexOf("src=\"/") != -1) {
			itemAdminService.imgCheckUpdate(itemVO.getDetail_content());
		}
		//상품카테고리 코드 분리 
		String[] code = item_code.split("_"); 
		int category_idx = Integer.parseInt(code[1]);
		 
	    //카테고리 검색(카테고리 명을 알아오기 위함) 
		CategoryGroupVO categoryGroupVO = categoryAdminService.getCategoryGroupInfor(code[0]);
		itemVO.setCategory_group_name(categoryGroupVO.getCategory_group_name());
		 
		//중분류가 존재하면.. 
		if(category_idx != 0) { 
			CategoryVO categoryVO = categoryAdminService.getCategoryInfor2(category_idx);
			itemVO.setCategory_name(categoryVO.getCategory_name()); 
		} 
		else {
			 itemVO.setCategory_name("NO"); 
		}
		 
		//옵션정보 가져와서 Set 
		ArrayList<ItemOptionVO> optionList = itemAdminService.getItemOptionInfor(itemVO.getItem_idx());
		itemVO.setItemOptionList(optionList);
		
		//이미지정보 가져와서 Set 
		ArrayList<ItemImageVO> imageList = itemAdminService.getItemImageInfor(itemVO.getItem_idx());
	    itemVO.setItemImageList(imageList);
	    

		String user_id = (String)session.getAttribute("sUser_id");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInfor(user_id);
		model.addAttribute("userVO", userVO);
	    
	    model.addAttribute("itemVO" ,itemVO);
		return "admin/item/itemUpdate";
	}
	
	//추가 이미지 삭제
	@ResponseBody
	@RequestMapping(value = "/itemImageDel", method = RequestMethod.POST)
	public String itemImageDelPost(int item_image_idx, String image_name) {
		itemAdminService.setItemImageDelete(item_image_idx, image_name);
		
		return "1";
	}
	
	
	//상품 수정 처리
	@Transactional(rollbackFor = Exception.class) //(트랜잭션 처리)
	@RequestMapping(value = "/itemUpdate", method = RequestMethod.POST)
	public String itemUpdatePost(ItemVO itemVO, MultipartHttpServletRequest multipart) {
		//수정전 content 알아오기
		ItemVO oriVO = itemAdminService.getItemContent(itemVO.getItem_idx());
		if(!oriVO.getDetail_content().equals(itemVO.getDetail_content())) {
			//itemContent 폴더에 복사되어있는 이미지들 중 해당 item_idx 의 detail_content 이미지인 경우 삭제처리한다.
			//먼저 삭제를 싹 해주고 다시 복사저장해줄 계획.
			if(oriVO.getDetail_content().indexOf("src=\"/") != -1) { //이미지 파일이 1개라도 content에 있을 시!
				itemAdminService.imgDelete(oriVO.getDetail_content());
			}
			//파일 복사 전에 원본파일의 위치가 'ckeditor/itemContent'폴더였던 것을 'ckeditor'폴더로 변경시켜두어야 한다.
			itemVO.setDetail_content(itemVO.getDetail_content().replace("/data/ckeditor/itemContent/", "/data/ckeditor/"));
			
			//앞의 준비작업이 완료되면, 수정된 그림(복사된그림)을 다시 itemContent폴더에 복사처리한다.(/data/ckeditor/ -> /data/ckeditor/itemContent/)
			//이 작업은 처음 게시글을 올릴 때의 파일복사 작업과 동일한 작업이다.
			itemAdminService.imgCheck(itemVO.getDetail_content());
			
			//복사가 완료되었기에 다시 content의 경로를 바꿔준다.
			itemVO.setDetail_content(itemVO.getDetail_content().replace("/data/ckeditor/", "/data/ckeditor/itemContent/"));
		}
		
		//상품수정 처리를 위한 작업들
		itemAdminService.setItemUpdate(itemVO, multipart, oriVO.getItem_image());
		
		return "redirect:/msg/itemUpdatetOk";
	}
	
	//상품 삭제 처리
	@RequestMapping(value = "/itemDelete", method = RequestMethod.GET)
	public String itemDeleteGet(@RequestParam(name="item_code", defaultValue = "NO", required = false) String item_code) {
		if(item_code.equals("NO")) {
			return "redirect:/msg/itemDeleteNo";
		}
		//item_code로 item_idx알아오기
		int item_idx = itemAdminService.getItemIdx(item_code);
		
		//해당 상품으로 배송 전(결제완료 / 주문확인)인 주문 내역이 있는지 확인
		ArrayList<OrderListVO> orderList = orderService.getOrderListItemIdx(item_idx);
		
		if(!orderList.isEmpty()) {
			return "redirect:/msg/itemDeleteNo2";
		}
		
		itemAdminService.setItemDelete(item_code);
		
		return "redirect:/msg/itemDeleteOk";
	}
	
	@ResponseBody
	@RequestMapping(value = "/displayFlagSW", method = RequestMethod.POST)
	public String displayFlagSWPost(int item_idx, String display_flag) {
		String flag = null;
		if(display_flag.equals("y")) {
			flag = "n";
		}
		else {
			flag = "y";
		}
		itemAdminService.setItemDisplayUpdate(item_idx,flag);
		return "1";
	}
	
	@ResponseBody
	@RequestMapping(value = "/deleteOption", method = RequestMethod.POST)
	public String deleteOptionPost(int item_option_idx) {
		itemAdminService.setdeleteOption(item_option_idx);
		return "1";
	}
}
