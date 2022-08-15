<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>결제완료</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <style>
		body, html {height: 100%}
		.bgimg {
		  background-image: url('${ctp}/images/payMain.jpg');
		  min-height: 100%;
		  background-position: center;
		  background-size: cover;
		}
	</style>
</head>
<body class="bgimg">
<!-- Nav  -->
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<!-- !PAGE CONTENT! -->
<div id="pageContent" style="max-width:1500px" onmouseover="hoverMenuClose()">
	<div class="container" style="margin-bottom:100px; padding-top:200px;">
   		<div class="text-center w3-padding w3-white" style="border: 0.5px solid lightgray; border-radius: 25px;">
   			<div style="font-size:23px; margin:20px; font-weight:bold; text-align:left">결제 완료</div>
 				<table class="w3-table">
 					<tr>
 						<td><b>결제 ID</b></td>
 						<td>${payMentVO.imp_uid}</td>
 						<td><b>결제 상점 거래 ID</b></td>
 						<td>${payMentVO.merchant_uid}</td>
 					</tr>
 					<tr>
 						<td><b>결제 상점 거래 ID</b></td>
 						<td>${payMentVO.merchant_uid}</td>
 						<td><b>카드 승인번호</b></td>
 						<td>${payMentVO.apply_num}</td>
 					</tr>
 					<tr>
 						<td><b>상품명</b></td>
 						<td>${payMentVO.name}</td>
 						<td><b>결제금액</b></td>
 						<td>${payMentVO.paid_amount}</td>
 					</tr>
 					<tr>
 						<td colspan="4">
 							<a href="${ctp}/user/myPageOpen" class="btn w3-2020-sunlight m-2">마이페이지로 이동</a>
							<a href="${ctp}/main/mainHome" class="btn w3-2021-buttercream m-2">계속 쇼핑하기</a>
 						</td>
 					</tr>
 				</table>
   		</div>
	</div>
</div>
</body>
</html>