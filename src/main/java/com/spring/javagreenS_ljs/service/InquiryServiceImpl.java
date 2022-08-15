package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_ljs.dao.InquiryDAO;
import com.spring.javagreenS_ljs.vo.InquiryVO;

@Service
public class InquiryServiceImpl implements InquiryService {

	@Autowired
	InquiryDAO inquiryDAO; 
	
	@Override
	public void setInquiryInsert(InquiryVO vo) {
		inquiryDAO.setInquiryInsert(vo);
	}

	@Override
	public ArrayList<InquiryVO> getInquiryList(int user_idx) {
		return inquiryDAO.getInquiryList(user_idx);
	}

	@Override
	public int getInquiryTotalCnt(InquiryVO searchVO) {
		return inquiryDAO.getInquiryTotalCnt(searchVO);
	}

	@Override
	public ArrayList<InquiryVO> getInquiryListAll(InquiryVO searchVO) {
		return inquiryDAO.getInquiryListAll(searchVO);
	}

	@Override
	public void setInquiryAnswer(InquiryVO searchVO) {
		inquiryDAO.setInquiryAnswer(searchVO);
	}

	@Override
	public void setInquiryDelete(InquiryVO searchVO) {
		inquiryDAO.setInquiryDelete(searchVO);
	}

	@Override
	public int getInquiryNoAnswerCount() {
		return inquiryDAO.getInquiryNoAnswerCount();
	}

}
