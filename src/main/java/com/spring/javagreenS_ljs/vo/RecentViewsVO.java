package com.spring.javagreenS_ljs.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class RecentViewsVO extends ItemVO {
	private Integer recent_views_idx;
	private Integer user_idx;
	private String recent_date;
}
