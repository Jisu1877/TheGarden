package com.spring.javagreenS_ljs;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;
import com.spring.javagreenS_ljs.service.CategoryAdminService;
import com.spring.javagreenS_ljs.service.InquiryService;
import com.spring.javagreenS_ljs.service.ItemAdminService;
import com.spring.javagreenS_ljs.service.NoticeService;
import com.spring.javagreenS_ljs.service.OfflineStoreService;
import com.spring.javagreenS_ljs.service.UserService;
import com.spring.javagreenS_ljs.vo.CategoryGroupVO;
import com.spring.javagreenS_ljs.vo.InquiryVO;
import com.spring.javagreenS_ljs.vo.ItemVO;
import com.spring.javagreenS_ljs.vo.NoticeVO;
import com.spring.javagreenS_ljs.vo.OfflineStoreVO;
import com.spring.javagreenS_ljs.vo.WishlistVO;

@Controller
@RequestMapping("/main")
public class MainController {
	
	@Autowired
	CategoryAdminService categoryAdminService; 
	
	@Autowired
	ItemAdminService itemAdminService;
	
	@Autowired
	UserService userService;
	
	@Autowired
	OfflineStoreService offlineStoreService;
	
	@Autowired
	InquiryService inquiryService;
	
	@Autowired
	NoticeService noticeService;
	
	//홈화면 호출
	@RequestMapping(value ="/mainHome", method = RequestMethod.GET)
	public String mainHomeGet(Model model, HttpSession session) {
		//카테고리 가져오기
		ArrayList<CategoryGroupVO> categoryVOS = categoryAdminService.getCategoryOnlyUseInfor();
		model.addAttribute("categoryVOS", categoryVOS);
		
		//상품 가져오기(기본)
		ArrayList<ItemVO> itemVOS =  itemAdminService.getItemAllInforOnlyDisplay();
		model.addAttribute("itemVOS", itemVOS);
		
		//상품 가져오기(인기도순)
		ArrayList<ItemVO> itemPopularityList = itemAdminService.getItemPopularitySort();
		model.addAttribute("itemPopularityList", itemPopularityList);
		
		//상품 가져오기(누적 판매순)
		ArrayList<ItemVO> itemSaleList = itemAdminService.getItemSaleSort();
		model.addAttribute("itemSaleList", itemSaleList);
		
		//상품 가져오기(낮은 가격순)
		ArrayList<ItemVO> itemLowPriceList = itemAdminService.getItemLowPriceSort();
		model.addAttribute("itemLowPriceList", itemLowPriceList);
		
		//상품 가져오기(최신 등록순)
		ArrayList<ItemVO> itemNewList = itemAdminService.getItemNewSort();
		model.addAttribute("itemNewList", itemNewList);
		
		//상품 가져오기(리뷰 많은순)
		ArrayList<ItemVO> itemLotsReviewsList = itemAdminService.getItemLotsReviewsSort();
		model.addAttribute("itemLotsReviewsList", itemLotsReviewsList);
		
		//상품 가져오기(평점 높은순)
		ArrayList<ItemVO> itemRatingList = itemAdminService.getItemRatingSort();
		model.addAttribute("itemRatingList", itemRatingList);
		
		//베스트 상품 가져오기
		ArrayList<ItemVO> itemBestList = itemAdminService.getBestItemAllInforOnlyDisplay();
		model.addAttribute("itemBestList", itemBestList);
		
		String user_id = (String)session.getAttribute("sUser_id");
		if(user_id != null) {
			//wishlist 가져오기
			int user_idx = (int) session.getAttribute("sUser_idx");
			ArrayList<WishlistVO> wishlist = userService.getUserWishList(user_idx);
			model.addAttribute("wishlist", wishlist);
			model.addAttribute("loginFlag", "yse");
		}
		else {
			model.addAttribute("loginFlag", "no");
		}
		
		//오프라인 매장 정보 가져오기
		ArrayList<OfflineStoreVO> storeList = offlineStoreService.getStoreList();
		Gson gson = new Gson();
		String storeJson = gson.toJson(storeList);
		model.addAttribute("storeJson", storeJson);
		
		//팝업공지사항 정보 가져오기
		ArrayList<NoticeVO> popupList =  noticeService.getPopupList();
		model.addAttribute("popupList", popupList);
		return "main/home";
	}
	
