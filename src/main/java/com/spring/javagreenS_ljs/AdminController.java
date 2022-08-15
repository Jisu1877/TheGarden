package com.spring.javagreenS_ljs;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.Gson;
import com.spring.javagreenS_ljs.pagination.PagingProcess;
import com.spring.javagreenS_ljs.service.InquiryService;
import com.spring.javagreenS_ljs.service.ItemQnaService;
import com.spring.javagreenS_ljs.service.OfflineStoreService;
import com.spring.javagreenS_ljs.service.PlantBoardService;
import com.spring.javagreenS_ljs.service.StatsService;
import com.spring.javagreenS_ljs.service.UserService;
import com.spring.javagreenS_ljs.vo.ItemQnaVO;
import com.spring.javagreenS_ljs.vo.PlantBoardVO;
import com.spring.javagreenS_ljs.vo.StatsOrderListVO;
import com.spring.javagreenS_ljs.vo.UserVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	OfflineStoreService offlineStoreService;
	
	@Autowired
	PagingProcess pagingProcess;
	
	@Autowired
	ItemQnaService itemQnaService;
	
	@Autowired
	StatsService statsService;
	
	@Autowired
	InquiryService inquiryService;
	
	@Autowired
	PlantBoardService boardService;
	
	//관리자 홈 호출
	@RequestMapping(value = "/mainHome", method = RequestMethod.GET)
	public String mainHomeGet(HttpSession session, Model model) {
		String user_id = (String)session.getAttribute("sUser_id");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInfor(user_id);
		model.addAttribute("userVO", userVO);
		
		//상품 문의 내용 가져오기
		ArrayList<ItemQnaVO> itemQnaList = itemQnaService.getitemQnaListLimit5();
		model.addAttribute("itemQnaList", itemQnaList);
		
		//식물 상담실 내용 가져오기
		ArrayList<PlantBoardVO> plantBoardList = boardService.getBoardListLimit5();
		model.addAttribute("plantBoardList", plantBoardList);
		
		// 통계 가져오기
		List<StatsOrderListVO> orderCountList = statsService.getOrderCountByStatus();
		int cancelRequestCount = statsService.getOrderCancelRequestCount();
		int exchangeCount = statsService.getOrderExchangeCount();
		int returnCount = statsService.getOrderReturnCount();
		model.addAttribute("orderCountList", orderCountList);
		model.addAttribute("cancelRequestCount", cancelRequestCount);
		model.addAttribute("exchangeCount", exchangeCount);
		model.addAttribute("returnCount", returnCount);
		
		Gson gson = new Gson();
		String bestSellingItemJson = gson.toJson(statsService.getBestSellingItemList());
		String weeklyTotalSales  = gson.toJson(statsService.getWeeklyTotalSales());
		String reasonList = gson.toJson(statsService.getClaimReasonCountList());
		String logList = gson.toJson(statsService.getLoginTimeList());
		
		//미답변 count 가져오기
		int itemQnaNoAnswerCount = itemQnaService.getItemQnaNoAnswerCount();
		int inquiryNoAnswerCount = inquiryService.getInquiryNoAnswerCount();
		int plantBoardNoAnswerCount = boardService.getPlantBoardNoAnswerCount();
		model.addAttribute("itemQnaNoAnswerCount", itemQnaNoAnswerCount);
		model.addAttribute("inquiryNoAnswerCount", inquiryNoAnswerCount);
		model.addAttribute("plantBoardNoAnswerCount", plantBoardNoAnswerCount);
		
		model.addAttribute("bestSellingItemList", bestSellingItemJson);
		model.addAttribute("weeklyTotalSales", weeklyTotalSales);
		model.addAttribute("reasonList", reasonList);
		model.addAttribute("logList", logList);
		
		return "admin/mainHome";
	}

}
