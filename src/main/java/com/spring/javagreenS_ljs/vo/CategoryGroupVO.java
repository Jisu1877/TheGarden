package com.spring.javagreenS_ljs.vo;

import java.util.ArrayList;

import lombok.Data;

@Data
public class CategoryGroupVO {
	private int category_group_idx;
	private String category_group_code;
	private String category_group_name;
	private String category_group_use_yn;
	private int category_group_level;
	private String category_group_del_yn;
	
	private ArrayList<CategoryVO> categoryList;
}
