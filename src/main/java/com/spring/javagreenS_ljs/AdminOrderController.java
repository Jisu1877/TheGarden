package com.spring.javagreenS_ljs;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.spring.javagreenS_ljs.pagination.PageVO;
import com.spring.javagreenS_ljs.pagination.PagingProcess;
import com.spring.javagreenS_ljs.service.DeliveryService;
import com.spring.javagreenS_ljs.service.ItemService;
import com.spring.javagreenS_ljs.service.OrderAdminService;
import com.spring.javagreenS_ljs.service.OrderService;
import com.spring.javagreenS_ljs.service.UserService;
import com.spring.javagreenS_ljs.vo.OrderCancelVO;
import com.spring.javagreenS_ljs.vo.OrderExchangeVO;
import com.spring.javagreenS_ljs.vo.OrderListVO;
import com.spring.javagreenS_ljs.vo.OrderReturnVO;
import com.spring.javagreenS_ljs.vo.ShippingListVO;
import com.spring.javagreenS_ljs.vo.UserDeliveryVO;
import com.spring.javagreenS_ljs.vo.UserVO;

@Controller
@RequestMapping("/admin/order")
public class AdminOrderController {
	
	@Autowired
	OrderAdminService orderAdminService;
	
	@Autowired
	UserService userService;

	@Autowired
	PagingProcess pagingProcess;
	
	@Autowired
	DeliveryService deliveryService;
	
	@Autowired
	OrderController orderController;
	
	@Autowired
	OrderService orderService; 
	
	@Autowired
	ItemService itemService;
	
