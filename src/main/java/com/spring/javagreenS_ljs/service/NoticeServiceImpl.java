package com.spring.javagreenS_ljs.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javagreenS_ljs.dao.NoticeDAO;
import com.spring.javagreenS_ljs.vo.NoticeVO;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	NoticeDAO noticeDAO;
	
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
			String copyFilePath = uploadPath + "notice/" + imgFileName;
			
			fileCopy(oFilePath,copyFilePath); //복사할 폴더에 파일을 복사처리한다.
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}
	
	//실제 서버에(ckeditor) 저장되어 있는 파일을 notice폴더로 복사처리한다.
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
		public void setNoticeInsert(MultipartHttpServletRequest mfile, NoticeVO vo) {
			try {
				String photo = "";
				List<MultipartFile> fileList = mfile.getFiles("file"); //file input 태그의 name을 ()안에 적어주기. file 안에 선택된 각 사진 파일들을 각각의 객체로 만들어주는 작업.
				
				int sw = 0;
				
				for(MultipartFile file : fileList) {
					String oFileName = file.getOriginalFilename();
					if(oFileName.equals("")) {
						sw = 1;
					}
					String sFileName = saveFileName(oFileName); //서버에 저장될 파일명을 결정해준다.
					
					if(sw == 0) {
						//서버에 파일 저장처리하기
						writeFile(file, sFileName);
						
						photo += sFileName;
					}
				}
				
				//서버에 파일 저장완료후 DB에 내역을 저장시켜준다.
				if(sw == 0) {
					vo.setFiles(photo);
				}
				else {
					vo.setFiles(null);
				}
				noticeDAO.setNoticeInsert(vo);
				
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			
			
		}

		//서버에 파일 저장하기
		private void writeFile(MultipartFile file, String sFileName) throws IOException {
			byte[] data = file.getBytes(); //넘어온 객체를 byte 단위로 변경시켜줌.
			
			//request 객체 꺼내오기.
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
			//실제로 업로드되는 경로를 찾아오기
			String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/notice/");
			//이 경로에 이 파일이름으로 저장할 껍데기 만들기
			FileOutputStream fos = new FileOutputStream(uploadPath + sFileName);
			fos.write(data); //내용물 채우기
			fos.close();
		}

		//저장되는 파일명의 중복을 방지하기 위해 새로 파일명을 만들어준다.
		private String saveFileName(String oFileName) {
			String fileName = "";

			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");

			fileName += sdf.format(date) + "_" + oFileName;

			return fileName;
		}
		
		@Override
		public ArrayList<NoticeVO> getPopupList() {
			return noticeDAO.getPopupList();
		}

		@Override
		public NoticeVO getNoticeInfor(int notice_idx) {
			return noticeDAO.getNoticeInfor(notice_idx);
		}

		@Override
		public int getNoticeTotalCnt(NoticeVO searchVO) {
			return noticeDAO.getNoticeTotalCnt(searchVO);
		}

		@Override
		public ArrayList<NoticeVO> getNoticeList(NoticeVO searchVO) {
			return noticeDAO.getNoticeList(searchVO);
		}

		@Override
		public void setViewsUp(Integer notice_idx) {
			noticeDAO.setViewsUp(notice_idx);
		}

		@Override
		public void setNoticeDelete(NoticeVO vo) {
			noticeDAO.setNoticeDelete(vo);
		}

		@Override //plantBoard 폴더에 있는 해당 idx의 이미지 삭제처리
		public void imgDelete(String content) {
			//                1         2         3         4         5             
			//      012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
			// <img src="/javagreenS_ljs/data/ckeditor/notice/220706101701_Geoff2.jpg" style="height:1217px; width:972px" />
			// <img src="/javagreenS_ljs/data/ckeditor/220706101701_Geoff2.jpg" style="height:1217px; width:972px" />
		
			//이 작업은 content안에 그림파일(img src="/)가 있을때만 수행한다.
			if(content.indexOf("src=\"/") == -1) return;
			
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
			String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/notice/");
			
			int position = 42; 
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
		public void noticeUpdate(MultipartHttpServletRequest mfile, NoticeVO vo, NoticeVO oriVO) {
			//DB저장 전에 첨부파일이 비어있지 않다면 기존 파일을 삭제하고 등록 루틴...
			try {
				String photo = "";
				List<MultipartFile> fileList = mfile.getFiles("file"); //file input 태그의 name을 ()안에 적어주기. file 안에 선택된 각 사진 파일들을 각각의 객체로 만들어주는 작업.
				
				int sw = 0;
				
				for(MultipartFile file : fileList) {
					String oFileName = file.getOriginalFilename();
					if(oFileName.equals("")) {
						sw = 1;
					}
					if(sw == 0) {
						
						String sFileName = saveFileName(oFileName); //서버에 저장될 파일명을 결정해준다.
						//서버에 파일 저장처리하기
						writeFile(file, sFileName);
						
						HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
						String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/notice/");
						
						//원본 사진 경로
						String oFilePath = uploadPath + oriVO.getFiles();
						//기존의 파일은 삭제하기
						fileDelete(oFilePath); //plantBoard폴더에 존재하는 파일을 삭제처리한다.
						
						photo += sFileName;
					}
				}
				
				//서버에 파일 저장완료후 DB에 내역을 저장시켜준다.
				if(sw == 0) {
					vo.setFiles(photo);
				}
				else {
					vo.setFiles(oriVO.getFiles());
				}
				noticeDAO.setNoticeUpdate(vo);
				
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}


}
