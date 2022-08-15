package com.spring.javagreenS_ljs.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_ljs.vo.UserDeliveryVO;

public interface DeliveryDAO {

	public UserDeliveryVO getDeliveryVO(@Param("user_idx") int user_idx);

	public void setDeliveryInfor(@Param("vo") UserDeliveryVO vo);

	public UserDeliveryVO getUserDeliveryInfor(@Param("delivery_idx") int delivery_idx);

	public ArrayList<UserDeliveryVO> getDeliveryList(@Param("user_idx") int user_idx);

	public void setDefaultChange(@Param("idx") int idx);

	public void setDefaultDelete(@Param("user_idx") int user_idx);

	public void setDelete(@Param("idx") int idx);

}
