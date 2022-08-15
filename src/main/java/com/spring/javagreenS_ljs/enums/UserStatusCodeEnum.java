package com.spring.javagreenS_ljs.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum UserStatusCodeEnum {

	ACTIVE(9, "활동중"),
	LEAVE(0, "탈퇴");
	
	private Integer index;
	private String label;
	
	public static UserStatusCodeEnum findByIndex(int index) {
		for (UserStatusCodeEnum e : UserStatusCodeEnum.values()) {
			if (e.getIndex() == index) {
				return e;
			}
		}
		throw new RuntimeException();
	}
	
	public static String getLabel(int index) {
		for (UserStatusCodeEnum e : UserStatusCodeEnum.values()) {
			if (e.getIndex() == index) {
				return e.label;
			}
		}
		throw new RuntimeException();
	}
}
