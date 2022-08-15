package com.spring.javagreenS_ljs.vo;

import lombok.Data;

@Data
public class CntVO {
	
	int orderListOnlyOrderCnt;
	int orderListOnlyDeliveryCnt;
	int orderListOnlyDeliveryOkCnt;
	int orderListOnlyReturnCnt;
	String nowDate;
	int couponListCnt;
}
