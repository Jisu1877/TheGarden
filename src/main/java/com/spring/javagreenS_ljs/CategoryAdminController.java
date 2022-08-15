package com.spring.javagreenS_ljs;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javagreenS_ljs.service.AdminService;
import com.spring.javagreenS_ljs.service.CategoryAdminService;
import com.spring.javagreenS_ljs.service.ItemAdminService;
import com.spring.javagreenS_ljs.service.UserService;
import com.spring.javagreenS_ljs.vo.CategoryGroupVO;
import com.spring.javagreenS_ljs.vo.CategoryVO;
import com.spring.javagreenS_ljs.vo.ItemVO;
import com.spring.javagreenS_ljs.vo.UserVO;

@Controller
@RequestMapping("/admin/category")
public class CategoryAdminController {
	
	@Autowired
	CategoryAdminService categoryAdminService;
	
	@Autowired
	ItemAdminService itemAdminService;
	
	@Autowired
	UserService userService;
	
	//카테고리 화면 호출
	@RequestMapping(value = "/categoryHome", method = RequestMethod.GET)
	public String categoryHomeGet(Model model, HttpSession session) {
		ArrayList<CategoryGroupVO> vos = categoryAdminService.getCategoryGroupInfor();
		model.addAttribute("vos", vos);
		
		String user_id = (String)session.getAttribute("sUser_id");
		int user_idx = (int) session.getAttribute("sUser_idx");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInfor(user_id);
		model.addAttribute("userVO", userVO);
	    
		return "admin/item/categoryHome";
	}
	
	@ResponseBody
	@RequestMapping(value = "/category_group_input", method = RequestMethod.POST)
	public String category_group_inputPost(String category_group_name) {
		//카테고리 그룹 코드 만들기(UUID)
		UUID uid = UUID.randomUUID();
		String category_group_code = uid.toString().substring(0,8);
	
		//만든 코드가 겹치는 지 확인
		CategoryGroupVO vo = categoryAdminService.getCategoryGroupInfor(category_group_code);
		
		//겹치지 않을 때까지 새로운 코드를 만들기
		if(vo != null) {
			while(true) {
				UUID uid2 = UUID.randomUUID();
				category_group_code = uid2.toString().substring(0,8);
				CategoryGroupVO vo2 = categoryAdminService.getCategoryGroupInfor(category_group_code);
				if(vo2 == null) {
					break;
				}
			}
		}
		vo = new CategoryGroupVO();
		vo.setCategory_group_code(category_group_code);
		vo.setCategory_group_name(category_group_name);
		//노출 최대레벨 알아오기
		int category_MaxLevel = categoryAdminService.getCategoryMaxLevel();
		int category_group_level = category_MaxLevel + 1;
		vo.setCategory_group_level(category_group_level);
		
		//카테고리 등록처리
		categoryAdminService.setCategoryGroup(vo);
		return "1";
	}
	
	@ResponseBody
	@RequestMapping(value = "/category_group_useNot", method = RequestMethod.POST)
	public String category_group_useNotPost(int category_group_idx, int category_group_level, String category_group_code) {
		//해당 카테고리로 등록된 상품이 있는지 확인
		ArrayList<ItemVO> itemVOS = itemAdminService.getItemAllInforOnlyDisplay();
		
		for(int i=0; i<itemVOS.size(); i++) {
			String item_code = itemVOS.get(i).getItem_code();
			
			String[] code = item_code.split("_"); 
			String category = code[0];
			
			if(category_group_code.equals(category)) {
				return "0";
			}
		}
		//카테고리 사용안함 처리 && 노출 레벨(0)로 조정
		categoryAdminService.setCategoryUseNot(category_group_idx);
		
		//노출 순서 조정 알고리즘
		ArrayList<CategoryGroupVO> vos = categoryAdminService.getCategoryGroupInfor();
		//int cnt = 0;
		int changeLevel = 0;
		int changeValue = 0;
		for(int i=0; i<vos.size(); i++) {
			/*
			 * if(vos.size() == cnt + 1) { break; }
			 */
			
			if (vos.get(i).getCategory_group_level() <= category_group_level) {
				continue;
			}
			
			CategoryGroupVO item = vos.get(i);
			changeLevel = item.getCategory_group_level();
			changeValue = item.getCategory_group_level() - 1;
			changeValue = changeValue < 0 ? 0 : changeValue;
			categoryAdminService.setCategoryLevelSort(changeLevel, changeValue);
			/*
			int beforeLevel = vos.get(i).getCategory_group_level();
			if(beforeLevel != 0) {
				int nextLevel = vos.get(i+1).getCategory_group_level();
				if((beforeLevel + 1) != nextLevel) {
					changeLevel = beforeLevel + 2;
					changeValue = beforeLevel + 1;
					adminService.setCategoryLevelSort(changeLevel, changeValue);
				}
				else if(beforeLevel == changeLevel) {
					changeLevel = beforeLevel + 1;
					changeValue = beforeLevel;
					adminService.setCategoryLevelSort(changeLevel, changeValue);
				}
			}
			cnt++;
			
			*/
		}
		
		return "1";
	}
	
