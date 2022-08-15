package com.spring.javagreenS_ljs.vo;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import com.spring.javagreenS_ljs.pagination.SearchVO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ItemQnaVO extends SearchVO{
	
	private int item_qna_idx;
	
	private int user_idx;
	
	private int item_idx;
	
	@NotBlank(message="상품 문의를 작성하세요.")
	private String item_qna_content;
	
	private String view_yn;
	
	@Size(min=8, max=30 , message="비밀번호는 8자 이상 30자 이하로 작성하세요.")
	private String item_qna_pwd;
	
	private String write_date;
	private String admin_answer_yn;
	private String admin_answer;
	private String admin_answer_date;
	private String delete_yn;
	
	private String user_id;
	private String item_name;
}
 