	@RequestMapping(value = "/close", method = RequestMethod.GET)
	public String closeGet() {
		return "main/close";
	}
	
	@RequestMapping(value = "/close2", method = RequestMethod.GET)
	public String close2Get() {
		return "main/close2";
	}
	
	//카테고리 그룹 검색
	@RequestMapping(value = "/categorySearch", method = RequestMethod.GET)
	public String categorySearchGet(@RequestParam(name="code", required = false) String code,
			@RequestParam(name="name", required = false) String name, Model model) {
		ArrayList<ItemVO> vos = itemAdminService.getItemSearch("item_code", code);
		model.addAttribute("vos", vos);
		model.addAttribute("name", name);
		return "main/SearchResult";
	}
	
	//카테고리 검색
	@RequestMapping(value = "/categorySearch2", method = RequestMethod.GET)
	public String categorySearch2Get(@RequestParam(name="code", required = false) String code,
			@RequestParam(name="name", required = false) String name, 
			@RequestParam(name="idx", required = false) String idx, 
			@RequestParam(name="groupName", required = false) String groupName, 
			Model model) {
		String item_code = code + "_" + idx;
		String strGruopName = groupName + " >";
		ArrayList<ItemVO> vos = itemAdminService.getItemSearch("item_code", item_code);
		
		
		model.addAttribute("vos", vos);
		model.addAttribute("name", name);
		model.addAttribute("groupName", strGruopName);
		return "main/SearchResult";
	}
	
	//베스트 상품 
	@RequestMapping(value = "/bestItem", method = RequestMethod.GET)
	public String bestItemGet(Model model) {
		//카테고리 가져오기
		ArrayList<CategoryGroupVO> categoryVOS = categoryAdminService.getCategoryOnlyUseInfor();
		model.addAttribute("categoryVOS", categoryVOS);
		
		//상품 가져오기
		ArrayList<ItemVO> itemVOS =  itemAdminService.getItemAllInforOnlyDisplay();
		model.addAttribute("itemVOS", itemVOS);
		
		//베스트 상품 가져오기
		ArrayList<ItemVO> itemBestList = itemAdminService.getBestItemAllInforOnlyDisplay();
		
		model.addAttribute("itemBestList", itemBestList);
		return "main/bestItem";
	}
	
	//1:1 문의 창 호출
	@RequestMapping(value = "/inquiryInsert", method = RequestMethod.GET)
	public String inquiryInsertGet() {
		
		return "main/qnaInsert";
	}
	
	//1:1 문의 등록
	@RequestMapping(value = "/qnaInsert", method = RequestMethod.POST)
	public String inquiryInsertPost(InquiryVO vo, HttpSession session) {
		String user_id = (String)session.getAttribute("sUser_id");
		int user_idx = (int) session.getAttribute("sUser_idx");
		
		vo.setUser_id(user_id);
		vo.setUser_idx(user_idx);
		
		inquiryService.setInquiryInsert(vo);
		
		return "redirect:/msg/inquiryInsertOk";
	}
	
	//오프라인 매장
	@RequestMapping(value = "/offlineStore", method = RequestMethod.GET)
	public String offlineStoreGet(Model model) {
		//오프라인 매장 정보 가져오기
		ArrayList<OfflineStoreVO> storeList = offlineStoreService.getStoreList();
		Gson gson = new Gson();
		String storeJson = gson.toJson(storeList);
		model.addAttribute("storeJson", storeJson);
		return "main/offlineStore";
	}
}
