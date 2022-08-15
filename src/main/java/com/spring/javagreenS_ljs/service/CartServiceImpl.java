package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_ljs.dao.CartDAO;
import com.spring.javagreenS_ljs.vo.CartVO;

@Service
public class CartServiceImpl implements CartService {
	
	@Autowired
	CartDAO cartDAO;
	
	@Override
	public void setInputCart(CartVO vo) {
		String item_option_flag = vo.getItem_option_flag();
		String shipping_group_code = "";
		int user_idx = vo.getUser_idx();
		
		//옵션 사용을 안하는 상품이라면..
		if(item_option_flag.equals("n")) {
			//shipping_group_code 만들기(회원고유번호_상품고유번호_옵션사용여부_옵션고유번호)
			shipping_group_code = user_idx + "_" + vo.getItem_idx() + "_" + item_option_flag;
			vo.setShipping_group_code(shipping_group_code);
			
			//같은 shipping_group_code가 있는지 확인
			CartVO cartVO = cartDAO.getCartCodeCheck(shipping_group_code);
			
			if(cartVO == null) {
				//장바구니 DB에 저장하기
				cartDAO.setInputCart(vo);
			}
			else {
				//같은 shipping_group_code 제품 수량
				cartDAO.setQuantity(vo);
			}
		}
		//옵션 사용을 하는 상품이라면..
		else {
			for(int i=0; i<vo.getOptionIdxArr().length; i++) {
				int[] optionIdxArr = vo.getOptionIdxArr();
				int[] optionQuantity = vo.getOption_quantity();
				shipping_group_code = user_idx + "_" + vo.getItem_idx() + "_" + item_option_flag + "_" + optionIdxArr[i];
				
				vo.setItem_option_idx(optionIdxArr[i]);
				vo.setQuantity(optionQuantity[i]);
				vo.setShipping_group_code(shipping_group_code);
				
				//같은 shipping_group_code가 있는지 확인
				CartVO cartVO = cartDAO.getCartCodeCheck(shipping_group_code);
				
				if(cartVO == null) {
					//장바구니 DB에 저장하기
					cartDAO.setInputCartWithOptions(vo);
				}
				else {
					//같은 shipping_group_code 제품 수량 + 1
					cartDAO.setQuantity(vo);
				}
				
			}
		}
		
	}

	@Override
	public String getCartCnt(int user_idx) {
		return cartDAO.getCartCnt(user_idx);
	}

	@Override
	public ArrayList<CartVO> getCartList(int user_idx) {
		return cartDAO.getCartList(user_idx);
	}

	@Override
	public void setCartDelete(int cartIdx) {
		cartDAO.setCartDelete(cartIdx);
	}

	@Override
	public void cartMinusPost(int cartIdx) {
		cartDAO.cartMinusPost(cartIdx);
	}

	@Override
	public void cartPlusPost(int cartIdx) {
		cartDAO.cartPlusPost(cartIdx);
	}
}
