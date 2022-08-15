package com.spring.javagreenS_ljs;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javagreenS_ljs.pagination.PagingProcess;
import com.spring.javagreenS_ljs.service.OfflineStoreService;
import com.spring.javagreenS_ljs.service.UserService;
import com.spring.javagreenS_ljs.vo.OfflineStoreVO;
import com.spring.javagreenS_ljs.vo.UserVO;

@Controller
@RequestMapping("/offline")
public class OfflineStoreController {
	
	@Autowired
	OfflineStoreService offlineStoreService;
	
	@Autowired
	UserService userService;
	
	@Autowired
	PagingProcess pagingProcess;
	
	@RequestMapping(value = "/storeInsert", method = RequestMethod.POST)
	public String storeInsertPost(OfflineStoreVO vo, HttpServletRequest request) {
		//가맹점 등록처리
		String uploadPath = request.getRealPath("/resources/data/qrCode/");
		vo.setUploadPath(uploadPath);
		
		offlineStoreService.setStoreInsert(vo);
		
		return "redirect:/msg/storeInsertOk";
	}
	
	//오프라인 매장 등록 창 호출
	@RequestMapping(value = "/offlineStoreInsert", method = RequestMethod.GET)
	public String offlineStoreInsertGet(HttpSession session, Model model) {
		String user_id = (String)session.getAttribute("sUser_id");
		int user_idx = (int) session.getAttribute("sUser_idx");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInfor(user_id);
		model.addAttribute("userVO", userVO);
		return "admin/other/offlineStore/offlineStoreInsert";
	}
	
	//오프라인 매장 관리 호출
	@RequestMapping(value = "/offlineStoreList", method = RequestMethod.GET)
	public String offlineStoreListGet(@ModelAttribute("searchVO") OfflineStoreVO searchVO, HttpSession session, Model model) {
		String user_id = (String)session.getAttribute("sUser_id");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInfor(user_id);
		
		//페이징 처리
		int totCnt = offlineStoreService.totRecCnt(searchVO);
		
		//오프라인 매장 목록 가져오기
		pagingProcess.pageProcess3(searchVO, totCnt);
		
		ArrayList<OfflineStoreVO> storeList = offlineStoreService.getStoreListSearch(searchVO);
		
		model.addAttribute("userVO", userVO);
		model.addAttribute("storeList", storeList);
		return "admin/other/offlineStore/offlineStoreList";
	}
	
	//오프라인 매장 삭제
	@RequestMapping(value = "/storeDelete", method = RequestMethod.GET)
	public String storeDeleteGet(OfflineStoreVO vo) {
		
		offlineStoreService.setStoreDelete(vo.getOffline_store_idx());
		
		return "redirect:/msg/storeDeleteOk";
	}
}
