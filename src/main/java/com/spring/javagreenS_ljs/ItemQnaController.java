package com.spring.javagreenS_ljs;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javagreenS_ljs.common.ARIAUtil;
import com.spring.javagreenS_ljs.pagination.PagingProcess;
import com.spring.javagreenS_ljs.service.ItemQnaService;
import com.spring.javagreenS_ljs.service.UserService;
import com.spring.javagreenS_ljs.vo.ItemQnaVO;
import com.spring.javagreenS_ljs.vo.UserVO;

import lombok.val;

@Controller
@RequestMapping("/itemQna")
public class ItemQnaController {
	
	@Autowired
	ItemQnaService itemQnaService;
	
	@Autowired
	UserService userService;

	@Autowired
	PagingProcess pagingProcess;
	
	@RequestMapping(value = "/itemQnaInsert", method = RequestMethod.GET)
	public String itemQnaOpenGet(@ModelAttribute("qnaInsert") ItemQnaVO qnaInsert, HttpSession session, Model model) {
		int user_idx = (int) session.getAttribute("sUser_idx");
		qnaInsert.setUser_idx(user_idx);
		
		return "item/itemQnaInsert";
	}
	
	//상품 문의 등록처리
	@RequestMapping(value = "/itemQnaInsert", method = RequestMethod.POST)
	public String itemQnaOpenPost(@ModelAttribute("qnaInsert") @Valid ItemQnaVO qnaInsert, BindingResult bindingResult, 
			HttpSession session, Model model) {
		if (bindingResult.hasErrors()) {
			return "item/itemQnaInsert";
		}
		
		int user_idx = (int) session.getAttribute("sUser_idx");
		qnaInsert.setUser_idx(user_idx);
		
		if(qnaInsert.getView_yn().equals("n")) {
			String encPwd = "";
			
			try {
				encPwd = ARIAUtil.ariaEncrypt(qnaInsert.getItem_qna_pwd());
			} catch (InvalidKeyException e) {
				e.printStackTrace();
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			
			System.out.println("encPwd" + encPwd);
			
			qnaInsert.setItem_qna_pwd(encPwd);
		}
		
		//상품 문의 등록 처리
		itemQnaService.setItemQnaInsert(qnaInsert);

		return "redirect:/msg/itemQnaInsertOk";
	}
	
	
	//관리자 상품 문의 관리 창 호출
	@RequestMapping(value = "/itemQnaList", method = RequestMethod.GET)
	public String itemQnaListGet(ItemQnaVO searchVO, HttpSession session, Model model) {
		int user_idx = (int) session.getAttribute("sUser_idx");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInforIdx(user_idx);
		
		//페이징
		int totCnt = itemQnaService.getQnaTotalCnt(searchVO);
		pagingProcess.pageProcess3(searchVO, totCnt);
		
		ArrayList<ItemQnaVO> itemQnaList = itemQnaService.getitemQnaListAll(searchVO);
		
		model.addAttribute("itemQnaList",itemQnaList);
		model.addAttribute("userVO", userVO);
		model.addAttribute("searchVO", searchVO);
		return "admin/itemQna/itemQnaList";
	}
	
	//관리자 상품 문의 답변 창 호출
	@RequestMapping(value = "/itemQnaAnswer", method = RequestMethod.GET)
	public String itemQnaAnswerGet(ItemQnaVO searchVO, HttpSession session, Model model) {
		int user_idx = (int) session.getAttribute("sUser_idx");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInforIdx(user_idx);

		//각 상품 문의 내용 가져오기
		ItemQnaVO vo = itemQnaService.getItemQnaInfor(searchVO.getItem_qna_idx());
		
		model.addAttribute("vo",vo);
		model.addAttribute("userVO", userVO);
		model.addAttribute("searchVO", searchVO);
		return "admin/itemQna/itemQnaAnswer";
	}
	
	//관리자 상품 문의 답변 등록 처리
	@RequestMapping(value = "/itemQnaAnswer", method = RequestMethod.POST)
	public String itemQnaAnswerPost(ItemQnaVO searchVO, Model model) {
		//등록처리
		itemQnaService.setItemQnaAnswer(searchVO);
		
		model.addAttribute("searchVO", searchVO);
		return "redirect:/itemQna/itemQnaList?searchVO=" + searchVO;
	}
	
	//관리자 상품 문의 답변 수정 창 호출
	@RequestMapping(value = "/itemQnaAnswerUpdate", method = RequestMethod.GET)
	public String itemQnaAnswerUpdateGet(ItemQnaVO searchVO, HttpSession session, Model model) {
		int user_idx = (int) session.getAttribute("sUser_idx");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInforIdx(user_idx);
		
		//각 상품 문의 내용 가져오기
		ItemQnaVO vo = itemQnaService.getItemQnaInfor(searchVO.getItem_qna_idx());
		
		model.addAttribute("vo",vo);
		model.addAttribute("userVO", userVO);
		model.addAttribute("searchVO", searchVO);
		return "admin/itemQna/itemQnaAnswerUpdate";
	}
	
	//관리자 상품 문의 답변 수정 창 호출
	@RequestMapping(value = "/itemQnaAnswerUpdate", method = RequestMethod.POST)
	public String itemQnaAnswerUpdatePost(ItemQnaVO searchVO, Model model) {
		//수정처리
		itemQnaService.setItemQnaAnswer(searchVO);
		
		model.addAttribute("searchVO", searchVO);
		return "redirect:/itemQna/itemQnaList?searchVO=" + searchVO;
	}
	
	//문의 글 삭제 처리
	@RequestMapping(value = "/itemQnaDelete", method = RequestMethod.GET)
	public String itemQnaDeleteGet(ItemQnaVO searchVO) {
		//삭제처리
		itemQnaService.setItemQnaDelete(searchVO);
		
		return "redirect:/msg/itemQnaDeleteOk";
	}
	
	//문의 글 삭제 처리(마이페이지)
	@RequestMapping(value = "/itemQnaDeleteUser", method = RequestMethod.GET)
	public String itemQnaDeleteUserGet(ItemQnaVO searchVO) {
		//삭제처리
		itemQnaService.setItemQnaDelete(searchVO);
		
		return "redirect:/msg/itemQnaDeleteUserOk";
	}
	
	
	//상품 문의 조회 비밀번호 체크 창 호출
	@RequestMapping(value = "/itemQnaPwdCheck", method = RequestMethod.GET)
	public String itemQnaPwdCheckGet(ItemQnaVO searchVO, Model model) {
		
		model.addAttribute("item_qna_idx", searchVO.getItem_qna_idx());
		return "item/itemQnaPwdCheck";
	}
	
	//상품 문의 조회 비밀번호 체크 
	@ResponseBody
	@RequestMapping(value = "/itemQnaPwdCheck", method = RequestMethod.POST)
	public String itemQnaPwdCheckPost(ItemQnaVO itemQnaVO, Model model) {
		//상품 문의 내용 가져오기
		ItemQnaVO vo = itemQnaService.getItemQnaInfor(itemQnaVO.getItem_qna_idx());
		
		String pwd = vo.getItem_qna_pwd();
		String decPwd = "";
		try {
			//복호화
			decPwd = ARIAUtil.ariaDecrypt(pwd);
		} catch (InvalidKeyException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		if(!itemQnaVO.getItem_qna_pwd().equals(decPwd)) {
			return "0";
		}
		
		return "1";
	}
	
	//상품 문의 내용 조회
	@RequestMapping(value = "/itemQnaContent", method = RequestMethod.GET)
	public String itemContentGet(ItemQnaVO itemQnaVO, Model model) {
		//상품 문의 내용 가져오기
		ItemQnaVO vo = itemQnaService.getItemQnaInfor(itemQnaVO.getItem_qna_idx());
		
		model.addAttribute("vo", vo);
		return "item/itemQnaContent";
	}
}
