package com.spring.javagreenS_ljs.vo;

import lombok.Data;

@Data
public class ShippingListVO{
	private int shipping_list_idx;
	private int user_idx;
	private int order_list_idx;
	private String order_number;
	private int user_delivery_idx;
	private String shipping_company;
	private String invoice_number;
	private String created_date;
	
	private String item_name;
	private String item_option_flag;
	private String option_name;
	private int order_quantity;
	
	private String title;
	private String delivery_name;
	private String delivery_tel;
	private String postcode;
	private String roadAddress;
	private String detailAddress;
	private String extraAddress;
	private String message;
	
	private String shipping_date;
}
