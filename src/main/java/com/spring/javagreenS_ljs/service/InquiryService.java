package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import com.spring.javagreenS_ljs.vo.InquiryVO;

public interface InquiryService {

	public void setInquiryInsert(InquiryVO vo);

	public ArrayList<InquiryVO> getInquiryList(int user_idx);

	public int getInquiryTotalCnt(InquiryVO searchVO);

	public ArrayList<InquiryVO> getInquiryListAll(InquiryVO searchVO);

	public void setInquiryAnswer(InquiryVO searchVO);

	public void setInquiryDelete(InquiryVO searchVO);

	public int getInquiryNoAnswerCount();

}
