package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_ljs.dao.DeliveryDAO;
import com.spring.javagreenS_ljs.vo.UserDeliveryVO;

@Service
public class DeliveryServiceImpl implements DeliveryService {

	@Autowired
	DeliveryDAO deliveryDAO;
	
	@Override
	public UserDeliveryVO getDeliveryVO(int user_idx) {
		return deliveryDAO.getDeliveryVO(user_idx);
	}

	@Override
	public void setDeliveryInfor(UserDeliveryVO vo) {
		deliveryDAO.setDeliveryInfor(vo);
	}

	@Override
	public UserDeliveryVO getUserDeliveryInfor(int delivery_idx) {
		return deliveryDAO.getUserDeliveryInfor(delivery_idx);
	}

	@Override
	public ArrayList<UserDeliveryVO> getDeliveryList(int user_idx) {
		return deliveryDAO.getDeliveryList(user_idx);
	}

	@Override
	public void setDefaultChange(int idx) {
		deliveryDAO.setDefaultChange(idx);
	}

	@Override
	public void setDefaultDelete(int user_idx) {
		deliveryDAO.setDefaultDelete(user_idx);
	}

	@Override
	public void setDelete(int idx) {
		deliveryDAO.setDelete(idx);
	}

}
