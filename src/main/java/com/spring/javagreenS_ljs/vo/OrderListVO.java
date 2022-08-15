package com.spring.javagreenS_ljs.vo;

import lombok.Data;

@Data
public class OrderListVO {
	private int order_list_idx;
	private int order_idx;
	private int item_idx;
	private String item_name;
	private String item_image;
	private int item_price;
	private String item_option_flag;
	private int option_idx;
	private String option_name;
	private String option_price;
	private int order_quantity;
	private String order_status_code;
	private String reject_code;
	private String update_date;
	private String created_date;
	
	private int user_idx;
	private int order_total_amount;
	private int cart_idx;
	private int use_point;
	
	private String order_number;
	private String email;
	private String tel;
	private String delivery_name;
	private String delivery_tel;
	private String postcode;
	private String roadAddress;
	private String detailAddress;
	private String extraAddress;
	private String message;
	private int user_delivery_idx;
	private String order_admin_memo;
	private String item_summary;
	private String user_id;
	private String item_return_flag;
	private UserDeliveryVO deliveryVO;
	
	private int coupon_amount;
	private int coupon_user_idx;
}
