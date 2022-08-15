<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<link rel="icon" href="${ctp}/images/favicon.png">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="${ctp}/ckeditor/ckeditor.js"></script>
<script src="${ctp}/js/myPage.js"></script>
<style>
.date {
	background-color:lavender;
	border: 0.5px solid lightgray;
	border-radius: 10px;
	padding: 5px;
}
p {
 	margin-bottom: 20px;
}
</style>
<script>
	let emailUpdateSw = 0;
	let pwdCheckSw = 0;
	function nameUpdate() {
		document.getElementById("nameForm").style.display = "block";
	}
	
	function nameUpdateNO() {
		document.getElementById("nameForm").style.display = "none";
	}

	function emailUpdate() {
		document.getElementById("emailForm").style.display = "block";
	}
	
	function emailUpdateNO() {
		document.getElementById("emailForm").style.display = "none";
	}
	
	function telUpdate() {
		document.getElementById("telForm").style.display = "block";
	}
	
	function telUpdateNO() {
		document.getElementById("telForm").style.display = "none";
	}
	
	function genderUpdate() {
		document.getElementById("genderForm").style.display = "block";
	}
	
	function genderUpdateNO() {
		document.getElementById("genderForm").style.display = "none";
	}
	
	function pwdUpdate() {
		document.getElementById("pwdForm").style.display = "block";
	}
	
	function pwdUpdateNO() {
		document.getElementById("pwdForm").style.display = "none";
	}
	
	function leaveUpdate() {
		document.getElementById("leaveForm").style.display = "block";
	}
	
	function leaveUpdateNO() {
		document.getElementById("leaveForm").style.display = "none";
	}
	
	function emailCheck() {
		let email1 = myForm.email1.value;
		let email2 = myForm.email2.value;
		let email = email1 + '@' + email2;
		
		let regEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		
		if(email1 == "") {
			alert("이메일을 입력하세요.");
			myForm.email1.focus();
			return false;
		}
		else if(!regEmail.test(email)) {
	        alert("이메일 형식에 맞지않습니다.");
	        myForm.email1.focus();
	        return false;
	    }
	    
	    LoadingWithMask();
	    $.ajax({
			type : "post",
			url : "${ctp}/user/mailSend",
			data : {email : email},
			success : function(data) {
				if(data != "") {
					document.getElementById("reciveForm").style.display = "block";
					
					let emailAddress = "";
					if(email2 == "naver.com") {
						emailAddress = "https://www.naver.com";
					}
					else if(email2 == "hanmail.net") {
						emailAddress = "https://www.daum.net";
					}
					else if(email2 == "hotmail.com") {
						emailAddress = "https://www.msn.com/ko-kr/";
					}
					else if(email2 == "gmail.com") {
						emailAddress = "https://www.google.com";
					}
					else if(email2 == "nate.com") {
						emailAddress = "https://www.nate.com";
					}
					else if(email2 == "yahoo.com") {
						emailAddress = "https://www.yahoo.com";
					}
					$('#loadingImg').hide();    
					$('#loadingImg').empty();
					window.open(emailAddress, "newWin", "width:800, height:400");
					sendNumber = data;
				}
				else {
					alert("인증번호 발송 실패. 다시 시도해주세요.");
				}
			},
			error : function() {
				alert("전송오류.");
			}
		});
	}
	
	var timer = null;
	var isRunning = false;
	$(function(){
	    $("#reciveBtn").click(function(e){
    	var display = $('.time');
    	var leftSec = 180;
    	// 남은 시간
    	// 이미 타이머가 작동중이면 중지
    	if (isRunning){
    		clearInterval(timer);
    		display.html("");
    		startTimer(leftSec, display);
    	}else{
    	startTimer(leftSec, display);
    		
    	}
    	});
	});

	function startTimer(count, display) {
	            
    		var minutes, seconds;
            timer = setInterval(function () {
            minutes = parseInt(count / 60, 10);
            seconds = parseInt(count % 60, 10);
     
            minutes = minutes < 10 ? "0" + minutes : minutes;
            seconds = seconds < 10 ? "0" + seconds : seconds;
     
            display.html(minutes + ":" + seconds);
     
            // 타이머 끝
            if (--count < 0) {
    	     clearInterval(timer);
    	     alert("인증시간이 초과되었습니다. 다시 인증번호를 발송하세요.");
    	     display.html("시간초과");
    	     $('.btn_chk').attr("disabled","disabled");
    	     isRunning = false;
    	     sendNumber = "";
    	     //document.getElementById("reciveForm").style.display = "none";
            }
        }, 1000);
             isRunning = true;
	}
	
	function LoadingWithMask() {    
    	//화면의 높이와 너비를 구합니다.    
    	var maskHeight = $(document).height();    
    	var maskWidth  = window.document.body.clientWidth;         
    	
    	var loadingImg = '';          
    	loadingImg += "<div id='loadingImg'>";    
    	loadingImg += " <img src='${ctp}/images/loading3.gif' style='position: relative; display: block; margin: 0px auto;'/>";
    	loadingImg += "</div>";        
    	
    	//로딩중 이미지 표시
    	$('#loadingImg').append(loadingImg);      
    	$('#loadingImg').show();
	}
	
	function numberCheck() {
		let reciveNumber = myForm.reciveNumber.value;
		
		if(reciveNumber != sendNumber) {
			if(sendNumber == "") {
				alert("인증시간이 초과되었습니다. 다시 인증번호를 발송하세요.");
				document.getElementById("reciveNumber").value = "";
			}
			else {
				alert("인증번호가 일치하지 않습니다.");
			}
			return false;
		}
		
		else {
			emailCheckSw = 1;
			alert("인증되었습니다. \n수정 버튼을 누르면 이메일 정보가 변경됩니다.");
			emailUpdateSw = 1;
			//폼닫기
			document.getElementById("reciveForm").style.display = "none";
			document.getElementById("reciveBtn").style.display = "none";
			$("#email1").attr('readonly', true);
			$(".options").attr('disabled', true);
			//타이머 중지
			clearInterval(timer);
			display.html("");
			startTimer(leftSec, display);
		}
	}
	
	function nameUpdateOk() {
		let name = $("#name").val();
		
		if(name == "") {
			alert("변경할 성명을 입력하세요.");
			return false;
		}
		
		$.ajax({
			type : "post",
			url : "${ctp}/user/nameUpdate",
			data : {name : name},
			success : function(res) {
				if(res == "1") {
					alert("수정되었습니다.");
					location.reload();
				}
				else {
					alert("정보 수정 실패. 다시 시도하세요.");
				}
			},
			error : function () {
				alert("전송오류.");
			}
		});
	}
	
	function emailUpdateOk() {
		let email1 = myForm.email1.value;
		let email2 = myForm.email2.value;
		let email = email1 + '@' + email2;
		
		if(emailUpdateSw == 0) {
			alert("이메일 인증을 진행한 후 수정할 수 있습니다.");
			return false;
		}
		
		$.ajax({
			type : "post",
			url : "${ctp}/user/emailUpdate",
			data : {email : email},
			success : function(res) {
				if(res == "1") {
					alert("수정되었습니다.");
					location.reload();
				}
				else {
					alert("정보 수정 실패. 다시 시도하세요.");
				}
			},
			error : function () {
				alert("전송오류.");
			}
		});
	}
	
	let telDupCheckSw = 0;
	
	function telUpateOk() {
		let tel1 = $("#tel1").val();
	    let tel2 = $("#tel2").val();
	    let tel3 = $("#tel3").val();
	    let tel = tel1 + "-" + tel2 + "-" +tel3;
	    
	    if(tel2 == "" || tel3 == "") {
			alert("변경할 연락처를 입력하세요.");
			$("#tel2").focus();
			return false;
		}
	    
	    if(telDupCheckSw == 0) {
	    	alert("중복체크를 진행해주세요.");
	    	return false;
	    }
	    
	    $.ajax({
			type : "post",
			url : "${ctp}/user/telUpdate",
			data : {tel : tel},
			success : function(res) {
				if(res == "1") {
					alert("수정되었습니다.");
					location.reload();
				}
				else {
					alert("정보 수정 실패. 다시 시도하세요.");
				}
			},
			error : function () {
				alert("전송오류.");
			}
		});
	}
	
	function telCheck() {
		let tel = $('#tel1').val() + '-' + $('#tel2').val() + '-' + $('#tel3').val();
		let telCheck = false;
		
		$.ajaxSetup({ async:false });
		$.get('/javagreenS_ljs/user/telCheck?tel=' + tel, function(response) {
			if (response === 0) {
				telCheck = true;
			} else {
				telCheck = false;
			}
		});
		
		return telCheck;
	}

	function telDupCheck() {
		let tel = $('#tel1').val() + '-' + $('#tel2').val() + '-' + $('#tel3').val();
		
		var regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
		if (regPhone.test(tel) === false) {
			alert('휴대전화 번호를 제대로 입력해주세요.');
			return false;
		}
		
		if (telCheck()) {
			telDupCheckSw = 1;
			$('#tel1').attr("disabled", true);
			$('#tel2').attr("disabled", true);
			$('#tel3').attr("disabled", true);
			alert('수정 가능한 번호입니다.');
		} else {
			alert('이미 존재하는 번호입니다.');
			return false;
		}
	}
	
	
	function genderUpdateOk() {
		var gender = $('input[name=gender]:checked').val();
		
		$.ajax({
			type : "post",
			url : "${ctp}/user/genderUpdate",
			data : {gender : gender},
			success : function(res) {
				if(res == "1") {
					alert("수정되었습니다.");
					location.reload();
				}
				else {
					alert("정보 수정 실패. 다시 시도하세요.");
				}
			},
			error : function () {
				alert("전송오류.");
			}
		});
	}
	
	function pwdUpdateOk() {
		let pwd = $("#pwd").val();
		let pwdUpdate = $("#pwdUpdate").val();
		let pwdUpdate2 = $("#pwdUpdate2").val();
		
		if(pwd == "") {
			alert("현재 비밀번호를 입력하세요.");
			return false;
		}
		else if(pwdUpdate == "" || pwdUpdate2 == "") {
			alert("변경할 비밀번호를 입력하세요.");
			return false;
		}
		else if(pwdUpdate != pwdUpdate2){
			alert("변경 비밀번호와 확인 비밀번호가 일치하지 않습니다.");
			return false;
		}
		
		$.ajax({
			type : "post",
			url : "${ctp}/user/pwdUpdate",
			data : {pwd : pwd,
					pwdUpdate : pwdUpdate},
			success : function(res) {
				if(res == "1") {
					alert("비밀번호가 변경되었습니다. 자동 로그아웃됩니다.");
					location.href = "${ctp}/user/userLogout";
				}
				else {
					alert("현재 비밀번호가 일치하지 않습니다.");
					$("#pwd").focus();
				}
			},
			error : function () {
				alert("전송오류.");
			}
		});
		
	}
	
	$(function() {
		$('#pwdUpdate').keyup(function(){
			pwdCheckSw = 0;
			let user_pwd = $("#pwdUpdate").val();
			let regPwd = /(?=.*[a-zA-Z])(?=.*?[#?!@$%^&*-]).{6,12}/;
			let str = '';
			
			if(user_pwd == "") {
				pwdCheckSw = 0;
				$("#pwdDemo").html("");
				$("#pwdUpdate").focus();
				return false;
			}
			else if(!regPwd.test(user_pwd) || user_pwd.length > 12) {
				pwdCheckSw = 0;
				str += '<div style="color:tomato">';
				str += '<i class="fa-solid fa-circle-info"></i>&nbsp; ';
				str += '비밀번호는 1개이상의 문자와 특수문자 조합의 6~12 자리로 작성해주세요.';
				str += '</div>';
				$("#pwdDemo").html(str);
				$("#pwdUpdate").focus();
	            return false;
	        }
			else if(regPwd.test(user_pwd)) {
				pwdCheckSw = 1;
				str += '<div style="color:royalblue">';
				str += '<i class="fa-solid fa-circle-info"></i>&nbsp;';
				str += '사용가능한 비밀번호입니다.';
				str += '</div>';
				$("#pwdDemo").html(str);
				$("#pwdUpdate").focus();
				return false;
		    }
	        
		});
	});
</script>
</head>
<body>
<!-- Nav  -->
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<!-- !PAGE CONTENT! -->
<div id="pageContent"  class="w3-container w3-content" style="max-width:1500px" onmouseover="hoverMenuClose()">
	<div style="margin-bottom:100px; margin-top:70px;">
    	<!-- The Grid -->
	  <div class="w3-row">
	    <!-- Left Column -->
	    <div class="w3-col m3">
	      <!-- Profile -->
	      <div class="w3-card w3-round w3-white">
	        <div class="w3-container" style="padding-top: 30px;">
	         <p class="w3-center">
	         	<img src="${ctp}/data/user/${userVO.user_image}" class="w3-circle" style="height:106px;width:106px" alt="userImage"><br>
	         </p>
	         <form name="userImageForm" method="post" action="${ctp}/user/userImageChange" enctype="multipart/form-data">
	         <h5 class="w3-center">${userVO.name} 
	         	<a href="javascript:$('#user_image').click()" title="프로필 사진 변경"><i class="fa-solid fa-gear" style="font-size:13px;"></i></a>
	         	<input type="file" id="user_image" name="user_image" style="display:none" accept=".png, .jpg, .jpeg, .jfif, .gif" onchange="userImageChange();">
	         	<input type="hidden" name="myPhoto" id="myPhoto">
	         </h5>
	         </form>
	         <h6 class="w3-center">${userVO.user_id} &nbsp; |  &nbsp;
	         <c:if test="${userVO.level == 1}">
				Gold
			 </c:if>
			 <c:if test="${userVO.level == 2}">
				Silver
			 </c:if>
			 <c:if test="${userVO.level == 0}">
				Admin
			 </c:if> 
	         <span class="w3-dropdown-click text-left">
				<a onclick="myFunction2()"><i class="fa-solid fa-circle-question"></i></a>
				<div id="pointDemo" class="w3-dropdown-content w3-bar-block w3-border montserrat" style="padding:10px; font-size: 12px;">
					더 가든은 회원 등급제를 운영하고 있습니다.<br>
					(Silver/Gold)
					<hr>
					Gold 레벨 변경 요건은?<br>
					- 로그인 횟수 50회 이상<br>
					- 구매 횟수 10회 이상<br>
					- 구매 총 가격 30만원 이상
					<hr>
					Gold 레벨의 혜택은?<br>
					- 적립 포인트 2배 적립
			    </div>
			 </span>
	         </h6>
	         <hr>
	         <div class="w3-row">
	         	<div class="w3-half text-center">
	         		<b>보유 포인트</b><br>
	         		<fmt:formatNumber value="${userVO.point}"/>Point
	         	</div>
	         	<div class="w3-half text-center">
	         		<b>사용 가능 쿠폰</b><br>
	         		<a onclick="couponList(${userVO.user_idx})" title="보유 쿠폰 확인">${couponCnt}개</a>
	         	</div>
	         </div>
	         <hr>
	         <p><i class="fa-solid fa-arrow-pointer w3-margin-right w3-text-theme"></i> 로그인 횟수 : ${userVO.login_count}회</p>
	         <p><i class="fa-solid fa-credit-card w3-margin-right w3-text-theme"></i> 구매 횟수 : ${userVO.buy_count}회
	         	<a onclick="myFunction3()"><i class="fa-solid fa-circle-question"></i></a>
				<div id="demo" class="w3-dropdown-content w3-bar-block w3-border montserrat" style="padding:10px; font-size: 12px;">
					구매 횟수와 구매 총금액은 상품 구매확정 시 누적됩니다.
			    </div>
	         </p>
	         <p><i class="fa-solid fa-hand-holding-dollar w3-margin-right w3-text-theme"></i> 구매 총 금액 : <fmt:formatNumber value="${userVO.buy_price}"/>원</p>
		     <p class="text-right" title="회원정보 수정"><a href="${ctp}/user/userInforUpdate"><i class="fa-solid fa-user-gear"></i>&nbsp;회원정보 수정</a></p>
	        </div>
	      </div>
	      <br>
	      
	      <!-- Accordion -->
	      <div class="w3-card w3-round">
	        <div class="w3-white">
	          <div class="w3-padding" style="font-size:17px; padding-top:20px;">
	          	<a href="${ctp}/user/wishAndRecent">
	          		<b>관심 상품</b>
	          	</a>
	          </div>
	          <button onclick="wishlistOpen()" class="btn w3-hover-wihte w3-block w3-left-align">
	          	<i class="fa-solid fa-heart-circle-check"></i> &nbsp;<span ${wishlistFlag == 'yes' && recentViewFlag == 'no' ? 'style="color:brown"' : ''}>찜한 상품</span>
	          </button>
	          <button onclick="recentViews()" class="btn w3-block w3-hover-wihte w3-left-align">
	          	<i class="fa-solid fa-eye"></i> &nbsp;<span ${wishlistFlag == 'yes' && recentViewFlag == 'yes' && reviewDoneFlag == 'no' && plantBoardFlag == 'no' ? 'style="color:brown"' : ''}>최근 본 상품</span>
	          </button>
	        </div>      
	      </div>
	      <br>
	      <div class="w3-card w3-round">
	        <div class="w3-white">
	          <div class="w3-padding" style="font-size:17px; padding-top:20px;"><b>상품 리뷰</b></div>
	          <button onclick="reivewNeedOpen()" class="btn w3-hover-wihte w3-block w3-left-align">
	          	<i class="fa-solid fa-pen-to-square"></i> &nbsp;<span ${reviewFlag == 'yes' ? 'style="color:brown"' : ''}>작성 가능한 리뷰</span> 
	          </button>
	          <button onclick="reviewDoneOpen()" class="btn w3-block w3-hover-wihte w3-left-align">
	          	<i class="fa-solid fa-file-lines"></i> &nbsp;<span ${reviewDoneFlag == 'yes' && plantBoardFlag != 'yes' ? 'style="color:brown"' : ''}>내가 작성한 리뷰</span>
	          </button>
	        </div>      
	      </div>
	      <br>
	      
	      <div class="w3-card w3-round">
	       <div class="w3-white">
	          <div class="w3-padding" style="font-size:17px; padding-top:20px;"><b>내가 쓴 게시물</b></div>
	          <button onclick="plantBoardUser()" class="btn w3-hover-wihte w3-block w3-left-align">
	          	<i class="fa-solid fa-seedling"></i> &nbsp;<span ${plantBoardFlag == 'yes' && inquiryFlag == 'no' ? 'style="color:brown"' : ''}>식물 상담</span> 
	          </button>
	          <button onclick="inquiryList()" class="btn w3-block w3-hover-wihte w3-left-align">
	          	<i class="fa-brands fa-quora"></i> &nbsp;<span ${inquiryFlag == 'yes' && itemQnaFlag == 'no' ? 'style="color:brown"' : ''}>1:1 문의</span> 
	          </button>
	          <button onclick="itemQnaList()" class="btn w3-block w3-hover-wihte w3-left-align">
	          	<span class="iconify" data-icon="fluent:chat-bubbles-question-20-filled" style="font-size:17px;"></span> &nbsp;<span ${itemQnaFlag == 'yes' ? 'style="color:brown"' : ''}>상품 문의</span> 
	          </button>
	        </div>      
	      </div>
	      <br>
	    <!-- End Left Column -->
	    </div>
	    
	    <!-- Middle Column -->
	    <div class="w3-col m9">
			<div class="w3-card w3-round w3-white" style="margin-left: 20px;">
		        <div class="w3-container">
					<div class="w3-right mt-2" style="font-size:18px;" title="정보수정 닫기">
						<a href="${ctp}/user/myPageOpen"><i class="fa-solid fa-xmark"></i></a>
					</div>
					<h4><b>회원정보 수정</b></h4>
					<div class="w3-row">
						<div class="w3-half">
							<div class="w3-content mt-4" style="padding-bottom: 30px;">
								<p><span class="pl-2 pr-2 mr-1 date">성명</span> ${userVO.name} &nbsp;&nbsp;<a href="#" onclick="nameUpdate()"><span class="badge badge-secondary">수정</span></a></p>
								<p><span class="pl-2 pr-2 mr-1 date">이메일</span> ${userVO.email} &nbsp;&nbsp;<a href="#" onclick="emailUpdate()"><span class="badge badge-secondary">수정</span></a></p>
				        		<p><span class="pl-2 pr-2 mr-1 date">연락처</span> ${userVO.tel} &nbsp;&nbsp;<a href="#" onclick="telUpdate()"><span class="badge badge-secondary">수정</span></a></p>
				        		<p><span class="pl-2 pr-2 mr-1 date">성별 </span> 
				        			<c:if test="${userVO.gender == 'm'}">
				        				남자 &nbsp;&nbsp;<a href="#" onclick="genderUpdate()"><span class="badge badge-secondary">수정</span></a>
				        			</c:if>	
				        			<c:if test="${userVO.gender == 'f'}">
				        				여자 &nbsp;&nbsp;<a href="#" onclick="genderUpdate()"><span class="badge badge-secondary">수정</span></a>
				        			</c:if>	
				        		</p>
				        		<p><span class="pl-2 pr-2 mr-1 date">비밀번호</span> &nbsp;&nbsp;<a href="#" onclick="pwdUpdate()"><span class="badge badge-warning">변경</span></a></p>
				        		<p><a class="pl-2 pr-2 mr-1 date w3-2020-flame-scarlet" href="#" onclick="leaveUpdate();">회원 탈퇴</a>
							</div>
						</div>
						<div class="w3-half">
							<div class="w3-content mt-4" style="padding-bottom: 30px;">
							<div style="display:none" id="nameForm">
								<div class="form-group">
						    		<label for="name"><span class="pl-2 pr-2 mr-1 date">성명 변경</span></label>
						      		<div class="input-group mb-3">
										<input class="w3-input" id="name" name="name" type="text" placeholder="변경할 성명을 입력하세요.">
						    		</div>
									<input type="button" value="수정" class="w3-btn w3-black w3-small mr-2" onclick="nameUpdateOk()">
									<input type="button" value="취소" class="w3-btn w3-2021-ultimate-gray w3-small" onclick="nameUpdateNO()">
						    	</div> 
							</div>
							<div style="display:none; margin-bottom: 20px;" id="emailForm">
								<form name="myForm">
								<div class="form-group">
							      <label for="email"><span class="pl-2 pr-2 mb-2 date">이메일 변경</span></label>
									<div class="input-group mb-3 mt-2">
									  <input type="text" class="form-control" placeholder="변경할 Email을 입력하세요." id="email1" name="email1" required />
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
							  	</div>
							  	</form>
							  	<input type="button" value="수정" class="w3-btn w3-black w3-small mr-2" onclick="emailUpdateOk()">
								<input type="button" value="취소" class="w3-btn w3-2021-ultimate-gray w3-small" onclick="emailUpdateNO()">
							</div>
			        		<div style="display:none" id="telForm">
			        			<div class="form-group">
							      <label for="tel"><span class="pl-2 pr-2 mt-2 date">연락처 변경</span></label>
							      <div class="input-group mb-3 mt-3">
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
							      <input type="button" value="수정" class="w3-btn w3-black w3-small mr-2" onclick="telUpateOk()">
							      <input type="button" value="취소" class="w3-btn w3-2021-ultimate-gray w3-small" onclick="telUpdateNO()">
							   </div>
			        		</div>
			        		<div style="display:none" id="genderForm">
			        			<div class="form-group">
							      <label for="gender"><span class="pl-2 pr-2 mr-1 date">성별 변경 </span> </label>
							      <div class="form-check-inline">
						        	<div class="form-check">
									    <input type="radio" class="gender" name="gender" value="m" ${userVO.gender == 'm' ? 'checked' : '' }>&nbsp;&nbsp;남자&nbsp;&nbsp;&nbsp;
									    <input type="radio" class="gender" name="gender" value="f" ${userVO.gender == 'f' ? 'checked' : '' }>&nbsp;&nbsp;여자
									</div>
								  </div>
								  <input type="button" value="수정" class="w3-btn w3-black w3-small mr-2" onclick="genderUpdateOk()">
							      <input type="button" value="취소" class="w3-btn w3-2021-ultimate-gray w3-small" onclick="genderUpdateNO()">
							  	</div> 
			        		</div>
			        		<div style="display:none" id="pwdForm">
			        			<div class="form-group">
							      <label for="gender"><span class="pl-2 pr-2 mr-1 date">비밀번호 변경 </span> </label>
							      <div class="input-group mb-3">
						      			<label class="mt-1">- 현재 비밀번호 : </label>
										<input class="w3-input" id="pwd" name="pwd" type="password">
										<label class="mt-1">- 변경할 비밀번호 : <div id="pwdDemo"></div></label>
										<input class="w3-input" id="pwdUpdate" name="pwdUpdate" type="password">
										<label class="mt-1">- 비밀번호 확인(변경 비밀번호 재입력) : </label>
										<input class="w3-input" id="pwdUpdate2" name="pwdUpdate2" type="password">
						    	  </div>
									<input type="button" value="변경" class="w3-btn w3-black w3-small mr-2" onclick="pwdUpdateOk()">
									<input type="button" value="취소" class="w3-btn w3-2021-ultimate-gray w3-small" onclick="pwdUpdateNO()">
							  	</div> 
			        		</div>
			        		<div style="display:none" id="leaveForm">
			        			<div class="form-group">
							      <label for="gender"><span class="pl-2 pr-2 mr-1 date">회원 탈퇴</span> </label>
							      <div class="mb-3">
						      			<label class="mt-1">- 탈퇴 사유 : </label><br>
										<textarea class="form-control" id="leave_reason" name="leave_reason"></textarea><br>
									<input type="button" value="탈퇴" class="w3-btn w3-black w3-small mr-2" onclick="leave('${userVO.user_id}');">
									<input type="button" value="취소" class="w3-btn w3-2021-ultimate-gray w3-small" onclick="leaveUpdateNO()">
							  	</div> 
			        		</div>
						</div>
						</div>
					</div>
				</div>
			</div>
	    <!-- End Middle Column -->
	    </div>
	    
	  <!-- End Grid -->
	  </div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script>
function myFunction2() {
  var x = document.getElementById("pointDemo");
  if (x.className.indexOf("w3-show") == -1) { 
    x.className += " w3-show";
  } else {
    x.className = x.className.replace(" w3-show", "");
  }
}
function myFunction3() {
  var x = document.getElementById("demo");
  if (x.className.indexOf("w3-show") == -1) { 
    x.className += " w3-show";
  } else {
    x.className = x.className.replace(" w3-show", "");
  }
}
</script>
</body>
</html>