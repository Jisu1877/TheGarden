package com.spring.javagreenS_ljs.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum SellerYnEnum {

	n("일반 회원"),
	y("판매자");
	
	private String label;
}
