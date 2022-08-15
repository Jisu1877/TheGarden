package com.spring.javagreenS_ljs;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javagreenS_ljs.service.OrderAdminService;
import com.spring.javagreenS_ljs.vo.OrderListVO;
import com.spring.javagreenS_ljs.vo.ShippingListVO;

@Controller
@RequestMapping("/excel")
public class ExcelController {
	
	@Autowired
	OrderAdminService orderAdminService;
	
	@RequestMapping(value = "/deliveryDownload", method = RequestMethod.GET)
	public void DeliveryDownloadGet(HttpServletResponse response, HttpSession session, String company) throws IOException {
	  //Workbook wb = new HSSFWorkbook();
      Workbook wb = new XSSFWorkbook();
      Sheet sheet = wb.createSheet("송장입력 시트");
      Row row = null;
      Cell cell = null;
      int rowNum = 0;
      
      //Header1
      row = sheet.createRow(rowNum++);
      cell = row.createCell(0);
      cell.setCellValue("※ 주문번호가 같은 상품은 동일한 송장번호를 입력하세요. 다르게 입력시 개별 발송으로 처리됩니다. ※ 엑셀 순서를 바꾸지 마세요.");
      
      // Header2
      row = sheet.createRow(rowNum++);
      cell = row.createCell(0);
      cell.setCellValue("번호");
      cell = row.createCell(1);
      cell.setCellValue("주문 목록 번호");
      cell = row.createCell(2);
      cell.setCellValue("주문 번호");
      cell = row.createCell(3);
      cell.setCellValue("상품명");
      cell = row.createCell(4);
      cell.setCellValue("옵션명");
      cell = row.createCell(5);
      cell.setCellValue("수량");
      cell = row.createCell(6);
      cell.setCellValue("수취인명");
      cell = row.createCell(7);
      cell.setCellValue("수취인 연락처");
      cell = row.createCell(8);
      cell.setCellValue("배송지(우편번호)");
      cell = row.createCell(9);
      cell.setCellValue("배송지(주소)");
      cell = row.createCell(10);
      cell.setCellValue("배송지(상세주소)");
      cell = row.createCell(11);
      cell.setCellValue("배송지(참고항목)");
      cell = row.createCell(12);
      cell.setCellValue("배송메세지");
      cell = row.createCell(13);
      cell.setCellValue("택배사");
      cell = row.createCell(14);
      cell.setCellValue("송장번호");

      //주문 확인 정보만 가져오기(+ 배송지 정보 함께)
      ArrayList<OrderListVO> orderList = orderAdminService.getOrderListWithDelivery();
      
      // Body
      for (int i=0; i<orderList.size(); i++) {
          row = sheet.createRow(rowNum++);
          cell = row.createCell(0);
          cell.setCellValue((i + 1));
          cell = row.createCell(1);
          cell.setCellValue(orderList.get(i).getOrder_list_idx());
          cell = row.createCell(2);
          cell.setCellValue(orderList.get(i).getOrder_number());
          cell = row.createCell(3);
          cell.setCellValue(orderList.get(i).getItem_name());
          cell = row.createCell(4);
          cell.setCellValue(orderList.get(i).getOption_name());
          cell = row.createCell(5);
          cell.setCellValue(orderList.get(i).getOrder_quantity());
          cell = row.createCell(6);
          cell.setCellValue(orderList.get(i).getDelivery_name());
          cell = row.createCell(7);
          cell.setCellValue(orderList.get(i).getDelivery_tel());
          cell = row.createCell(8);
          cell.setCellValue(orderList.get(i).getPostcode());
          cell = row.createCell(9);
          cell.setCellValue(orderList.get(i).getRoadAddress());
          cell = row.createCell(10);
          cell.setCellValue(orderList.get(i).getDetailAddress());
          cell = row.createCell(11);
          cell.setCellValue(orderList.get(i).getExtraAddress());
          cell = row.createCell(12);
          cell.setCellValue(orderList.get(i).getMessage());
          cell = row.createCell(13);
          cell.setCellValue(company);
          cell = row.createCell(14);
          cell.setCellValue("");
      }

      // 컨텐츠 타입과 파일명 지정
      response.setContentType("ms-vnd/excel");
      
      Date date = new Date();
      SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
      
      //response.setHeader("Content-Disposition", "attachment;filename=example.xls");
      response.setHeader("Content-Disposition", "attachment;filename=theGarden_excel_form_"+sdf.format(date)+".xlsx");

      // Excel File Output
      wb.write(response.getOutputStream());
      wb.close();
	}
	
