package com.spring.javagreenS_ljs.vo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Locale;

import lombok.Data;

@Data
public class PointVO implements Comparable<PointVO> {
	private Integer save_point_idx;
	private Integer user_idx;
	private Integer save_point_amount;
	private String save_reason;
	private Integer order_idx;
	private String admin_id;
	private String created_date;
	
	private Integer use_point_idx;
	private Integer use_point_amount;
	
	@Override
	public int compareTo(PointVO o) {
		long previous;
		try {
			long current = getTimeMillis(created_date);
			previous = getTimeMillis(o.getCreated_date());
			if (current < previous) {
				return -1;
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	private long getTimeMillis(String date) throws ParseException {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss", Locale.KOREAN);
		cal.setTime(sdf.parse(date));// all done
		return cal.getTimeInMillis();
	}
}
