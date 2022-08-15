package com.spring.javagreenS_ljs;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javagreenS_ljs.enums.AgreeEnum;
import com.spring.javagreenS_ljs.enums.LevelEnum;
import com.spring.javagreenS_ljs.enums.SellerYnEnum;
import com.spring.javagreenS_ljs.enums.UserStatusCodeEnum;
import com.spring.javagreenS_ljs.pagination.PagingProcess;
import com.spring.javagreenS_ljs.service.DeliveryService;
import com.spring.javagreenS_ljs.service.PointService;
import com.spring.javagreenS_ljs.service.UserAdminService;
import com.spring.javagreenS_ljs.service.UserService;
import com.spring.javagreenS_ljs.vo.PointVO;
import com.spring.javagreenS_ljs.vo.UserDeliveryVO;
import com.spring.javagreenS_ljs.vo.UserVO;

@Controller
@RequestMapping("/admin/user")
public class AdminUserController {
	
	@Autowired
	UserAdminService userAdminService;
	
	@Autowired
	UserService userService;
	
	@Autowired
	PointService pointService;
	
	@Autowired
	DeliveryService deliveryService;
	
	@Autowired
	PagingProcess pagingProcess;
	
	@RequestMapping(value = "/userList", method = RequestMethod.GET)
	public String userListGet(UserVO searchVO, HttpSession session, Model model) {
		String user_id = (String) session.getAttribute("sUser_id");
		UserVO userVO = userService.getUserInfor(user_id);
		
		// 페이징
		int totCnt = userAdminService.getUserListTotalCnt(searchVO);
		pagingProcess.pageProcess3(searchVO, totCnt);
		
		model.addAttribute("userVO", userVO);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("userList", userAdminService.getUserList(searchVO));
		return "admin/user/userList";
	}
	
	@RequestMapping(value = "/userInforUpdate", method = RequestMethod.GET)
	public String userInforUpdateGet(@ModelAttribute("searchVO") UserVO searchVO, HttpSession session, Model model) {
		String user_id = (String) session.getAttribute("sUser_id");
		UserVO userVO = userService.getUserInfor(user_id);
		
		UserVO user = userService.getUserInfor(searchVO.getUser_id());
		
		model.addAttribute("userVO", userVO);
		model.addAttribute("user", user);
		model.addAttribute("statusList", UserStatusCodeEnum.values());
		model.addAttribute("levelList", LevelEnum.values());
		model.addAttribute("sellerYnList", SellerYnEnum.values());
		model.addAttribute("agreeList", AgreeEnum.values());
		
		return "admin/user/userInforUpdate";
	}
	
	@RequestMapping(value = "/userInforUpdate", method = RequestMethod.POST)
	public String userInforUpdatePost(UserVO userVO, HttpSession session, Model model) {
		if (userVO.getStatus_code() != null && userVO.getStatus_code().equals(UserStatusCodeEnum.LEAVE.getIndex())) {
			if (userVO.getLeave_date() == null || userVO.getLeave_date().equals("")) {
				String now = new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
				userVO.setLeave_date(now);
			}
		}
		
		int result = userAdminService.updateUser(userVO);
		
		if (result > 0) {
			model.addAttribute("msg", "수정이 완료되었습니다.");
			model.addAttribute("url", "admin/user/userInforUpdate?user_id=" + userVO.getUser_id());			
		} else {
			model.addAttribute("msg", "수정 처리 중 오류가 발생했습니다.");
			model.addAttribute("url", "admin/user/userInforUpdate?user_id=" + userVO.getUser_id());	
		}
		
		return "redirect:/msg";
	}
	
	//배송지 목록 불러오기
	@RequestMapping(value = "/delivery", method = RequestMethod.GET)
	public String delivery(UserVO userVO, Model model) {
		ArrayList<UserDeliveryVO> deliverList = deliveryService.getDeliveryList(userVO.getUser_idx());
		model.addAttribute("deliverList", deliverList);
		model.addAttribute("userVO", userService.getUserInforIdx(userVO.getUser_idx()));

		return "admin/user/delivery";
	}

