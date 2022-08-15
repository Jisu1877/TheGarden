package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import com.spring.javagreenS_ljs.vo.PlantBoardReplyVO;
import com.spring.javagreenS_ljs.vo.PlantBoardVO;

public interface PlantBoardService {

	public void setBoardInsert(PlantBoardVO vo);

	public void imgCheck(String content);

	public ArrayList<PlantBoardVO> getBoardList(PlantBoardVO searchVO);

	public PlantBoardVO getBoardContent(int idx);

	public void setBoardViewsUp(int idx);

	public PlantBoardVO getPreBoardContent(int idx);

	public PlantBoardVO getNextBoardContent(int idx);

	public int getBoardTotalCnt(PlantBoardVO searchVO);

	public void setBoardAdminAnswer(PlantBoardVO searchVO);

	public void setBoardDelete(int idx);

	public void imgDelete(String admin_content);

	public void setBoardUpdateAdmin(PlantBoardVO searchVO, int idx);

	public void setBoardUpdate(PlantBoardVO searchVO);

	public void setBoardAdminInsert(PlantBoardVO vo);

	public void setBoardNoticeUpdate(PlantBoardVO searchVO);

	public ArrayList<PlantBoardVO> getBoardListLimit5();

	public ArrayList<PlantBoardVO> getBoardListUser(int user_idx);

	public int getPlantBoardNoAnswerCount();

	public void setBoardReplyInsert(PlantBoardReplyVO vo);

	public String getMaxLevelOrder(PlantBoardReplyVO vo);

	public ArrayList<PlantBoardReplyVO> getBoardReplyList(int idx);

	public void setLevelOrderPlusUpdate(PlantBoardReplyVO vo);

	public ArrayList<PlantBoardReplyVO> getChildReplyList(PlantBoardReplyVO vo);

	public void setReplyDeleteReal(PlantBoardReplyVO vo);

	public void setReplyDelete(PlantBoardReplyVO vo);

}
