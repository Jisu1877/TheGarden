package com.spring.javagreenS_ljs.vo;

import lombok.Data;

@Data
public class CouponVO {
	private int coupon_idx;
	private String coupon_explan;
	private int	discount_rate;
	private int	coupon_period;
	
	private int	coupon_user_idx;
	private int	user_idx;
	private String reason;
	private String expiry_date;
	private String use_flag;
	private String use_date;
	private String created_date;
}
