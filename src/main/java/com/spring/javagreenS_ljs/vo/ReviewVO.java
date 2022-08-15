package com.spring.javagreenS_ljs.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class ReviewVO extends ItemVO{
	private Integer review_idx;
	private Integer user_idx;
	private Integer order_idx;
	private Integer order_list_idx;
	private Integer rating;
	private String 	review_subject;
	private String review_contents;
	private String photo;
	private String delete_yn;
	private String review_date;
	
	private Integer fileLength;
	private Double rating_cal;
	private Integer ratingValue;
	
	private String user_id;
	private String user_image;
}
