package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_ljs.dao.OrderAdminDAO;
import com.spring.javagreenS_ljs.dao.OrderDAO;
import com.spring.javagreenS_ljs.vo.OrderCancelVO;
import com.spring.javagreenS_ljs.vo.OrderListVO;
import com.spring.javagreenS_ljs.vo.ShippingListVO;
import com.spring.javagreenS_ljs.vo.UserDeliveryVO;

@Service
public class OrderAdminServiceImpl implements OrderAdminService {
	
	@Autowired
	OrderDAO orderDAO;
	
	@Autowired
	OrderAdminDAO orderAdminDAO;
	
	@Autowired
	OrderService orderService;
	
	@Autowired
	ItemService itemService;

	@Override
	public ArrayList<OrderListVO> getOrderList(int startIndexNo, int pageSize, String code, String search, String searchValue, String start, String end) {
		if(!code.equals("0") && search.equals("") && start.equals("")){
			//part를 골랐는데 상세검색은 안했을 때
			return orderAdminDAO.getOrderListCode(startIndexNo, pageSize, code);
		}
		else if(code.equals("0") && !search.equals("") && start.equals("")) {
			//part를 안골랐는데 상세검색 중 상세 조건만 검색일 때
			return orderAdminDAO.getOrderListSearch1(startIndexNo, pageSize,search,searchValue);
		}
		else if(code.equals("0") && search.equals("") && !start.equals("")) {
			//part를 안골랐는데 상세검색 중 조회 기간 검색일 때
			return orderAdminDAO.getOrderListTerm1(startIndexNo, pageSize,start,end);
		}
		else if(code.equals("0") && !search.equals("") && !start.equals("")) {
			//part를 안골랐는데 상세검색 중 조회 기간, 상세 조건 모두 검색일 때
			return orderAdminDAO.getOrderListALL1(startIndexNo, pageSize, search, searchValue, start, end);
		}
		else if(!code.equals("0") && !search.equals("") && start.equals("")) {
			//part를 골랐는데 상세검색 중 상세 조건만 검색일 때
			return orderAdminDAO.getOrderListSearch2(startIndexNo, pageSize,search,searchValue,code);
		}
		else if(!code.equals("0") && search.equals("") && !start.equals("")) {
			//part를 골랐는데 상세검색 중 조회 기간 검색일 때
			return orderAdminDAO.getOrderListTerm2(startIndexNo, pageSize,start,end,code);
		}
		else if(!code.equals("0") && !search.equals("") && !start.equals("")) {
			//part를 골랐는데 상세검색 중 조회 기간, 상세 조건 모두 검색일 때
			return orderAdminDAO.getOrderListALL2(startIndexNo, pageSize, search, searchValue, start, end, code);
		}
		else {
			return orderAdminDAO.getOrderList(startIndexNo, pageSize);
		}
	}

	@Override
	public ArrayList<OrderListVO> getOrderInfor(int idx) {
		return orderAdminDAO.getOrderInfor(idx);
	}

	@Override
	public void setOrderAdminMemo(int idx, String memo) {
		orderAdminDAO.setOrderAdminMemo(idx,memo);
	}

	@Override
	public void setOrderCodeChange(int idx, String code) {
		orderAdminDAO.setOrderCodeChange(idx,code);
	}

	@Override
	public OrderCancelVO getOrderCancelRequestInfor(int listIdx, int orderIdx) {
		return orderAdminDAO.getOrderCancelRequestInfor(listIdx,orderIdx);
	}

	@Override
	public void setOrderCancelRequestAnswer(OrderCancelVO vo) {
		orderAdminDAO.setOrderCancelRequestAnswer(vo);
	}

	@Override
	public ArrayList<OrderListVO> getOrderListWithDelivery() {
		return orderAdminDAO.getOrderListWithDelivery();
	}

	@Override
	public void setRejectCodeUpdate(int order_list_idx, String reject_code) {
		orderAdminDAO.setRejectCodeUpdate(order_list_idx, reject_code);
	}

	@Override
	public void setShippingListHistory(ShippingListVO vo) {
		
		//주문 목록 번호로 필요한 정보 모두 가져오기
		OrderListVO listVO = orderAdminDAO.getOrderListInfor(vo.getOrder_list_idx());
		
		vo.setUser_idx(listVO.getUser_idx());
		vo.setUser_delivery_idx(listVO.getUser_delivery_idx());
		
		orderAdminDAO.setShippingListHistory(vo);
	}

	@Override
	public ShippingListVO getShippingList(int order_list_idx) {
		return orderAdminDAO.getShippingList(order_list_idx);
	}

	@Override
	public void setOrderExchangeOk(int ilstIdx) {
		orderAdminDAO.setOrderExchangeOk(ilstIdx);
	}

	@Override
	public ArrayList<OrderListVO> getOrderCheck() {
		return orderAdminDAO.getOrderCheck();
	}
}
