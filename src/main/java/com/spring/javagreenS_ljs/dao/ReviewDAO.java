package com.spring.javagreenS_ljs.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_ljs.vo.ReviewVO;

public interface ReviewDAO {

	public void setReviewInsert(@Param("vo") ReviewVO vo);

	public ArrayList<ReviewVO> getReviewList(@Param("item_idx") int item_idx);

	public ArrayList<ReviewVO> getReviewChartValue(@Param("item_idx") int item_idx);

	public ReviewVO getReviewRating(@Param("item_idx") int item_idx);

	public int getReviewTotalCnt(ReviewVO searchVO);

	public ArrayList<ReviewVO> getreviewListAll(ReviewVO searchVO);

	public void setReviewDelete(ReviewVO vo);

	public ArrayList<ReviewVO> getReviewListUser(@Param("user_idx") int user_idx);

	public ReviewVO getReviewInfor(Integer review_idx);

	public void setReviewPhotoUpdate(ReviewVO vo);

	public void setReviewUpdate(ReviewVO vo);

}
