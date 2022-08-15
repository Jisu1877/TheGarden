package com.spring.javagreenS_ljs;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javagreenS_ljs.service.ExtarFileService;
import com.spring.javagreenS_ljs.service.UserService;
import com.spring.javagreenS_ljs.vo.ExtraFileVO;
import com.spring.javagreenS_ljs.vo.UserVO;

@Controller
@RequestMapping(value = "/extraFile")
public class ExtraFileController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	ExtarFileService extarFileService;
	
	@RequestMapping(value = "/extraFileList", method = RequestMethod.GET)
	public String extraFileGet(HttpSession session, Model model) {
		String user_id = (String)session.getAttribute("sUser_id");
		
		//회원정보 가져오기
		UserVO userVO = userService.getUserInfor(user_id);
		
		//임시 파일 목록 가져오기
		ArrayList<String> extraFileList = extarFileService.getExtraFileList();
		
		model.addAttribute("userVO", userVO);
		model.addAttribute("extraFileList", extraFileList);
		return "admin/other/extraFile/extraFileList";
	}
	
	@RequestMapping(value = "/extarFileDelete", method = RequestMethod.GET)
	public String extarFileDeleteGet(ExtraFileVO vo) {
		//서버 파일 개별 삭제 처리
		extarFileService.setExtarFileDelete(vo);
		
		return "redirect:/msg/extarFileDeleteOk";
	}
	
	@RequestMapping(value = "/extarFileDeleteAll", method = RequestMethod.GET)
	public String extarFileDeleteAllGet() {
		//서버 파일 전체 삭제 처리
		extarFileService.setExtarFileDeleteAll();
		
		return "redirect:/msg/extarFileDeleteAllOk";
	}
}
