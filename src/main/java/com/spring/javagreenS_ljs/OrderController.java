package com.spring.javagreenS_ljs;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javagreenS_ljs.service.DeliveryService;
import com.spring.javagreenS_ljs.service.ItemService;
import com.spring.javagreenS_ljs.service.OrderAdminService;
import com.spring.javagreenS_ljs.service.OrderService;
import com.spring.javagreenS_ljs.service.UserService;
import com.spring.javagreenS_ljs.vo.CouponVO;
import com.spring.javagreenS_ljs.vo.ItemVO;
import com.spring.javagreenS_ljs.vo.OrderCancelVO;
import com.spring.javagreenS_ljs.vo.OrderExchangeVO;
import com.spring.javagreenS_ljs.vo.OrderListVO;
import com.spring.javagreenS_ljs.vo.OrderReturnVO;
import com.spring.javagreenS_ljs.vo.OrderVO;
import com.spring.javagreenS_ljs.vo.PayMentVO;
import com.spring.javagreenS_ljs.vo.ShippingListVO;
import com.spring.javagreenS_ljs.vo.UserDeliveryVO;
import com.spring.javagreenS_ljs.vo.UserVO;

@Controller
@RequestMapping("/order")
public class OrderController {
	
	@Autowired
	DeliveryService deliveryService;
	
	@Autowired
	UserService userService;
	
	@Autowired
	ItemService itemService;
	
	@Autowired
	OrderService orderService;
	
	@Autowired
	OrderAdminService orderAdminService;
	
