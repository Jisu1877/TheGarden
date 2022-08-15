<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <script src="${ctp}/js/userJoin.js"></script>
    <script>
	    function LoadingWithMask() {    
	    	//화면의 높이와 너비를 구합니다.    
	    	var maskHeight = $(document).height();    
	    	var maskWidth  = window.document.body.clientWidth;         
	    	
	    	//화면에 출력할 마스크를 설정해줍니다.    
	    	//var mask  = "<div id='mask' style='position:absolute; z-index:9000; background-color:#000000; display:none; left:0; top:0;'></div>";    
	    	
	    	var loadingImg = '';          
	    	loadingImg += "<div id='loadingImg'>";    
	    	loadingImg += " <img src='${ctp}/images/loading3.gif' style='position: relative; display: block; margin: 0px auto;'/>";
	    	loadingImg += "</div>";        
	    	
	    	//화면에 레이어 추가    
	    	//$('body').append(mask);
	    	
	    	//마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채웁니다.    
	    	//$('#mask').css({            
	    	//	'width' : maskWidth, 
	    	//	'height': maskHeight, 
	    	//	'opacity' : '0.3'    
	    	//});       
	    	
	    	//마스크 표시    
	    	//$('#mask').show();         
	    	
	    	//로딩중 이미지 표시
	    	$('#loadingImg').append(loadingImg);      
	    	$('#loadingImg').show();
	
	    }
    </script>
</head>
<body>
<!-- Nav  -->
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<!-- Header -->
<jsp:include page="/WEB-INF/views/include/header2.jsp" />

