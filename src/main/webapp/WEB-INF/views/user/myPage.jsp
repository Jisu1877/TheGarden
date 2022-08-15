<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<link rel="icon" href="${ctp}/images/favicon.png">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<style>
	#item_list_all > div {
		min-height: 180px;
	}
	#discountPrice {
		text-decoration: line-through;
	}
	.w3-radius {
		border-radius: 20px;
	}
	.tableStyle {
 		width:100%;
 		overflow-x : auto;
 		white-space:nowrap;
 		border-radius: 15px;
 		background-color: white;
 	}
</style>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="${ctp}/ckeditor/ckeditor.js"></script>
<script src="${ctp}/js/myPage.js"></script>
<script>
$(document).ready(function() {
	let date = '${nowDate}';
	let dateArr = date.split('-');
	let dateNum = Number(dateArr[1]);
	let calDate = Number(dateArr[1]) - 1;
});

/* 구매확정 처리 */
function confirmCheck(listIdx,orderIdx,total_amount, item_idx) {
	
	$.ajax({
		type : "post",
		url : "${ctp}/order/confirmCheck",
		data : {idx : listIdx,
			    code : 6,
			    order_idx : orderIdx,
			    total_amount : total_amount,
			    item_idx : item_idx
		},
		success : function(res) {
			if(res == "1") {
				alert("구매 확정이 완료되었습니다.\n감사합니다.");
				location.reload();
			}
			else if(res == "2") {
				alert("구매 확정과 쿠폰 발급이 완료되었습니다.\n감사합니다.");
				location.reload();
			}
			else if(res == "0") {
				alert("같은 주문번호 결제 건 중,\n취소 요청 혹은 환불 요청 진행 중인 주문건이 있으므로 구매확정이 어렵습니다. \n진행 완료 후 구매확정을 진행하시기 바랍니다.");
			}
		},
		error : function() {
			alert("전송 오류 입니다.");
		}
	});
}
</script>
<style>
.date {
	background-color:lavender;
	border: 0.5px solid lightgray;
	border-radius: 10px;
	padding: 5px;
}
</style>
</head>
<body>
<!-- Nav  -->
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<!-- !PAGE CONTENT! -->
<div id="pageContent"  class="w3-container w3-content" style="max-width:1500px" onmouseover="hoverMenuClose()">
	<div style="margin-bottom:100px; margin-top:70px;">
    	<!-- The Grid -->
	  <div class="w3-row">
	    <!-- Left Column -->
	    <div class="w3-col m3">
	      <!-- Profile -->
	      <div class="w3-card w3-round w3-white">
	        <div class="w3-container" style="padding-top: 30px;">
	         <p class="w3-center">
	         	<img src="${ctp}/data/user/${userVO.user_image}" class="w3-circle" style="height:106px;width:106px" alt="userImage"><br>
	         </p>
	         <form name="userImageForm" method="post" action="${ctp}/user/userImageChange" enctype="multipart/form-data">
	         <h5 class="w3-center">${userVO.name} 
	         	<a href="javascript:$('#user_image').click()" title="프로필 사진 변경"><i class="fa-solid fa-gear" style="font-size:13px;"></i></a>
	         	<input type="file" id="user_image" name="user_image" style="display:none" accept=".png, .jpg, .jpeg, .jfif, .gif" onchange="userImageChange();">
	         	<input type="hidden" name="myPhoto" id="myPhoto">
	         </h5>
	         </form>
	         <h6 class="w3-center">${userVO.user_id} &nbsp; |  &nbsp;
	         <c:if test="${userVO.level == 1}">
				Gold
			 </c:if>
			 <c:if test="${userVO.level == 2}">
				Silver
			 </c:if>
			 <c:if test="${userVO.level == 0}">
				Admin
			 </c:if> 
	         <span class="w3-dropdown-click text-left">
				<a onclick="myFunction2()"><i class="fa-solid fa-circle-question"></i></a>
				<div id="pointDemo" class="w3-dropdown-content w3-bar-block w3-border montserrat" style="padding:10px; font-size: 12px;">
					더 가든은 회원 등급제를 운영하고 있습니다.<br>
					(Silver/Gold)
					<hr>
					Gold 레벨 변경 요건은?<br>
					- 로그인 횟수 50회 이상<br>
					- 구매 횟수 10회 이상<br>
					- 구매 총 가격 30만원 이상
					<hr>
					Gold 레벨의 혜택은?<br>
					- 적립 포인트 2배 적립
			    </div>
			 </span>
	         </h6>
	         <hr>
	         <div class="w3-row">
	         	<div class="w3-half text-center">
	         		<b>보유 포인트</b><br>
	         		<fmt:formatNumber value="${userVO.point}"/>Point
	         	</div>
	         	<div class="w3-half text-center">
	         		<b>사용 가능 쿠폰</b><br>
	         		<a onclick="couponList(${userVO.user_idx})" title="보유 쿠폰 확인">${couponCnt}개</a>
	         	</div>
	         </div>
	         <hr>
	         <p><i class="fa-solid fa-arrow-pointer w3-margin-right w3-text-theme"></i> 로그인 횟수 : ${userVO.login_count}회</p>
	         <p><i class="fa-solid fa-credit-card w3-margin-right w3-text-theme"></i> 구매 횟수 : ${userVO.buy_count}회
	         	<a onclick="myFunction3()"><i class="fa-solid fa-circle-question"></i></a>
				<div id="demo" class="w3-dropdown-content w3-bar-block w3-border montserrat" style="padding:10px; font-size: 12px;">
					구매 횟수와 구매 총금액은 상품 구매확정 시 누적됩니다.
			    </div>
	         </p>
	         <p><i class="fa-solid fa-hand-holding-dollar w3-margin-right w3-text-theme"></i> 구매 총 금액 : <fmt:formatNumber value="${userVO.buy_price}"/>원</p>
		     <p class="text-right" title="회원정보 수정"><a href="${ctp}/user/userInforUpdate"><i class="fa-solid fa-user-gear"></i>&nbsp;회원정보 수정</a></p>
	        </div>
	      </div>
	      <br>
	      
	     <!-- Accordion -->
	      <div class="w3-card w3-round">
	        <div class="w3-white">
	          <div class="w3-padding" style="font-size:17px; padding-top:20px;">
	          	<a href="${ctp}/user/wishAndRecent">
	          		<b>관심 상품</b>
	          	</a>
	          </div>
	          <button onclick="wishlistOpen()" class="btn w3-hover-wihte w3-block w3-left-align">
	          	<i class="fa-solid fa-heart-circle-check"></i> &nbsp;<span ${wishlistFlag == 'yes' && recentViewFlag == 'no' ? 'style="color:brown"' : ''}>찜한 상품</span>
	          </button>
	          <button onclick="recentViews()" class="btn w3-block w3-hover-wihte w3-left-align">
	          	<i class="fa-solid fa-eye"></i> &nbsp;<span ${wishlistFlag == 'yes' && recentViewFlag == 'yes' && reviewDoneFlag == 'no' && plantBoardFlag == 'no' ? 'style="color:brown"' : ''}>최근 본 상품</span>
	          </button>
	        </div>      
	      </div>
	      <br>
	      <div class="w3-card w3-round">
	        <div class="w3-white">
	          <div class="w3-padding" style="font-size:17px; padding-top:20px;"><b>상품 리뷰</b></div>
	          <button onclick="reivewNeedOpen()" class="btn w3-hover-wihte w3-block w3-left-align">
	          	<i class="fa-solid fa-pen-to-square"></i> &nbsp;<span ${reviewFlag == 'yes' ? 'style="color:brown"' : ''}>작성 가능한 리뷰</span> 
	          </button>
	          <button onclick="reviewDoneOpen()" class="btn w3-block w3-hover-wihte w3-left-align">
	          	<i class="fa-solid fa-file-lines"></i> &nbsp;<span ${reviewDoneFlag == 'yes' && plantBoardFlag != 'yes' ? 'style="color:brown"' : ''}>내가 작성한 리뷰</span>
	          </button>
	        </div>      
	      </div>
	      <br>
	      
	      <div class="w3-card w3-round">
	       <div class="w3-white">
	          <div class="w3-padding" style="font-size:17px; padding-top:20px;"><b>내가 쓴 게시물</b></div>
	          <button onclick="plantBoardUser()" class="btn w3-hover-wihte w3-block w3-left-align">
	          	<i class="fa-solid fa-seedling"></i> &nbsp;<span ${plantBoardFlag == 'yes' && inquiryFlag == 'no' ? 'style="color:brown"' : ''}>식물 상담</span> 
	          </button>
	          <button onclick="inquiryList()" class="btn w3-block w3-hover-wihte w3-left-align">
	          	<i class="fa-brands fa-quora"></i> &nbsp;<span ${inquiryFlag == 'yes' && itemQnaFlag == 'no' ? 'style="color:brown"' : ''}>1:1 문의</span> 
	          </button>
	          <button onclick="itemQnaList()" class="btn w3-block w3-hover-wihte w3-left-align">
	          	<span class="iconify" data-icon="fluent:chat-bubbles-question-20-filled" style="font-size:17px;"></span> &nbsp;<span ${itemQnaFlag == 'yes' ? 'style="color:brown"' : ''}>상품 문의</span> 
	          </button>
	        </div>      
	      </div>
	      <br>
	    <!-- End Left Column -->
	    </div>
	    
	    <!-- Middle Column -->
	    <div class="w3-col m9">
	    
	      <div class="w3-row-padding">
	        <div class="w3-quarter text-center">
	          <a href="${ctp}/user/myPageOnlyOrder">
	          <div class="w3-card w3-round w3-2019-sweet-corn w3-hover-khaki">
	            <div class="w3-container w3-padding">
	            	<span class="w3-badge w3-xlarge w3-padding w3-white">
	            		🧾
	            	</span>
            		<div style="font-size:20px; margin-top:15px;"><b>주문</b></div>
            		<div style="font-size:20px; margin-top:15px;">${orderListOnlyOrderCnt}</div>
	            </div>
	          </div>
	          </a>
	        </div>
	        <div class="w3-quarter text-center">
	          <a href="${ctp}/user/myPageOnlyDelivery">
	          <div class="w3-card w3-round w3-2019-sweet-corn w3-hover-khaki">
	            <div class="w3-container w3-padding">
	            	<span class="w3-badge w3-xlarge w3-padding w3-white">
	            		🚚
	            	</span>
            		<div style="font-size:20px; margin-top:15px;"><b>배송중</b></div>
            		<div style="font-size:20px; margin-top:15px;">${orderListOnlyDeliveryCnt}</div>
	            </div>
	          </div>
	          </a>
	        </div>
	        <div class="w3-quarter text-center">
	          <a href="${ctp}/user/myPageOnlyDeliveryOk">
	          <div class="w3-card w3-round w3-2019-sweet-corn w3-hover-khaki">
	            <div class="w3-container w3-padding">
	            	<span class="w3-badge w3-xlarge w3-padding w3-white">
	            		📦
	            	</span>
            		<div style="font-size:20px; margin-top:15px;"><b>배송완료</b></div>
            		<div style="font-size:20px; margin-top:15px;">${orderListOnlyDeliveryOkCnt}</div>
	            </div>
	          </div>
	          </a>
	        </div>
	        <div class="w3-quarter text-center">
	          <a href="${ctp}/user/myPageOnlyReturn">
	          <div class="w3-card w3-round w3-2019-sweet-corn w3-hover-khaki">
	            <div class="w3-container w3-padding">
	            	<span class="w3-badge w3-xlarge w3-padding w3-white">
	            		🔙
	            	</span>
            		<div style="font-size:20px; margin-top:15px;"><b>취소/반품/교환</b></div>
            		<div style="font-size:20px; margin-top:15px;">${orderListOnlyReturnCnt}</div>
	            </div>
	          </div>
	          </a>
	        </div>
	      </div>
		
         <form name="orderSearchForm" method="get" action="${ctp}/user/orderSearch">
	      <div class="w3-container w3-card w3-white w3-round w3-margin"><br>
	        <div class="w3-row-padding" style="margin:0 -16px;">
		          <div class="w3-third w3-margin-bottom">
		            <label>
		            	<i class="fa fa-calendar-o"></i>&nbsp; 주문 조회 &nbsp;
		            </label>
		            <input class="w3-input w3-border" type="text" placeholder="YYYY-DD-MM" name="start" id="start" value="${start}" autocomplete="off">
		          </div>
		          <div class="w3-third">
		            <label>&nbsp;</label>
		            <input class="w3-input w3-border" type="text" placeholder="YYYY-DD-MM" name="end" id="end" value="${end}" autocomplete="off">
		          </div>
		          <div class="w3-third">
		          	<div class="w3-row">
		          		<div class="w3-half">
		          			<label>&nbsp;</label>
		          			<select name="order_status_code" id="order_status_code" class="w3-select w3-border">
		          				<option value="0" ${code == 0 ? 'selected' : '' }>전체조회</option>
		          				<option value="1" ${code == 1 ? 'selected' : '' }>결제완료</option>
		          				<option value="3" ${code == 3 ? 'selected' : '' }>취소</option>
		          				<option value="4" ${code == 4 ? 'selected' : '' }>배송중</option>
		          				<option value="5" ${code == 5 ? 'selected' : '' }>배송완료</option>
		          				<option value="6" ${code == 6 ? 'selected' : '' }>교환</option>
		          				<option value="7" ${code == 7 ? 'selected' : '' }>반품</option>
		          			</select>
		          		</div>
		          		<div class="w3-half pl-4">
