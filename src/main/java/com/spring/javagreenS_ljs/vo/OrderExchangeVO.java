package com.spring.javagreenS_ljs.vo;

import lombok.Data;

@Data
public class OrderExchangeVO {
	private int order_exchange_idx;
	private int user_idx;
	private int order_idx;
	private int order_list_idx;
	private String exchange_reason;
	private String photo;
	private String user_message;
	private String request_flag;
	private String exchange_admin_memo;
	private String bring_shipping_company;
	private String bring_invoice_number;
	private String request_answer_date;
	private int bring_status;
	private String exchange_invoice_number;
	private String exchange_shipping_company;
	private String exchange_delivery_date;
	private int exchange_status;
	private String created_date;
}
