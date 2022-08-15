<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>보유 쿠폰 목록</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
</head>
<body>
<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px">
   	<div class="w3-bar w3-border w3-2020-sunlight">
	  <span class="w3-bar-item w3-padding-16" style="font-size:18px;">보유 쿠폰 목록</span>
	</div>
	<div style="margin-top:10px; padding:10px;">
		<div class="w3-row-padding w3-padding-16">
			<div class="w3-col m1 w3-margin-bottom"></div>
			<div class="w3-col m10 w3-margin-bottom">
				<c:forEach var="vo" items="${couponList}" varStatus="st">
				<table class="table w3-bordered">
					${st.count}.
					<tr>
						<th>쿠폰 명</th>
						<td>${vo.reason}</td>
					</tr>
					<tr>
						<th>사용 여부</th>
						<td>
							<c:if test="${vo.use_flag == 'y'}">
								<font color="gray">사용완료</font><br>
								(사용일 : ${fn:substring(vo.use_date, 0, 10)})
							</c:if>
							<c:if test="${vo.use_flag == 'n'}"><font color="tomato">미사용</font></c:if>
						</td>
					</tr>
					<tr>
						<th>할인 적용</th>
						<td>${vo.discount_rate}<i class="fa-solid fa-percent"></i></td>
					</tr>
					<tr>
						<th>만료일</th>
						<td>${vo.expiry_date}<br>(발급일로부터 ${vo.coupon_period}일 내로 사용)</td>
					</tr>
					<tr>
						<th>발급일</th>
						<td>${fn:substring(vo.created_date, 0, 19)}</td>
					</tr>
				</table><br>
				</c:forEach>
				<c:if test="${fn:length(couponList) < 1}">
					<div>보유한 쿠폰이 없습니다.</div>
				</c:if>
				<br>
				<div class="text-center">
					<input type="button" value="닫기" class="w3-btn w3-2020-sunlight" onclick="window.close();"/>
				</div>
		    </div>
		    <div class="w3-col m1 w3-margin-bottom">
		    </div>
	    </div>
	</div>
</div>
</body>
</html>