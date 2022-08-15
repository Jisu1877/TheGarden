package com.spring.javagreenS_ljs.dao;

import java.util.List;

import com.spring.javagreenS_ljs.vo.PointVO;

public interface PointDAO {

	public void setUsePointHistory(PointVO pointVO);

	public void setSavePointHistory(PointVO pointVO);
	
	public List<PointVO> getSavePointListByUserIdx(PointVO pointVO);
	
	public List<PointVO> getUsePointListByUserIdx(PointVO pointVO);
}
