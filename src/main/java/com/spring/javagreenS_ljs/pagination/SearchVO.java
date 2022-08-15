package com.spring.javagreenS_ljs.pagination;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Set;

import org.springframework.util.ReflectionUtils;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class SearchVO extends PageVO {
	private String search;
	private String searchValue;

	// 모든 변수를 쿼리스트링으로 변환
	public String getParams(Object o) {
		StringBuilder queryString = new StringBuilder("?");
		List<Field> allFields = new ArrayList<>();
		Class<?> clz = SearchVO.class;
		while (clz != null && clz != Object.class) {
			Collections.addAll(allFields, clz.getDeclaredFields());
			clz = clz.getSuperclass();
		}
		try {
			for (Field f : allFields) {
				f.setAccessible(true);
				String name = f.getName();
				String value = String.valueOf(f.get(o));
				value = value != null && !value.toLowerCase().equals("null") ? value : "";
				if (name.equals("pag")) {
					continue;
				}
				queryString.append(name + "=" + value + "&");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return queryString.substring(0, queryString.length() - 1);
	}
}