	//주문,결제 확인 창 호출
	@RequestMapping(value = "/orderCheck", method = RequestMethod.GET)
	public String orderCheckGet(OrderVO orderVO, Model model, HttpSession session) {
		
		String user_id = (String) session.getAttribute("sUser_id");
		int user_idx = (int) session.getAttribute("sUser_idx");
		orderVO.setUser_idx(user_idx);
		
		//구매가능 여부 체크
		String[] order_item_idx = orderVO.getOrder_item_idx();
		String[] order_item_name = orderVO.getOrder_item_name();
 		String[] order_item_option_flag = orderVO.getOrder_item_option_flag();
  		String[] order_option_idx = orderVO.getOrder_option_idx();
 		String[] order_option_name = orderVO.getOrder_option_name();
		String[] order_quantity = orderVO.getOrder_quantity();
		
 		for(int i = 0; i < order_item_option_flag.length; i++) {
 			if(order_item_option_flag[i].equals("n")) {
				int item_idx = Integer.parseInt(order_item_idx[i]);
				int stock_quantity = itemService.getStockquantity(item_idx);
				int orderQuantity = Integer.parseInt(order_quantity[i]);
				if(orderQuantity > stock_quantity) {
					model.addAttribute("name", order_item_name[i]);
					model.addAttribute("value1", stock_quantity);
					return "redirect:/msg/quantityNO";
				}
			}
			else {
				int option_idx = Integer.parseInt(order_option_idx[i]);
				int option_stock_quantity = itemService.getOptionStockquantity(option_idx);
				int orderQuantity = Integer.parseInt(order_quantity[i]);
				if(orderQuantity > option_stock_quantity) {
					model.addAttribute("name", order_item_name[i]);
					model.addAttribute("value1", option_stock_quantity);
					model.addAttribute("value2", order_option_name[i]);
					return "redirect:/msg/quantityOptionNO";
				}
			}
		}
		
		
		//임시 주문 목록 DB에 저장하기 전에 user_idx 로 이미 데이터가 있다면 모두 삭제처리
		//데이터가 있는지 확인
		ArrayList<OrderListVO> orderList = orderService.getOrderListTempList(user_idx);
		
		//데이터가 있다면 삭제처리
		if(orderList != null) {
			orderService.setOrderListTempDelete(user_idx);
		}
		
		//임시 주문 목록 DB에 저장
		String[] cartIdx = orderVO.getCart_idx();
		if (cartIdx.length == 1 && "0".equals(cartIdx[0])) {
			orderService.setOrderListTempInsertForBuyNow(orderVO, user_idx);
		} else {
			orderService.setOrderListTempInsert(orderVO, user_idx);			
		}
		
		//등록한 배송정보 가져오기
		UserDeliveryVO deliveryVO = deliveryService.getDeliveryVO(user_idx);
		String deliveryFlag = "";
		if(deliveryVO == null) {
			deliveryFlag = "n";
		}
		else {
			deliveryFlag = "y";
		}
		
		//회원정보 가져오기
		UserVO userVO = userService.getUserInfor(user_id);
		
		//등록한 임시 DB 가져오기
		ArrayList<OrderListVO> orderListTemp = orderService.getOrderListTempList(user_idx);
		
		//보유 쿠폰 목록 가져오기
		ArrayList<CouponVO> couponList = userService.getUserCouponListOnlyUseOk(user_idx);
		
		model.addAttribute("couponList", couponList);
		model.addAttribute("deliveryFlag", deliveryFlag);
		model.addAttribute("deliveryVO", deliveryVO);
		model.addAttribute("userVO", userVO);
		model.addAttribute("orderVO", orderVO);
		model.addAttribute("orderListTemp", orderListTemp);
		model.addAttribute("user_idx", user_idx);
		return "order/orderPay";
	}
	
	
	//결제 진행
	@RequestMapping(value = "/orderCheck", method = RequestMethod.POST)
	public String orderCheckPost(OrderVO orderVO, Model model, HttpSession session) {
		String user_id = (String) session.getAttribute("sUser_id");
		int user_idx = (int) session.getAttribute("sUser_idx");
		
		//구매가능 여부 체크
		String[] order_item_idx = orderVO.getOrder_item_idx();
		String[] order_item_name = orderVO.getOrder_item_name();
 		String[] order_item_option_flag = orderVO.getOrder_item_option_flag();
  		String[] order_option_idx = orderVO.getOrder_option_idx();
 		String[] order_option_name = orderVO.getOrder_option_name();
		String[] order_quantity = orderVO.getOrder_quantity();
		
 		for(int i = 0; i < order_item_option_flag.length; i++) {
 			if(order_item_option_flag[i].equals("n")) {
				int item_idx = Integer.parseInt(order_item_idx[i]);
				int stock_quantity = itemService.getStockquantity(item_idx);
				int orderQuantity = Integer.parseInt(order_quantity[i]);
				if(orderQuantity > stock_quantity) {
					model.addAttribute("name", order_item_name[i]);
					model.addAttribute("value1", stock_quantity);
					return "redirect:/msg/quantityNO";
				}
			}
			else {
				int option_idx = Integer.parseInt(order_option_idx[i]);
				int option_stock_quantity = itemService.getOptionStockquantity(option_idx);
				int orderQuantity = Integer.parseInt(order_quantity[i]);
				if(orderQuantity > option_stock_quantity) {
					model.addAttribute("name", order_item_name[i]);
					model.addAttribute("value1", option_stock_quantity);
					model.addAttribute("value2", order_option_name[i]);
					return "redirect:/msg/quantityOptionNO";
				}
			}
		}
		
 		//결제로 이동하기 전 최종 결제 총 금액과 사용 포인트 혹은 쿠폰 할인금액을 temp 데이터베이스에 저장한다.
 		int total_amount = 0;
 		int point = 0;
 		int coupon_amount = 0;
 		int coupon_user_idx = 0;
 		
 		if(orderVO.getOrder_total_amount_calc() != 0 && !orderVO.getPoint().equals("")) {
 			total_amount = orderVO.getOrder_total_amount_calc();
 			point = Integer.parseInt(orderVO.getPoint());
 		}
 		else if(orderVO.getOrder_total_amount_calc() != 0 && orderVO.getCoupon_amount() != 0) {
 			total_amount = orderVO.getOrder_total_amount_calc();
 			coupon_amount = orderVO.getCoupon_amount();
 			coupon_user_idx = orderVO.getCoupon_user_idx();
 		}
 		else {
 			total_amount = orderVO.getOrder_total_amount();
 		}
 		
 		OrderVO temp = new OrderVO();
 		
 		temp.setUser_idx(user_idx);
 		temp.setOrder_total_amount(total_amount);
 		temp.setUse_point(point);
 		temp.setCoupon_amount(coupon_amount);
 		temp.setCoupon_user_idx(coupon_user_idx);
 		
 		//임시 테이블에 정보 저장
 		orderService.setOrder_total_amount_and_point(temp);
 		
		//회원 정보 가져오기
		UserVO userVO = userService.getUserInfor(user_id);
		
		//선택 기본 주소 가져오기
		UserDeliveryVO deliveryVO = deliveryService.getDeliveryVO(user_idx);
		
		//임시 주문 테이블에서 정보를 가져오기
		ArrayList<OrderListVO> OrderTempList = orderService.getOrderListTempList(user_idx);
		
		//결제 창에 뜰 상품 이름 만들어주기
		String name = "";
		if(OrderTempList.size() > 1) {
			name = OrderTempList.get(0).getItem_name() + " 외 " + OrderTempList.size() + "건";
		}
		else {
			name = OrderTempList.get(0).getItem_name();
		}
		
		int imsi = 10;
		//결제 창으로 보내줄 정보를 set 한다.
		PayMentVO vo = new PayMentVO();
		vo.setName(name);
		vo.setAmount(imsi);
		//vo.setAmount(total_amount);
		vo.setBuyer_email(userVO.getEmail());
		vo.setBuyer_name(userVO.getName());
		vo.setBuyer_tel(userVO.getTel());
		vo.setBuyer_addr(deliveryVO.getRoadAddress());
		vo.setBuyer_postcode(deliveryVO.getPostcode());
		
		model.addAttribute("vo", vo);
		
		return "order/payment";
	}
	
