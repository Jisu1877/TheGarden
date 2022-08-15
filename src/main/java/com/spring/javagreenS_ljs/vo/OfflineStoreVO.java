package com.spring.javagreenS_ljs.vo;

import com.spring.javagreenS_ljs.pagination.SearchVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class OfflineStoreVO extends SearchVO {
	private Integer offline_store_idx;
	private String store_name;
	private String store_tel;
	private String lat;
	private String lng;
	private String rode_address;
	private String address;
	private String detail_address;
	private String create_date;
	private String qr_image;
	
	private String qr_url;
	private String uploadPath;
}
