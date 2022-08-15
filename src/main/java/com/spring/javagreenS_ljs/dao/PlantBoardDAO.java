package com.spring.javagreenS_ljs.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_ljs.vo.PlantBoardReplyVO;
import com.spring.javagreenS_ljs.vo.PlantBoardVO;

public interface PlantBoardDAO {

	public void setBoardInsert(@Param("vo") PlantBoardVO vo);

	public ArrayList<PlantBoardVO> getBoardList(PlantBoardVO searchVO);

	public PlantBoardVO getBoardContent(@Param("idx") int idx);

	public void setBoardViewsUp(@Param("idx") int idx);

	public PlantBoardVO getPreBoardContent(@Param("idx") int idx);

	public PlantBoardVO getNextBoardContent(@Param("idx") int idx);

	public int getBoardTotalCnt(PlantBoardVO searchVO);

	public void setBoardAdminAnswer(PlantBoardVO searchVO);

	public void setBoardDelete(@Param("idx") int idx);

	public void setBoardUpdateAdmin(@Param("searchVO") PlantBoardVO searchVO, @Param("idx") int idx);

	public void setBoardUpdate(PlantBoardVO searchVO);

	public void setBoardAdminInsert(@Param("vo") PlantBoardVO vo);

	public void setBoardNoticeUpdate(PlantBoardVO searchVO);

	public ArrayList<PlantBoardVO> getBoardListLimit5();

	public ArrayList<PlantBoardVO> getBoardListUser(@Param("user_idx") int user_idx);

	public int getPlantBoardNoAnswerCount();

	public String getMaxLevelOrder(@Param("vo") PlantBoardReplyVO vo);

	public void setBoardReplyInsert(PlantBoardReplyVO vo);

	public ArrayList<PlantBoardReplyVO> getBoardReplyList(@Param("idx") int idx);

	public void setLevelOrderPlusUpdate(PlantBoardReplyVO vo);

	public ArrayList<PlantBoardReplyVO> getChildReplyList(PlantBoardReplyVO vo);

	public void setReplyDeleteReal(PlantBoardReplyVO vo);

	public void setReplyDelete(PlantBoardReplyVO vo);
}
