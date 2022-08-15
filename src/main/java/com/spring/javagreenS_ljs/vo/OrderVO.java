package com.spring.javagreenS_ljs.vo;

import lombok.Data;

@Data
public class OrderVO {
	private int order_idx;
	private String order_number;
	private int user_idx;
	private int order_total_amount;
	private String email;
	private String tel;
	private int user_delivery_idx;
	private String order_admin_memo;
	private int use_point;
	private int coupon_user_idx;
	private int coupon_amount;
	private String created_date;
	
	private String[] order_item_idx;
	private String[] order_item_name;
	private String[] order_item_image;
	private int[] order_item_price;
	private String[] order_item_option_flag;
	private String[] order_option_idx;
	private String[] order_option_name;
	private String[] order_option_price;
	private String[] order_quantity;
	private String[] cart_idx;
	
	private String item_name;
	private String point;
	private int order_total_amount_calc;
}
