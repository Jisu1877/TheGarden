<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>아이디 찾기</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <script>
    	function userIdFind() {
			let name = $("#name").val();
			let email1 = $("#email1").val();
			let email2 =  $("select[name=email2]").val();
			let tel1 = $("select[name=tel1]").val();
			let tel2 = $("#tel2").val();
			let tel3 = $("#tel3").val();
			
			if(name == '') {
				alert("성명을 입력하세요.");
				return false;
			}
			if(email1 == '') {
				alert("이메일을 입력하세요.");
				return false;
			}
			if(tel2 == '' || tel3 == '') {
				alert("전화번호를 입력하세요.");
				return false;
			}
			
			let email = email1 + "@" + email2;
			let tel = tel1 + "-" + tel2 + "-" + tel3;
			
			
			let query = {
				name : name,
				email : email,
				tel : tel
			}
			
			$.ajax({
				type : "post",
				url : "${ctp}/user/userIdFind",
				data : query,
				success : function(res) {
					if(res == '0') {
						alert("입력하신 정보와 일치하는 회원이 없습니다.");
						return false;
					}
					else {
						//아이디 가공처리
						let length = (res.length - 4);
						
						let id = res.substring(0,length) + "****";
						
						$("#insertForm").attr("style", "display:none");
						$("#inforForm").attr("style", "display:block");
						$("#id").html(id);
						$("#user_id").val(res.substring(0,length));
					}
				},
				error : function() {
					alert("전송 오류");
				}
			});
		}
    	
    	/* 비밀번호 찾기 창 호출 */
    	function pwdFind() {
    		let user_id = $("#user_id").val();
    		
    		let url = "${ctp}/user/pwdFind?user_id=" + user_id;
    		let winX = 650;
    	    let winY = 580;
    	    let x = (window.screen.width/2) - (winX/2);
    	    let y = (window.screen.height/2) - (winY/2);
    		window.open(url, "nWin", "width="+winX+",height="+winY+", left="+x+", top="+y+", resizable = no, scrollbars = no");
		}
    </script>
</head>
<body>
<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px">
   	<div class="w3-bar w3-border w3-2019-toffee">
	  <span class="w3-bar-item w3-padding-16" style="font-size:18px;">아이디 찾기</span>
	</div>
	<div style="margin-top:10px; padding:10px;">
		<form name="myForm" method="post">
			<div class="w3-row-padding w3-padding-16">
				<div class="w3-col m1"></div>
				<div class="w3-col m10" id="insertForm">
					<span style="font-size:13px;"><i class="fa-solid fa-circle-info"></i> 가입 당시 입력했던 정보와 동일하게 입력하세요.</span><br> 
					<label class="mt-3"><b>성명 입력 : </b></label>
					<div class="form-group">
						<div class="input-group mb-3">
	    					<input class="input form-control" id="name" name="name" type="text" placeholder="성명을 입력하세요."/>
	    				</div>
	    			</div>
					<label class="mt-3"><b>이메일 입력 : </b></label>
					<div class="form-group">
						<div class="input-group mb-3">
							<input type="text" class="form-control" placeholder="Email을 입력하세요." id="email1" name="email1"/>
							<div class="input-group-append">
								<select name="email2" class="custom-select w3-border">
									<option value="naver.com" selected class="options">@naver.com</option>
									<option value="hanmail.net" class="options">@hanmail.net</option>
									<option value="hotmail.com" class="options">@hotmail.com</option>
									<option value="gmail.com" class="options">@gmail.com</option>
									<option value="nate.com" class="options">@nate.com</option>
									<option value="yahoo.com" class="options">@yahoo.com</option>
								</select>
							</div>
						</div>
					</div>
					<label class="mt-3"><b>전화번호 입력 : </b></label>
					<div class="form-group">
					      <div class="input-group mb-3">
						      <div class="input-group-prepend">
							      <select name="tel1" id="tel1" class="w3-select w3-border">
								    <option value="010" selected>010</option>
								    <option value="02">서울</option>
								    <option value="031">경기</option>
								    <option value="032">인천</option>
								    <option value="041">충남</option>
								    <option value="042">대전</option>
								    <option value="043">충북</option>
							        <option value="051">부산</option>
							        <option value="052">울산</option>
							        <option value="061">전북</option>
							        <option value="062">광주</option>
								  </select><span>&nbsp; &nbsp;</span><span style="margin-top:6px">-</span> <span>&nbsp; &nbsp;</span>
						      </div>
						      <input type="text" name="tel2" id="tel2" size=8 maxlength=4 class="w3-border" required/><span>&nbsp; &nbsp;</span><span style="margin-top:6px">-</span><span>&nbsp; &nbsp;</span>
						      <input type="text" name="tel3" id="tel3" size=8 maxlength=4 class="w3-border" required/>&nbsp; &nbsp;
						  </div> 
					   </div>
					<div class="text-center mt-5">
						<a class="w3-btn w3-2019-toffee" href="javascript:userIdFind()">아이디 찾기</a>&nbsp;
						<a class="w3-btn w3-2020-ash" onclick="window.close();">닫기</a>
					</div>
			    </div>
				<div class="w3-col m10" id="inforForm" style="display: none">
					<div class="w3-panel w3-light-grey">
						<span style="font-size: 150px; line-height: 0.6em; opacity: 0.2">❝</span>
						<p style="margin-top: -40px">
							<i>입력하신 정보와 일치하는 아이디는 "<span id="id"></span>" 입니다.
							</i>
						</p>
					</div>
					<div class="text-center mt-5">
						<a class="w3-btn w3-2019-toffee" href="javascript:pwdFind()">비밀번호 찾기</a>&nbsp; <a class="w3-btn w3-2020-ash" onclick="window.close();">닫기</a>
					</div>
					<input type="hidden" id="user_id"/>
				</div>
				<div class="w3-col m1"></div>
		    </div>
	    </form>
	</div>
</div>
</body>
</html>