<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <script>
	    function closePopup() {
	    	if(document.getElementById("check").value) {
	    		setCookie("popupYN${vo.notice_idx}","N",1);
	    		self.close();
	    	}
	    }
	    
	    // 유효시간 1일 : todayDate.setTime(todayDate.getTim() + (expiredays * 24 * 60 * 60 * 1000))
	    // 유효시간 1분 : todayDate.setMinutes(todayDate.getMinutes() + expiredays)
	    // setCookie(쿠키명, 쿠키값, 쿠키유효시간)
	    function setCookie(name, value, expiredays) {
	    	var date = new Date();
	    	date.setDate(date.getDate() + expiredays);
	    	document.cookie = escape(name) + "=" + escape(value) + "; expires="+date.toUTCString()+"; path=${ctp}";
	    }
	    		
	    function showContent(idx) {
	    	opener.location.href="${ctp}/notice/showcontent?notice_idx=" + idx;
			window.close();
		}
  </script>
  <style>
  	div #content img { max-width: 100%; height: auto; }
  	a:hover {
  		text-decoration: none;
  		color : black;
  	}
  </style>
</head>
<body>
<div>
  	<table class="w3-table w3-bordered">
		<tr>
			<td>${vo.notice_title}</td>
		</tr>
		<tr>
			<td>${vo.create_date}</td>
		</tr>
		<tr>
			<td>
				<c:if test="${not empty vo.files}">
				<div id="content">
					<a href="javascript:showContent(${vo.notice_idx})">
						<img src="${ctp}/data/notice/${vo.files}">
					</a>
				</div>
				</c:if>
				<c:if test="${empty vo.files}">
					<a href="javascript:showContent(${vo.notice_idx})">
						${vo.notice_content}
					</a>
				</c:if>
			</td>
		</tr>
		<tr>
			<td class="text-right">
				<input type="checkbox" id="check" onclick="closePopup()">
      			<font size="3"><a href="javascript:closePopup()">오늘 더이상 보지 않기</a></font>
			</td>
		</tr>
    </table>
	<div class="text-center mt-3 mb-3">
		<button onclick="showContent(${vo.notice_idx})" class="w3-btn w3-lime w3-round-large w3-small">공지 내용 확인</button>
	</div>
 </div>
</body>
</html>