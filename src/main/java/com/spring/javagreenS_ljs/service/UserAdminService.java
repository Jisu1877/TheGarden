package com.spring.javagreenS_ljs.service;

import java.util.List;

import com.spring.javagreenS_ljs.vo.UserVO;

public interface UserAdminService {
	
	public int getUserListTotalCnt(UserVO userVO);

	public List<UserVO> getUserList(UserVO userVO);

	public int updateUser(UserVO userVO);
}