	//결제 완료 후 처리
	@RequestMapping(value="/paymentResult", method=RequestMethod.GET)
	public String paymentResultGet(Model model, HttpSession session, PayMentVO payMentVO) {
		String user_id = (String) session.getAttribute("sUser_id");
		int user_idx = (int) session.getAttribute("sUser_idx");
		
		//결제가 완료된 이후에 진행 처리
		orderService.setOrderProcess(user_id, user_idx, payMentVO);
		
		session.setAttribute("payMentVO", payMentVO);
		
		return "redirect:/msg/paymentOk";
	}
	
	@RequestMapping(value = "/payResult", method = RequestMethod.GET)
	public String payResultGet(HttpSession session, Model model) {
		
		PayMentVO payMentVO = (PayMentVO)session.getAttribute("payMentVO");
		
		model.addAttribute("payMentVO", payMentVO);
		return "order/payResult";
	}
	
	
	//주문 취소 처리 창 호출
	@RequestMapping(value = "/orderCancel", method = RequestMethod.GET)
	public String orderCancelGet(
			@RequestParam(name="listIdx") int listIdx,
			@RequestParam(name="orderIdx") int orderIdx, Model model) {
		
		//취소하고자하는 주문 내용 가져오기
		OrderListVO vo = orderService.getOrderListInfor(listIdx,orderIdx);
		model.addAttribute("vo", vo);
		return "order/orderCancel";
	}
	
	
	//주문 취소 처리
	@Transactional(rollbackFor = Exception.class) //트랜잭션 처리 
	@ResponseBody
	@RequestMapping(value = "/orderCancelOk", method = RequestMethod.POST)
	public String orderCancelOkPost(OrderCancelVO vo, HttpSession session) {
		int user_idx = (int) session.getAttribute("sUser_idx");
		vo.setUser_idx(user_idx);
		
		//주문 취소 테이블에 저장
		orderService.setOrderCancelHistory(vo);
		
		//주문 목록 상태값 변경
		orderAdminService.setOrderCodeChange(vo.getOrder_list_idx(), "3");
		
		//주문 목록 정보 가져오기
		OrderListVO orderListVO = orderService.getorderListInfor2(vo.getOrder_list_idx());
		
		//상품 재고 수량 재 업데이트
		int item_idx = orderListVO.getItem_idx();
		int order_quantity = orderListVO.getOrder_quantity();
		itemService.setStockQuantityUpdate(item_idx, order_quantity);
		itemService.setOrderUpdate(item_idx, order_quantity * -1);
		
		if (orderListVO.getItem_option_flag().equals("y")) {
			itemService.setOptionStockQuantityUpdate(orderListVO.getOption_idx(), order_quantity * -1);
			
			//옵션 품절 여부 체크
			int option_quantity = itemService.getOptionStockquantity(orderListVO.getOption_idx());
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
			
			itemService.setOptionSoldOutUpdate(orderListVO.getOption_idx(), sold_out);
		}
		
		//상품 품절 여부 체크
		int stock_quantity = itemService.getStockquantity(item_idx);
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
		itemService.setSoldOutUpdate(item_idx,sold_out);
		
		//주문 테이블의 사용 포인트 차감
		if(vo.getUse_point() != 0) {
			orderService.setUsePointSub(vo.getOrder_idx(), vo.getUse_point());
		}
		
		//쿠폰 사용 할인 금액도 차감
		if(vo.getCoupon_amount() != 0)  {
			orderService.setCouponAmountSub(vo.getOrder_idx(), vo.getCoupon_amount());
		}
		
		return "1";
	}
	
