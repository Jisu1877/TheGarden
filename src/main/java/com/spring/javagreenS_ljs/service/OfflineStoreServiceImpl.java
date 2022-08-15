package com.spring.javagreenS_ljs.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.spring.javagreenS_ljs.dao.OfflineStoreDAO;
import com.spring.javagreenS_ljs.vo.OfflineStoreVO;

@Service
public class OfflineStoreServiceImpl implements OfflineStoreService {

	@Autowired
	OfflineStoreDAO offlineStoreDAO;
	
	@Override
	public void setStoreInsert(OfflineStoreVO vo) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmm");
		UUID uid = UUID.randomUUID();
		String strUid = uid.toString().substring(0,4);
		String qrCodeName = "";
		qrCodeName = sdf.format(new Date()) + "_" + vo.getStore_name() + "_" + strUid;
		String img = qrCodeName + ".png";
	    vo.setQr_image(img);
		
		try {
		      File file = new File(vo.getUploadPath());		// qr코드 이미지를 저장할 디렉토리 지정
		      if(!file.exists()) {
		          file.mkdirs();
		      }
		      String codeurl = new String(vo.getQr_url().getBytes("UTF-8"), "ISO-8859-1");	// qr코드 인식시 이동할 url 주소
		      //int qrcodeColor = 0xFF2e4e96;			// qr코드 바코드 생성값(전경색)
		      int qrcodeColor = 0xFF000000;			// qr코드 바코드 생성값(전경색) - 뒤의 6자리가 색상코드임
		      int backgroundColor = 0xFFFFFFFF;	// qr코드 배경색상값
		      
		      QRCodeWriter qrCodeWriter = new QRCodeWriter();
		      BitMatrix bitMatrix = qrCodeWriter.encode(codeurl, BarcodeFormat.QR_CODE,200, 200);
		      
		      MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrcodeColor,backgroundColor);
		      BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix,matrixToImageConfig);
		      
		      ImageIO.write(bufferedImage, "png", new File(vo.getUploadPath() + qrCodeName + ".png"));		// ImageIO를 사용한 바코드 파일쓰기
		      
		      offlineStoreDAO.setStoreInsert(vo);
		      
		  } catch (Exception e) {
		      e.printStackTrace();
		  }
		
	}

	@Override
	public ArrayList<OfflineStoreVO> getStoreList() {
		return offlineStoreDAO.getStoreList();
	}

	@Override
	public int totRecCnt(OfflineStoreVO searchVO) {
		return offlineStoreDAO.totRecCnt();
	}

	@Override
	public ArrayList<OfflineStoreVO> getStoreListSearch(OfflineStoreVO searchVO) {
		return offlineStoreDAO.getStoreListSearch(searchVO);
	}

	@Override
	public void setStoreDelete(Integer offline_store_idx) {
		offlineStoreDAO.setStoreDelete(offline_store_idx);
	}
	
}
