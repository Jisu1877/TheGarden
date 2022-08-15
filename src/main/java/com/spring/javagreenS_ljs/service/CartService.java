package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import com.spring.javagreenS_ljs.vo.CartVO;

public interface CartService {

	public void setInputCart(CartVO vo);

	public String getCartCnt(int user_idx);

	public ArrayList<CartVO> getCartList(int user_idx);

	public void setCartDelete(int cartIdx);

	public void cartMinusPost(int cartIdx);

	public void cartPlusPost(int cartIdx);
	
}