	//취소 내용 확인
	@RequestMapping(value = "/orderCancelInfor", method = RequestMethod.GET)
	public String orderCancelInforGet(@RequestParam(name="listIdx") int listIdx,
			@RequestParam(name="orderIdx") int orderIdx, Model model) {
		
		//취소 내용 가져오기
		OrderCancelVO vo = orderService.getorderCancelInfor(listIdx);
		model.addAttribute("vo", vo);
		
		//주문 내용 가져오기
		OrderListVO orderVO = orderService.getOrderListInfor(listIdx,orderIdx);
		model.addAttribute("orderVO", orderVO);
		
		return "order/orderCancelInfor";
	}
	
	//취소 요청 창 호출
	@RequestMapping(value = "/orderCancelRequest", method = RequestMethod.GET)
	public String orderCancelRequestGet(		
			@RequestParam(name="listIdx") int listIdx,
			@RequestParam(name="orderIdx") int orderIdx, Model model) {
		//취소하고자하는 주문 내용 가져오기
		OrderListVO vo = orderService.getOrderListInfor(listIdx,orderIdx);
		model.addAttribute("vo", vo);
		return "order/orderCancelRequest";
	}
	
	
	//취소 요청 처리
	@Transactional(rollbackFor = Exception.class) //트랜잭션 처리 
	@ResponseBody
	@RequestMapping(value = "/orderCancelRequestOk", method  = RequestMethod.POST)
	public String orderCancelRequestOkPost(OrderCancelVO vo, HttpSession session) {
		int user_idx = (int) session.getAttribute("sUser_idx");
		vo.setUser_idx(user_idx);
	
		//주문 취소 요청 테이블에 저장
		orderService.setOrderCancelRequsetHistory(vo);
		
		//주문 목록 상태값 변경
		orderAdminService.setOrderCodeChange(vo.getOrder_list_idx(), "15");
		
		//주문 테이블의 사용 포인트 차감(**반려 시 다시 돌려놓아야 함..)
		if(vo.getUse_point() != 0) {
			orderService.setUsePointSub(vo.getOrder_idx(), vo.getUse_point());
		}
		
		// 쿠폰 사용 할인 금액도 차감(**반려 시 다시 돌려놓아야 함..)
		if(vo.getCoupon_amount() != 0)  {
			orderService.setCouponAmountSub(vo.getOrder_idx(), vo.getCoupon_amount());
		}
		
		return "1";
	}
	
	
	//취소 반려 내용 확인
	@RequestMapping(value = "/orderCancelRequestInfor", method = RequestMethod.GET)
	public String orderCancelRequestInforGet(
			@RequestParam(name="listIdx") int listIdx,
			@RequestParam(name="orderIdx") int orderIdx, Model model) {
		
		//취소 요청 처리 내용 가져오기
		OrderCancelVO vo = orderAdminService.getOrderCancelRequestInfor(listIdx, orderIdx);
		model.addAttribute("vo", vo);
		return "order/orderCancelRequestInfor";
	}
	
	
	//주문 상태값 변경(구매확정)
	@ResponseBody
	@RequestMapping(value = "/confirmCheck", method = RequestMethod.POST)
	public String orderCodeChangePost(@RequestParam int idx ,@RequestParam String code, 
			@RequestParam int order_idx, @RequestParam int total_amount,@RequestParam int item_idx, HttpSession session) {
		String result = "1";
		int user_idx = (int) session.getAttribute("sUser_idx");
		
		//해당 주문 고유 번호로 취소 요청 or 환불 요청 테이블에 기록되어 있는 내용이 있는지 확인(아직 처리 중인 내용이 있는가?)
		
		//취소 테이블 검색
		int requestCnt = orderService.getOrderCancelOnlyRequest(order_idx);
		
		//환불 테이블 검색
		int returnCnt = orderService.getOrderReturnOnlyRequest(order_idx);
		
		if(requestCnt > 0 || returnCnt > 0) {
			return "0";
		}
		
		//구매확정시 첫 구매이거나 결제 금액이 10만원 이상 결제 인 경우 10% 할인 쿠폰 발급
		//첫 구매인지 ?
		int buyCnt = orderService.getBuyCnt(user_idx);
		
		if(buyCnt == 0) {
			//10% 쿠폰 발급 처리
			userService.setCouponInsertFirstBuy(user_idx, 2);
			result = "2";
		}
		
		int total_amount_calc = total_amount;
		
		//TODO 취소 or 환불 테이블에 해당 주문 고유 번호로 기록된 내용이 있는지 확인(완료 건만)
		
		//취소 테이블 검색 후 처리
		ArrayList<OrderCancelVO> cancelList = orderService.getOrderCancelOnlyComplete2(order_idx);
		
		for(int a = 0; a < cancelList.size(); a++) {
			total_amount_calc = total_amount_calc - cancelList.get(a).getReturn_price();
		}
		
		//취소요청 테이블 검색 후 처리
		ArrayList<OrderCancelVO> cancelRequestList = orderService.getOrderCancelOnlyComplete(order_idx);
		
		for(int i = 0; i < cancelRequestList.size(); i++) {
			total_amount_calc = total_amount_calc - cancelRequestList.get(i).getReturn_price();
		}
		
		//환불 테이블 검색 후 처리
		ArrayList<OrderReturnVO> returnList = orderService.getOrderReturnOnlyComplete(order_idx);
		
		for(int j = 0; j < returnList.size(); j++) {
			total_amount_calc = total_amount_calc - returnList.get(j).getItem_price();
		}
		
		//10만원 이상 결제 인지?
		if(total_amount_calc > 100000) {
			//같은 order_idx를 가진 상품 중에 이미 구매확정을 진행한 상품이 있는지 확인
			int alreadyConfirmCheck = orderService.getAlreadyConfirmCheck(user_idx,order_idx);
			
			if(alreadyConfirmCheck == 0) {
				//10% 쿠폰 발급
				userService.setCouponInsertFirstBuy(user_idx, 3);
				result = "2";
				
			}
		}
		
		//회원 구매 횟수와 구매 총 금액 누적
		orderService.setOrderUpdate(user_idx, total_amount_calc);
		
		//회원 포인트 지급
		//지급할 포인트 알아오기
		ItemVO itemVO = itemService.getItemInfor(item_idx); 
		int point = itemVO.getSeller_point();
		
		//골드 레벨인 경우 지급 포인트 2배 처리
		//회원 레벨 알아오기
		int level = userService.getUserLevel(user_idx);
		
		if(level == 1) {
			point = point * 2;
		}
		
		//포인트 지급
		userService.setUserGivePoint(user_idx,point);
		
		//주문 상태값 변경
		orderAdminService.setOrderCodeChange(idx,code);
		
		UserVO userVO = new UserVO();
		userVO.setUser_idx(user_idx);
		userService.userLevelUp(userVO);
		
		return result;
	}
	
