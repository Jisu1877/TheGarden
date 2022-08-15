package com.spring.javagreenS_ljs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_ljs.dao.StatsDAO;
import com.spring.javagreenS_ljs.vo.ItemVO;
import com.spring.javagreenS_ljs.vo.StatsClaimVO;
import com.spring.javagreenS_ljs.vo.StatsOrderListVO;
import com.spring.javagreenS_ljs.vo.StatsOrderVO;
import com.spring.javagreenS_ljs.vo.StatsloginTimeVO;

@Service
public class StatsServiceImpl implements StatsService {

	@Autowired
	StatsDAO statsDAO;
	
	@Override
	public List<StatsOrderVO> getWeeklyTotalSales() {
		return statsDAO.getWeeklyTotalSales();
	}

	@Override
	public List<ItemVO> getBestSellingItemList() {
		return statsDAO.getBestSellingItemList();
	}

	@Override
	public List<StatsOrderListVO> getOrderCountByStatus() {
		return statsDAO.getOrderCountByStatus();
	}

	@Override
	public int getOrderCancelRequestCount() {
		return statsDAO.getOrderCancelRequestCount();
	}

	@Override
	public int getOrderExchangeCount() {
		return statsDAO.getOrderExchangeCount();
	}

	@Override
	public int getOrderReturnCount() {
		return statsDAO.getOrderReturnCount();
	}

	@Override
	public List<StatsClaimVO> getClaimReasonCountList() {
		return statsDAO.getClaimReasonCountList();
	}

	@Override
	public List<StatsloginTimeVO> getLoginTimeList() {
		return statsDAO.getLoginTimeList();
	}

}
