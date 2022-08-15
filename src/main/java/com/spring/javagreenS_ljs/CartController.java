package com.spring.javagreenS_ljs;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javagreenS_ljs.service.CartService;
import com.spring.javagreenS_ljs.service.ItemAdminService;
import com.spring.javagreenS_ljs.vo.CartVO;
import com.spring.javagreenS_ljs.vo.ItemVO;

@Controller
@RequestMapping("/cart")
public class CartController {
	
	@Autowired
	CartService cartService;
	
	@Autowired
	ItemAdminService itemAdminService;

	// 장바구니 담기
	@ResponseBody
	@RequestMapping(value = "/inputCart", method = RequestMethod.POST)
	public String inputCartPost(CartVO vo, HttpSession session) {
		// 세션 값 저장
		String user_id = (String) session.getAttribute("sUser_id");
		int user_idx = (int) session.getAttribute("sUser_idx");
		vo.setUser_id(user_id);
		vo.setUser_idx(user_idx);
		
		cartService.setInputCart(vo);
		
		return "1";
	}

	// 장바구니 리스트로 이동
	@RequestMapping(value = "/cartList", method = RequestMethod.GET)
	public String cartListGet(HttpSession session, Model model) {
		int user_idx = (int) session.getAttribute("sUser_idx");

		// 장바구니 목록 가져오기
		ArrayList<CartVO> cartList = cartService.getCartList(user_idx);
		model.addAttribute("cartList", cartList);
		
		return "cart/cartListTable";
	}

	// 해당 회원 장바구니 담긴 개수 알아오기
	@ResponseBody
	@RequestMapping(value = "/cartCheck", method = RequestMethod.POST)
	public String cartCheckPost(HttpSession session) {
		String cnt = "";
		if (session.getAttribute("sUser_idx") != null) {
			int user_idx = (int) session.getAttribute("sUser_idx");
			cnt = cartService.getCartCnt(user_idx);
		}
		return cnt;
	}
	
	//장바구니 목록 삭제하기
	@ResponseBody
	@RequestMapping(value = "/cartDelete", method = RequestMethod.POST)
	public String cartDeletePost(int cartIdx) {
		cartService.setCartDelete(cartIdx);
		
		return "1";
	}
	
	//장바구니 목록 수량 마이너스 처리
	@ResponseBody
	@RequestMapping(value = "/cartMinus", method = RequestMethod.POST)
	public String cartMinusPost(int cartIdx) {
		cartService.cartMinusPost(cartIdx);
		
		return "1";
	}
	
	//장바구니 목록 수량 플러스 처리
	@ResponseBody
	@RequestMapping(value = "/cartPlus", method = RequestMethod.POST)
	public String cartPlusPost(int cartIdx) {
		cartService.cartPlusPost(cartIdx);
		
		return "1";
	}
	
}
