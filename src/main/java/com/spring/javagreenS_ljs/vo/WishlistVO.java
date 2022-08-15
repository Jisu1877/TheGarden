package com.spring.javagreenS_ljs.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class WishlistVO extends ItemVO{
	private Integer wishlist_idx;
	private Integer user_idx;
	private String wish_date;
}
