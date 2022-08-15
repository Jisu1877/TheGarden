package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import com.spring.javagreenS_ljs.vo.UserDeliveryVO;

public interface DeliveryService {

	public UserDeliveryVO getDeliveryVO(int user_idx);

	public void setDeliveryInfor(UserDeliveryVO vo);

	public UserDeliveryVO getUserDeliveryInfor(int delivery_idx);

	public ArrayList<UserDeliveryVO> getDeliveryList(int user_idx);

	public void setDefaultChange(int idx);

	public void setDefaultDelete(int user_idx);

	public void setDelete(int idx);

}
