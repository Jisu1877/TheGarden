package com.spring.javagreenS_ljs;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javagreenS_ljs.pagination.PagingProcess;
import com.spring.javagreenS_ljs.service.InquiryService;
import com.spring.javagreenS_ljs.service.UserService;
import com.spring.javagreenS_ljs.vo.InquiryVO;
import com.spring.javagreenS_ljs.vo.UserVO;

@Controller
@RequestMapping("inquiry")
public class InquiryController {
	
	@Autowired
	InquiryService inquiryService;
	
	@Autowired
	UserService userService;
	
	@Autowired
	PagingProcess pagingProcess;
	
	// 관리자 1:1 문의 관리 호출
	@RequestMapping(value = "/inquiryList", method = RequestMethod.GET)
	public String inquiryListGet(InquiryVO searchVO, Model model, HttpSession session) {
		int user_idx = (int) session.getAttribute("sUser_idx");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInforIdx(user_idx);
		
		//페이징
		int totCnt = inquiryService.getInquiryTotalCnt(searchVO);
		pagingProcess.pageProcess3(searchVO, totCnt);
		
		//문의 내용 가져오기
		ArrayList<InquiryVO> inquiryList = inquiryService.getInquiryListAll(searchVO);
		
		model.addAttribute("inquiryList", inquiryList);
		model.addAttribute("userVO", userVO);
		model.addAttribute("searchVO", searchVO);
		return "admin/inquiry/inquiryList";
	}
	
	
	//1:1문의 관리자 답변
	@RequestMapping(value = "/inquiryAnswer", method = RequestMethod.GET)
	public String inquiryAnswerGet(InquiryVO searchVO) {
		//답변 DB 업데이트
		inquiryService.setInquiryAnswer(searchVO);
		
		return "redirect:/msg/inquiryAnswerOk";
	}
	
	//관리자 답변 수정
	@RequestMapping(value = "/inquiryAnswerUpdate", method = RequestMethod.GET)
	public String inquiryAnswerUpdateGet(InquiryVO searchVO) {
		//답변 업데이트
		inquiryService.setInquiryAnswer(searchVO);
		
		return "redirect:/msg/inquiryAnswerUpdateOk";
	}
	
	//문의 삭제 처리
	@RequestMapping(value = "/inquiryDelete", method = RequestMethod.GET)
	public String inquiryDeleteGet(InquiryVO searchVO) {
		//삭제 처리
		inquiryService.setInquiryDelete(searchVO);
		
		return "redirect:/msg/inquiryDeleteOk";
	}
	
	//문의 삭제 처리
	@RequestMapping(value = "/inquiryDeleteUser", method = RequestMethod.GET)
	public String inquiryDeleteUserGet(InquiryVO searchVO) {
		//삭제 처리
		inquiryService.setInquiryDelete(searchVO);
		
		return "redirect:/msg/inquiryDeleteUserOk";
	}
}
