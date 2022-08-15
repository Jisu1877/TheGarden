package com.spring.javagreenS_ljs.dao;

import java.util.List;

import com.spring.javagreenS_ljs.vo.ItemVO;
import com.spring.javagreenS_ljs.vo.StatsClaimVO;
import com.spring.javagreenS_ljs.vo.StatsOrderListVO;
import com.spring.javagreenS_ljs.vo.StatsOrderVO;
import com.spring.javagreenS_ljs.vo.StatsloginTimeVO;

public interface StatsDAO {

	public List<StatsOrderVO> getWeeklyTotalSales();
	
	public List<ItemVO> getBestSellingItemList();
	
	public List<StatsOrderListVO> getOrderCountByStatus();
	
	public int getOrderCancelRequestCount();
	
	public int getOrderExchangeCount();
	
	public int getOrderReturnCount();
	
	public List<StatsClaimVO> getClaimReasonCountList();

	public List<StatsloginTimeVO> getLoginTimeList();
	
}
