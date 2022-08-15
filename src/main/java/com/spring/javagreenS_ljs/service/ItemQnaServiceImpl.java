package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_ljs.dao.ItemQnaDAO;
import com.spring.javagreenS_ljs.vo.ItemQnaVO;

@Service
public class ItemQnaServiceImpl implements ItemQnaService {
	
	@Autowired
	ItemQnaDAO itemQnaDAO; 
	
	@Override
	public void setItemQnaInsert(ItemQnaVO vo) {
		itemQnaDAO.setItemQnaInsert(vo);
	}

	@Override
	public ArrayList<ItemQnaVO> getItemQnaList(int item_idx) {
		return itemQnaDAO.getItemQnaList(item_idx);
	}

	@Override
	public ArrayList<ItemQnaVO> getitemQnaListAll(ItemQnaVO searchVO) {
		return itemQnaDAO.getitemQnaListAll(searchVO);
	}

	@Override
	public int getQnaTotalCnt(ItemQnaVO searchVO) {
		return itemQnaDAO.getQnaTotalCnt(searchVO);
	}

	@Override
	public ItemQnaVO getItemQnaInfor(int item_qna_idx) {
		return itemQnaDAO.getItemQnaInfor(item_qna_idx);
	}

	@Override
	public void setItemQnaAnswer(ItemQnaVO searchVO) {
		itemQnaDAO.setItemQnaAnswer(searchVO);
	}

	@Override
	public void setItemQnaDelete(ItemQnaVO searchVO) {
		itemQnaDAO.setItemQnaDelete(searchVO);
	}

	@Override
	public ArrayList<ItemQnaVO> getitemQnaListLimit5() {
		return itemQnaDAO.getitemQnaListLimit5();
	}

	@Override
	public int getItemQnaNoAnswerCount() {
		return itemQnaDAO.getItemQnaNoAnswerCount();
	}

	@Override
	public ArrayList<ItemQnaVO> getItemQnaListUser(int user_idx) {
		return itemQnaDAO.getItemQnaListUser(user_idx);
	}

}
