package com.spring.javagreenS_ljs;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javagreenS_ljs.pagination.PagingProcess;
import com.spring.javagreenS_ljs.service.OrderAdminService;
import com.spring.javagreenS_ljs.service.OrderService;
import com.spring.javagreenS_ljs.service.ReviewService;
import com.spring.javagreenS_ljs.service.UserService;
import com.spring.javagreenS_ljs.vo.OrderListVO;
import com.spring.javagreenS_ljs.vo.ReviewVO;
import com.spring.javagreenS_ljs.vo.UserVO;

@Controller
@RequestMapping("review")
public class ReviewController {
	
	@Autowired
	OrderService orderService;
	
	@Autowired
	ReviewService reviewService;
	
	@Autowired
	OrderAdminService orderAdminService;

	@Autowired
	UserService userService;
	
	@Autowired
	PagingProcess pagingProcess;
	
	@RequestMapping(value = "/reviewInsert", method = RequestMethod.GET)
	public String reviewInsertGet(ReviewVO vo, Model model) {
		//주문 내용 가져오기
		OrderListVO orderVO = orderService.getOrderListInfor(vo.getOrder_list_idx(),vo.getOrder_idx());
		
		model.addAttribute("vo", vo);
		model.addAttribute("orderVO", orderVO);
		return "review/reviewInsert";
	}
	
	@RequestMapping(value = "/reviewUpdate", method = RequestMethod.GET)
	public String reviewUpdateGet(ReviewVO vo, Model model) {
		//주문 내용 가져오기
		OrderListVO orderVO = orderService.getOrderListInfor(vo.getOrder_list_idx(),vo.getOrder_idx());
		
		//리뷰 내용 가져오기
		ReviewVO reviewVO = reviewService.getReviewInfor(vo.getReview_idx());
		
		model.addAttribute("vo", vo);
		model.addAttribute("orderVO", orderVO);
		model.addAttribute("reviewVO", reviewVO);
		return "review/reviewUpdate";
	}
	
	@ResponseBody
	@RequestMapping(value = "/reviewImageDel", method = RequestMethod.POST)
	public String reviewImageDelPost(ReviewVO vo, String image_name) {
		reviewService.reviewImageDel(vo, image_name);
		return "1";
	}
	
	
	@RequestMapping(value = "/reviewInsert", method = RequestMethod.POST)
	public String reviewInsertPost(MultipartHttpServletRequest file, ReviewVO vo, Model model, HttpSession session) {
		int user_idx = (int) session.getAttribute("sUser_idx");
		vo.setUser_idx(user_idx);
		
		//리뷰 테이블에 저장
		reviewService.setReviewInsert(vo,file);
		
		//주문 상태값 변경
		orderAdminService.setOrderCodeChange(vo.getOrder_list_idx(), "18");
		
		if(vo.getFileLength() > 0) {
			//포토 리뷰 500point 지급
			userService.setUserGivePoint(user_idx, 500);
		}
		else {
			//일반 리뷰 100point 지급
			userService.setUserGivePoint(user_idx, 100);
		}
		
		return "redirect:/msg/reviewInsertOk";
	}
	
	@RequestMapping(value = "/reviewUpdate", method = RequestMethod.POST)
	public String reviewUpdatePost(MultipartHttpServletRequest file, ReviewVO vo, Model model, HttpSession session) {
		int user_idx = (int) session.getAttribute("sUser_idx");
		vo.setUser_idx(user_idx);
		
		//리뷰 테이블에 업데이트
		reviewService.setReviewUpdate(vo,file);
		
		return "redirect:/msg/reviewUpdateOk";
	}
	
	//리뷰 관리 창 호출
	@RequestMapping(value = "/reviewList", method = RequestMethod.GET)
	public String reviewListGet(ReviewVO searchVO, Model model, HttpSession session) {
		int user_idx = (int) session.getAttribute("sUser_idx");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInforIdx(user_idx);
		
		//페이징
		int totCnt = reviewService.getReviewTotalCnt(searchVO);
		pagingProcess.pageProcess3(searchVO, totCnt);
				
		//리뷰 내용 가져오기
		ArrayList<ReviewVO> reviewList = reviewService.getreviewListAll(searchVO);
		
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("userVO", userVO);
		model.addAttribute("searchVO", searchVO);
		return "admin/review/reviewList";
	}
	
	
	//리뷰 삭제 처리
	@RequestMapping(value = "/reviewDelete", method = RequestMethod.GET)
	public String reviewDeleteGet(ReviewVO vo) {
		//리뷰 삭제 처리
		reviewService.setReviewDelete(vo);
		
		return "redirect:/msg/reviewDeleteOk";
	}
}
