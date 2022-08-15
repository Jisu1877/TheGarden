<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 취소 내용 확인</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <style>
    	th {
    		width:30%;
    	}
    </style>
</head>
<body>
<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px">
   	<div class="w3-bar w3-border w3-yellow">
	  <span class="w3-bar-item w3-padding-16" style="font-size:18px;">주문 취소 내역</span>
	</div>
	<div style="margin-top:10px; padding:10px;">
		<div class="w3-row-padding w3-padding-16">
			<div class="w3-col m1 w3-margin-bottom"></div>
			<div class="w3-col m10 w3-margin-bottom">
				<label class="w3-yellow"><b>주문 정보</b></label>
				<table class="table w3-bordered">
					<tr>
						<th>주문 번호</th>
						<td>${orderVO.order_number}</td>
					</tr>
					<tr>
						<th>주문 목록 번호</th>
						<td>${vo.order_list_idx}</td>
					</tr>
					<tr>
						<th>상품금액</th>
						<td><fmt:formatNumber value="${orderVO.item_price}"/>원</td>
					</tr>
					<tr>
						<th>차감금액</th>
						<td>
							<c:if test="${vo.coupon_amount == 0}">
								<fmt:formatNumber value="${vo.use_point}"/>원
							</c:if>
							<c:if test="${vo.coupon_amount != 0}">
								<fmt:formatNumber value="${vo.coupon_amount}"/>원
							</c:if>
						</td>
					</tr>
					<tr>
						<th>최종 환불금액</th>
						<c:set var="refund" value="${orderVO.item_price - (vo.use_point + vo.coupon_amount)}"/>
						<td><fmt:formatNumber value="${refund}"/>원</td>
					</tr>
				</table>
				<br>
				<label class="w3-yellow"><b>취소 정보</b></label>
				<table class="table w3-bordered">
					<tr>
						<th>취소사유</th>
						<td>
							${vo.cancel_reason}
						 </td>
					</tr>
					<tr>
						<th>은행</th>
						<td>
							${vo.return_bank_name}
						</td>
					</tr>
					<tr>
						<th>예금주</th>
						<td>
							${vo.return_bank_user_name}
						</td>
					</tr>
					<tr>
						<th>계좌번호</th>
						<td>
							${vo.return_bank_number}
						</td>
					</tr>
					<tr>
						<th>취소일</th>
						<td>${fn:substring(vo.created_date, 0, 19)}</td>
					</tr>
				</table>
				<div class="text-center">
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