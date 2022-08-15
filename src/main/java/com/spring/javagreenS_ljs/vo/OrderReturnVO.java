package com.spring.javagreenS_ljs.vo;

import lombok.Data;

@Data
public class OrderReturnVO {
	private Integer order_return_idx;
	private Integer user_idx;
	private Integer order_idx;
	private Integer order_list_idx;
	private String return_reason;
	private String photo;
	private Integer return_price;
	private String return_bank_name;
	private String return_bank_user_name;
	private String return_bank_number;
	private String user_message;
	private String request_flag;
	private String return_admin_memo;
	private String bring_shipping_company;
	private String bring_invoice_number;
	private String request_answer_date;
	private Integer bring_status;
	private String return_ok_date;
	private Integer return_status;
	private Integer use_point;
	private Integer coupon_amount;
	private String created_date;
	
	private Integer shipping_return_price;
	private Integer item_price;
}
