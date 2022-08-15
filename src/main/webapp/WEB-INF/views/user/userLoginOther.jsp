<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <style>
    	#pageContent {
    		background-image: url("${ctp}/images/main2.jpg");
    	}
    	#login {
    		background-color: white;
    		padding-left: 30px;
    		padding-right: 30px;
    		border-radius: 20px 20px 20px 20px;
    	}
    </style>
    <script type="text/javascript">
    	'use strict';
    	function fCheck() {
			let user_id = myForm.user_id.value;
			let user_pwd = myForm.user_pwd.value;
			
			if(user_id == "") {
				alert("아이디를 입력하세요.");
				return false;
			}
			else(user_pwd == "") {
				alert("비밀번호를 입력하세요.");
			}
			else {
				myForm.submit();
				window.close();
			}
		}
    </script>
</head>
<body>
<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px" onmouseover="hoverMenuClose()">
	<div class="container" style="height:800px; padding-top:100px;">
		<div class="w3-row-padding w3-padding-16">
			<div class="w3-col m3 w3-margin-bottom"></div>
			<div class="w3-col m6 w3-margin-bottom" id="login">
			<h1 class="headerJoin text-center">LOGIN</h1><p><br></p>
				<form name="myForm" method="post">
					<div class="form-group">
				      <label for="mid">ID :</label>
				      <input type="text" class="form-control" id="user_id" value="${cUser_id}" placeholder="아이디를 입력하세요." name="user_id" required autofocus>
				    </div>
					<div class="form-group" >
				      <label for="pwd">Password :</label>
				      <input type="password" class="form-control" id="user_pwd" placeholder="비밀번호를 입력하세요." name="user_pwd" required>
				    </div>
					<div class="row" style="font-size:12px">
						<span class="col"><input type="checkbox" name="idCheck" checked />&nbsp;아이디 저장</span>
						<span class="col text-right"><a href="javascript:idFind()">아이디 찾기</a> / <a href="javascript:pwdFind()">비밀번호 찾기</a></span>
					</div>
					<div class="row" style="font-size:12px; margin-top: 5px;">
						<span class="col">
							<a title="회원가입 하러가기" href="${ctp}/user/userJoin">
								<i class="fa-solid fa-circle-question"></i>&nbsp; 기존 회원이 아니신가요?
							</a>
						</span>
					</div>
					<p><br></p>
				    <div class="form-group text-center">
					<button type="submit" class="w3-btn w3-2019-toffee w3-round-large" onclick="fCheck()">로그인</button> &nbsp;&nbsp;		
					</div>
					<input type="hidden" name="host_ip" value="${pageContext.request.remoteAddr}"/>
				</form>
			</div>
			<div class="w3-col m3 w3-margin-bottom"></div>
		</div>
	</div>
</div>
</body>
</html>