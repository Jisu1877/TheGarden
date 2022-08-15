<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
	$(function() {
		WinClose();
	});
	
	function WinClose() {
		window.open('about:blank', '_self').self.close();
		opener.parent.location.reload();
	}
</script>