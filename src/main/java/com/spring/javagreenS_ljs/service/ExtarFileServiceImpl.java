package com.spring.javagreenS_ljs.service;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.javagreenS_ljs.vo.ExtraFileVO;

@Service
public class ExtarFileServiceImpl implements ExtarFileService {

	//ckeditor 폴더의 파일 모두 가져오기
	@Override
	public ArrayList<String> getExtraFileList() {
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		
		File dir = new File(uploadPath);
		String[] filenames = dir.list();
		
		ArrayList<String> extarFileList = new ArrayList<String>();
		for (int i = 0; i < filenames.length; i++) {
			if(filenames[i].contains(".")) {
				extarFileList.add(filenames[i]);
			}
		}
		
		return extarFileList;
	}

	//개별 삭제 처리
	@Override
	public void setExtarFileDelete(ExtraFileVO vo) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		
		String oFilePath = uploadPath + vo.getImage_name();
		fileDelete(oFilePath);
	}
	
	
	//원본 이미지를 삭제처리한다.(ckeditor폴더에서 삭제처리)
	private void fileDelete(String oFilePath) {
		File delFile = new File(oFilePath);
		if(delFile.exists() && delFile != null) { //이 객체가 정말 존재한다면
			delFile.delete(); //삭제해라.
		}
	}

	//전체 삭제 처리
	@Override
	public void setExtarFileDeleteAll() {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		
		File dir = new File(uploadPath);
		String[] filenames = dir.list();
		
		for (int i = 0; i < filenames.length; i++) {
			if(filenames[i].contains(".")) {
				String oFilePath = uploadPath + filenames[i];
				fileDelete(oFilePath);
			}
		}
		
	}

}
