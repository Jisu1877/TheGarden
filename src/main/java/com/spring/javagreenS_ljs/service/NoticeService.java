package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javagreenS_ljs.vo.NoticeVO;

public interface NoticeService {

	public void imgCheck(String notice_content);

	public void setNoticeInsert(MultipartHttpServletRequest file, NoticeVO vo);

	public ArrayList<NoticeVO> getPopupList();

	public NoticeVO getNoticeInfor(int notice_idx);

	public int getNoticeTotalCnt(NoticeVO searchVO);

	public ArrayList<NoticeVO> getNoticeList(NoticeVO searchVO);

	public void setViewsUp(Integer notice_idx);

	public void setNoticeDelete(NoticeVO vo);

	public void imgDelete(String notice_content);

	public void noticeUpdate(MultipartHttpServletRequest file, NoticeVO noticeVO, NoticeVO oriVO);

}
