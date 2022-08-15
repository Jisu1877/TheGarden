package com.spring.javagreenS_ljs.vo;

import com.spring.javagreenS_ljs.pagination.SearchVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class PlantBoardVO extends SearchVO{
	private Integer plant_board_idx;
	private Integer user_idx;
	private String user_id;
	private String email;
	private String title;
	private String content;
	private String notice_yn;
	private String admin_answer_yn;
	private Integer views;
	private String choice1;
	private String choice2;
	private String choice3;
	private String choice4;
	private String choice5;
	private String email_yn;
	private String delete_yn;
	private String write_date;
	private String admin_content;
	private String admin_write_date;
	
	private Integer reply_count;
	private Integer diff_time;
}
