package com.spring.javagreenS_ljs.vo;

import lombok.Data;

@Data
public class ItemOptionVO {
	private int item_option_idx;
	private int item_idx;
	private String option_use_flag;
	private String option_name;
	private int option_price;
	private int option_stock_quantity;
	private String option_sold_out;
	private String option_display_flag;
	private String created_date;
}
