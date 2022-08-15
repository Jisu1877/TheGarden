package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javagreenS_ljs.vo.OrderCancelVO;
import com.spring.javagreenS_ljs.vo.OrderExchangeVO;
import com.spring.javagreenS_ljs.vo.OrderListVO;
import com.spring.javagreenS_ljs.vo.OrderReturnVO;
import com.spring.javagreenS_ljs.vo.OrderVO;
import com.spring.javagreenS_ljs.vo.PayMentVO;
import com.spring.javagreenS_ljs.vo.ShippingListVO;

public interface OrderService {

	public void setOrderListTempInsert(OrderVO orderVO, int user_idx);
	
	public void setOrderListTempInsertForBuyNow(OrderVO orderVO, int user_idx);

	public ArrayList<OrderListVO> getOrderListTempList(int user_idx);

	public void setOrderListTempDelete(int user_idx);

	public void setOrder_total_amount_and_point(OrderVO temp);

	public void setOrderProcess(String user_id, int user_idx, PayMentVO payMentVO);

	public ArrayList<OrderListVO> getOrderListOnlyThisMonth(int user_idx);

	public ArrayList<OrderListVO> getOrderList(int user_idx);

	public ArrayList<OrderListVO> getorderListOnlyOrder(int user_idx);

	public ArrayList<OrderListVO> getOrderListOnlyDeliveryOk(int user_idx);

	public ArrayList<OrderListVO> getOrderListOnlyReturn(int user_idx);

	public ArrayList<OrderListVO> getOrderListSearch(int user_idx, String start, String end, String order_status_code);

	public OrderListVO getOrderListInfor(int listIdx, int orderIdx);

	public void setOrderCancelHistory(OrderCancelVO vo);

	public OrderCancelVO getorderCancelInfor(int listIdx);

	public ArrayList<OrderListVO> getOrderListOnlyChoice(int user_idx, String order_status_code);

	public ArrayList<OrderListVO> getOrderListOnlyChangeReturn(int user_idx);

	public ArrayList<OrderListVO> getOrderListOnlyRefund(int user_idx);

	public void setOrderCancelRequsetHistory(OrderCancelVO vo);

	public OrderListVO getorderListInfor2(int order_list_idx);

	public void setUsePointSub(int order_idx, int use_point);

	public void setUsePointPlus(int order_idx, int use_point);

	public int getBuyCnt(int user_idx);

	public int getAlreadyConfirmCheck(int user_idx, int order_idx);

	public void setOrderUpdate(int user_idx, int total_amount);

	public void setCouponAmountSub(int order_idx, int coupon_amount);

	public void setExchangeRequest(MultipartHttpServletRequest file, OrderExchangeVO vo);

	public OrderExchangeVO getOrderExchangeInfor(int order_list_idx);

	public void setExchangeAns(OrderExchangeVO vo);

	public void setExchangeShipping(OrderExchangeVO vo);

	public void setCouponAmountPlus(int order_idx, int coupon_amount);

	public void setReturnRequest(MultipartHttpServletRequest file, OrderReturnVO vo);

	public OrderReturnVO getOrderReturnInfor(int order_list_idx);

	public void setReturnAns(OrderReturnVO vo);

	public void setReturnOk(OrderReturnVO vo);

	public int getOrderCancelOnlyRequest(int order_idx);

	public int getOrderReturnOnlyRequest(int order_idx);

	public ArrayList<OrderCancelVO> getOrderCancelOnlyComplete(int order_idx);

	public ArrayList<OrderReturnVO> getOrderReturnOnlyComplete(int order_idx);

	public ArrayList<OrderCancelVO> getOrderCancelOnlyComplete2(int order_idx);

	public ShippingListVO getShippingInfor(int order_list_idx);

	public ArrayList<OrderListVO> getOrderListItemIdx(int item_idx);

}
