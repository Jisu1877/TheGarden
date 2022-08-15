<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<style>
	body, h1 {
		font-family: "Montserrat", sans-serif
	}
	
	a {
		text-decoration: none;
	}
	
	a:hover {
		color: black;
		text-decoration: none;
	}
	
	.box {
		box-shadow: 0 16px 18px -20px rgba(0, 0, 0, 0.7);
	}
	
	#schedule_date {
		padding-left: 20px;
	}
</style>
</head>
<body class="w3-light-grey">
	<!-- !PAGE CONTENT! -->
	<div class="w3-main">
	
	    <!-- Header -->
		<header class="w3-bar w3-border w3-2020-sunlight">
			<span class="w3-bar-item w3-padding-16" style="font-size:18px;">포인트 지급</span>
		</header>
	 	
	 	<!-- content  -->
	 	<div class="w3-row-padding w3-margin-bottom">
			<form action="./point" method="POST" class="was-validated mt-3" >
				<input type="hidden" name="user_idx" value="${user.user_idx}">
				<input type="hidden" name="admin_id" value="${userVO.user_id}">
				
				<div class="w3-col">
					<div class="box w3-border">
						<div class="w3-white w3-padding">
							<div class="form-group">
								<label for="item_name">지급할 포인트 <span style="color: red;">🔸&nbsp;</span></label>
								<div class="input-group mb-3">
									<input type="number" name="save_point_amount" id="save_point_amount" class="input w3-padding-16 w3-border form-control" required>
								</div>
								<div id="pwdDemo"></div>
							</div>
							<div class="form-group">
								<label for="item_name">지급 사유 <span style="color: red;">🔸&nbsp;</span></label>
								<div class="input-group mb-3">
									<textarea name="save_reason" id="save_reason" class="input w3-padding-16 w3-border form-control"></textarea>
								</div>
								<div id="pwdDemo"></div>
							</div>
							<hr>
							<div>
								<p style="text-align: center;">
									<input type="submit" class="w3-btn w3-2021-desert-mist" value="지급">
									<a href="#" class="w3-btn w3-2019-brown-granite" onclick="window.close();">닫기</a>
								</p>
							</div>
						</div>
					</div>
				</div>
				<div class="w3-col s1"></div>
			</form>
			
			<table class="w3-table w3-striped table-bordered w3-white" style="width:100%;">
				<colgroup>
					<col style="width:16%;">
					<col style="width:16%;">
					<col style="width:16%;">
					<col style="width:16%;">
					<col style="width:16%;">
					<col style="width:16%;">
				</colgroup>
		     	<tr>
		     		<th class="text-center">아이디</th>
		     		<th class="text-center">지급/차감 포인트</th>
		     		<th class="text-center">지급 사유</th>
		     		<th class="text-center">주문 번호</th>
		     		<th class="text-center">지급자</th>
		     		<th class="text-center">지급일</th>
		     	</tr>
		     	<c:if test="${fn:length(pointList) > 0}">
		     	<c:forEach var="point" items="${pointList}">
		     		<c:choose>
		     			<c:when test="${point.save_point_amount > 0}">
		     				<c:set var="amount" value="+${point.save_point_amount}" />
		     			</c:when>
		     			<c:otherwise>
		     				<c:set var="amount" value="${point.use_point_amount * -1}" />
		     			</c:otherwise>
		     		</c:choose>
		     		<tr>
		     			<td class="text-center">${user.user_id}</td>
		     			<td class="text-center">${amount}</td>
		     			<td>${point.save_reason}</td>
		     			<td class="text-center">${point.order_idx}</td>
		     			<td class="text-center">${point.admin_id}</td>
		     			<td class="text-center">${point.created_date }</td>
		     		</tr>
		     	</c:forEach>
		     	</c:if>
		     	<c:if test="${fn:length(pointList) == 0}">
		     		<tr>
		     			<td class="text-center" colspan="8">조회된 내역이 없습니다.</td>
		     		</tr>
		     	</c:if>
		     </table>
		 </div>
	</div>
</body>
</html>