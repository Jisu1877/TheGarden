<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 취소</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <style>
    	th {
    		width:30%;
    	}
    </style>
    <script>
    	'use strict';
    	function orderCancel(ilstIdx,price,point,orderIdx,coupon) {
			let cancel_reason = $("select[name=cancel_reason]").val();
			let return_bank_name = $("select[name=return_bank_name]").val();
			let return_bank_user_name = $("#return_bank_user_name").val();
			let return_bank_number = $("#return_bank_number").val();
			
			if(cancel_reason == "") {
				alert("취소 사유를 선택하세요.");
				return false;
			}
			else if(return_bank_name == "") {
				alert("환불 받을 은행을 선택하세요.");
				return false;
			}
			else if(return_bank_user_name == "") {
				alert("예금주 성명을 입력하세요.");
				return false;
			}
			else if(return_bank_number == "") {
				alert("계좌번호를 입력하세요.");
				return false;
			}
			
			let num1 = Number(price);
			
			$.ajax({
				type : "post",
				url : "${ctp}/order/orderCancelOk",
				async: false,
				data : {
					cancel_reason : cancel_reason,
					return_bank_name : return_bank_name,
					return_bank_user_name : return_bank_user_name,
					return_bank_number : return_bank_number,
					order_list_idx : ilstIdx,
					return_price : num1,
					use_point : point,
					order_idx : orderIdx,
					coupon_amount : coupon
				},
				success : function(data) {
					if(data == "1") {
						alert("주문 취소처리가 완료되었습니다.");
						window.opener.location.reload();
						window.close();
					}
				},
				error : function () {
				 	alert("전송오류.");
				}
				
			});
		}
    </script>
</head>
<body>
<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px">
   	<div class="w3-bar w3-border w3-2019-galaxy-blue">
	  <span class="w3-bar-item w3-padding-16" style="font-size:18px;">주문 취소</span>
	</div>
	<div style="margin-top:10px; padding:10px;">
		<div class="w3-row-padding w3-padding-16">
			<div class="w3-col m1 w3-margin-bottom"></div>
			<div class="w3-col m10 w3-margin-bottom">
				<div>
					<i class="fa-solid fa-circle-info"></i> 부분 취소의 경우 포인트 혹은 쿠폰 사용으로 할인을 받았다면, <font color="tomato">가장 먼저 취소하는 상품에서 차감</font>되어 환불됩니다.
				</div>
				<label class="w3-yellow mt-3"><b>주문 정보</b></label>
				<table class="table w3-bordered">
					<tr>
						<th>주문 번호</th>
						<td>${vo.order_number}</td>
					</tr>
					<tr>
						<th>주문 목록 번호</th>
						<td>${vo.order_list_idx}</td>
					</tr>
					<tr>
						<th>상품금액</th>
						<td><fmt:formatNumber value="${vo.item_price}"/>원</td>
					</tr>
					<tr>
						<th>차감금액</th>
						<td><fmt:formatNumber value="${vo.use_point  + vo.coupon_amount}"/>원</td>
					</tr>
					<tr>
						<th>최종 환불금액</th>
						<c:set var="refund" value="${vo.item_price - (vo.use_point + vo.coupon_amount)}"/>
						<td><fmt:formatNumber value="${refund}"/>원</td>
					</tr>
				</table>
				<br>
				<label class="w3-yellow"><b>취소 정보</b></label>
				<table class="table w3-bordered">
					<tr>
						<th>취소사유</th>
						<td>
							<select name="cancel_reason" id="reason" class="w3-select w3-border">
							    <option value="" selected>취소 사유를 선택하세요</option>
							    <option value="단순변심">단순변심</option>
							    <option value="주문내용변경">주문내용변경</option>
							    <option value="다른제품구매">다른제품구매</option>
							    <option value="기타">기타</option>
							</select>
						 </td>
					</tr>
					<tr>
						<th>환불 받을 은행</th>
						<td>
							<select name="return_bank_name" class="w3-select w3-border">
		                        <option value="" selected>은행명을 선택하세요</option>
		                        <option value="경남은행">경남은행</option>
		                        <option value="광주은행">광주은행</option>
		                        <option value="국민은행">국민은행</option>
		                        <option value="농협중앙회">농협중앙회</option>
		                        <option value="농협회원조합">농협회원조합</option>
		                        <option value="대구은행">대구은행</option>
		                        <option value="도이치은행">도이치은행</option>
		                        <option value="부산은행">부산은행</option>
		                        <option value="산업은행">산업은행</option>
		                        <option value="상호저축은행">상호저축은행</option>
		                        <option value="새마을금고">새마을금고</option>
		                        <option value="수협중앙회">수협중앙회</option>
		                        <option value="신한금융투자">신한금융투자</option>
		                        <option value="신한은행">신한은행</option>
		                        <option value="신협중앙회">신협중앙회</option>
		                        <option value="외환은행">외환은행</option>
		                        <option value="우리은행">우리은행</option>
		                        <option value="우체국">우체국</option>
		                        <option value="전북은행">전북은행</option>
		                        <option value="제주은행">제주은행</option>
		                        <option value="카카오뱅크">카카오뱅크</option>
		                        <option value="케이뱅크">케이뱅크</option>
		                        <option value="하나은행">하나은행</option>
		                        <option value="한국씨티은행">한국씨티은행</option>
		                        <option value="HSBC">HSBC은행</option>
		                        <option value="제일은행">SC제일은행</option>
							</select>	
						</td>
					</tr>
					<tr>
						<th>예금주</th>
						<td>
							<input class="input w3-border form-control" id="return_bank_user_name" name="return_bank_user_name" type="text"/>
						</td>
					</tr>
					<tr>
						<th>계좌번호</th>
						<td>
							<input class="input w3-border form-control" id="return_bank_number" name="return_bank_number" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true"/>
						</td>
					</tr>
				</table>
				<div class="text-center">
					<input type="button" value="주문 취소" class="w3-btn w3-2019-princess-blue" onclick="orderCancel(${vo.order_list_idx},${refund},${vo.use_point},${vo.order_idx},${vo.coupon_amount})"/>&nbsp;
					<input type="button" value="닫기" class="w3-btn w3-2021-illuminating" onclick="window.close();"/>
				</div>
		    </div>
		    <div class="w3-col m1 w3-margin-bottom">
		    </div>
	    </div>
	</div>
</div>
</body>
</html>