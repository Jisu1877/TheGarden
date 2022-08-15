package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import com.spring.javagreenS_ljs.vo.OrderCancelVO;
import com.spring.javagreenS_ljs.vo.OrderListVO;
import com.spring.javagreenS_ljs.vo.ShippingListVO;

public interface OrderAdminService {

	public ArrayList<OrderListVO> getOrderList(int startIndexNo, int pageSize, String code, String search, String searchValue, String start, String end);

	public ArrayList<OrderListVO> getOrderInfor(int idx);

	public void setOrderAdminMemo(int idx, String memo);

	public void setOrderCodeChange(int idx, String code);

	public OrderCancelVO getOrderCancelRequestInfor(int listIdx, int orderIdx);

	public void setOrderCancelRequestAnswer(OrderCancelVO vo);

	public ArrayList<OrderListVO> getOrderListWithDelivery();

	public void setRejectCodeUpdate(int order_list_idx, String string);

	public void setShippingListHistory(ShippingListVO vo);

	public ShippingListVO getShippingList(int order_list_idx);

	public void setOrderExchangeOk(int idx);

	public ArrayList<OrderListVO> getOrderCheck();

}
