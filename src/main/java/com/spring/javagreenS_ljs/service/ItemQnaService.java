package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import com.spring.javagreenS_ljs.vo.ItemQnaVO;

public interface ItemQnaService {

	public void setItemQnaInsert(ItemQnaVO vo);

	public ArrayList<ItemQnaVO> getItemQnaList(int item_idx);

	public ArrayList<ItemQnaVO> getitemQnaListAll(ItemQnaVO searchVO);

	public int getQnaTotalCnt(ItemQnaVO searchVO);

	public ItemQnaVO getItemQnaInfor(int item_qna_idx);

	public void setItemQnaAnswer(ItemQnaVO searchVO);

	public void setItemQnaDelete(ItemQnaVO searchVO);

	public ArrayList<ItemQnaVO> getitemQnaListLimit5();

	public int getItemQnaNoAnswerCount();

	public ArrayList<ItemQnaVO> getItemQnaListUser(int user_idx);

}
