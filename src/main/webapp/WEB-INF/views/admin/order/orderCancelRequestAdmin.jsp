<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>취소 요청 처리</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <style>
    	th {
    		width:24%;
    	}
    </style>
    <script type="text/javascript">
    	function orderCancelProcess(request_idx, order_idx, order_list_idx, use_point, coupon_amount) {
			let adminMemo = $("#adminMemo").val();
			
			if(adminMemo == "") {
				alert("관리자 메세지를 작성해주세요.");
				return false;
			}
			
			let answer = $("input[name=request_answer]:checked").val();
			
			let query = {
				order_cancel_request_idx : request_idx,
				order_idx : order_idx,
				order_list_idx : order_list_idx,
				cancel_admin_memo : adminMemo,
				request_answer : answer,
				use_point : use_point,
				coupon_amount : coupon_amount
			}
			
			$.ajax({
				type : "post",
				url : "${ctp}/admin/order/orderCancelProcess",
				data : query,
				success : function(res) {
					if(res == "1") {
						alert("처리가 완료되었습니다.");
						window.opener.location.reload();
						window.close();
					}
				},
				error : function() {
					alert("전송오류");
				}
				
			});
		}
    	
    </script>
</head>
<body>
<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px">
	<div class="w3-bar w3-border w3-2020-mosaic-blue">
	  <span class="w3-bar-item w3-padding-16" style="font-size:18px;">취소 요청 처리</span>
	</div>
	<div style="margin-top:40px; padding:10px;">
		<div class="w3-row-padding w3-padding-16">
			<div class="w3-col m1 w3-margin-bottom"></div>
			<div class="w3-col m10 w3-margin-bottom">
				<div>
					<label class="w3-yellow"><b>취소 요청 정보</b></label>
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
						<th>차감된 금액</th>
						<td><fmt:formatNumber value="${vo.use_point  + vo.coupon_amount}"/>원</td>
					</tr>
					<tr>
						<th>최종 환불금액</th>
						<td><fmt:formatNumber value="${vo.return_price}"/>원</td>
					</tr>
					<tr>
						<th>취소사유</th>
						<td>${vo.cancel_reason}</td>
					</tr>
					<tr>
						<th>환불 받을 은행</th>
						<td>${vo.return_bank_name}</td>
					</tr>
					<tr>
						<th>예금주</th>
						<td>${vo.return_bank_user_name}</td>
					</tr>
					<tr>
						<th>계좌번호</th>
						<td>${vo.return_bank_number}</td>
					</tr>
					<tr>
						<th>취소 요청일</th>
						<td>${fn:substring(vo.created_date,0,19)}</td>
					</tr>
				</table>
				<br>
				</table>
					<br>
					<label class="w3-yellow"><b>구매자 정보</b></label>
					<table class="table w3-bordered">
						<tr>
							<th>회원 아이디</th>
							<td>${userVO.user_id}</td>
						</tr>
						<tr>
							<th>연락처</th>
							<td>${userVO.tel}</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td>${userVO.email}</td>
						</tr>
					</table>
					<br>
				</div>
				<label class="w3-yellow"><b>승인 여부</b></label>
				<div class="form-check-inline">
		        	<div class="form-check">
					    <input type="radio" name="request_answer" value="y" checked>&nbsp;&nbsp;취소 승인&nbsp;&nbsp;&nbsp;
					    <input type="radio" name="request_answer" value="n">&nbsp;&nbsp;취소 반려
					</div>
				</div>
				<hr>
				<label class="w3-yellow"><b>관리자 메세지</b></label>
				<br>
				<textarea rows="5" cols="50" id="adminMemo" name="cancel_admin_memo"></textarea>
				<div class="text-center mt-3">
					<a class="w3-btn w3-2020-mosaic-blue" onclick="orderCancelProcess(${vo.order_cancel_request_idx},${vo.order_idx},${vo.order_list_idx},${vo.use_point},${vo.coupon_amount});">요청 처리</a>&nbsp;
					<a class="w3-btn w3-2019-princess-blue" onclick="window.close();">닫기</a>
				</div>
		    </div>
		    <div class="w3-col m1 w3-margin-bottom">
		    </div>
	    </div>
	</div>
</div>
</body>,
</html>