	@Transactional(rollbackFor = Exception.class)
	@ResponseBody
	@RequestMapping(value = "/fileUpload", method = RequestMethod.POST)
	public String fileUploadPost(@RequestParam("file") MultipartFile file, Model model) throws IOException {
		
		ArrayList<ShippingListVO> ShippingList = new ArrayList<ShippingListVO>();
		
		String extension = FilenameUtils.getExtension(file.getOriginalFilename());
		
		if (!extension.equals("xlsx") && !extension.equals("xls")) {
		      throw new IOException("엑셀파일만 업로드 해주세요.");
		}
		
		Workbook workbook = new XSSFWorkbook(file.getInputStream());
		
		Sheet worksheet = workbook.getSheetAt(0); 

		for (int i = 2; i < worksheet.getPhysicalNumberOfRows(); i++) { // 4

		      Row row = worksheet.getRow(i);

		      ShippingListVO vo = new ShippingListVO();
		      
		      vo.setOrder_list_idx((int) row.getCell(1).getNumericCellValue());
		      vo.setOrder_number(row.getCell(2).getStringCellValue());
		      vo.setShipping_company(row.getCell(13).getStringCellValue());
		      
		      //아래와 같이 했을때 형변환 에러가 발생.
		      //vo.setShipping_company(row.getCell(14).getStringCellValue());
		      
		      //따라서 아래와 같이 string 타입으로 변환시켜줌.
		      Cell cell1 = row.getCell(14);
		      String invoice = new BigDecimal(String.valueOf(cell1.getNumericCellValue())).toPlainString();
		      
		      //이렇게 하면 제대로 값을 못가져 온다.
		      //Stirng invoice = cell1.toString();
		      
		      vo.setInvoice_number(invoice);
		      
		      ShippingList.add(vo);
		}
		
		//System.out.println(ShippingList.get(0));
		workbook.close();
		
		ArrayList<OrderListVO> orderList = null;
		//일괄 발송 처리 하기
		for(int i =0; i < ShippingList.size(); i++) {
			System.out.println(ShippingList.get(i));
			int order_list_idx = ShippingList.get(i).getOrder_list_idx();
			String invoice_number = ShippingList.get(i).getInvoice_number();
			String order_number = ShippingList.get(i).getOrder_number();
			String shipping_company = ShippingList.get(i).getShipping_company();
			
			System.out.println("order_number : " + order_number);
			
			if(i == 0) {
				//배송처리가 필요한 주문 건수 알아오기
				orderList = orderAdminService.getOrderCheck();
			}
			
			if(!orderList.get(i).getOrder_number().equals(order_number)) {
				return "2";
			}
			
			if(invoice_number.equals("")) {
				return "0";
			}
			
			//해당 주문 목록 상태값 변경
			orderAdminService.setOrderCodeChange(order_list_idx, "4");
			
			//배송 목록 테이블에 저장
			ShippingListVO vo = new ShippingListVO();
			
			vo.setOrder_list_idx(order_list_idx);
			vo.setInvoice_number(invoice_number);
			vo.setOrder_number(order_number);
			vo.setShipping_company(shipping_company);
			
			orderAdminService.setShippingListHistory(vo);
		}
		
		return "1";
	}
}
