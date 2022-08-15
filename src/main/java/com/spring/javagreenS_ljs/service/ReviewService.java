package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javagreenS_ljs.vo.ReviewVO;

public interface ReviewService {

	public void setReviewInsert(ReviewVO vo, MultipartHttpServletRequest file);

	public ArrayList<ReviewVO> getReviewList(int item_idx);

	public ArrayList<ReviewVO> getReviewChartValue(int item_idx);

	public ReviewVO getReviewRating(int item_idx);

	public int getReviewTotalCnt(ReviewVO searchVO);

	public ArrayList<ReviewVO> getreviewListAll(ReviewVO searchVO);

	public void setReviewDelete(ReviewVO vo);

	public ArrayList<ReviewVO> getReviewListUser(int user_idx);

	public ReviewVO getReviewInfor(Integer review_idx);

	public void reviewImageDel(ReviewVO vo, String image_name);

	public void setReviewUpdate(ReviewVO vo, MultipartHttpServletRequest file);

}
