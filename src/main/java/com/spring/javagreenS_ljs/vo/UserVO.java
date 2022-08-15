package com.spring.javagreenS_ljs.vo;

import java.util.ArrayList;

import com.spring.javagreenS_ljs.pagination.SearchVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class UserVO extends SearchVO {
	private Integer user_idx;
	private String user_id;
	private String user_pwd;
	private String name;
	private String gender;
	private String email;
	private String tel;
	private String user_image;
	private Integer status_code;
	private Integer login_count;
	private Integer buy_count;
	private Integer buy_price;
	private Integer level;
	private Integer point;
	private String seller_yn;
	private Integer agreement;
	private String login_date;
	private String created_date;
	private String updated_date;
	private String deny_date;
	private String leave_date;
	private String leave_reason;

	ArrayList<OrderListVO> orderList;
}
