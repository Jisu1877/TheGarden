package com.spring.javagreenS_ljs.dao;

import java.util.List;

import com.spring.javagreenS_ljs.vo.UserVO;

public interface UserAdminDAO {

	public int getUserListTotalCnt(UserVO userVO);
	
	public List<UserVO> getUserList(UserVO userVO);
	
	public int updateUser(UserVO userVO);
}
