package com.spring.javagreenS_ljs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_ljs.dao.UserAdminDAO;
import com.spring.javagreenS_ljs.vo.UserVO;

@Service
public class UserAdminServiceImpl implements UserAdminService {
	
	@Autowired
	private UserAdminDAO userAdminDAO;
	
	@Override
	public int getUserListTotalCnt(UserVO userVO) {
		// TODO Auto-generated method stub
		return userAdminDAO.getUserListTotalCnt(userVO);
	}

	@Override
	public List<UserVO> getUserList(UserVO userVO) {
		return userAdminDAO.getUserList(userVO);
	}

	@Override
	public int updateUser(UserVO userVO) {
		return userAdminDAO.updateUser(userVO);
	}

}