	@ResponseBody
	@RequestMapping(value = "/category_group_use", method = RequestMethod.POST)
	public String category_group_usePost(int category_group_idx) {
		//노출 최대레벨 알아오기
		int category_MaxLevel = categoryAdminService.getCategoryMaxLevel();
		int category_group_level = category_MaxLevel + 1;
		
		CategoryGroupVO vo = new CategoryGroupVO();
		vo.setCategory_group_idx(category_group_idx);
		vo.setCategory_group_level(category_group_level);
		
		//카테고리 사용처리 및 레벨 조정(0 -> 최하위 순위 레벨)
		categoryAdminService.setCategoryUse(vo);
		return "1";
	}
	
	@ResponseBody
	@RequestMapping(value =  "/category_group_update", method = RequestMethod.POST)
	public String category_group_update(CategoryGroupVO vo, int original_level) {
		//입력받은 level를 갖고 있는 레코드 검색
		CategoryGroupVO vo2 = categoryAdminService.getCategoryGroupInfor(vo.getCategory_group_level());
		
		if(vo2 != null) {
			//vo2의 레벨을 변경
			categoryAdminService.setCategoryLevelSort(vo2.getCategory_group_level() , original_level);
		}
		
		//vo의 정보로 업데이트 처리
		categoryAdminService.setCategoryUpate(vo);
		
		return "1";
	}
	
	//최대 노출 레벨 알아오기
	@ResponseBody
	@RequestMapping(value =  "/category_group_MaxLevel", method = RequestMethod.POST)
	public String category_group_MaxLevel() {
		int category_MaxLevel = categoryAdminService.getCategoryMaxLevel();
		String strMaxLevel = String.valueOf(category_MaxLevel);
		return strMaxLevel;
	}
	
	@ResponseBody
	@RequestMapping(value =  "/category_group_delete", method = RequestMethod.POST)
	public String category_group_delete(int category_group_idx, int category_group_level, String category_group_code) {
		//해당 카테고리로 등록된 상품이 있는지 확인
		ArrayList<ItemVO> itemVOS = itemAdminService.getItemList();
		
		for(int i=0; i<itemVOS.size(); i++) {
			String item_code = itemVOS.get(i).getItem_code();
			
			String[] code = item_code.split("_"); 
			String category = code[0];
			
			if(category_group_code.equals(category)) {
				return "0";
			}
		}
		
		//삭제처리
		categoryAdminService.setCategoryGroupDelete(category_group_idx);
		
		if(category_group_level != 0) {
			//노출 순서 조정 알고리즘
			ArrayList<CategoryGroupVO> vos = categoryAdminService.getCategoryGroupInfor();
			int changeLevel = 0;
			int changeValue = 0;
			for(int i=0; i<vos.size(); i++) {
				
				if (vos.get(i).getCategory_group_level() <= category_group_level) {
					continue;
				}
				
				CategoryGroupVO item = vos.get(i);
				changeLevel = item.getCategory_group_level();
				changeValue = item.getCategory_group_level() - 1;
				changeValue = changeValue < 0 ? 0 : changeValue;
				categoryAdminService.setCategoryLevelSort(changeLevel, changeValue);
			}
		}
		
		return "1";
	}
	
	@ResponseBody
	@RequestMapping(value = "/category_input", method = RequestMethod.POST)
	public String category_inputPost(CategoryVO vo) {
		//중분류 등록처리
		categoryAdminService.setCategory(vo);
		return "1";
	}
	
	@ResponseBody
	@RequestMapping(value = "/category_delete", method = RequestMethod.POST)
	public String category_deletePost(int category_idx) {
		//해당 카테고리로 등록된 상품이 있는지 확인
		ArrayList<ItemVO> itemVOS = itemAdminService.getItemList();
		
		for(int i=0; i<itemVOS.size(); i++) {
			String item_code = itemVOS.get(i).getItem_code();
			
			String[] code = item_code.split("_"); 
			int category = Integer.parseInt(code[1]);
			
			if(category_idx == category) {
				return "0";
			}
		}
		
		//중분류 삭제처리
		categoryAdminService.setCategoryDelete(category_idx);
		return "1";
	}
	
	
	//중분류 사용중지처리
	@ResponseBody
	@RequestMapping(value = "/category_useNot", method = RequestMethod.POST)
	public String category_useNotPost(int category_idx) {
		//해당 카테고리로 등록된 상품이 있는지 확인
		ArrayList<ItemVO> itemVOS = itemAdminService.getItemAllInforOnlyDisplay();
		
		for(int i=0; i<itemVOS.size(); i++) {
			String item_code = itemVOS.get(i).getItem_code();
			
			String[] code = item_code.split("_"); 
			int category = Integer.parseInt(code[1]);
			
			if(category_idx == category) {
				return "0";
			}
		}
		
		//중분류 사용중지처리
		categoryAdminService.setCategoryUseNot2(category_idx);
		return "1";
	}
	
	@ResponseBody
	@RequestMapping(value = "/category_updateOk", method = RequestMethod.POST)
	public String category_updateOkPost(int category_idx, String category_name) {
		
		//중분류 수정처리
		categoryAdminService.setCategoryUpate2(category_idx,category_name);
		return "1";
	}
	
	@ResponseBody
	@RequestMapping(value = "/category_use", method = RequestMethod.POST)
	public String category_usePost(int category_idx) {
		
		//중분류 사용 처리
		categoryAdminService.setCategoryUse2(category_idx);
		return "1";
	}
	
	
	
	
}