<%-- 		          		<label class="w3-2021-buttercream">
		          				<span style="text-align:right; cursor: pointer;" onclick="location.href='${ctp}/user/myPageOpen'">첫 화면으로 이동</span>
		          			</label><br> --%>
		          			<label>&nbsp;</label><br>
		          			<a class="w3-button w3-2019-soybean" onclick="searchCheck()"><i class="fa fa-search w3-margin-right"></i> Search</a>
		          		</div>
		          	</div>
		          </div>
	        </div>
	      </div>
         </form>
         <c:if test="${wishlistFlag == 'no'}">
         <div id="basicOrderList">
	      <div class="w3-container w3-card w3-white w3-round w3-margin">
	          <c:if test="${orderListSearch.size() == 0 && empty reviewFlag && thisMonth == 'yes'}">
	          	  <div class="w3-padding-16" style="font-size:16px;">
					<i class="fa-solid fa-circle-exclamation"></i>&nbsp; 이번달 주문 내역이 없습니다☺️
	          	  </div>
	          </c:if>
	          <c:if test="${orderListSearch.size() == 0 && empty reviewFlag && thisMonth != 'yes'}">
	          	  <div class="w3-padding-16" style="font-size:16px;">
					<i class="fa-solid fa-circle-exclamation"></i>&nbsp; 조회되는 주문 내역이 없습니다☺️
	          	  </div>
	          </c:if>
	          <c:if test="${orderListSearch.size() == 0 && reviewFlag == 'yes'}">
	          	  <div class="w3-padding-16" style="font-size:16px;">
					<i class="fa-solid fa-circle-exclamation"></i>&nbsp; 작성가능한 리뷰가 없습니다☺️
	          	  </div>
	          </c:if>
	          <c:if test="${orderListSearch.size() != 0}">
          	  <c:set var="cnt" value="0"/>
	          <c:set var="idx" value="0"/>
	          <c:set var="sw" value="0"/>
	          <c:forEach var="vo" items="${orderListSearch}">
	          		<c:set var="date" value="${fn:split(vo.created_date, '-')}"/>
	          		<c:set var="date2" value="${fn:split(nowDate, '-')}"/>
		          	<c:if test="${date[1] == date2[1] && cnt == 0}">
			          	<div class="w3-padding-16" style="font-size:22px;"><span class="pl-2 pr-2 date">${nowDate}</span></div>
			          	<div>
			          		<i class="fa-solid fa-circle-info"></i> 포토 리뷰 작성 시 500Point 적립❕[텍스트 리뷰 100Point]
			          	</div>
			      	  	<hr>
			      	  	<c:set var="cnt" value="1"/>
		      	  	</c:if>
		      	  	<c:if test="${date2[1] - date[1] != sw}">
		      	  		 <c:set var="sw" value="0"/>
		      	  	</c:if>
		          	<c:if test="${date[1] != date2[1] && sw == 0}">
		          		<c:set var="calSub" value="${date2[1] - date[1]}"/>
		          		<c:set var="calDay" value="${date2[1] - calSub}"/>
		          		<c:set var="el" value="-"/>
		          		<c:set var="zero" value="0"/>
		          		<c:set var="calDate" value="${date[0]}${el}${zero}${calDay}"/>
			          	<div class="w3-padding-16" style="font-size:22px;"><span class="pl-2 pr-2 date">${calDate}</span></div>
			          	<div>
			          		<i class="fa-solid fa-circle-info"></i> 포토 리뷰 작성 시 500Point 적립❕[텍스트 리뷰 100Point]
			          	</div>
			      	  	<hr>
			      	  	<c:set var="sw" value="${calSub}"/>
		      	  	</c:if>
		          	<div class="w3-row">
		          		<c:if test="${idx != vo.order_idx}">
		          			<div class="w3-bottombar w3-2019-sweet-corn w3-padding" style="margin-bottom: 20px;">
						    	<div>
						    		<span>주문번호 <b>${vo.order_number}</b></span> &nbsp; | &nbsp;
						    		총 결제금액 : <b><fmt:formatNumber value="${vo.order_total_amount}"/>원</b>
						    	</div>
						    </div>
		          		</c:if>
		          		<div class="w3-col m2">
				          <img src="${ctp}/data/item/${vo.item_image}" class="w3-left w3-margin-right w3-radius" style="width:90%">
		          		</div>
		          		<div class="w3-col m8 pl-2">
				            <h5>${vo.item_summary}</h5>
				            <c:if test="${vo.item_option_flag == 'y'}">
							  <div>옵션 : ${vo.option_name}</div>		          
				            </c:if>
						    <div>수량 : ${vo.order_quantity} 개</div>
						    <div>상품 금액 : <fmt:formatNumber value="${vo.item_price}"/>원</div>
						    <c:if test="${vo.item_return_flag == 'n'}">
						    	<div class="mt-1" style="color:tomato"><i class="fa-solid fa-circle-info"></i> 반품 불가 상품</div>
						    </c:if>
							<hr>
							<c:if test="${vo.order_status_code == '1'}">
								<font size="3" color="gray">결제완료</font><br>
								✔️ 주문 확인 중입니다.
							</c:if>					
							<c:if test="${vo.order_status_code == '2' && vo.reject_code == '0'}">
								<font size="3" color="gray">확인완료(배송 준비중)</font><br>
								✔️ 배송 준비 중입니다☺️ 조금만 기다려주세요.
							</c:if>					
							<c:if test="${vo.order_status_code == '3'}">
								<font size="3" color="red">취소완료</font><br>
								✔️ 취소처리가 완료되었습니다. 감사합니다.
							</c:if>					
							<c:if test="${vo.order_status_code == '4'}">
								<font size="3" color="gray">배송중</font><br>
								<i class="fa-solid fa-truck-bolt"></i> 배송 중입니다☺️ 금방 도착합니다~!
							</c:if>					
							<c:if test="${vo.order_status_code == '5'}">
								<font size="3" color="gray">배송완료</font><br>
								<i class="fa-solid fa-box-check"></i> 배송이 완료되었습니다. 구매확정을 진행해주세요.
								<div class="mt-2">
									<a class="btn w3-amber btn-sm mr-1" href="javascript:confirmCheck(${vo.order_list_idx},${vo.order_idx},${vo.order_total_amount},${vo.item_idx})">구매확정</a>
									<a href="javascript:exchangeRequest(${vo.order_list_idx},${vo.order_idx},${vo.item_idx})" class="btn w3-2020-orange-peel btn-sm mr-1">교환 요청</a>
									<c:if test="${vo.item_return_flag == 'y'}">
										<a onclick="javascript:returnRequest(${vo.order_list_idx},${vo.order_idx},${vo.item_idx})" class="btn w3-black btn-sm">반품 요청</a>
									</c:if>
								</div>
							</c:if>					
							<c:if test="${vo.order_status_code == '6'}">
								<font size="3" color="gray">구매완료</font><br>
								✔️ 구매확정이 완료되었습니다. 리뷰를 작성해주세요.
							</c:if>					
							<c:if test="${vo.order_status_code == '7'}">
								<font size="3" color="blue">교환요청 처리 중</font><br>
								✔️ 교환 요청이 완료되었습니다. 관리자 승인여부 처리를 기다려주세요.
							</c:if>					
							<c:if test="${vo.order_status_code == '8'}">
								<font size="3" color="blue">교환승인 완료</font><br>
								✔️ 상품 수거 처리 중입니다. 불편을 끼쳐드려 죄송합니다.
							</c:if>					
							<c:if test="${vo.order_status_code == '9'}">
								<font size="3" color="blue">배송중(교환)</font><br>
								✔️ 교환상품이 배송 중입니다.
							</c:if>					
							<c:if test="${vo.order_status_code == '10'}">
								<font size="3" color="red">교환요청 반려</font><br>
								✔ 교환 요청이 반려되었습니다. 관리자 답변을 확인해주세요.<br>
								<div class="mt-2">
									<a class="btn w3-amber btn-sm mr-1" href="javascript:confirmCheck(${vo.order_list_idx},${vo.order_idx},${vo.order_total_amount},${vo.item_idx})">구매확정</a>
									<c:if test="${vo.item_return_flag == 'y'}">
										<a onclick="javascript:returnRequest(${vo.order_list_idx},${vo.order_idx},${vo.item_idx})" class="btn w3-black btn-sm">반품 요청</a>
									</c:if>
								</div>
							</c:if>					
							<c:if test="${vo.order_status_code == '11'}">
								<font size="3" color="blue">반품요청 처리 중</font><br>
								✔ 반품 요청이 완료되었습니다. 관리자 승인여부 처리를 기다려주세요.
							</c:if>					
							<c:if test="${vo.order_status_code == '12'}">
								<font size="3" color="brown">반품승인</font><br>
								✔ 반품 요청이 승인되었습니다. 상품 수거 처리 중입니다.
							</c:if>					
							<c:if test="${vo.order_status_code == '13'}">
								<font size="3" color="brown">환불완료</font><br>
								✔ 환불이 완료되었습니다. 입력하신 계좌를 확인해주세요.
							</c:if>					
							<c:if test="${vo.order_status_code == '14'}">
								<font size="3" color="red">반품 요청 반려</font><br>
								✔ 반품 요청이 반려되었습니다. 자세한 내용은 요청 처리 내용을 확인해주세요.<br>
								<div class="mt-2">
									<a class="btn w3-amber btn-sm mr-1" href="javascript:confirmCheck(${vo.order_list_idx},${vo.order_idx},${vo.order_total_amount},${vo.item_idx})">구매확정</a>
									<a href="javascript:exchangeRequest(${vo.order_list_idx},${vo.order_idx},${vo.item_idx})" class="btn w3-2020-orange-peel btn-sm mr-1">교환 요청</a>
								</div>
							</c:if>					
							<c:if test="${vo.order_status_code == '15'}">
								<font size="3" color="blue">취소 요청 중</font><br>
								✔ 취소 요청을 검토중입니다. 기다려주세요.
							</c:if>					
							<c:if test="${vo.order_status_code == '2' && vo.reject_code == '1'}">
								<font size="3" color="red">취소 요청 반려(배송 준비 중)</font><br>
								✔ 취소 요청이 반려되었습니다. 처리 내용을 확인해주세요.
							</c:if>
							<c:if test="${vo.order_status_code == '17'}">
								<font size="3" color="gray">배송완료(교환)</font><br>
								✔ 교환 상품이 배송완료되었습니다. 구매확정을 진행해주세요.
								<div class="mt-2">
									<a class="btn w3-amber btn-sm mr-1" href="javascript:confirmCheck(${vo.order_list_idx},${vo.order_idx},${vo.order_total_amount},${vo.item_idx})">구매확정</a>
									<c:if test="${vo.item_return_flag == 'y'}">
										<a onclick="javascript:returnRequest(${vo.order_list_idx},${vo.order_idx},${vo.item_idx})" class="btn w3-black btn-sm">반품 요청</a>
									</c:if>
								</div>
							</c:if>		
							<c:if test="${vo.order_status_code == '18'}">
								<font size="3" color="gray">리뷰 작성 완료</font><br>
							</c:if>				
		          		</div>
		          		<div class="w3-col m2">
		          			<div class="mb-2">
		          				<span class="w3-right w3-opacity">${fn:substring(vo.created_date, 0, 19)}</span>
		          			</div><br>
		          			<div style="margin-top: 20px;" class="w3-right">
		          				<c:if test="${vo.order_status_code == '1'}">
		          					<a onclick="orderCancel(${vo.order_list_idx},${vo.order_idx})" class="btn btn-outline-primary btn-sm m-1">주문 취소</a>
								</c:if>
		          				<c:if test="${vo.order_status_code == '2' && vo.reject_code == '0'}">
		          					<a onclick="orderCancelRequest(${vo.order_list_idx},${vo.order_idx})" class="btn btn-outline-success btn-sm m-1">취소 요청</a>
								</c:if>
		          				<c:if test="${vo.order_status_code == '3'}">
		          					<a onclick="orderCancelInfor(${vo.order_list_idx},${vo.order_idx})" class="btn w3-yellow btn-sm m-1">취소 내역 확인</a>
								</c:if>
		          				<c:if test="${vo.reject_code == '1'}">
		          					<a onclick="orderCancelRequestInfor(${vo.order_list_idx},${vo.order_idx})" class="btn w3-2020-mosaic-blue btn-sm m-1 w3-right">취소 처리 내용 확인</a>
								</c:if>
								<c:if test="${vo.order_status_code == '8' || vo.order_status_code == '9' || vo.order_status_code == '10' || vo.order_status_code == '17'}">
									<a onclick="orderExchangeInfor(${vo.order_list_idx})" class="btn w3-2020-orange-peel btn-sm m-1 w3-right">교환 요청 처리 확인</a>
								</c:if>
								<c:if test="${vo.order_status_code == '12' || vo.order_status_code == '13' || vo.order_status_code == '14'}">
									<a onclick="orderReturnInfor(${vo.order_list_idx})" class="btn w3-black btn-sm m-1 w3-right">반품 요청 처리 확인</a>
								</c:if>
								<c:if test="${vo.order_status_code == '6'}">
									<a onclick="reviewInsert(${vo.item_idx},${vo.order_idx},${vo.order_list_idx})" class="btn btn-outline-dark btn-sm m-1 w3-right">리뷰 작성</a>
								</c:if>
								<c:if test="${vo.order_status_code == '18'}">
									<a onclick="reviewInsert(${vo.item_idx},${vo.order_idx},${vo.order_list_idx})" class="btn btn-outline-info btn-sm m-1 w3-right">리뷰 내용 조회</a>
								</c:if>
								<c:if test="${vo.order_status_code == '4' || vo.order_status_code == '5' || vo.order_status_code == '6' || vo.order_status_code == '17' || vo.order_status_code == '18'}">
									<a href="javascript:shippingInfor(${vo.order_list_idx})" class="btn btn-outline-secondary btn-sm m-1 w3-right">배송 내역</a>
								</c:if>
		          			</div>
		          		</div>
			        </div><br><br>
			        <c:set var="idx" value="${vo.order_idx}"/>
		     </c:forEach>
	       </c:if>
	      </div>
	      </div> 
		</c:if>
		<c:if test="${wishlistFlag == 'yes' && recentViewFlag == 'no'}">
			<div class="w3-container w3-card w3-white w3-round w3-margin">
				<div class="w3-row-padding" style="margin-top:20px">
					<div style="font-size:20px;"><strong><i class="fa-solid fa-heart-circle-check"></i> 찜한 상품 목록</strong></div>
					<hr>
				</div>
				<c:forEach var="itemVO" items="${wishlist}" varStatus="st">
					<div id="item_list_all">
		  			<div class="w3-half">
		  				<a href="${ctp}/item/itemView?item_code=${itemVO.item_code}">
		  				<div class="w3-col m4">
				  			<div class="w3-display-container">
								<img src="${ctp}/data/item/${itemVO.item_image}" alt="${itemVO.item_image}" style="width:90%; margin-top:0px;" class="w3-radius">
						    </div>
		  				</div>
		  				</a>
		  				<div class="w3-col m8">
							<div>
								<div style="color:gray; font-size:14px;">${fn:substring(itemVO.wish_date, 0, 10)}</div>
			  					<a href="${ctp}/item/itemView?item_code=${itemVO.item_code}">
									<h6 class="text-left w3-white" style="font-family:'MaruBuriSemiBold'">
										<strong>
											 ${fn:substring(itemVO.item_summary, 0, 21)}
										    <c:if test="${fn:length(itemVO.item_summary) > 20}">
										    ...
										    </c:if>
						  					<%-- ${itemVO.item_summary} --%>
						  				</strong>
									</h6>
								</a>
							</div>
							<div class="text-left">
							<c:if test="${itemVO.seller_discount_flag == 'n'}">
								<c:set var="priceFmt" value="${itemVO.sale_price}"/>
					        	<div class="mt-2" style="font-size:14px;"><b><fmt:formatNumber value="${priceFmt}"/>원</b></div>
							</c:if>
							<c:if test="${itemVO.seller_discount_flag == 'y'}">
								<div class="w3-row mt-2" style="font-size:14px;"><b>
						        	<span id="discountPrice">
										<c:set var="priceFmt" value="${itemVO.sale_price}"/>
						        		<fmt:formatNumber value="${priceFmt}"/>원
						        	</span>
					        		<span>
						        		<i class="fa-solid fa-arrow-trend-down"></i>&nbsp;
						        		<c:set var="calPriceFmt" value="${itemVO.sale_price - itemVO.seller_discount_amount}"/>
						        		<fmt:formatNumber value="${calPriceFmt}"/>원
					        		</span>
					        		<span style="font-size: 13px; margin-left: 10px; color:brown">
					        			<!-- (할인율) = (할인액) / (정가) X 100 -->
					        			<c:set var="calDiscountFmt" value="${(itemVO.seller_discount_amount / itemVO.sale_price) * 100}"/>
					        			<fmt:formatNumber type="number" maxFractionDigits="0"  value="${calDiscountFmt}" />
					        			<i class="fa-solid fa-percent"></i> 할인
					        		</span>
					        	</b></div>
							</c:if>
							</div>
							<div class="mt-4" style="font-size:13px">
								<a href="javascript:unlike(${itemVO.item_idx})">
									<i class="fa-solid fa-xmark"></i> 삭제
								</a>
							</div>
		  				</div>
					</div>
					</div>
				</c:forEach>
				<c:if test="${wishlist.size() == 0}">
					<div style="margin-bottom:20px;">
						<i class="fa-solid fa-circle-info"></i> 찜한 상품이 없습니다.
					</div>
				</c:if>
				</div>
			</c:if>
			<c:if test="${wishlistFlag == 'yes' && recentViewFlag == 'yes' && reviewDoneFlag == 'no'}">
				<div class="w3-container w3-card w3-white w3-round w3-margin">
					<div class="w3-row-padding" style="margin-top:20px">
						<div style="font-size:20px;"><strong><i class="fa-solid fa-eye"></i> 최근 본 상품 목록</strong></div>
						<hr>
					</div>
					<c:forEach var="itemVO" items="${recentViews}" varStatus="st">
						<div id="item_list_all">
			  			<div class="w3-half">
			  				<a href="${ctp}/item/itemView?item_code=${itemVO.item_code}">
			  				<div class="w3-col m4">
					  			<div class="w3-display-container">
									<img src="${ctp}/data/item/${itemVO.item_image}" alt="${itemVO.item_image}" style="width:90%; margin-top:0px;" class="w3-radius">
							    </div>
			  				</div>
			  				</a>
			  				<div class="w3-col m8">
								<div>
									<div style="color:gray; font-size:14px;">${fn:substring(itemVO.recent_date, 0, 10)}</div>
				  					<a href="${ctp}/item/itemView?item_code=${itemVO.item_code}">
										<h6 class="text-left w3-white" style="font-family:'MaruBuriSemiBold'">
											<strong>
												 ${fn:substring(itemVO.item_summary, 0, 21)}
											    <c:if test="${fn:length(itemVO.item_summary) > 20}">
											    ...
											    </c:if>
							  					<%-- ${itemVO.item_summary} --%>
							  				</strong>
										</h6>
									</a>
								</div>
								<div class="text-left">
								<c:if test="${itemVO.seller_discount_flag == 'n'}">
									<c:set var="priceFmt" value="${itemVO.sale_price}"/>
						        	<div class="mt-2" style="font-size:14px;"><b><fmt:formatNumber value="${priceFmt}"/>원</b></div>
								</c:if>
								<c:if test="${itemVO.seller_discount_flag == 'y'}">
									<div class="w3-row mt-2" style="font-size:14px;"><b>
							        	<span id="discountPrice">
											<c:set var="priceFmt" value="${itemVO.sale_price}"/>
							        		<fmt:formatNumber value="${priceFmt}"/>원
							        	</span>
						        		<span>
							        		<i class="fa-solid fa-arrow-trend-down"></i>&nbsp;
							        		<c:set var="calPriceFmt" value="${itemVO.sale_price - itemVO.seller_discount_amount}"/>
							        		<fmt:formatNumber value="${calPriceFmt}"/>원
						        		</span>
						        		<span style="font-size: 13px; margin-left: 10px; color:brown">
						        			<!-- (할인율) = (할인액) / (정가) X 100 -->
						        			<c:set var="calDiscountFmt" value="${(itemVO.seller_discount_amount / itemVO.sale_price) * 100}"/>
						        			<fmt:formatNumber type="number" maxFractionDigits="0"  value="${calDiscountFmt}" />
						        			<i class="fa-solid fa-percent"></i> 할인
						        		</span>
						        	</b></div>
								</c:if>
								</div>
			  				</div>
						</div>
						</div>
					</c:forEach>
					<c:if test="${recentViews.size() == 0}">
						<div style="margin-bottom:20px;">
							<i class="fa-solid fa-circle-info"></i> 최근 본 상품이 없습니다.
						</div>
					</c:if>
					</div>
				</c:if>
			<c:if test="${reviewDoneFlag == 'yes' && plantBoardFlag == 'no'}">
				<div class="w3-container w3-card w3-white w3-round w3-margin">
					<div class="w3-row-padding" style="margin-top:20px">
						<div style="font-size:20px;"><strong><i class="fa-solid fa-file-lines"></i> 내가 작성한 리뷰</strong></div>
						<hr>
					</div>
					<c:forEach var="vo" items="${reviewList}">
					    <div class="w3-row-padding" style="margin-bottom:40px;">
				    		<div class="w3-col l1 m1">
					  			<div class="w3-display-container">
									<img src="${ctp}/data/user/${vo.user_image}" alt="${vo.user_image}" style="width:80%; margin-top:0px;" class="w3-radius">
							    </div>
			  				</div>
			  				<div class="w3-col l7 m8 ml-2">
			  					<div>
				  					<c:if test="${vo.rating == 5}">
				  						⭐⭐⭐⭐⭐ <font size="4">5</font>
				  					</c:if>
				  					<c:if test="${vo.rating == 4}">
				  						⭐⭐⭐⭐ <font size="4">4</font>
				  					</c:if>
				  					<c:if test="${vo.rating == 3}">
				  						⭐⭐⭐ <font size="4">3</font>
				  					</c:if>
				  					<c:if test="${vo.rating == 2}">
				  						⭐⭐ <font size="4">2</font>
				  					</c:if>
				  					<c:if test="${vo.rating == 1}">
				  						⭐ <font size="4">1</font>
				  					</c:if>
			  					</div>
			  					<div class="ml-2" style="color:gray; font-size:13px;">
			  						<span>${fn:substring(vo.user_id, 0, 3)}*****</span>
			  						&nbsp;${fn:substring(vo.review_date, 0, 10)}
			  					</div>
			  					<div class="mt-2" style="font-size: 15px;">
			  						<b>${fn:replace(vo.review_subject, newLine, '<br>')}</b>
			  					</div>
			  					<div style="color:gray; font-size:14px;">
			  						${fn:replace(vo.review_contents, newLine, '<br>')}
			  					</div>
			  					<div class="w3-text-gray mt-3" style="font-size:12px;">
			  						<a href="javascript:reviewUpdate(${vo.review_idx}, ${vo.order_idx}, ${vo.order_list_idx})">수정하기</a>
			  					</div>
		  					</div>
		  					<div class="w3-col m3">
		  						<div style="text-align:right">
			  						<c:if test="${vo.photo != ''}">
			  							<c:set var="photo" value="${fn:split(vo.photo, '/')}"/>
			  							<a href="javascript:showImage(${vo.review_idx})">
			  								<img src="${ctp}/data/review/${photo[0]}" alt="${photo[0]}" style="width:40%; margin-top:0px;" class="w3-radius">
			  							</a>
			  						</c:if>
		  						</div>
		  					</div>
				    	</div>
			    		<a href="javascript:hideImage(${vo.review_idx})">
					    	<div class="w3-row-padding" id="showImage${vo.review_idx}" style="display:none">
					    		<c:set var="images" value="${fn:split(vo.photo, '/')}"/>
					    		<c:forEach var="image" items="${images}">
					    			<img src="${ctp}/data/review/${image}" alt="${image}" style="width:30%; margin-top:0px;">
					    		</c:forEach>
					    	</div>
			    		</a>
				    	<hr>
	    		</c:forEach>
	    		<c:if test="${reviewList.size() == 0}">
					<div style="margin-bottom:20px;">
						<i class="fa-solid fa-circle-info"></i> 내가 작성한 리뷰가 없습니다.
					</div>
				</c:if>
				</div>
			</c:if>
			<c:if test="${plantBoardFlag == 'yes' && inquiryFlag == 'no'}">
				<div class="w3-container w3-card w3-white w3-round w3-margin">
					<div class="w3-row-padding" style="margin-top:20px">
						<div style="font-size:20px;"><strong><i class="fa-solid fa-seedling"></i> 식물 상담</strong></div>
						<hr>
					</div>
					<div class="w3-responsive tableStyle">
					<table class="w3-table w3-striped" style="border-collapse:separate;">
						<thead>
				        	<tr class="w3-2021-mint">
				        		<th class="text-center">제목</th>
				        		<th class="text-center">등록일</th>
				        		<th class="text-center">조회수</th>
				        		<th class="text-center">답변여부</th>
				        		<th class="text-center">수정/삭제</th>
				        	</tr>
						</thead>
						<tbody>
							<c:forEach var="vo" items="${plantBoardList}">
								<tr>
									<td class="text-center">
										<a href="javascript:showboardContent(${vo.plant_board_idx})">
											${vo.title}
										</a>
									</td>
									<td class="text-center">${vo.write_date}</td>
									<td class="text-center">${vo.views}</td>
									<td class="text-center">
										<c:if test="${vo.admin_answer_yn == 'y'}">
				        					<i class="fa-solid fa-o"></i>
				        				</c:if>
				        				<c:if test="${vo.admin_answer_yn == 'n'}">
				        					<i class="fa-solid fa-x"></i>
				        				</c:if>
									</td>
									<td class="text-center">
										<c:if test="${vo.admin_answer_yn == 'n'}">
	    									<a href="javascript:boardUpdate('${vo.plant_board_idx}','${vo.admin_answer_yn}')" class="w3-button w3-khaki w3-hover-khaki w3-round-large w3-padding-small w3-samll mr-2">수정</a>
	    								</c:if>
										<a href="javascript:boardDelete(${vo.plant_board_idx})" class="w3-button w3-khaki w3-hover-khaki w3-round-large w3-padding-small w3-samll">삭제</a>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${plantBoardList.size() == 0}">
								<tr><td colspan="5" class="p-1 m-0 text-center">작성한 상담 글이 없습니다.</td></tr>
							</c:if>
							<tr><td colspan="5" class="p-1 m-0"></td></tr>
						</tbody>
					</table>
				</div>
				</div>
			</c:if>
			<c:if test="${inquiryFlag == 'yes' && itemQnaFlag == 'no'}">
				<div class="w3-container w3-card w3-white w3-round w3-margin">
					<div class="w3-row-padding" style="margin-top:20px">
						<div style="font-size:20px;"><strong><i class="fa-brands fa-quora"></i> 1:1 문의</strong></div>
						<hr>
					</div>
					<div class="w3-responsive tableStyle" style="margin-bottom:30px;">
					<table class="w3-table w3-striped" style="border-collapse:separate;">
						<thead>
				        	<tr class="w3-2021-inkwell">
				        		<th class="text-center">내용</th>
				        		<th class="text-center">등록일</th>
				        		<th class="text-center">답변여부</th>
				        		<th class="text-center">수정/삭제</th>
				        	</tr>
						</thead>
						<tbody>
							<c:forEach var="vo" items="${inquiryList}">
								<tr>
									<td class="text-center">
										<a href="javascript:showInquiryContent(${vo.inquiry_idx})">
											${fn:substring(vo.inquiry_content,0,10)}
											<c:if test="${fn:length(vo.inquiry_content) > 10}">...</c:if>
										</a>
									</td>
									<td class="text-center">${vo.write_date}</td>
									<td class="text-center">
										<c:if test="${vo.admin_answer_yn == 'y'}">
				        					<i class="fa-solid fa-o"></i>
				        				</c:if>
				        				<c:if test="${vo.admin_answer_yn == 'n'}">
				        					<i class="fa-solid fa-x"></i>
				        				</c:if>
									</td>
									<td class="text-center">
										<a href="javascript:inquiryDelete(${vo.inquiry_idx})" class="w3-button w3-khaki w3-hover-khaki w3-round-large w3-padding-small w3-samll">삭제</a>
									</td>
								</tr>
								<tr><td colspan="4" class="p-0 m-0" style="display:none"></td></tr>
								<tr class="showInquiry" id="showInquiry${vo.inquiry_idx}" style="display:none">
									<td colspan="3">
										<div class="mb-2">
											▪️ 문의 내용 :
							    			${vo.inquiry_content}
							    		</div><br>
							    		<c:if test="${vo.admin_answer_yn == 'y'}">
							    			<div class="ml-3">
							    				<span class="iconify" data-icon="bi:arrow-return-right"></span> &nbsp; 답변 : ${vo.admin_answer}
							    			</div>
							    		</c:if>
									</td>
									<td class="text-center">
										<a href="javascript:hideInquiryContent(${vo.inquiry_idx})" class="w3-btn w3-black w3-round-large w3-padding-small w3-small">닫기</a>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${inquiryList.size() == 0}">
								<tr><td colspan="5" class="p-1 m-0 text-center">1:1 문의내용이 없습니다.</td></tr>
							</c:if>
						</tbody>
					</table>
					</div>
					</div>
				</c:if>
				<c:if test="${itemQnaFlag == 'yes'}">
					<div class="w3-container w3-card w3-white w3-round w3-margin">
						<div class="w3-row-padding" style="margin-top:20px">
							<div style="font-size:20px;"><strong><span class="iconify" data-icon="fluent:chat-bubbles-question-20-filled" style="font-size:20px;"></span> 상품 문의</strong></div>
							<hr>
						</div>
						<div class="w3-responsive tableStyle">
							<table class="w3-table w3-striped" style="border-collapse:separate;">
								<thead>
						        	<tr class="w3-2021-inkwell">
						        		<th class="text-center">상품명</th>
						        		<th class="text-center">회원 ID</th>
						        		<th class="text-center">공개여부</th>
						        		<th class="text-center">작성일</th>
						        		<th class="text-center">답변여부</th>
						        		<th class="text-center">답변조회</th>
						        		<th class="text-center">삭제</th>
						        	</tr>
								</thead>
								<tbody>
									<c:forEach var="vo" items="${itemQnaList}">
											<tr>
												<td class="text-center">
													${vo.item_name}
												</td>
												<td class="text-center">${vo.user_id}</td>
												<td class="text-center">
													<c:if test="${vo.view_yn == 'y'}">공개</c:if>
													<c:if test="${vo.view_yn == 'n'}">비밀글</c:if>
												</td>
												<td class="text-center">${fn:substring(vo.write_date,0,10)}</td>
												<td class="text-center">
							        				<c:if test="${vo.admin_answer_yn == 'y'}">
							        					<i class="fa-solid fa-o"></i>
							        				</c:if>
							        				<c:if test="${vo.admin_answer_yn == 'n'}">
							        					<i class="fa-solid fa-x"></i>
							        				</c:if>
												</td>
												<td class="text-center">
													<c:if test="${vo.admin_answer_yn == 'y'}">
														<a href="javascript:showItemQnaContent(${vo.item_qna_idx})" class="w3-button w3-2021-french-blue w3-round-large w3-padding-small w3-small">조회</a>
													</c:if>
													<c:if test="${vo.admin_answer_yn == 'n'}">-</c:if>
												</td>
												<td class="text-center" style="width:10%">
													<a href="javascript:qnaDelete(${vo.item_qna_idx})" class="w3-button w3-brown w3-hover-brown w3-round-large w3-padding-small w3-small">삭제</a>
												</td>
											</tr>
											<tr><td colspan="8" class="p-1 m-1" style="display:none"></td></tr>
									</c:forEach>
									<tr>
										<td colspan="8" class="p-1 m-1 text-center">
											<c:if test="${fn:length(itemQnaList) < 1}">
						        				조회된 내역이 없습니다.
						        			</c:if>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						</div>
					</c:if>
				<c:if test="${allFlag == 'yes'}">
					<div class="w3-container w3-card w3-white w3-round w3-margin">
						<div class="w3-row-padding" style="margin-top:20px">
							<div style="font-size:20px;"><strong><i class="fa-solid fa-heart-circle-check"></i> 찜한 상품 목록</strong></div>
							<hr>
						</div>
						<c:forEach var="itemVO" items="${wishlist}" varStatus="st">
							<div id="item_list_all">
				  			<div class="w3-half">
				  				<a href="${ctp}/item/itemView?item_code=${itemVO.item_code}">
				  				<div class="w3-col m4">
						  			<div class="w3-display-container">
										<img src="${ctp}/data/item/${itemVO.item_image}" alt="${itemVO.item_image}" style="width:90%; margin-top:0px;" class="w3-radius">
								    </div>
				  				</div>
				  				</a>
				  				<div class="w3-col m8">
									<div>
										<div style="color:gray; font-size:14px;">${fn:substring(itemVO.wish_date, 0, 10)}</div>
					  					<a href="${ctp}/item/itemView?item_code=${itemVO.item_code}">
											<h6 class="text-left w3-white" style="font-family:'MaruBuriSemiBold'">
												<strong>
													 ${fn:substring(itemVO.item_summary, 0, 21)}
												    <c:if test="${fn:length(itemVO.item_summary) > 20}">
												    ...
												    </c:if>
								  					<%-- ${itemVO.item_summary} --%>
								  				</strong>
											</h6>
										</a>
									</div>
									<div class="text-left">
									<c:if test="${itemVO.seller_discount_flag == 'n'}">
										<c:set var="priceFmt" value="${itemVO.sale_price}"/>
							        	<div class="mt-2" style="font-size:14px;"><b><fmt:formatNumber value="${priceFmt}"/>원</b></div>
									</c:if>
									<c:if test="${itemVO.seller_discount_flag == 'y'}">
										<div class="w3-row mt-2" style="font-size:14px;"><b>
								        	<span id="discountPrice">
												<c:set var="priceFmt" value="${itemVO.sale_price}"/>
								        		<fmt:formatNumber value="${priceFmt}"/>원
								        	</span>
							        		<span>
								        		<i class="fa-solid fa-arrow-trend-down"></i>&nbsp;
								        		<c:set var="calPriceFmt" value="${itemVO.sale_price - itemVO.seller_discount_amount}"/>
								        		<fmt:formatNumber value="${calPriceFmt}"/>원
							        		</span>
							        		<span style="font-size: 13px; margin-left: 10px; color:brown">
							        			<!-- (할인율) = (할인액) / (정가) X 100 -->
							        			<c:set var="calDiscountFmt" value="${(itemVO.seller_discount_amount / itemVO.sale_price) * 100}"/>
							        			<fmt:formatNumber type="number" maxFractionDigits="0"  value="${calDiscountFmt}" />
							        			<i class="fa-solid fa-percent"></i> 할인
							        		</span>
							        	</b></div>
									</c:if>
									</div>
									<div class="mt-4" style="font-size:13px">
										<a href="javascript:unlike(${itemVO.item_idx})">
											<i class="fa-solid fa-xmark"></i> 삭제
										</a>
									</div>
				  				</div>
							</div>
							</div>
						</c:forEach>
					</div>
					
					<div class="w3-container w3-card w3-white w3-round w3-margin">
						<div class="w3-row-padding" style="margin-top:20px">
							<div style="font-size:20px;"><strong><i class="fa-solid fa-eye"></i> 최근 본 상품 목록</strong></div>
							<hr>
						</div>
						<c:forEach var="itemVO" items="${recentViews}" varStatus="st">
							<div id="item_list_all">
				  			<div class="w3-half">
				  				<a href="${ctp}/item/itemView?item_code=${itemVO.item_code}">
				  				<div class="w3-col m4">
						  			<div class="w3-display-container">
										<img src="${ctp}/data/item/${itemVO.item_image}" alt="${itemVO.item_image}" style="width:90%; margin-top:0px;" class="w3-radius">
								    </div>
				  				</div>
				  				</a>
				  				<div class="w3-col m8">
									<div>
										<div style="color:gray; font-size:14px;">${fn:substring(itemVO.recent_date, 0, 10)}</div>
					  					<a href="${ctp}/item/itemView?item_code=${itemVO.item_code}">
											<h6 class="text-left w3-white" style="font-family:'MaruBuriSemiBold'">
												<strong>
													 ${fn:substring(itemVO.item_summary, 0, 21)}
												    <c:if test="${fn:length(itemVO.item_summary) > 20}">
												    ...
												    </c:if>
								  					<%-- ${itemVO.item_summary} --%>
								  				</strong>
											</h6>
										</a>
									</div>
									<div class="text-left">
									<c:if test="${itemVO.seller_discount_flag == 'n'}">
										<c:set var="priceFmt" value="${itemVO.sale_price}"/>
							        	<div class="mt-2" style="font-size:14px;"><b><fmt:formatNumber value="${priceFmt}"/>원</b></div>
									</c:if>
									<c:if test="${itemVO.seller_discount_flag == 'y'}">
										<div class="w3-row mt-2" style="font-size:14px;"><b>
								        	<span id="discountPrice">
												<c:set var="priceFmt" value="${itemVO.sale_price}"/>
								        		<fmt:formatNumber value="${priceFmt}"/>원
								        	</span>
							        		<span>
								        		<i class="fa-solid fa-arrow-trend-down"></i>&nbsp;
								        		<c:set var="calPriceFmt" value="${itemVO.sale_price - itemVO.seller_discount_amount}"/>
								        		<fmt:formatNumber value="${calPriceFmt}"/>원
							        		</span>
							        		<span style="font-size: 13px; margin-left: 10px; color:brown">
							        			<!-- (할인율) = (할인액) / (정가) X 100 -->
							        			<c:set var="calDiscountFmt" value="${(itemVO.seller_discount_amount / itemVO.sale_price) * 100}"/>
							        			<fmt:formatNumber type="number" maxFractionDigits="0"  value="${calDiscountFmt}" />
							        			<i class="fa-solid fa-percent"></i> 할인
							        		</span>
							        	</b></div>
									</c:if>
									</div>
				  				</div>
							</div>
							</div>
						</c:forEach>
					</div>
				</c:if>
	    <!-- End Middle Column -->
	    </div>
	    
	  <!-- End Grid -->
	  </div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script>
function myFunction2() {
  var x = document.getElementById("pointDemo");
  if (x.className.indexOf("w3-show") == -1) { 
    x.className += " w3-show";
  } else {
    x.className = x.className.replace(" w3-show", "");
  }
}
function myFunction3() {
  var x = document.getElementById("demo");
  if (x.className.indexOf("w3-show") == -1) { 
    x.className += " w3-show";
  } else {
    x.className = x.className.replace(" w3-show", "");
  }
}
</script>
</body>
</html>