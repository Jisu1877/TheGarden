package com.spring.javagreenS_ljs.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum AgreeEnum {

	ALL(3, "전체 동의"),
	ONLY_REQUIRED(2, "선택 동의");
	
	private Integer value;
	private String label;
	
	public static AgreeEnum findByValue(Integer value) {
		for (AgreeEnum e : AgreeEnum.values()) {
			if (e.getValue() == value) {
				return e;
			}
		}
		throw new RuntimeException();
	}
}
