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
								<span style="font-size:25px;">상담 글 등록</span>
			    			</div>	
			    			<div class="w3-half text-right">
			    				<b>회원 아이디</b> | ${userVO.user_id}<br>
			    				<b>Email</b> | ${userVO.email}
			    			</div>
		    			</div><br>
					</div>
	    			<label for="choice1"><b>1. 식물 상담 분류를 선택하세요.</b> </label><br>
				      <div class="form-check-inline" style="margin-bottom: 20px;">
			        	<div class="form-check">
						    <input type="radio" class="choice1" name="choice1" value="식물 이름" checked>&nbsp;&nbsp;식물 이름&nbsp;&nbsp;&nbsp;
						    <input type="radio" class="choice1" name="choice1" value="식물 병해충">&nbsp;&nbsp;식물 병해충&nbsp;&nbsp;&nbsp;
						    <input type="radio" class="choice1" name="choice1" value="식물 관리법">&nbsp;&nbsp;식물 관리법&nbsp;&nbsp;&nbsp;
						    <input type="radio" class="choice1" name="choice1" value="기타">&nbsp;&nbsp;기타
						</div>
					</div><br>
	    			<label for="choice2"><b>2. 식물의 분류를 선택하세요.</b> </label><br>
				      <div class="form-check-inline" style="margin-bottom: 20px;">
			        	<div class="form-check">
						    <input type="radio" class="choice2" name="choice2" value="초본" checked>&nbsp;&nbsp;초본&nbsp;&nbsp;&nbsp;
						    <input type="radio" class="choice2" name="choice2" value="목본">&nbsp;&nbsp;목본&nbsp;&nbsp;&nbsp;
						</div>
					</div><br>
	    			<label for="choice3"><b>3. 키우는 장소를 선택하세요.</b> </label><br>
				      <div class="form-check-inline" style="margin-bottom: 20px;">
			        	<div class="form-check">
						    <input type="radio" class="choice3" name="choice3" value="베란다" checked>&nbsp;&nbsp;베란다&nbsp;&nbsp;&nbsp;
						    <input type="radio" class="choice3" name="choice3" value="실내">&nbsp;&nbsp;실내&nbsp;&nbsp;&nbsp;
						    <input type="radio" class="choice3" name="choice3" value="실외">&nbsp;&nbsp;실외&nbsp;&nbsp;&nbsp;
						</div>
					</div><br>
	    			<label for="choice4"><b>4. 한달동안 물주는 주기를 선택하세요.</b> </label><br>
				      <div class="form-check-inline" style="margin-bottom: 20px;">
			        	<div class="form-check">
						    <input type="radio" class="choice4" name="choice4" value="1회" checked>&nbsp;&nbsp;1회&nbsp;&nbsp;&nbsp;
						    <input type="radio" class="choice4" name="choice4" value="2회">&nbsp;&nbsp;2회&nbsp;&nbsp;&nbsp;
						    <input type="radio" class="choice4" name="choice4" value="3회">&nbsp;&nbsp;3회&nbsp;&nbsp;&nbsp;
						    <input type="radio" class="choice4" name="choice4" value="4회 이상">&nbsp;&nbsp;4회 이상
						</div>
					</div><br>
	    			<label for="choice5"><b>5. 물주는 방법을 선택하세요.</b> </label><br>
				      <div class="form-check-inline" style="margin-bottom: 20px;">
			        	<div class="form-check">
						    <input type="radio" class="choice5" name="choice5" value="흙이 충분히 젖도록" checked>&nbsp;&nbsp;흙이 충분히 젖도록&nbsp;&nbsp;&nbsp;
						    <input type="radio" class="choice5" name="choice5" value="흙겉만 젖게">&nbsp;&nbsp;흙겉만 젖게&nbsp;&nbsp;&nbsp;
						</div>
					</div><br>
	    			<div style="margin-top:30px;">
	    				<label style="font-size:18px;"><b>글 제목</b></label>
	    				<input type="text" class="w3-input" id="boardTitle" name="title" placeholder="제목을 입력하세요."/>
	    			</div><br>
	    			<div>
	    				<div style="font-size:18px;"><b>상담 내용</b></div><br>
    					<textarea rows="10" id="CKEDITOR" name="content" class="form-control"></textarea>
					</div>
					<div style="text-align:center; margin-top: 20px;">
						<label for="email_yn"><b>이메일 공개 여부를 선택하세요.</b> </label><br>
					      <div class="form-check-inline" style="margin-bottom: 20px;">
				        	<div class="form-check">
							    <input type="radio" class="email_yn" name="email_yn" value="y" checked>&nbsp;&nbsp;공개&nbsp;&nbsp;&nbsp;
							    <input type="radio" class="email_yn" name="email_yn" value="n">&nbsp;&nbsp;비공개&nbsp;&nbsp;&nbsp;
							</div>
						</div><br>
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
    		<input type="hidden" name="user_id" value="${userVO.user_id}"/>
    		<input type="hidden" name="email" value="${userVO.email}"/>
    	</form>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>