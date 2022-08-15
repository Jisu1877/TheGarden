<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<title>The Garden</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<link rel="icon" href="${ctp}/images/favicon.png">
<link rel="stylesheet" href="${ctp}/css/main.css">
<style type="text/css">
	#discountPrice {
		text-decoration: line-through;
	}
	img {
		margin-top: 10px;
	}
	#pageContent {
   		font-family: 'MaruBuriExtraLight';
		font-family: 'MaruBuriLight;
		font-family: 'MaruBuri';
		font-family: 'MaruBuriBold';
		font-family: 'MaruBuriSemiBold';
   	} 
</style>
<script>
	 function popupCheck() {
	  <c:forEach var="popup" items="${popupList}"> /* main컨트롤러에서 popupSw가 'Y'인 자료만 보내준다. */
	  	var url = "${ctp}/notice/popup?notice_idx=${popup.notice_idx}";
	  	openPopup(url,${popup.notice_idx});
	  </c:forEach>
	 }
	 
	 var xPos = 0;
	 function openPopup(url,notice_idx) {
	  xPos += 100;
	  var cookieCheck = getCookie("popupYN"+notice_idx);
	  if(cookieCheck != "N") {
	  	window.open(url,"","width=500,height=650,left="+xPos+",top=5");
	  }
	 }
	
	 function getCookie(name) {
	  var cookie = document.cookie;  // 클라이언트에 저장된 쿠키의 정보를 읽어(가져)온다.
	  if(cookie != "") {
		  var cookieArray = cookie.split("; ");
		  for(var index in cookieArray) {
			  var cookieName = cookieArray[index].split("=");
			  if(cookieName[0] == name) {
				  return cookieName[1];
			  }
		  }
	  }
	  return;
	 }
 
</script>
</head>
<body onload="javascript:popupCheck()">
<!-- Nav  -->
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px" onmouseover="hoverMenuClose()">
	
<!-- Header -->
    <jsp:include page="/WEB-INF/views/include/header.jsp" />
	
	<!-- Shop -->
	<div id="shop">
		<p style="margin-left: 20px; font-family: 'Montserrat', sans-serif">
			<span class="w3-white w3-xxlarge mt-2">SHOP</span>
		  	<span style="font-size: 18px; margin-left: 10px;"> The Garden 전 상품 무료배송!</span>
		  	<span class="w3-tag w3-round w3-green w3-border w3-border-white">
				FREE Shipping
		    </span>
		</p>
	</div>
	<jsp:include page="/WEB-INF/views/include/mainContent.jsp" />
 	
<!-- footer  -->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
 
<!-- End Page Content -->
</div>
 
</body>
</html>
