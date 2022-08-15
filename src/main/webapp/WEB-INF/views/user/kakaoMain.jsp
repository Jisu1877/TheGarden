<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>title</title>
    <%-- <jsp:include page="/WEB-INF/views/include/bs4.jsp" /> --%>
    <link rel="icon" href="${ctp}/images/favicon.png">
    <script>
	  /* $(document).ready(function(){ */
		//location.href = "${ctp}/user/memKakaoLogin?host_ip=" + ${host_ip};
		location.href = "${ctp}/user/memKakaoLogin";
	  /* } */
    </script>
</head>
<body>
<!-- Nav  -->

<!-- !PAGE CONTENT! -->
<!-- <div id="pageContent" class="w3-content" style="max-width:1500px" onmouseover="hoverMenuClose()">
	<div class="container" style="margin-bottom:100px; margin-top:70px;">
    	
	</div>
</div> -->
</body>
</html>