	//교환요청 창 호출
	@RequestMapping(value = "/exchangeRequest", method = RequestMethod.GET)
	public String exchangeRequestGet(int listIdx, int orderIdx, int item_idx, Model model, HttpSession session) {
		//주문 내용 가져오기
		OrderListVO vo = orderService.getOrderListInfor(listIdx,orderIdx);
		
		//상품 정보 가져오기
		ItemVO itemVO = itemService.getItemInfor(item_idx);
		
		//등록한 배송정보 가져오기
		UserDeliveryVO deliveryVO = deliveryService.getUserDeliveryInfor(vo.getUser_delivery_idx());
		
		model.addAttribute("vo", vo);
		model.addAttribute("itemVO", itemVO);
		model.addAttribute("deliveryVO", deliveryVO);
		return "order/exchangeRequest";
		
	}
	
	//교환요청 처리
	@RequestMapping(value = "/exchangeRequest", method = RequestMethod.POST)
	public String exchangeRequestPost(MultipartHttpServletRequest file, OrderExchangeVO vo, Model model, HttpSession session) {
		int user_idx = (int) session.getAttribute("sUser_idx");
		vo.setUser_idx(user_idx);
		
		//교환 요청 테이블에 저장
		orderService.setExchangeRequest(file, vo);
		
		//주문 상태값 변경
		orderAdminService.setOrderCodeChange(vo.getOrder_list_idx(), "7");
		
		return "redirect:/msg/exchangeRequest";
	}
	
