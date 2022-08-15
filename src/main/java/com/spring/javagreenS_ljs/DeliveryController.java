package com.spring.javagreenS_ljs;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javagreenS_ljs.service.DeliveryService;
import com.spring.javagreenS_ljs.vo.UserDeliveryVO;
import com.spring.javagreenS_ljs.vo.UserVO;

@Controller
@RequestMapping("/delivery")
public class DeliveryController {
	
	@Autowired
	DeliveryService deliveryService;
	
	//배송지 추가 창 호출
	@RequestMapping(value = "/deliveryInsert", method = RequestMethod.GET)
	public String deliveryInsertGet(String flag, Model model) {
		
		model.addAttribute("flag", flag);
		return "delivery/deliveryInsert";
	}
	
	//배송지 추가 처리
	@ResponseBody
	@RequestMapping(value = "/deliveryInsert", method = RequestMethod.POST)
	public String deliveryInsertPost(UserDeliveryVO vo, HttpSession session) {
		int user_idx = (int) session.getAttribute("sUser_idx");
		vo.setUser_idx(user_idx);
		
		//이미 등록한 배송지가 있는지 확인
		UserDeliveryVO deliveryVO = deliveryService.getDeliveryVO(user_idx);
		
		String deliveryFlag = "";
		if(deliveryVO == null) {
			//비어있다면 기본 주소로 등록
			deliveryFlag = "y";
		}
		else {
			//이미 등록된 배송지가 있다면 추가 주소로 등록
			deliveryFlag = "n";
		}
		vo.setDefault_flag(deliveryFlag);
		
		//배송지 추가 처리
		deliveryService.setDeliveryInfor(vo);
		
		return "1";
	}
	
	//배송지 목록 불러오기
	@RequestMapping(value = "/deliveryList", method = RequestMethod.GET)
	public String deliveryListGet(UserVO vo, Model model) {
		ArrayList<UserDeliveryVO> deliverList = deliveryService.getDeliveryList(vo.getUser_idx());
		model.addAttribute("deliverList",deliverList);
		
		return "order/deliveryList";
	}
	
	
	//기본 배송지로 변경
	@RequestMapping(value = "/defaultChange", method = RequestMethod.POST)
	public String defaultChangePost(HttpSession session, @RequestParam int idx, Model model) {
		int user_idx = (int) session.getAttribute("sUser_idx");
		
		//기존에 기본 배송지를 해제하기
		deliveryService.setDefaultDelete(user_idx);
		
		//기본 배송지로 변경
		deliveryService.setDefaultChange(idx);
		

		ArrayList<UserDeliveryVO> deliverList = deliveryService.getDeliveryList(user_idx);
		model.addAttribute("deliverList",deliverList);
		
		return "order/deliveryList";
	}
	
	//배송지삭제
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String deleteGet(HttpSession session, @RequestParam int idx, Model model) {
		int user_idx = (int) session.getAttribute("sUser_idx");
		
		//삭제처리
		deliveryService.setDelete(idx);
		
		ArrayList<UserDeliveryVO> deliverList = deliveryService.getDeliveryList(user_idx);
		model.addAttribute("deliverList",deliverList);
		return "order/deliveryList";
		
	}
}
