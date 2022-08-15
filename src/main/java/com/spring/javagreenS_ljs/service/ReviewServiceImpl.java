package com.spring.javagreenS_ljs.service;

import java.io.File;
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

import com.spring.javagreenS_ljs.dao.ReviewDAO;
import com.spring.javagreenS_ljs.vo.ReviewVO;

@Service
public class ReviewServiceImpl implements ReviewService{
	@Autowired
	ReviewDAO reviewDAO;

	@Override
	public void setReviewInsert(ReviewVO vo, MultipartHttpServletRequest mfile) {
		try {
			String photo = "";
			List<MultipartFile> fileList = mfile.getFiles("file"); //file input 태그의 name을 ()안에 적어주기. file 안에 선택된 각 사진 파일들을 각각의 객체로 만들어주는 작업.
			
			for(MultipartFile file : fileList) {
				String oFileName = file.getOriginalFilename();
				String sFileName = saveFileName(oFileName); //서버에 저장될 파일명을 결정해준다.
				
				//서버에 파일 저장처리하기
				writeFile(file, sFileName);
				
				photo += sFileName + "/";
			}
			
			//서버에 파일 저장완료후 DB에 내역을 저장시켜준다.
			vo.setPhoto(photo);
			reviewDAO.setReviewInsert(vo);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	public void setReviewUpdate(ReviewVO vo, MultipartHttpServletRequest mfile) {
		try {
			String photo = vo.getPhoto();
			List<MultipartFile> fileList = mfile.getFiles("file"); //file input 태그의 name을 ()안에 적어주기. file 안에 선택된 각 사진 파일들을 각각의 객체로 만들어주는 작업.
			
			for(MultipartFile file : fileList) {
				String oFileName = file.getOriginalFilename();
				String sFileName = saveFileName(oFileName); //서버에 저장될 파일명을 결정해준다.
				
				//서버에 파일 저장처리하기
				writeFile(file, sFileName);
				
				photo += sFileName + "/";
			}
			
			//서버에 파일 저장완료후 DB에 내역을 저장시켜준다.
			vo.setPhoto(photo);
			reviewDAO.setReviewUpdate(vo);
			
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
			String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/review/");
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
		public ArrayList<ReviewVO> getReviewList(int item_idx) {
			return reviewDAO.getReviewList(item_idx);
		}

		@Override
		public ArrayList<ReviewVO> getReviewChartValue(int item_idx) {
			return reviewDAO.getReviewChartValue(item_idx);
		}

		@Override
		public ReviewVO getReviewRating(int item_idx) {
			return reviewDAO.getReviewRating(item_idx);
		}

		@Override
		public int getReviewTotalCnt(ReviewVO searchVO) {
			return reviewDAO.getReviewTotalCnt(searchVO);
		}

		@Override
		public ArrayList<ReviewVO> getreviewListAll(ReviewVO searchVO) {
			return reviewDAO.getreviewListAll(searchVO);
		}

		@Override
		public void setReviewDelete(ReviewVO vo) {
			reviewDAO.setReviewDelete(vo);
		}

		@Override
		public ArrayList<ReviewVO> getReviewListUser(int user_idx) {
			return reviewDAO.getReviewListUser(user_idx);
		}

		@Override
		public ReviewVO getReviewInfor(Integer review_idx) {
			return reviewDAO.getReviewInfor(review_idx);
		}

		@Override
		public void reviewImageDel(ReviewVO vo, String image_name) {
			//서버에서 해당 사진을 삭제시킨다.
			ItemimgDelete(image_name);
			
			//DB에 저장할 Photo를 가공처리
			String photo = vo.getPhoto();
			
			String[] photoArray = photo.split("/");
			
			String newPhoto = "";
			for(int i = 0; i < photoArray.length; i++) {
				if(!photoArray[i].equals(image_name)) {
					newPhoto += photoArray[i] + "/";
				}
			}
			
			vo.setPhoto(newPhoto);
			
			//DB에 새로 저장시키기
			reviewDAO.setReviewPhotoUpdate(vo);
		}
		
		public void ItemimgDelete(String image_name) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
			String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/review/");
			
			//원본 사진 경로
			String oFilePath = uploadPath + image_name;
			fileDelete(oFilePath); //review폴더에 존재하는 파일을 삭제처리한다.
		}
		
		//원본 이미지를 삭제처리한다.(review폴더에서 삭제처리)
		private void fileDelete(String oFilePath) {
			File delFile = new File(oFilePath);
			if(delFile.exists() && delFile != null) { //이 객체가 정말 존재한다면
				delFile.delete(); //삭제해라.
			}
		}



}
