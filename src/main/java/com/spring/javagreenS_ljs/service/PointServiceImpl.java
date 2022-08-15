package com.spring.javagreenS_ljs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_ljs.dao.PointDAO;
import com.spring.javagreenS_ljs.vo.PointVO;

@Service
public class PointServiceImpl implements PointService {

	@Autowired
	PointDAO pointDAO;
	
	@Override
	public void setUsePointHistory(PointVO pointVO) {
		pointDAO.setUsePointHistory(pointVO);
	}

	@Override
	public void setSavePointHistory(PointVO pointVO) {
		pointDAO.setSavePointHistory(pointVO);
	}

	@Override
	public List<PointVO> getSavePointListByUserIdx(PointVO pointVO) {
		return pointDAO.getSavePointListByUserIdx(pointVO);
	}
	
	@Override
	public List<PointVO> getUsePointListByUserIdx(PointVO pointVO) {
		return pointDAO.getUsePointListByUserIdx(pointVO);
	}

}
