package com.spring.javagreenS_ljs.dao;

import java.util.ArrayList;

import com.spring.javagreenS_ljs.vo.OfflineStoreVO;

public interface OfflineStoreDAO {

	public void setStoreInsert(OfflineStoreVO vo);

	public ArrayList<OfflineStoreVO> getStoreList();

	public int totRecCnt();

	public ArrayList<OfflineStoreVO> getStoreListSearch(OfflineStoreVO searchVO);

	public void setStoreDelete(Integer offline_store_idx);

}
