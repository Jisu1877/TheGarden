<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<title>에러 페이지</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<style>
body,h1 {font-family: "Raleway", sans-serif}
body, html {height: 100%}
.bgimg {
  background-image: url('${ctp}/images/main.jpg');
  min-height: 100%;
  background-position: center;
  background-size: cover;
}
</style>
</head>
<body>
<!-- Nav  -->
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content bgimg" style="max-width:1500px" onmouseover="hoverMenuClose()">
	<div class="w3-display-middle">
    <h1 class="w3-animate-top w3-white">이용에 불편을 드려서 죄송합니다.</h1>
    <h1 class="w3-animate-top w3-white">빠른 시일 내에 복구하도록 하겠습니다.</h1>
    <hr class="w3-border-grey" style="margin:auto;width:40%">
  </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
