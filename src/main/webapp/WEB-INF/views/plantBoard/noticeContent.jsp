<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지 조회</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <style>
      	#pageContent {
			font-family: 'MaruBuriExtraLight' !important;
			font-family: 'MaruBuriLight' !important;
			font-family: 'MaruBuri' !important;
			font-family: 'MaruBuriBold' !important;
			font-family: 'MaruBuriSemiBold' !important;
		}
		div, ul, li {-webkit-box-sizing: border-box;-moz-box-sizing: border-box;box-sizing: border-box;padding:0;margin:0}
		a {text-decoration:none;}
		
		.quickmenu {position:absolute;width:90px;top:50%;margin-top:-50px;right:10px;background:#fff;}
		.quickmenu ul {position:relative;float:left;width:100%;display:inline-block;*display:inline;border:1px solid #ddd;}
		.quickmenu ul li {float:left;width:100%;border-bottom:1px solid #ddd;text-align:center;display:inline-block;*display:inline;}
		.quickmenu ul li a {position:relative;float:left;width:100%;height:30px;line-height:30px;text-align:center;color:#000;font-size:9.5pt;}
		.quickmenu ul li a:hover {}
		.quickmenu ul li:last-child {border-bottom:0;}
		
		.content {position:relative;min-height:1000px;}
    </style>
    <script>
   		$(document).ready(function(){
    	  var currentPosition = parseInt($(".quickmenu").css("top"));
    	  $(window).scroll(function() {
    	    var position = $(window).scrollTop(); 
    	    $(".quickmenu").stop().animate({"top":position+currentPosition+"px"},800);
    	  });
    	});
   		
	  	function boardDelete(idx) {
			let ans = confirm("해당 공지글을 삭제하시겠습니까?");
			if(!ans) return false;
			
			location.href="${ctp}/plant/boardDelete?idx=" + idx;
		}
	  	
	  	function boardUpdate(idx,flag) {
			location.href="${ctp}/plant/boardNoticeUpdate?idx="+idx;
		}
    </script>
</head>
<body>
<span id="navBar">
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
</span>
<jsp:include page="/WEB-INF/views/include/header2.jsp" />

<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px" onmouseover="hoverMenuClose()">
	<div class="container" style="margin-bottom:100px; margin-top:40px;">
		<div style="text-align:center">
    		<img class="w3-image" src="${ctp}/images/20220727_141251.png" width="180px" id="mainImage">
    	</div>
    	<div>
    		<div class="w3-row-padding">
    			<div class="w3-col l2 m2">&nbsp;</div>
	    		<div class="w3-col l8 m8">
	    			<div style="font-family:Montserrat,sans-serif">
	    				<c:if test="${level == 0}">
	    					<a href="javascript:boardDelete(${vo.plant_board_idx})" class="w3-button w3-khaki w3-hover-khaki w3-round-large w3-right w3-padding-small w3-samll mb-3">삭제</a>
	    					<a href="javascript:boardUpdate('${vo.plant_board_idx}','${vo.admin_answer_yn}')" class="w3-button w3-khaki w3-hover-khaki w3-round-large w3-right w3-padding-small w3-samll mb-3 mr-2">수정</a>
	    				</c:if>
	    			</div>
		    		<table class="w3-table w3-bordered" style="margin-top:30px;">
		    			<tr>
		    				<td>공지 제목</td>
		    				<td>${vo.title}</td>
		    			</tr>
		    			<tr>
		    				<td>작성일</td>
		    				<td>${vo.write_date}</td>
		    			</tr>
		    			<tr>
		    				<td colspan="2" style="padding-top: 10px;">
		    					${vo.content}
		    				</td>
		    			</tr>
				    </table>
	    		</div>
    			<div class="w3-col l2 m2">&nbsp;</div>
    		</div>
    	</div>
    	<div class="quickmenu" style="font-family:Montserrat,sans-serif">
		  <ul>
		  	<c:if test="${!empty nextVO}">
		    	<li><a  href="${ctp}/plant/showcontent${searchVO.getParams(searchVO)}&pag=${param.pag}&idx=${nextVO.plant_board_idx}">▲ 다음 글</a></li>
		    </c:if>
		    <c:if test="${!empty preVO}">
		    	<li><a href="${ctp}/plant/showcontent${searchVO.getParams(searchVO)}&pag=${param.pag}&idx=${preVO.plant_board_idx}">▼ 이전 글</a></li>
		    </c:if>
		    <c:if test="${vo.admin_answer_yn == 'y'}">
		    	<li><a href="#admin">답변보기</a></li>
		    </c:if>
		    <li><a href="${ctp}/plant/boardList${searchVO.getParams(searchVO)}&pag=${param.pag}">목록으로</a></li>
		    <li><a href="#header" class="w3-black">TOP&nbsp; <i class="fa-solid fa-angles-up"></i></a></li>
		  </ul>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>