package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import com.spring.javagreenS_ljs.vo.ExtraFileVO;

public interface ExtarFileService {

	public ArrayList<String> getExtraFileList();

	public void setExtarFileDelete(ExtraFileVO vo);

	public void setExtarFileDeleteAll();

}
