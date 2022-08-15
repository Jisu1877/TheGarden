package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import com.spring.javagreenS_ljs.vo.OfflineStoreVO;

public interface OfflineStoreService {

	public void setStoreInsert(OfflineStoreVO vo);

	public ArrayList<OfflineStoreVO> getStoreList();

	public int totRecCnt(OfflineStoreVO searchVO);

	public ArrayList<OfflineStoreVO> getStoreListSearch(OfflineStoreVO searchVO);

	public void setStoreDelete(Integer offline_store_idx);

}