	// 기본 배송지로 변경
	@ResponseBody
	@RequestMapping(value = "/delivery/defaultChange", method = RequestMethod.POST)
	public String defaultChangePost(UserDeliveryVO userDeliveryVO, Model model) {
		// 기존에 기본 배송지를 해제하기
		deliveryService.setDefaultDelete(userDeliveryVO.getUser_idx());

		// 기본 배송지로 변경
		deliveryService.setDefaultChange(userDeliveryVO.getUser_delivery_idx());
		
		return "";
	}

	// 배송지삭제
	@RequestMapping(value = "/delivery/delete", method = RequestMethod.GET)
	public String deleteGet(UserDeliveryVO userDeliveryVO, String user_id, Model model) {
		// 삭제처리
		deliveryService.setDelete(userDeliveryVO.getUser_delivery_idx());
		
		return "redirect:/admin/user/userInforUpdate?user_id=" + user_id + "&target=delivery-tab";
	}
	
	@RequestMapping(value = "/point", method = RequestMethod.GET)
	public String pointGet(UserVO searchVO, HttpSession session, Model model) {
		String user_id = (String) session.getAttribute("sUser_id");
		UserVO userVO = userService.getUserInfor(user_id);
		
		UserVO user = userService.getUserInfor(searchVO.getUser_id());
		
		PointVO pointVO = new PointVO();
		pointVO.setUser_idx(user.getUser_idx());
		List<PointVO> pointList = pointService.getSavePointListByUserIdx(pointVO);
		pointList.addAll(pointService.getUsePointListByUserIdx(pointVO));
		Collections.sort(pointList);
		
		model.addAttribute("userVO", userVO);
		model.addAttribute("user", user);
		model.addAttribute("pointList", pointList);
		return "admin/user/point";
	}
	
	@Transactional
	@RequestMapping(value = "/point", method = RequestMethod.POST)
	public String pointPost(PointVO pointVO, HttpSession session, Model model) {
		String user_id = (String) session.getAttribute("sUser_id");
		UserVO userVO = userService.getUserInfor(user_id);
		
		pointVO.setAdmin_id(userVO.getUser_id());
		pointService.setSavePointHistory(pointVO);
		UserVO user = userService.getUserInforIdx(pointVO.getUser_idx());
		user.setPoint(user.getPoint() + pointVO.getSave_point_amount());
		userAdminService.updateUser(user);
		
		model.addAttribute("userVO", userVO);
		model.addAttribute("user", user);
		return "redirect:userInforUpdate?user_id=" + user.getUser_id() + "&target=point-tab";
	}
	
	@RequestMapping(value = "/leave", method = RequestMethod.GET)
	public String leaveGet(@ModelAttribute UserVO userVO, Model model) {
		return "admin/user/leave";
	}
	
	@RequestMapping(value = "/leave", method = RequestMethod.POST)
	public String leave(UserVO userVO, Model model) {
		UserVO user = userService.getUserInfor(userVO.getUser_id());
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss", Locale.KOREA);
		String nowDate = format.format(Calendar.getInstance().getTime());
		user.setLeave_date(nowDate);
		user.setStatus_code(UserStatusCodeEnum.LEAVE.getIndex());
		user.setLeave_reason(userVO.getLeave_reason());
		int result = userAdminService.updateUser(user);
		
		if (result > 0) {
			model.addAttribute("msg", "탈퇴 처리가 완료되었습니다.");
			model.addAttribute("url", "admin/user/userInforUpdate?user_id=" + userVO.getUser_id() + "&target=leave-tab");			
		} else {
			model.addAttribute("msg", "탈퇴 처리 중 오류가 발생했습니다.");
			model.addAttribute("url", "admin/user/userInforUpdate?user_id=" + userVO.getUser_id() + "&target=leave-tab");	
		}
		
		return "redirect:/msg";
	}
}