	//교환 처리 내역 확인
	@RequestMapping(value = "/orderExchangeInfor", method = RequestMethod.GET)
	public String orderExchangeInforGet(@RequestParam int order_list_idx, Model model) {
		//교환 요청 내용 가져오기
    	OrderExchangeVO exVO = orderService.getOrderExchangeInfor(order_list_idx);
		
    	//주문 내용 가져오기
		OrderListVO listVO = orderService.getOrderListInfor(exVO.getOrder_list_idx(),exVO.getOrder_idx());
		
		model.addAttribute("exVO", exVO);
		model.addAttribute("listVO", listVO);
		return "order/orderExchangeInfor";
	}
	
	//반품 요청 창 호출
	@RequestMapping(value = "/returnRequest", method = RequestMethod.GET)
	public String returnRequestGet(int listIdx, int orderIdx, int item_idx, Model model, HttpSession session) {
		//주문 내용 가져오기
		OrderListVO vo = orderService.getOrderListInfor(listIdx,orderIdx);
		
		//상품 정보 가져오기
		ItemVO itemVO = itemService.getItemInfor(item_idx);
		
		//등록한 배송정보 가져오기
		UserDeliveryVO deliveryVO = deliveryService.getUserDeliveryInfor(vo.getUser_delivery_idx());
		
		model.addAttribute("vo", vo);
		model.addAttribute("itemVO", itemVO);
		model.addAttribute("deliveryVO", deliveryVO);
		return "order/returnRequest";
		
	}
	
	//반품 요청 처리
	@RequestMapping(value = "/returnRequest", method = RequestMethod.POST)
	public String returnRequestPost(MultipartHttpServletRequest file, OrderReturnVO vo, Model model, HttpSession session) {
		int user_idx = (int) session.getAttribute("sUser_idx");
		vo.setUser_idx(user_idx);
		
		//반품 요청 테이블에 저장
		orderService.setReturnRequest(file, vo);
		
		//주문 상태값 변경
		orderAdminService.setOrderCodeChange(vo.getOrder_list_idx(), "11");
		
		//주문 테이블의 사용 포인트 차감(**반려 시 다시 돌려놓아야 함..)
		if(vo.getUse_point() != 0) {
			orderService.setUsePointSub(vo.getOrder_idx(), vo.getUse_point());
		}
		
		// 쿠폰 사용 할인 금액도 차감(**반려 시 다시 돌려놓아야 함..)
		if(vo.getCoupon_amount() != 0)  {
			orderService.setCouponAmountSub(vo.getOrder_idx(), vo.getCoupon_amount());
		}
		
		return "redirect:/msg/returnRequest";
	}
	
	//교환 처리 내역 확인
	@RequestMapping(value = "/orderReturnInfor", method = RequestMethod.GET)
	public String orderReturnInforGet(@RequestParam int order_list_idx, Model model) {
		//반품 요청 내용 가져오기
		OrderReturnVO reVO = orderService.getOrderReturnInfor(order_list_idx);
		
		//주문 내용 가져오기
		OrderListVO listVO = orderService.getOrderListInfor(reVO.getOrder_list_idx(),reVO.getOrder_idx());
		
		//등록한 배송정보 가져오기
		UserDeliveryVO deliveryVO = deliveryService.getUserDeliveryInfor(listVO.getUser_delivery_idx());
		
		model.addAttribute("reVO", reVO);
		model.addAttribute("listVO", listVO);
		model.addAttribute("deliveryVO", deliveryVO);
		return "order/orderReturnInfor";
	}
	
	@RequestMapping(value = "/shippingInfor", method = RequestMethod.GET)
	public String shippingInforGet(ShippingListVO vo, Model model) {
		
		ShippingListVO shippingInfor = orderService.getShippingInfor(vo.getOrder_list_idx());
		
		model.addAttribute("shippingInfor", shippingInfor);
		return "order/shippingInfor";
	}
}
