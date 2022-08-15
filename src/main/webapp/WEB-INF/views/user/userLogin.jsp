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
    <script>
    	/* 아이디 찾기 */
    	function userIdFind() {
    		let url = "${ctp}/user/userIdFind";
    		let winX = 650;
    	    let winY = 580;
    	    let x = (window.screen.width/2) - (winX/2);
    	    let y = (window.screen.height/2) - (winY/2);
    		window.open(url, "nWin", "width="+winX+",height="+winY+", left="+x+", top="+y+", resizable = no, scrollbars = no");
		}
    	
    	/* 비밀번호 찾기 */
    	function pwdFind() {
    		let url = "${ctp}/user/pwdFind";
    		let winX = 650;
    	    let winY = 580;
    	    let x = (window.screen.width/2) - (winX/2);
    	    let y = (window.screen.height/2) - (winY/2);
    		window.open(url, "nWin", "width="+winX+",height="+winY+", left="+x+", top="+y+", resizable = no, scrollbars = no");
		}
    </script>
</head>
<body>
<!-- Nav  -->
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px" onmouseover="hoverMenuClose()">
	<div class="container" style="height:800px; padding-top:100px;">
		<div class="w3-row-padding w3-padding-16">
			<div class="w3-col m3 w3-margin-bottom"></div>
			<div class="w3-col m6 w3-margin-bottom" id="login">
			<h1 class="headerJoin text-center">LOGIN</h1><p><br></p>
				<form name="myForm" method="post" class="was-validated">
					<div class="form-group">
				      <label for="mid">ID :</label>
				      <input type="text" class="form-control" id="user_id" value="${cUser_id}" placeholder="아이디를 입력하세요." name="user_id" required autofocus>
				    </div>
					<div class="form-group" >
				      <label for="pwd">Password :</label>
				      <input type="password" class="form-control" id="user_pwd" placeholder="비밀번호를 입력하세요." name="user_pwd" required>
				    </div>
					<div class="row" style="font-size:12px">
						<span class="col"><input type="checkbox" name="idCheck" checked/>&nbsp;아이디 저장</span>
						<span class="col text-right"><a href="javascript:userIdFind()">아이디 찾기</a> / <a href="javascript:pwdFind()">비밀번호 찾기</a></span>
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
						<button type="submit" class="w3-btn w3-2019-toffee w3-round-large">로그인</button> &nbsp;&nbsp;
						<a href="https://kauth.kakao.com/oauth/authorize?client_id=95928dc81cedc0f5aff8f30e06f44c5f&redirect_uri=http://localhost:9090/javagreenS_ljs/kakao/kakaoMain&response_type=code">
						<!-- <a href="https://kauth.kakao.com/oauth/authorize?client_id=95928dc81cedc0f5aff8f30e06f44c5f&redirect_uri=http://49.142.157.251:9090/javagreenS_ljs/kakao/kakaoMain&response_type=code"> -->
			          	  <img src="${ctp}/images/kakaoLogin.png" class="text-center" style="height:52px; margin-top:9px;"/>
			          	</a>		
					</div>
					<input type="hidden" name="host_ip" value="${pageContext.request.remoteAddr}"/>
				</form>
			</div>
			<div class="w3-col m3 w3-margin-bottom"></div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>