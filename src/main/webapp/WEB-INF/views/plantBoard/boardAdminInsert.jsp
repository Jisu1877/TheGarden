<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상담 글 작성</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="${ctp}/ckeditor/ckeditor.js"></script>
    <script>
    	function insert() {
			let title = $("#boardTitle").val();
			let text = CKEDITOR.instances['CKEDITOR'].getData();
			
			if(title == "") {
				alert("글 제목을 입력하세요.");
				$("#title").focus();
				return false;
			}
			else if(text == "") {
				alert("상담 내용을 입력하세요.");
				return false;
			}
			
			boardForm.submit();
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
    		<img class="w3-image" src="${ctp}/images/20220727_141250.png" width="180px" id="mainImage">
    	</div>
    	<form name="boardForm" method="Post">
    		<div class="w3-row-padding">
    			<div class="w3-col l2 m2">&nbsp;</div>
	    		<div class="w3-col l8 m8" style="font-family:'MaruBuriLight';">
    				<div class="w3-row-padding text-right">
	   					<div class="text-left mb-5">
			    			<div class="w3-half">
								<span style="font-size:25px;">공지 등록</span>
			    			</div>	
		    			</div><br>
					</div>
	    			<div style="margin-top:30px;">
	    				<label style="font-size:18px;"><b>공지 제목</b></label>
	    				<input type="text" class="w3-input" id="boardTitle" name="title" placeholder="제목을 입력하세요."/>
	    			</div><br>
	    			<div>
	    				<div style="font-size:18px;"><b>공지 내용</b></div><br>
    					<textarea rows="10" id="CKEDITOR" name="content" class="form-control"></textarea>
					</div>
					<div style="text-align:center; margin-top: 20px;">
						<a href="javascript:insert()" class="w3-btn w3-2021-mint w3-round-large">등록</a>&nbsp;
						<a href="${ctp}/plant/boardList" class="w3-btn w3-2021-marigold w3-round-large">돌아가기</a>
					</div>
					<script>
			      	  CKEDITOR.replace("content",{
			      		  height:500,
			      		  filebrowserUploadUrl :"${ctp}/imageUpload",
			      		  uploadUrl : "${ctp}/imageUpload"
			      	  });
		      	    </script>
	    		</div>
	    		<div class="w3-col l2 m2">&nbsp;</div>
    		</div>
    		<input type="hidden" name="user_idx" value="${userVO.user_idx}"/>
    		<input type="hidden" name="user_id" value="관리자"/>
    		<input type="hidden" name="email" value="${userVO.email}"/>
    	</form>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>