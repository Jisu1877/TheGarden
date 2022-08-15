package com.spring.javagreenS_ljs.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_ljs.vo.OrderCancelVO;
import com.spring.javagreenS_ljs.vo.OrderListVO;
import com.spring.javagreenS_ljs.vo.ShippingListVO;
import com.spring.javagreenS_ljs.vo.UserDeliveryVO;

public interface OrderAdminDAO {

	public int totRecCnt();

	public ArrayList<OrderListVO> getOrderList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public ArrayList<OrderListVO> getOrderInfor(@Param("idx") int idx);

	public void setOrderAdminMemo(@Param("idx")int idx,@Param("memo") String memo);

	public void setOrderCodeChange(@Param("idx")int idx,@Param("code") String code);

	public OrderCancelVO getOrderCancelRequestInfor(@Param("listIdx") int listIdx, @Param("orderIdx") int orderIdx);

	public void setOrderCancelRequestAnswer(@Param("vo") OrderCancelVO vo);

	public int totCodeRecCnt(@Param("code") String code);

	public ArrayList<OrderListVO> getOrderListCode(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("code") String code);

	public int totSearchRecCnt1(@Param("search") String search,@Param("searchValue") String searchValue);

	public int totTermRecCnt1(@Param("start") String start,@Param("end") String end);

	public int totALLRecCnt1(@Param("search") String search,@Param("searchValue") String searchValue,@Param("start") String start,@Param("end") String end);

	public int totSearchRecCnt2(@Param("search") String search,@Param("searchValue") String searchValue,@Param("code") String code);

	public int totTermRecCnt2(@Param("start") String start,@Param("end") String end,@Param("code") String code);

	public int totALLRecCnt2(@Param("search") String search,@Param("searchValue") String searchValue,@Param("start") String start,@Param("end") String end, @Param("code") String code);

	public ArrayList<OrderListVO> getOrderListSearch1(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize,@Param("search") String search,
			@Param("searchValue") String searchValue);

	public ArrayList<OrderListVO> getOrderListTerm1(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("start") String start,@Param("end") String end);

	public ArrayList<OrderListVO> getOrderListALL1(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("search") String search, @Param("searchValue")String searchValue,
			@Param("start") String start,@Param("end") String end);

	public ArrayList<OrderListVO> getOrderListSearch2(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("search") String search,@Param("searchValue") String searchValue,
			@Param("code") String code);

	public ArrayList<OrderListVO> getOrderListTerm2(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("start") String start,@Param("end") String end,
			@Param("code") String code);

	public ArrayList<OrderListVO> getOrderListALL2(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("search") String search,@Param("searchValue") String searchValue,
			@Param("start") String start,@Param("end") String end, @Param("code") String code);

	public ArrayList<OrderListVO> getOrderListWithDelivery();

	public void setRejectCodeUpdate(@Param("order_list_idx") int order_list_idx,@Param("reject_code") String reject_code);

	public OrderListVO getOrderListInfor(@Param("order_list_idx") int order_list_idx);

	public void setShippingListHistory(@Param("vo") ShippingListVO vo);

	public ShippingListVO getShippingList(@Param("order_list_idx") int order_list_idx);

	public void setOrderExchangeOk(@Param("ilstIdx") int ilstIdx);

	public ArrayList<OrderListVO> getOrderCheck();

}
