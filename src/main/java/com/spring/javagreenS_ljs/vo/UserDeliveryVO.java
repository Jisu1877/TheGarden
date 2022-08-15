package com.spring.javagreenS_ljs.vo;

import lombok.Data;

@Data
public class UserDeliveryVO {
	private int user_delivery_idx;
	private int user_idx;
	private String default_flag;
	private String title;
	private String delivery_name;
	private String delivery_tel;
	private String postcode;
	private String roadAddress;
	private String detailAddress;
	private String extraAddress;
	private String message;
	private String delete_flag;
	private String created_date;
}
