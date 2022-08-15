package com.spring.javagreenS_ljs.vo;

import java.util.ArrayList;

import com.spring.javagreenS_ljs.pagination.SearchVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ItemVO extends SearchVO {
	private int item_idx;
	private String item_code;
	private String item_name;
	private String item_summary;
	private String display_flag;
	private int sale_price;
	private String seller_discount_flag;
	private int seller_discount_amount;
	private String seller_point_flag;
	private int seller_point;
	private String sold_out;
	private int stock_quantity;
	private String stock_schedule_date;
	private int order_min_quantity;
	private int order_max_quantity;
	private int sale_quantity;
	private String item_option_flag;
	private String detail_content;
	private String brand;
	private String form;
	private String item_model_name;
	private String origin_country;
	private String after_service;
	private String item_image; 
	private String shipment_address;
	private String shipment_return_address;
	private String shipment_type;
	private int shipping_price;
	private int shipping_free_amount;
	private int shipping_extra_charge;
	private String item_return_flag;
	private int shipping_return_price;
	private String item_keyword;
	private String created_admin_id;
	private String item_delete_flag;
	private int wish;
	private String created_date;
	
	private int category_group_idx;
	private String category_group_name;
	private int category_idx;
	private String category_name;
	
	private ArrayList<ItemOptionVO> itemOptionList;
	private ArrayList<ItemImageVO> itemImageList;
	private ArrayList<CategoryGroupVO> categoryGroupList;
	private ItemImageVO itemImageVO;
	private ItemNoticeVO itemNoticeVO;
	
	private String option_use_flag;
	private int option_price;
	private int option_stock_quantity;
	private String option_sold_out;
	private String option_display_flag;
	
	private String option_name;
	private String str_option_idx;
	private String str_option_price;
	private String str_option_stock_quantity;
	
	private String notice_value1;
	private String notice_value2;
	private String notice_value3;
	private String notice_value4;
	private String notice_value5;
	
	private String titlephoto;
	private Integer cal_rating;
}
