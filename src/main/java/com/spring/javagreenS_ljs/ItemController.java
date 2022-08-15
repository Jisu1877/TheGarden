package com.spring.javagreenS_ljs;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;
import com.spring.javagreenS_ljs.service.CategoryAdminService;
import com.spring.javagreenS_ljs.service.ItemAdminService;
import com.spring.javagreenS_ljs.service.ItemQnaService;
import com.spring.javagreenS_ljs.service.ItemService;
import com.spring.javagreenS_ljs.service.ReviewService;
import com.spring.javagreenS_ljs.service.UserService;
import com.spring.javagreenS_ljs.vo.CategoryGroupVO;
import com.spring.javagreenS_ljs.vo.CategoryVO;
import com.spring.javagreenS_ljs.vo.ItemImageVO;
import com.spring.javagreenS_ljs.vo.ItemOptionVO;
import com.spring.javagreenS_ljs.vo.ItemQnaVO;
import com.spring.javagreenS_ljs.vo.ItemVO;
import com.spring.javagreenS_ljs.vo.RecentViewsVO;
import com.spring.javagreenS_ljs.vo.ReviewVO;
import com.spring.javagreenS_ljs.vo.WishlistVO;

@Controller
@RequestMapping("/item")
public class ItemController {
	
	@Autowired
	ItemService itemService;
	
	@Autowired
	ItemAdminService itemAdminService;
	
	@Autowired
	CategoryAdminService categoryAdminService;
	
	@Autowired
	UserService userService;
	
	@Autowired
	ReviewService reviewService;
	
	@Autowired
	ItemQnaService itemQnaService;
	
	@RequestMapping(value = "/itemView", method = RequestMethod.GET)
	public String itemViewGet(Model model, HttpSession session,
			@RequestParam(name="item_code", defaultValue = "NO", required = false) String item_code) {
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
		
		//카테고리 대분류 모든 정보 가져오기
		ArrayList<CategoryGroupVO> categoryGroupList = categoryAdminService.getCategoryGroupInforOnlyUse();
		itemVO.setCategoryGroupList(categoryGroupList);
		
		//옵션정보 가져와서 Set
		ArrayList<ItemOptionVO> optionList = itemAdminService.getItemOptionInfor(itemVO.getItem_idx());
		itemVO.setItemOptionList(optionList);
		
		//이미지정보 가져와서 Set
		ArrayList<ItemImageVO> imageList = itemAdminService.getItemImageInfor(itemVO.getItem_idx());
		itemVO.setItemImageList(imageList);
		
		Gson gson = new Gson();
		String itemJson = gson.toJson(itemVO);
		
		//리뷰정보 가져오기
		ArrayList<ReviewVO> reviewList = reviewService.getReviewList(itemVO.getItem_idx());
		
		//리뷰 평점 평균 가져오기
		ReviewVO rating = reviewService.getReviewRating(itemVO.getItem_idx());
		
		//평점 분포 가져오기
		ArrayList<ReviewVO> reviewChartValue = reviewService.getReviewChartValue(itemVO.getItem_idx());
		String reviewChartJson = gson.toJson(reviewChartValue);
		
		//상품 문의 정보 가져오기
		ArrayList<ItemQnaVO> itemQnaList = itemQnaService.getItemQnaList(itemVO.getItem_idx());
		model.addAttribute("itemQnaList", itemQnaList);
		
		//회원의 wishlist 가져오기
		String user_id = (String)session.getAttribute("sUser_id");
		if(user_id != null) {
			int user_idx = (int) session.getAttribute("sUser_idx");
			ArrayList<WishlistVO> wishlist = userService.getUserWishList(user_idx);
			model.addAttribute("wishlist", wishlist);
			model.addAttribute("loginFlag", "yes");
			
			//같은 상품은 삭제처리
			userService.setRecentViewsDelete(user_idx,itemVO.getItem_idx());
			
			//최근 본 상품 등록
			userService.setRecentViewsInsert(user_idx,itemVO.getItem_idx());
			
			//최근 본 상품 3개만 가지고 오기
			ArrayList<RecentViewsVO> recentList = userService.getRecentViews(user_idx,3);
			model.addAttribute("recentList", recentList);
		}
		else {
			model.addAttribute("loginFlag", "no");
		}
		model.addAttribute("user_id", user_id);
		model.addAttribute("category_group_code", code[0]);
		model.addAttribute("category_idx", code[1]);
		model.addAttribute("itemVO" ,itemVO);
		model.addAttribute("itemJson", itemJson);
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("rating", rating);
		model.addAttribute("reviewChartJson", reviewChartJson);
		
		return "item/itemView";
	}
	
	
	//키워드 검색
	@RequestMapping(value = "/keywordSearch", method = RequestMethod.GET)
	public String keywordSearchGet(String keyword, Model model) {
		ArrayList<ItemVO> vos = itemAdminService.getItemSearch("item_keyword",keyword);
		
		model.addAttribute("vos", vos);
		model.addAttribute("name", keyword);
		return "main/SearchResult";
	}
	
}
