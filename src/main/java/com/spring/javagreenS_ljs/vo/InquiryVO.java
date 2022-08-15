package com.spring.javagreenS_ljs.vo;

import com.spring.javagreenS_ljs.pagination.SearchVO;

import lombok.Data;

@Data
public class InquiryVO extends SearchVO{
	private Integer inquiry_idx;
	private Integer user_idx;
	private String user_id;
	private String inquiry_content;
	private String write_date;
	private String admin_answer_yn;
	private String admin_answer;
	private String admin_answer_date;
	private String delete_yn;
	
}
