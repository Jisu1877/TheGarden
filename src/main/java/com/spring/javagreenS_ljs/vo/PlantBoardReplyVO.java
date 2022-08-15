package com.spring.javagreenS_ljs.vo;

import lombok.Data;

@Data
public class PlantBoardReplyVO {
	private Integer plant_board_reply_idx;
	private Integer plant_board_idx;
	private String user_id;
	private String write_date;
	private String content;
	private Integer level;
	private Integer levelOrder;
	private Integer parents;
	private String delete_yn;
}
