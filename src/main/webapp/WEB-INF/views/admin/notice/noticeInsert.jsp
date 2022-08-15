<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지 등록</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="${ctp}/ckeditor/ckeditor.js"></script>
     <style>
		body,h1 {font-family: "Montserrat", sans-serif}
		a {
			text-decoration: none;	
		}
		a:hover {
			color : black;
			text-decoration: none;	
		}
		.tableStyle {
	  		width:100%;
	  		overflow-x : auto;
	  		white-space:nowrap;
	  		border-radius: 15px;
	  		background-color: white;
	  	}
	  	td {
	  		vertical-align: middle;
	  	}
	</style>
	<script>
		function noticeInsert() {
			let popup_yn = $("input[name='popup_yn']:checked").val();
			
			let file = $("#file").val();
			let maxSize = 1024 * 1024 * 20;
			
			let notice_title = $("#notice_title").val();
			let text = CKEDITOR.instances['CKEDITOR'].getData();
			
			if(text == "") {
			 	alert("공지 내용을 작성하세요");
			 	return false;
			}
			if(notice_title == "") {
				alert("공지 제목을 입력하세요.");
				return false;
			}
			if(popup_yn == 'y' && file == "") {
				alert("팝업 사용 시에는 팝업 이미지 첨부는 필수 사항입니다.");
				return false;
			}		
			
			let fileSize = 0;
    		var files= document.getElementById("file").files;
    		for(let i=0; i< files.length; i++) {
    			
    			let fName = files[i].name;
    			
    			if(fName != "") {
	   				let ext = fName.substring(fName.lastIndexOf(".")+1);
	   	    		let uExt = ext.toUpperCase();
	
	   	    		if (uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "JPEG" && uExt != "JFIF") {
	   	 				alert("업로드 가능한 파일은 'JPG/GIF/PNG/JPEG/JFIF' 입니다.");
	   	    			return false;
	   	    		}
	   	    		else {
		   	    		fileSize += files[i].size;
	   	    		}
    			}
    		}
    		
    		if(fileSize > maxSize) {
    			alert("업로드 가능한 파일의 총 최대 용량은 20MByte 입니다.");
    			return false;
    		}    		
    		else {
    			noticeForm.submit();
    		}
		}
	</script>
</head>
<body class="w3-light-grey">
<!-- Nav  -->
<jsp:include page="/WEB-INF/views/include/admin_nav.jsp" />
<jsp:include page="/WEB-INF/views/include/admin_sidebarMenu.jsp" />

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:250px;margin-top:43px;">
 	<!-- content  -->
 	<div class="w3-row-padding w3-margin-bottom">
	    <!-- Header -->
		<header style="padding-top:22px;">
			<div class="w3-bottombar w3-light-gray w3-padding" style="margin-bottom: 20px;">
		    	<span style="font-size:23px;">공지 등록</span>
		    	<a href="${ctp}/notice/noticeList" class="w3-button w3-khaki w3-hover-khaki w3-round-large w3-right">목록으로</a>
		    </div>
		</header>
    	<div>
    		<div class="w3-row-padding">
	    		<form name="noticeForm" method="post" enctype="multipart/form-data">
		    		<div>
		    			<div class="mb-3">
		    				<span style="font-size:19px;">팝업 여부</span>
		    				<div class="form-check-inline">
					        	<div class="form-check">
								    <input type="radio" name="popup_yn" value="y">&nbsp;&nbsp;팝업 사용&nbsp;&nbsp;&nbsp;
								    <input type="radio" name="popup_yn" value="n" checked>&nbsp;&nbsp;팝업 미사용
								</div>
							</div>
		    			</div>
		    			<div class="mb-3">
		    				<div style="font-size:17px; margin-bottom: 10px;">팝업 이미지 첨부</div>
							<input type="file" class="w3-file" name="file" id="file" class="w3-file" accept=".png, .jpg, .jpeg, .jfif, .gif">
		    			</div>
		    			<div class="mb-3">
		    				<span style="font-size:19px;">공지 제목</span>
		    				<input type="text" class="w3-input w3-border" id="notice_title" name="notice_title"/>
		    			</div>
		    			<div class="mb-3">
		    				<span style="font-size:19px;">공지 내용</span>
		    			</div>
					   <textarea rows="10" id="CKEDITOR" name="notice_content" class="form-control"></textarea> 				
		    		</div>
		    		<div class="text-center mt-4">
		    			<a href="javascript:noticeInsert()" class="w3-btn w3-2020-ultramarine-green w3-round-large">공지 등록</a>
		    		</div>
	      	    </form>
	    		<script>
		      	  CKEDITOR.replace("notice_content",{
		      		  height:500,
		      		  filebrowserUploadUrl :"${ctp}/imageUpload",
		      		  uploadUrl : "${ctp}/imageUpload",
		      		  disallowedContent : 'img{width,height}'
		      	  });
	      	    </script>
    		</div>
    	</div>
	</div>
</div>
</body>
</html>