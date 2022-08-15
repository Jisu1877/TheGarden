package com.spring.javagreenS_ljs.vo;

import lombok.Data;

@Data
public class OrderCancelVO {
	private int order_cancel_idx;
	private int user_idx;
	private int  order_list_idx;
	private String cancel_reason;
	private int return_price;
	private String return_bank_name;
	private String return_bank_user_name;
	private String return_bank_number;
	private String created_date;
	
	private String request_answer;
	private String request_answer_flag;
	private String cancel_admin_memo;
	private int use_point;
	private int coupon_amount;
	private int order_idx;
	private int order_cancel_request_idx;
	
	private String order_number;
}