<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px" onmouseover="hoverMenuClose()">
	<div class="container" style="margin-bottom:100px; margin-top:70px;">
	    	<h1 class="headerJoin text-center">JOIN</h1>
	    <!-- <h4 class="text-center">Welcome to join us!</h4><br> -->
		<div class="w3-row-padding w3-padding-16">
			<div class="w3-col m3 w3-margin-bottom"></div>
			<div class="w3-col m6 w3-margin-bottom">
			    <form id="myForm" name="myForm" method="post">
			    	<div class="form-group">
			    		<label for="user_id"><span style="color:red;">*&nbsp;</span>아이디&nbsp;(ID)</label>
			      		<div class="input-group mb-3">
			    			<input class="input w3-padding-16 w3-border form-control" id="user_id" name="user_id" type="text" placeholder="아이디를 입력하세요.">
			    		</div>
					    <div id="midDemo"></div>
			    	</div>
			    	<div class="form-group">
			    		<label for="user_pwd"><span style="color:red;">*&nbsp;</span>비밀번호&nbsp;(PASSWORD)</label>
			      		<div class="input-group mb-3">
			    			<input class="input w3-padding-16 w3-border form-control" id="user_pwd" name="user_pwd" type="password" placeholder="비밀번호를 입력하세요." required>
			    		</div>
					    <div id="pwdDemo"></div>
			    	</div>
			    	<div class="form-group">
			    		<label for="name"><span style="color:red;">*&nbsp;</span>성명 </label>
			      		<div class="input-group mb-3">
			    			<input class="input w3-padding-16 w3-border form-control" id="name" name="name" type="text" placeholder="성명을 입력하세요.">
			    		</div>
			    	</div>
			    	<div class="form-group">
				      <label for="gender"><span style="color:red;">*&nbsp;</span>성별 </label>
				      <div class="form-check-inline">
			        	<div class="form-check">
						    <input type="radio" class="gender" name="gender" value="m" checked>&nbsp;&nbsp;남자&nbsp;&nbsp;&nbsp;
						    <input type="radio" class="gender" name="gender" value="f">&nbsp;&nbsp;여자
						</div>
					  </div>
				  	</div>
			    	<div class="form-group">
				      <label for="tel"><span style="color:red;">*&nbsp;</span>연락처 </label>
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
					      <input type="text" name="tel2" id="tel2" size=8 maxlength=4 class="w3-border"/><span>&nbsp; &nbsp;</span><span style="margin-top:6px">-</span><span>&nbsp; &nbsp;</span>
					      <input type="text" name="tel3" id="tel3" size=8 maxlength=4 class="w3-border"/>&nbsp; &nbsp;
					      <div class="input-group-append"><input type="button" value="중복 확인" class="btn w3-black" onclick="telDupCheck(); return false;"></div>
					  </div> 
				   </div>
				   <div class="form-group">
				      <label for="email"><span style="color:red;">*&nbsp;</span>이메일 </label>
						<div class="input-group mb-3">
						  <input type="text" class="form-control" placeholder="Email을 입력하세요." id="email1" name="email1" required />
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
						  <div class="input-group-append" id="reciveBtn"><input type="button" value="인증번호 발송" class="btn w3-black" onclick="emailCheck()" id="reciveBtn"></div>
						</div>
						<div id="loadingImg"></div>
						<div id="reciveForm" style="display:none">
							인증번호 : &nbsp;&nbsp;
							<input type="text" id="reciveNumber" name="reciveNumber">&nbsp;
							<input type="button" id="reciveNumberCheck" value="확인" class="btn btn-warning btn-sm" onclick="numberCheck()">&nbsp;&nbsp;
							남은 시간 : <span class="time"></span>
							<div>${sendNumber}</div>
						</div>
				  </div><br><br>
				  <p class="text-center">- 약관 동의 - </p><br>
		   <div class="form-group">
		        <div style="font-size:14px; font-weight: bold;">
            		<label for='agree3'><input type='checkbox' id='agreeCheckAll' name='agree3' onclick="checkAll()"> &nbsp;&nbsp;<a onclick="javascript:$('#agreeCheckAll').click();">The Garden 이용약관, 개인정보 수집 및 이용, 프로모션 정보 수신(선택)에 모두 동의합니다. </a></label>
           	    </div><br>
                <div> 
		            <jsp:include page="/WEB-INF/views/include/agreement1.jsp" />
	            </div> 
	            <p></p>
	            <div class="agree">
		            <input type='checkbox' id='agreeCheck1' name='agree1'>
		            <label for='agree1'> &nbsp;&nbsp;<a onclick="javascript:$('#agreeCheck1').click();"> 동의합니다</a> </label>
	            </div>
	            <p></p>
	           		<jsp:include page="/WEB-INF/views/include/agreement2.jsp" />
	            <p></p>
	            <div class="agree">
		            <input type='checkbox' id='agreeCheck2' name='agree2'>
		            <label for='agree2'> &nbsp;&nbsp;<a onclick="javascript:$('#agreeCheck2').click();"> 동의합니다</a> </label>
	            </div>
	            <p></p>
		        <label for='comment3' style='font-weight: bold;'>프로모션 정보 수신 동의(선택) :</label><br>
		        <textarea class="form-control">The Garden에서 제공하는 이벤트/혜택 등 다양한 정보를 휴대전화, 이메일로 받아보실 수 있습니다. 일부 서비스(별도 회원 체계로 운영하거나 The Garden 가입 이후 추가 가입하여 이용하는 서비스 등)의 경우, 개별 서비스에 대해 별도 수신 동의를 받을 수 있으며, 이때에도 수신 동의에 대해 별도로 안내하고 동의를 받습니다.
				</textarea> 
	            <p></p>
	            <div class="agree">
		            <input type='checkbox' id='agreeCheck3' name='agree3'>
		            <label for='agree3'> &nbsp;&nbsp;<a onclick="javascript:$('#agreeCheck3').click();"> 동의합니다 </a></label>
	            </div>
	            <br>
		   </div>
				  <p><br></p>
			      <p style="text-align: center;"><button class="w3-btn w3-2019-toffee w3-round-large" type="button" onclick="fCheck()">회원가입</button></p>
				  <input type="hidden" name="email" />
				  <input type="hidden" name="tel" />
				  <input type="hidden" name="agreement" />
			    </form>
		    </div>
		    <div class="w3-col m3 w3-margin-bottom">
		    </div>
	    </div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>