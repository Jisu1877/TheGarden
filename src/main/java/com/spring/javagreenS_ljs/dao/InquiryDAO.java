package com.spring.javagreenS_ljs.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_ljs.vo.InquiryVO;

public interface InquiryDAO {

	public void setInquiryInsert(InquiryVO vo);

	public ArrayList<InquiryVO> getInquiryList(@Param("user_idx") int user_idx);

	public int getInquiryList(InquiryVO searchVO);

	public int getInquiryTotalCnt(InquiryVO searchVO);

	public ArrayList<InquiryVO> getInquiryListAll(InquiryVO searchVO);

	public void setInquiryAnswer(InquiryVO searchVO);

	public void setInquiryDelete(InquiryVO searchVO);

	public int getInquiryNoAnswerCount();

}