	//주문관리 호출
    @RequestMapping(value = "/orderList", method = RequestMethod.GET)
	public String orderManagementGet(HttpSession session, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="part", defaultValue = "0", required = false) String part,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="searchValue", defaultValue = "", required = false) String searchValue,
			@RequestParam(name="start", defaultValue = "", required = false) String start,
			@RequestParam(name="end", defaultValue = "", required = false) String end
			) {
    	String user_id = (String)session.getAttribute("sUser_id");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInfor(user_id);
		model.addAttribute("userVO", userVO);
		
		//주문내역 리스트 가져오기(페이징 처리)
		PageVO pageVo = pagingProcess.pageProcess2(pag, pageSize,"adminOrder", part , search, searchValue, start, end);
		ArrayList<OrderListVO> orderList = orderAdminService.getOrderList(pageVo.getStartIndexNo(), pageVo.getPageSize(), part, search, searchValue, start, end);
		
		model.addAttribute("code", part);
		model.addAttribute("search", search);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("start", start);
		model.addAttribute("end", end);
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("orderList", orderList);
		return "admin/order/orderManagement";
	} 
 
    //주문 상세 정보 가져오기
    @RequestMapping(value = "/orderInfor", method = RequestMethod.GET)
    public String orderInforGet(int idx, Model model) {
    	//주문 정보 가져오기
    	ArrayList<OrderListVO> orderList = orderAdminService.getOrderInfor(idx);
    	
    	//배송지 정보 가져오기
    	int delivery_idx = orderList.get(0).getUser_delivery_idx();
    	UserDeliveryVO deliveryVO = deliveryService.getUserDeliveryInfor(delivery_idx);
    	
    	ArrayList<ShippingListVO> shippingList = new ArrayList<ShippingListVO>();
    	
    	//배송 정보 가져오기
    	for(int i = 0; i < orderList.size(); i++) {
    		ShippingListVO shippingVO = orderAdminService.getShippingList(orderList.get(i).getOrder_list_idx());
    		if(shippingVO != null) {
    			shippingList.add(shippingVO);
    		}
    	}
    	
    	//TODO 교환 요청 정보 가져오기
    	
    	//TODO 환불 요청 정보 가져오기
    	
    	model.addAttribute("orderList", orderList);
    	model.addAttribute("shippingList", shippingList);
    	model.addAttribute("deliveryVO", deliveryVO);
    	return "admin/order/orderInfor";
    }
    
    //관리자 메모 등록
    @ResponseBody
    @RequestMapping(value = "/orderMemoInput", method = RequestMethod.POST)
    public String orderMemoInputPost(int idx, String memo) {
    	orderAdminService.setOrderAdminMemo(idx,memo);
    	return "1";
    }
    
    //주문 상태 변경(idx : 주문 리스트 idx / code : 값 삽입해줄 상태코드)
    @ResponseBody
    @RequestMapping(value = "/orderCodeChange", method = RequestMethod.POST)
    public String orderCodeChangePost(@RequestParam int idx, @RequestParam String code) {
    	orderAdminService.setOrderCodeChange(idx,code);
    	
    	if(code.equals("17"))  {
    		//교환 DB 교환완료 처리
    		orderAdminService.setOrderExchangeOk(idx);
    	}
    	
    	return "1";
    }
    
    //취소 요청 처리 창 호출
    @RequestMapping(value = "/orderCancelRequest", method = RequestMethod.GET)
    public String orderCancelRequestGet(
    		@RequestParam(name="listIdx") int listIdx,
			@RequestParam(name="orderIdx") int orderIdx, HttpSession session, Model model) {
    	
    	//취소 요청 정보 가져오기
    	OrderCancelVO cancelVO = orderAdminService.getOrderCancelRequestInfor(listIdx,orderIdx);
    	
    	System.out.println("cancelVO : " + cancelVO);
    	//회원정보 가져오기
		UserVO userVO = userService.getUserInforIdx(cancelVO.getUser_idx());
		
		model.addAttribute("userVO", userVO);
    	model.addAttribute("vo", cancelVO);
    	return "admin/order/orderCancelRequestAdmin";
    }
    
    
    //취소 요청 처리
    @Transactional(rollbackFor = Exception.class) //트랜잭션 처리 
    @ResponseBody
    @RequestMapping(value = "/orderCancelProcess", method = RequestMethod.POST)
    public String orderCancelProcessPost(OrderCancelVO vo) {
    	//관리자 메세지 등록 및 승인 여부 등록
    	orderAdminService.setOrderCancelRequestAnswer(vo);
    	
    	//취소 승인 시..
    	if(vo.getRequest_answer().equals("y")) {
    		//취소 요청 정보 가져와서 취소 처리 서비스로 보내기
    		OrderCancelVO requestVO = orderAdminService.getOrderCancelRequestInfor(vo.getOrder_list_idx(), vo.getOrder_idx());
    		
    		//취소 처리
    		//주문 취소 테이블에 저장
    		orderService.setOrderCancelHistory(requestVO);
    		
    		//주문 목록 상태값 변경
    		orderAdminService.setOrderCodeChange(requestVO.getOrder_list_idx(), "3");
    		
    		//주문 목록 정보 가져오기
    		OrderListVO orderListVO = orderService.getorderListInfor2(requestVO.getOrder_list_idx());
    		
    		//상품 재고 수량 재 업데이트
    		int item_idx = orderListVO.getItem_idx();
    		int order_quantity = orderListVO.getOrder_quantity();
    		itemService.setStockQuantityUpdate(item_idx, order_quantity);
    		itemService.setOrderUpdate(item_idx, order_quantity * -1);

    		if (orderListVO.getItem_option_flag().equals("y")) {
    			itemService.setOptionStockQuantityUpdate(orderListVO.getOption_idx(), order_quantity * -1);

    			// 옵션 품절 여부 체크
    			int option_quantity = itemService.getOptionStockquantity(orderListVO.getOption_idx());
    			String sold_out = "0";

    			if (option_quantity == 0) {
    				sold_out = "1";
    			} else if (option_quantity > 0) {
    				sold_out = "0";
    			} else { // 만약 음수값이 들어온다면..
    				sold_out = "1";
    			}

    			itemService.setOptionSoldOutUpdate(orderListVO.getOption_idx(), sold_out);
    		}

    		// 상품 품절 여부 체크
    		int stock_quantity = itemService.getStockquantity(item_idx);
    		String sold_out = "0";

    		if (stock_quantity == 0) {
    			sold_out = "1";
    		} else if (stock_quantity > 0) {
    			sold_out = "0";
    		} else { // 만약 음수값이 들어온다면..
    			sold_out = "1";
    		}

    		// 품절 여부 업데이트
    		itemService.setSoldOutUpdate(item_idx, sold_out);
    	}
    	else {
    		//취소 반려 시..
    		//주문 목록 상태값 변경
    		orderAdminService.setOrderCodeChange(vo.getOrder_list_idx(), "2");
    		orderAdminService.setRejectCodeUpdate(vo.getOrder_list_idx(), "1");
    		
    		//주문 테이블의 사용 포인트 차감 돌려놓기
    		if(vo.getUse_point() != 0) {
    			orderService.setUsePointPlus(vo.getOrder_idx(), vo.getUse_point());
    		}
    		
    		//쿠폰 사용 할인 금액 차감 돌려놓기
    		if(vo.getCoupon_amount() != 0)  {
    			orderService.setCouponAmountPlus(vo.getOrder_idx(), vo.getCoupon_amount());
    		}
    		
    	}
    	return "1";
    }
    
    //배송관리 호출
    @RequestMapping(value = "/orderDelivery", method = RequestMethod.GET)
	public String orderDeliveryGet(HttpSession session, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="part", defaultValue = "0", required = false) String part,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="searchValue", defaultValue = "", required = false) String searchValue,
			@RequestParam(name="start", defaultValue = "", required = false) String start,
			@RequestParam(name="end", defaultValue = "", required = false) String end
			) {
    	String user_id = (String)session.getAttribute("sUser_id");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInfor(user_id);
		model.addAttribute("userVO", userVO);
		
		//주문 관리만
		part = "2";
		
		//주문내역 리스트 가져오기(페이징 처리)
		PageVO pageVo = pagingProcess.pageProcess2(pag, pageSize,"orderDelivery", part, search, searchValue, start, end);
		ArrayList<OrderListVO> orderList = orderAdminService.getOrderList(pageVo.getStartIndexNo(), pageVo.getPageSize(), part, search, searchValue, start, end);
		
		model.addAttribute("code", part);
		model.addAttribute("search", search);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("start", start);
		model.addAttribute("end", end);
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("orderList", orderList);
		return "admin/order/orderDelivery";
	} 
    
    //엑셀 읽어오기 창 호출
    @RequestMapping(value = "/sendProcess", method = RequestMethod.GET)
    public String sendProcessGet() {
    	return "admin/order/sendProcess";
    }
    
    //개별 송장 입력
    @ResponseBody
    @RequestMapping(value = "/invoiceinsert", method = RequestMethod.POST)
    public String invoiceinsertPost(ShippingListVO vo) {
    	
    	//배송 목록 테이블에 저장
    	orderAdminService.setShippingListHistory(vo);
    	
    	//해당 주문 목록 상태값 변경
    	orderAdminService.setOrderCodeChange(vo.getOrder_list_idx(), "4");
    	
    	return "1";
    }
    
    //교환 요청 승인/거부 처리 창 호출
    @RequestMapping(value = "/exchangeManagement", method = RequestMethod.GET)
    public String exchangeManagementGet(OrderExchangeVO vo, Model model, HttpSession session) {
    	String user_id = (String)session.getAttribute("sUser_id");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInfor(user_id);
    	
    	//주문 내용 가져오기
    	OrderListVO listVO = orderService.getOrderListInfor(vo.getOrder_list_idx(), vo.getOrder_idx());
    	
    	//교환 요청 내용 가져오기
    	OrderExchangeVO exVO = orderService.getOrderExchangeInfor(vo.getOrder_list_idx());
    	
    	model.addAttribute("userVO", userVO);
    	model.addAttribute("listVO", listVO);
    	model.addAttribute("exVO", exVO);
    	
		return "admin/order/exchangeManagement";
    }
    
    //교환 수거 완료 처리 및 교환 상품 발송 처리 창 호출
    @RequestMapping(value = "/exchangeManagement2", method = RequestMethod.GET)
    public String exchangeManagement2Get(OrderExchangeVO vo, Model model, HttpSession session) {
    	String user_id = (String)session.getAttribute("sUser_id");
    	//회원정보 가져오기
    	UserVO userVO = userService.getUserInfor(user_id);
    	
    	//주문 내용 가져오기
    	OrderListVO listVO = orderService.getOrderListInfor(vo.getOrder_list_idx(), vo.getOrder_idx());
    	
    	//교환 요청 내용 가져오기
    	OrderExchangeVO exVO = orderService.getOrderExchangeInfor(vo.getOrder_list_idx());
    	
    	model.addAttribute("userVO", userVO);
    	model.addAttribute("listVO", listVO);
    	model.addAttribute("exVO", exVO);
    	return "admin/order/exchangeManagement2";
    }
    
    // 교환 승인 및 거부 처리
    @RequestMapping(value = "/exchangeAns", method = RequestMethod.POST)
    public String exchangeAnsPost(OrderExchangeVO vo) {
    	//교환DB 업뎃
    	orderService.setExchangeAns(vo);
    	
    	//교환 거부 시..
    	if(vo.getRequest_flag().equals("n")) {
    		orderAdminService.setOrderCodeChange(vo.getOrder_list_idx(), "10");
    	}
    	//교환 승인 시..
    	else {
    		orderAdminService.setOrderCodeChange(vo.getOrder_list_idx(), "8");
    	}
    	
    	return "redirect:/msg/exchangeAnsOk";
    }
    
    //교환 상품 발송
    @RequestMapping(value = "/exchangeShipping", method = RequestMethod.POST)
    public String exchangeProcessPost(OrderExchangeVO vo) {
    	//수거 완료 상태 처리
    	orderAdminService.setOrderCodeChange(vo.getOrder_list_idx(), "9");
    	
    	//교환DB 업뎃
    	orderService.setExchangeShipping(vo);
    	
    	return "redirect:/msg/exchangeProcessOk";
    }
    
    //반품 요청 승인/거부 처리 창 호출
    @RequestMapping(value = "/returnManagement", method = RequestMethod.GET)
    public String returnManagementGet(OrderReturnVO vo, Model model, HttpSession session) {
    	String user_id = (String)session.getAttribute("sUser_id");
    	//회원정보 가져오기
    	UserVO userVO = userService.getUserInfor(user_id);
    	
    	//주문 내용 가져오기
    	OrderListVO listVO = orderService.getOrderListInfor(vo.getOrder_list_idx(), vo.getOrder_idx());
    	
    	//반품 요청 내용 가져오기
    	OrderReturnVO reVO = orderService.getOrderReturnInfor(vo.getOrder_list_idx());
    	
    	model.addAttribute("userVO", userVO);
    	model.addAttribute("listVO", listVO);
    	model.addAttribute("reVO", reVO);
    	return "admin/order/returnManagement";
    }
    
    // 반품 승인 및 거부 처리
    @Transactional(rollbackFor = Exception.class)
    @RequestMapping(value = "/returnAns", method = RequestMethod.POST)
    public String returnAnsPost(OrderReturnVO vo) {
    	//반품DB 업뎃
    	orderService.setReturnAns(vo);
    	
    	//반품 거부 시..
    	if(vo.getRequest_flag().equals("n")) {
    		orderAdminService.setOrderCodeChange(vo.getOrder_list_idx(), "14");
    		//TODO reject flag 저장..
    		//TODO 반품 거부시 상품 상태 값을 어떻게 할 것인가..?
    		
    		//주문 테이블의 사용 포인트 차감 돌려놓기
    		if(vo.getUse_point() != 0) {
    			orderService.setUsePointPlus(vo.getOrder_idx(), vo.getUse_point());
    		}
    		
    		//쿠폰 사용 할인 금액 차감 돌려놓기
    		if(vo.getCoupon_amount() != 0)  {
    			orderService.setCouponAmountPlus(vo.getOrder_idx(), vo.getCoupon_amount());
    		}
    	}
    	//반품 승인 시..
    	else {
    		orderAdminService.setOrderCodeChange(vo.getOrder_list_idx(), "12");
    		
    		//상품 재고 수량 재 업데이트
    		OrderListVO orderListVO = orderService.getorderListInfor2(vo.getOrder_list_idx());
    		int item_idx = orderListVO.getItem_idx();
    		int order_quantity = orderListVO.getOrder_quantity();
    		itemService.setStockQuantityUpdate(item_idx, order_quantity);
    		itemService.setOrderUpdate(item_idx, order_quantity * -1);

    		if (orderListVO.getItem_option_flag().equals("y")) {
    			itemService.setOptionStockQuantityUpdate(orderListVO.getOption_idx(), order_quantity * -1);

    			// 옵션 품절 여부 체크
    			int option_quantity = itemService.getOptionStockquantity(orderListVO.getOption_idx());
    			String sold_out = "0";

    			if (option_quantity == 0) {
    				sold_out = "1";
    			} else if (option_quantity > 0) {
    				sold_out = "0";
    			} else { // 만약 음수값이 들어온다면..
    				sold_out = "1";
    			}

    			itemService.setOptionSoldOutUpdate(orderListVO.getOption_idx(), sold_out);
    		}

    		// 상품 품절 여부 체크
    		int stock_quantity = itemService.getStockquantity(item_idx);
    		String sold_out = "0";

    		if (stock_quantity == 0) {
    			sold_out = "1";
    		} else if (stock_quantity > 0) {
    			sold_out = "0";
    		} else { // 만약 음수값이 들어온다면..
    			sold_out = "1";
    		}

    		// 품절 여부 업데이트
    		itemService.setSoldOutUpdate(item_idx, sold_out);
    	}
    	
    	return "redirect:/msg/returnAnsOk";
    }
    
    
    //반품 수거 완료 처리 창 호출
    @RequestMapping(value = "/returnManagement2", method = RequestMethod.GET)
    public String returnManagement2Get(OrderReturnVO vo, Model model, HttpSession session) {
    	String user_id = (String)session.getAttribute("sUser_id");
    	//회원정보 가져오기
    	UserVO userVO = userService.getUserInfor(user_id);
    	
    	//주문 내용 가져오기
    	OrderListVO listVO = orderService.getOrderListInfor(vo.getOrder_list_idx(), vo.getOrder_idx());
    	
    	//반품 요청 내용 가져오기
    	OrderReturnVO reVO = orderService.getOrderReturnInfor(vo.getOrder_list_idx());
    	
    	model.addAttribute("userVO", userVO);
    	model.addAttribute("listVO", listVO);
    	model.addAttribute("reVO", reVO);
    	return "admin/order/returnManagement2";
    }
    
    // 반품 완료(환불 완료) 처리
    @RequestMapping(value = "/returnOk", method = RequestMethod.POST)
    public String returnOkPost(OrderReturnVO vo) {
    	//반품 완료 상태 처리
    	orderAdminService.setOrderCodeChange(vo.getOrder_list_idx(), "13");
    	
    	//반품DB 업뎃
    	orderService.setReturnOk(vo);
    	
    	return "redirect:/msg/returnOk";
    }
}
