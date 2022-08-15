package com.spring.javagreenS_ljs.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_ljs.vo.CartVO;

public interface CartDAO {

	public void setInputCart(@Param("vo") CartVO vo);

	public void setInputCartWithOptions(@Param("vo") CartVO vo);

	public String getCartCnt(@Param("user_idx") int user_idx);

	public CartVO getCartCodeCheck(@Param("shipping_group_code") String shipping_group_code);

	public ArrayList<CartVO> getCartList(@Param("user_idx") int user_idx);
	
	public void setQuantity(@Param("vo") CartVO vo);

	public void setCartDelete(@Param("cartIdx") int cartIdx);

	public void cartMinusPost(@Param("cartIdx") int cartIdx);

	public void cartPlusPost(@Param("cartIdx") int cartIdx);

}
