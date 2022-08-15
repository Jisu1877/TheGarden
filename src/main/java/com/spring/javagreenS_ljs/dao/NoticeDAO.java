package com.spring.javagreenS_ljs.dao;

import java.util.ArrayList;

import com.spring.javagreenS_ljs.vo.NoticeVO;

public interface NoticeDAO {

	public void setNoticeInsert(NoticeVO vo);

	public ArrayList<NoticeVO> getPopupList();

	public NoticeVO getNoticeInfor(int notice_idx);

	public int getNoticeTotalCnt(NoticeVO searchVO);

	public ArrayList<NoticeVO> getNoticeList(NoticeVO searchVO);

	public void setViewsUp(Integer notice_idx);

	public void setNoticeDelete(NoticeVO vo);

	public void setNoticeUpdate(NoticeVO vo);

}
