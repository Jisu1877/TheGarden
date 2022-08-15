<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>배송지 목록</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <style type="text/css">
    	a:hover {
    		text-decoration: none;
    	}
    </style>
    <script>
    	function defaultChange(idx) {
			$.ajax({
				type : "post",
				url : "${ctp}/delivery/defaultChange",
				data : {idx : idx},
				success : function() {
					alert("기본 배송지 변경이 완료되었습니다.");
					window.opener.location.reload();
					window.close();
				},
				error : function() {
					alert("전송오류.");
				}
			});
		}
    </script>
    
</head>
<body>
<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px">
   	<div class="w3-bar w3-border w3-2020-sunlight">
	  <span class="w3-bar-item w3-padding-16" style="font-size:18px;">배송지 목록</span>
	</div>
	<div style="margin-top:10px; padding:10px;">
		<div class="w3-row-padding w3-padding-16">
			<div class="w3-col m1 w3-margin-bottom"></div>
			<div class="w3-col m10 w3-margin-bottom">
				<c:if test="${deliverList.size() == 0}">
					<label class="mt-3" style="color:gray; font-size:13px;"><i class="fa-solid fa-circle-exclamation"></i>&nbsp; 등록된 배송지가 없습니다. </label><br>
				</c:if>
				<c:if test="${deliverList.size() > 0}">
					<label class="mt-3" style="color:gray; font-size:13px;"><i class="fa-solid fa-circle-exclamation"></i>&nbsp; 기본 배송지는 삭제할 수 없습니다.</label><br>
				</c:if>
				<c:forEach var="deliveryVO" items="${deliverList}" varStatus="st">
				[${st.count}번 배송지]&nbsp;
				<c:if test="${deliveryVO.default_flag == 'y'}">
					<font color="tomato">기본배송지</font>
				</c:if>
				<c:if test="${deliveryVO.default_flag == 'n'}">
					<a href="javascript:defaultChange(${deliveryVO.user_delivery_idx})">👇기본배송지로 변경</a> <!-- ajax로 변경 후 부모 창 새로고침 추가 -->
					<a href="${ctp}/delivery/delete?idx=${deliveryVO.user_delivery_idx}" class="w3-right">[삭제]</a>
				</c:if>
				<table class="table w3-bordered">
					<tr>
						<th width="23%" class="text-center">배송지 이름</th>
    					<td>${deliveryVO.title}</td>
					</tr>
					<tr>
    					<th width="20%" class="text-center">수령인</th>
    					<td>${deliveryVO.delivery_name}</td>
    				</tr>
    				<tr>
    					<th width="20%" class="text-center">연락처</th>
    					<td>${deliveryVO.delivery_tel}</td>
    				</tr>
    				<tr>
    					<th width="20%" class="text-center">주소</th>
    					<td>(${deliveryVO.postcode})${deliveryVO.roadAddress} ${deliveryVO.detailAddress} ${deliveryVO.extraAddress}</td>
    				</tr>
    				<tr>
    					<th width="20%" class="text-center">배송메세지</th>
    					<td> 
    						<c:if test="${deliveryVO.message == ''}">
    							없음
    						</c:if>
    						<c:if test="${deliveryVO.message != ''}">
	    						${deliveryVO.message}
    						</c:if>
    					</td>
    				</tr>
				</table><br>
				</c:forEach>
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