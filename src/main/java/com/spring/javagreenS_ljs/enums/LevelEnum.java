package com.spring.javagreenS_ljs.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum LevelEnum {

	ADMIN(0, "관리자"),
	GOLD(1, "골드레벨"),
	SILVER(2, "실버레벨");
	
	private Integer index;
	private String label;
}
