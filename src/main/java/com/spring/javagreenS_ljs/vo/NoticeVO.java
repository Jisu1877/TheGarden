package com.spring.javagreenS_ljs.vo;

import com.spring.javagreenS_ljs.pagination.SearchVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class NoticeVO extends SearchVO{
	private Integer notice_idx;
	private String notice_title;
	private String notice_content;
	private String popup_yn;
	private Integer views;
	private String files;
	private String create_date;
}
