package com.spring.javagreenS_ljs.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.javagreenS_ljs.dao.PlantBoardDAO;
import com.spring.javagreenS_ljs.vo.PlantBoardReplyVO;
import com.spring.javagreenS_ljs.vo.PlantBoardVO;

@Service
public class PlantBoardServiceImpl implements PlantBoardService{

	@Autowired
	PlantBoardDAO plantBoardDAO;
	
	@Override
	public void setBoardInsert(PlantBoardVO vo) {
		plantBoardDAO.setBoardInsert(vo);
	}
	
	
	// 상품의 상세설명 글을 등록 / 수정 할때 사용하는 메소드.
	@Override
	public void imgCheck(String content) {
		//                1         2         3         4         5             
		//      012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
		// <img src="/javagreenS_ljs/data/ckeditor/220706101701_Geoff2.jpg" style="height:1217px; width:972px" />
		
		//이 작업은 content안에 그림파일(img src="/)가 있을때만 수행한다.
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		
		int position = 35;  //src="/javagreenS_ljs/data/ckeditor/ 이 해당 경로가 어떻게 될지 모르기에 실제 파일명이 시작되는 index번호를 세서 작성한다.
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		
		boolean sw = true;
		while(sw) {
			String imgFileName = nextImg.substring(0,nextImg.indexOf("\""));
			
			//원본 사진 경로
			String oFilePath = uploadPath + imgFileName;
			//복사한 사진 저장할 경로
			String copyFilePath = uploadPath + "plantBoard/" + imgFileName;
			
			fileCopy(oFilePath,copyFilePath); //복사할 폴더에 파일을 복사처리한다.
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}
	
	
	//실제 서버에(ckeditor) 저장되어 있는 파일을 plantBoard폴더로 복사처리한다.
	public void fileCopy(String oFilePath, String copyFilePath) {
		File oFile = new File(oFilePath);
		File copyFile = new File(copyFilePath);
		
		try {
			FileInputStream fis = new FileInputStream(oFile); //꺼내기
			FileOutputStream fos = new FileOutputStream(copyFile); //저장할 껍데기 만들기
			
			byte[] buffer = new byte[2048];
			int count = 0;
			while((count = fis.read(buffer)) != -1) {
				fos.write(buffer, 0, count); 
			}
			
			fos.flush();
			fos.close();
			fis.close();
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public ArrayList<PlantBoardVO> getBoardList(PlantBoardVO searchVO) {
		return plantBoardDAO.getBoardList(searchVO);
	}

	@Override
	public PlantBoardVO getBoardContent(int idx) {
		return plantBoardDAO.getBoardContent(idx);
	}

	@Override
	public void setBoardViewsUp(int idx) {
		plantBoardDAO.setBoardViewsUp(idx);
	}

	@Override
	public PlantBoardVO getPreBoardContent(int idx) {
		return plantBoardDAO.getPreBoardContent(idx);
	}

	@Override
	public PlantBoardVO getNextBoardContent(int idx) {
		return plantBoardDAO.getNextBoardContent(idx);
	}

	@Override
	public int getBoardTotalCnt(PlantBoardVO searchVO) {
		return plantBoardDAO.getBoardTotalCnt(searchVO);
	}

	@Override
	public void setBoardAdminAnswer(PlantBoardVO searchVO) {
		plantBoardDAO.setBoardAdminAnswer(searchVO);
	}

	@Override
	public void setBoardDelete(int idx) {
		plantBoardDAO.setBoardDelete(idx);
	}

	@Override //plantBoard 폴더에 있는 해당 idx의 이미지 삭제처리
	public void imgDelete(String content) {
		//                1         2         3         4         5             
		//      012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
		// <img src="/javagreenS_ljs/data/ckeditor/plantBoard/220706101701_Geoff2.jpg" style="height:1217px; width:972px" />
		// <img src="/javagreenS_ljs/data/ckeditor/220706101701_Geoff2.jpg" style="height:1217px; width:972px" />
	
		//이 작업은 content안에 그림파일(img src="/)가 있을때만 수행한다.
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/plantBoard/");
		
		int position = 46; 
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		
		boolean sw = true;
		while(sw) {
			String imgFileName = nextImg.substring(0,nextImg.indexOf("\""));
			
			//원본 사진 경로
			String oFilePath = uploadPath + imgFileName;
			fileDelete(oFilePath); //plantBoard폴더에 존재하는 파일을 삭제처리한다.
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}
	
	//원본 이미지를 삭제처리한다.(itemContent폴더에서 삭제처리)
	private void fileDelete(String oFilePath) {
		File delFile = new File(oFilePath);
		if(delFile.exists() && delFile != null) { //이 객체가 정말 존재한다면
			delFile.delete(); //삭제해라.
		}
	}

	@Override
	public void setBoardUpdateAdmin(PlantBoardVO searchVO, int idx) {
		plantBoardDAO.setBoardUpdateAdmin(searchVO, idx);
	}


	@Override
	public void setBoardUpdate(PlantBoardVO searchVO) {
		plantBoardDAO.setBoardUpdate(searchVO);
	}


	@Override
	public void setBoardAdminInsert(PlantBoardVO vo) {
		plantBoardDAO.setBoardAdminInsert(vo);
	}


	@Override
	public void setBoardNoticeUpdate(PlantBoardVO searchVO) {
		plantBoardDAO.setBoardNoticeUpdate(searchVO);
	}


	@Override
	public ArrayList<PlantBoardVO> getBoardListLimit5() {
		return plantBoardDAO.getBoardListLimit5();
	}


	@Override
	public ArrayList<PlantBoardVO> getBoardListUser(int user_idx) {
		return plantBoardDAO.getBoardListUser(user_idx);
	}


	@Override
	public int getPlantBoardNoAnswerCount() {
		return plantBoardDAO.getPlantBoardNoAnswerCount();
	}


	@Override
	public void setBoardReplyInsert(PlantBoardReplyVO vo) {
		plantBoardDAO.setBoardReplyInsert(vo);
	}


	@Override
	public String getMaxLevelOrder(PlantBoardReplyVO vo) {
		return plantBoardDAO.getMaxLevelOrder(vo);
	}


	@Override
	public ArrayList<PlantBoardReplyVO> getBoardReplyList(int idx) {
		return plantBoardDAO.getBoardReplyList(idx);
	}


	@Override
	public void setLevelOrderPlusUpdate(PlantBoardReplyVO vo) {
		plantBoardDAO.setLevelOrderPlusUpdate(vo);
	}


	@Override
	public ArrayList<PlantBoardReplyVO> getChildReplyList(PlantBoardReplyVO vo) {
		return plantBoardDAO.getChildReplyList(vo);
	}


	@Override
	public void setReplyDeleteReal(PlantBoardReplyVO vo) {
		plantBoardDAO.setReplyDeleteReal(vo);
	}


	@Override
	public void setReplyDelete(PlantBoardReplyVO vo) {
		plantBoardDAO.setReplyDelete(vo);
	}


}
