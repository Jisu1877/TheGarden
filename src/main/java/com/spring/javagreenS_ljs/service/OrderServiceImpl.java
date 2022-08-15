package com.spring.javagreenS_ljs.service;

import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javagreenS_ljs.dao.CartDAO;
import com.spring.javagreenS_ljs.dao.DeliveryDAO;
import com.spring.javagreenS_ljs.dao.ItemDAO;
import com.spring.javagreenS_ljs.dao.OrderDAO;
import com.spring.javagreenS_ljs.dao.PointDAO;
import com.spring.javagreenS_ljs.dao.UserDAO;
import com.spring.javagreenS_ljs.vo.OrderCancelVO;
import com.spring.javagreenS_ljs.vo.OrderExchangeVO;
import com.spring.javagreenS_ljs.vo.OrderListVO;
import com.spring.javagreenS_ljs.vo.OrderReturnVO;
import com.spring.javagreenS_ljs.vo.OrderVO;
import com.spring.javagreenS_ljs.vo.PayMentVO;
import com.spring.javagreenS_ljs.vo.PointVO;
import com.spring.javagreenS_ljs.vo.ShippingListVO;
import com.spring.javagreenS_ljs.vo.UserDeliveryVO;
import com.spring.javagreenS_ljs.vo.UserVO;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	OrderDAO orderDAO;

	@Autowired
	UserDAO userDAO;
	
	@Autowired
	DeliveryDAO diDeliveryDAO;
	
	@Autowired
	CartDAO cartDAO;
	
	@Autowired
	PointDAO pointDAO;
	
	@Autowired
	ItemDAO itemDAO;
	
	@Override
	public void setOrderListTempInsert(OrderVO orderVO, int user_idx) { 
		String[] order_item_idx = orderVO.getOrder_item_idx();
		String[] order_item_name = orderVO.getOrder_item_name();
 		String[] order_item_image = orderVO.getOrder_item_image();
		int[] order_item_price = orderVO.getOrder_item_price();
		String[] order_item_option_flag = orderVO.getOrder_item_option_flag();
		String[] order_option_idx = orderVO.getOrder_option_idx();
		String[] order_option_name = orderVO.getOrder_option_name();
		String[] order_option_price = orderVO.getOrder_option_price();
		String[] order_quantity = orderVO.getOrder_quantity();
		String[] strCart_idx = orderVO.getCart_idx();
		
		for(int i = 0; i < order_item_idx.length; i++) { //여기가 문제다 문제 ㅠㅠ 바로구매하면 옵션2개를 선택해도 1개만 들어간당..
			OrderListVO vo = new OrderListVO();
			
			vo.setUser_idx(user_idx);
			
			int item_idx = Integer.parseInt(order_item_idx[i]);
			int cart_idx = Integer.parseInt(strCart_idx[i]);
			int option_idx = 0;
			
			if(order_option_idx.length > 0) {
				if(!order_option_idx[i].equals("")) {
					option_idx = Integer.parseInt(order_option_idx[i]);
				}
			}
			
			int quantity = Integer.parseInt(order_quantity[i]);
			vo.setItem_idx(item_idx);
			vo.setItem_name(order_item_name[i]);
			vo.setItem_image(order_item_image[i]);
			vo.setItem_price(order_item_price[i]);
			vo.setItem_option_flag(order_item_option_flag[i]);
			vo.setOption_idx(option_idx);
			vo.setOption_name(order_option_name[i]);
			vo.setOption_price(order_option_price[i]);
			vo.setOrder_quantity(quantity);
			vo.setCart_idx(cart_idx);
			
			orderDAO.setOrderListTempInsert(vo);
		}
	}
	
	@Override
	public void setOrderListTempInsertForBuyNow(OrderVO orderVO, int user_idx) {
		String[] order_item_idx = orderVO.getOrder_item_idx();
		String[] order_item_name = orderVO.getOrder_item_name();
 		String[] order_item_image = orderVO.getOrder_item_image();
		int[] order_item_price = orderVO.getOrder_item_price();
		String[] order_item_option_flag = orderVO.getOrder_item_option_flag();
		String[] order_option_idx = orderVO.getOrder_option_idx();
		String[] order_option_name = orderVO.getOrder_option_name();
		String[] order_option_price = orderVO.getOrder_option_price();
		String[] order_quantity = orderVO.getOrder_quantity();
		String[] strCart_idx = orderVO.getCart_idx();
		
		for(int i = 0; i < order_item_idx.length; i++) { //여기가 문제다 문제 ㅠㅠ 바로구매하면 옵션2개를 선택해도 1개만 들어간당..
			OrderListVO vo = new OrderListVO();
			
			vo.setUser_idx(user_idx);
			
			int item_idx = Integer.parseInt(order_item_idx[i]);
			int cart_idx = Integer.parseInt(strCart_idx[i]);
			int option_idx = 0;
			
			if(order_option_idx.length > 0) {
				if(!order_option_idx[i].equals("")) {
					option_idx = Integer.parseInt(order_option_idx[i]);
				}
			}
			
			int quantity = Integer.parseInt(order_quantity[i]);
			vo.setItem_idx(item_idx);
			vo.setItem_name(order_item_name[i]);
			vo.setItem_image(order_item_image[i]);
			vo.setItem_option_flag(order_item_option_flag[i]);
			vo.setOption_idx(option_idx);
			vo.setOption_name(order_option_name[i]);
			vo.setOption_price(order_option_price[i]);
			vo.setOrder_quantity(quantity);
			vo.setCart_idx(cart_idx);
			
			if(order_option_idx.length == 1)  {
				vo.setItem_price(order_item_price[0]);
			}
			else {
				vo.setItem_price(order_item_price[0]);
			}
			
			orderDAO.setOrderListTempInsert(vo);
		}
	}

	@Override
	public void setOrderListTempDelete(int user_idx) {
		orderDAO.setOrderListTempDelete(user_idx);
	}

	@Override
	public void setOrder_total_amount_and_point(OrderVO temp) {
		orderDAO.setOrder_total_amount_and_point(temp);
	}

	@Override
	public ArrayList<OrderListVO> getOrderListTempList(int user_idx) {
		return orderDAO.getOrderListTempList(user_idx);
	}
	
	
	@Transactional(rollbackFor = Exception.class) //트랜잭션 처리 
	@Override
	public void setOrderProcess(String user_id, int user_idx, PayMentVO payMentVO) {
		//임시 주문 목록 정보 가져오기
		ArrayList<OrderListVO> orderListTemp = orderDAO.getOrderListTempList(user_idx);
		
		//회원 정보 가져오기
		UserVO userVO = userDAO.getUserInfor(user_id);
		
		//회원 선택 배송지 정보 가져오기
		UserDeliveryVO deliveryVO = diDeliveryDAO.getDeliveryVO(user_idx);
		
		// 필요한 정보 vo set
		OrderVO orderVO = new OrderVO();
		
		int total_amount = orderListTemp.get(0).getOrder_total_amount();
		
		orderVO.setUser_idx(user_idx);
		orderVO.setOrder_total_amount(total_amount);
		orderVO.setEmail(userVO.getEmail());
		orderVO.setTel(userVO.getTel());
		orderVO.setUser_delivery_idx(deliveryVO.getUser_delivery_idx());
		
		//사용 포인트
		int point = orderListTemp.get(0).getUse_point();
		orderVO.setUse_point(point);
		
		//사용 쿠폰 할인
		int coupon_user_idx = orderListTemp.get(0).getCoupon_user_idx();
		int coupon_amount = orderListTemp.get(0).getCoupon_amount();
		orderVO.setCoupon_amount(coupon_amount);
		orderVO.setCoupon_user_idx(coupon_user_idx);
		
		//주문번호 만들기
		String applyNum = payMentVO.getApply_num();
		//주문 테이블 최대 idx 알아오기
		int orderMaxIdx = (orderDAO.getOrderMaxIdx() + 1);
		String order_number = applyNum + "_" + orderMaxIdx;
		orderVO.setOrder_number(order_number);
		
		// 주문 테이블 저장
		orderDAO.setOrderHistory(orderVO);
		
		//방금 저장한 order_idx 알아오기
		int order_idx  = orderDAO.getOrderIdx(user_idx);
		
		for(int i = 0; i < orderListTemp.size(); i++) {
			//주문 목록 테이블 저장
			OrderListVO vo = orderListTemp.get(i);
			vo.setOrder_idx(order_idx);
			orderDAO.setOrderListHistory(vo);
			
			//장바구니 삭제(주문한 물품만)
			if(vo.getCart_idx() != 0) {
				cartDAO.setCartDelete(vo.getCart_idx());
			}
			
			//상품 정보 수정(상품 재고 수량 차감 / 판매수량 증가 처리)
			int item_idx = orderListTemp.get(i).getItem_idx();
			int quantity = orderListTemp.get(i).getOrder_quantity();
			itemDAO.setOrderUpdate(item_idx,quantity);
			
			if(vo.getItem_option_flag().equals("y")) {
				//옵션 재고 수량 차감
				itemDAO.setOptionStockQuantityUpdate(vo.getOption_idx(),quantity);
				
				//옵션 품절 여부 체크
				int option_quantity = itemDAO.getOptionStockquantity(vo.getOption_idx());
				String sold_out = "0";
				
				if(option_quantity == 0) {
					sold_out = "1";
				}
				else if(option_quantity > 0){
					sold_out = "0";
				}
				else { //만약 음수값이 들어온다면..
					sold_out = "1";
				}
				
				//옵션 품절 여부 업데이트
				itemDAO.setOptionSoldOutUpdate(vo.getOption_idx(),sold_out);
			}
			
			//상품 품절 여부 체크
			int stock_quantity = itemDAO.getStockquantity(item_idx);
			String sold_out = "0";
			
			if(stock_quantity == 0) {
				sold_out = "1";
			}
			else if(stock_quantity > 0){
				sold_out = "0";
			}
			else { //만약 음수값이 들어온다면..
				sold_out = "1";
			}
			
			//품절 여부 업데이트
			itemDAO.setSoldOutUpdate(item_idx,sold_out);
			
		}
		
		//포인트 사용 시 포인트 사용 내용 저장
		if(point != 0) {
			PointVO pointVO = new PointVO();
			pointVO.setUser_idx(user_idx);
			pointVO.setUse_point_amount(point);
			pointVO.setOrder_idx(order_idx);
			pointDAO.setUsePointHistory(pointVO);
			
			//회원 포인트 차감
			userDAO.setPointUseUpate(user_idx, point);
		}
		
		//쿠폰 사용시 해당 쿠폰 '사용됨'으로 업뎃처리
		if(coupon_amount != 0) {
			userDAO.setCouponUseFlag(coupon_user_idx);
		}
		
		//임시 DB 삭제
		orderDAO.setOrderListTempDelete(user_idx);
		
	}
	
	//마이페이지에서 호출/회원별 주문 목록 조회(이번 달 주문 건만)
	@Override
	public ArrayList<OrderListVO> getOrderListOnlyThisMonth(int user_idx) {
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");        
        Date now = new Date();
        String nowDate = sdf1.format(now);
		
        LocalDate date = LocalDate.parse(nowDate);
        
        //이번달의 첫날
        LocalDate firstDate = date.withDayOfMonth(1);
        //이번달의 마지막날
        LocalDate lastDate = date.withDayOfMonth(date.lengthOfMonth());
		
		return orderDAO.getOrderListOnlyThisMonth(user_idx, firstDate.toString(), lastDate.toString());
	}

	@Override
	public ArrayList<OrderListVO> getOrderList(int user_idx) {
		return orderDAO.getOrderList(user_idx);
	}

	@Override
	public ArrayList<OrderListVO> getorderListOnlyOrder(int user_idx) {
		return orderDAO.getorderListOnlyOrder(user_idx);
	}

	@Override
	public ArrayList<OrderListVO> getOrderListOnlyDeliveryOk(int user_idx) {
		return orderDAO.getOrderListOnlyDeliveryOk(user_idx);
	}

	@Override
	public ArrayList<OrderListVO> getOrderListOnlyReturn(int user_idx) {
		return orderDAO.getOrderListOnlyReturn(user_idx);
	}

	@Override
	public ArrayList<OrderListVO> getOrderListSearch(int user_idx, String start, String end, String order_status_code) {
		//상태 코드에 따라 return 이 달라진다.
		//전체조회
		if(order_status_code.equals("0")) {
			return orderDAO.getOrderListSearch(user_idx, start, end);
		}
		//결제완료
		else if(order_status_code.equals("1")) {
			return orderDAO.getorderListOnlyOrderSearch(user_idx, start, end);
		}
		//취소 or 배송중 or 배송완료
		else if(order_status_code.equals("3") || order_status_code.equals("4") || order_status_code.equals("5")) {
			return orderDAO.getorderListOnlySearch(user_idx, start, end, order_status_code);
		}
		//교환 관련 건
		else if(order_status_code.equals("6")) {
			return orderDAO.getorderListOnlyChangeOkSearch(user_idx, start, end);
		}
		else {
			return orderDAO.getorderListOnlyReturnOkSearch(user_idx, start, end);
		}
	}

	@Override
	public OrderListVO getOrderListInfor(int listIdx, int orderIdx) {
		return orderDAO.getOrderListInfor(listIdx, orderIdx);
	}

	@Override
	public void setOrderCancelHistory(OrderCancelVO vo) {
		orderDAO.setOrderCancelHistory(vo);
	}

	@Override
	public OrderCancelVO getorderCancelInfor(int listIdx) {
		return orderDAO.getorderCancelInfor(listIdx);
	}

	@Override
	public ArrayList<OrderListVO> getOrderListOnlyChoice(int user_idx, String order_status_code) {
		return orderDAO.getOrderListOnlyChoice(user_idx, order_status_code);
	}

	@Override
	public ArrayList<OrderListVO> getOrderListOnlyChangeReturn(int user_idx) {
		return orderDAO.getOrderListOnlyChangeReturn(user_idx);
	}

	@Override
	public ArrayList<OrderListVO> getOrderListOnlyRefund(int user_idx) {
		return orderDAO.getOrderListOnlyRefund(user_idx);
	}

	@Override
	public void setOrderCancelRequsetHistory(OrderCancelVO vo) {
		orderDAO.setOrderCancelRequsetHistory(vo);
	}

	@Override
	public OrderListVO getorderListInfor2(int order_list_idx) {
		return orderDAO.getorderListInfor2(order_list_idx);
	}

	@Override
	public void setUsePointSub(int order_idx, int use_point) {
		orderDAO.setUsePointSub(order_idx, use_point);
	}

	@Override
	public void setUsePointPlus(int order_idx, int use_point) {
		orderDAO.setUsePointPlus(order_idx,use_point);
	}

	@Override
	public int getBuyCnt(int user_idx) {
		return orderDAO.getBuyCnt(user_idx);
	}

	@Override
	public int getAlreadyConfirmCheck(int user_idx, int order_idx) {
		return orderDAO.getAlreadyConfirmCheck(user_idx,order_idx);
	}

	@Override
	public void setOrderUpdate(int user_idx, int total_amount) {
		//회원 정보 수정(구매 횟수 추가 / 구매 총가격 누적 업데이트)
		userDAO.setOrderUpdate(user_idx,total_amount);
	}

	@Override
	public void setCouponAmountSub(int order_idx, int coupon_amount) {
		orderDAO.setCouponAmountSub(order_idx,coupon_amount);
	}

	@Override
	public void setExchangeRequest(MultipartHttpServletRequest mfile, OrderExchangeVO vo) {
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
			orderDAO.setExchangeRequest(vo);
			
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
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/order/");
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
	public OrderExchangeVO getOrderExchangeInfor(int order_list_idx) {
		return orderDAO.getOrderExchangeInfor(order_list_idx);
	}

	@Override
	public void setExchangeAns(OrderExchangeVO vo) {
		orderDAO.setExchangeAns(vo);
	}

	@Override
	public void setExchangeShipping(OrderExchangeVO vo) {
		orderDAO.setExchangeShipping(vo);
	}

	@Override
	public void setCouponAmountPlus(int order_idx, int coupon_amount) {
		orderDAO.setCouponAmountPlus(order_idx, coupon_amount);
	}

	@Override
	public void setReturnRequest(MultipartHttpServletRequest mfile, OrderReturnVO vo) {
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
			
			//DB저장 전에 반품 사유가 '단순 변심'이면 배송비를 차감시킨다.
			if(vo.getReturn_reason().equals("단순변심")) {
				int price = vo.getReturn_price() - vo.getShipping_return_price();
				
				if(price > 0) {
					vo.setReturn_price(price);
				}
				else {
					vo.setReturn_price(0);
				}
				
			}
			
			orderDAO.setReturnRequest(vo);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public OrderReturnVO getOrderReturnInfor(int order_list_idx) {
		return orderDAO.getOrderReturnInfor(order_list_idx);
	}

	@Override
	public void setReturnAns(OrderReturnVO vo) {
		orderDAO.setReturnAns(vo);
	}

	@Override
	public void setReturnOk(OrderReturnVO vo) {
		orderDAO.setReturnOk(vo);
	}

	@Override
	public int getOrderCancelOnlyRequest(int order_idx) {
		return orderDAO.getOrderCancelOnlyRequest(order_idx);
	}

	@Override
	public int getOrderReturnOnlyRequest(int order_idx) {
		return orderDAO.getOrderReturnOnlyRequest(order_idx);
	}

	@Override
	public ArrayList<OrderCancelVO> getOrderCancelOnlyComplete(int order_idx) {
		return orderDAO.getOrderCancelOnlyComplete(order_idx);
	}

	@Override
	public ArrayList<OrderReturnVO> getOrderReturnOnlyComplete(int order_idx) {
		return orderDAO.getOrderReturnOnlyComplete(order_idx);
	}

	@Override
	public ArrayList<OrderCancelVO> getOrderCancelOnlyComplete2(int order_idx) {
		return orderDAO.getOrderCancelOnlyComplete2(order_idx);
	}

	@Override
	public ShippingListVO getShippingInfor(int order_list_idx) {
		return orderDAO.getShippingInfor(order_list_idx);
	}

	@Override
	public ArrayList<OrderListVO> getOrderListItemIdx(int item_idx) {
		return orderDAO.getOrderListItemIdx(item_idx);
	}

}
