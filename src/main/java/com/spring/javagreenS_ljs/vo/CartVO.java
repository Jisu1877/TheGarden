package com.spring.javagreenS_ljs.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CartVO extends ItemVO {
	private int cart_idx;
	private int user_idx;
	private int item_idx;
	private String user_id;
	private String item_option_flag;
	private int item_option_idx;
	private int quantity;
	private int total_price;
	private String shipping_group_code;
	private String created_date;
	
	private int[] optionIdxArr;
	private int[] option_quantity;
	private String flag;
}
