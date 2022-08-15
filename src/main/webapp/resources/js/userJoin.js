let idCheckSw = 0;
let sendNumber = "";
let emailCheckSw = 0;
let pwdCheckSw = 0;

$(function() {
	$('#user_id').keyup(function() {
		idCheckSw = 0;
		let user_id = myForm.user_id.value;
		let regMid = /^[a-z0-9]{4,20}$/;
		let str = '';

		if (user_id.trim().indexOf(" ") != -1) {
			str += '<span style="color:tomato">';
			str += '<i class="fa-solid fa-circle-info"></i>&nbsp; ';
			str += '아이디에 공백을 사용하실 수 없습니다.';
			str += '</span>';
			$("#midDemo").html(str);
			myForm.user_id.focus();
			return false;
		}
		else if (user_id == "") {
			$("#midDemo").html("");
			myForm.user_id.focus();
			return false;
		}
		else if (regMid.test(user_id)) {
			$("#midDemo").html("");
			myForm.user_id.focus();
			return false;
		}
		else if (!regMid.test(user_id)) {
			str += '<span style="color:tomato">';
			str += '<i class="fa-solid fa-circle-info"></i>&nbsp; ';
			str += '아이디는 4~20자의 영문 소문자와 숫자만 사용가능합니다.';
			str += '</span>';
			$("#midDemo").html(str);
			myForm.user_id.focus();
			return false;
		}
	});

	$('#user_id').focusout(function() {
		idCheckSw = 0;
		let user_id = myForm.user_id.value;
		let regMid = /^[a-z0-9]{4,20}$/;
		let str = '';

		if (user_id.trim() == "") {
			alert("아이디를 입력해주세요.");
			$("#midDemo").html("");
			return false;
		}
		else if (user_id.trim().indexOf(" ") != -1) {
			str += '<span style="color:tomato">';
			str += '<i class="fa-solid fa-circle-info"></i>&nbsp; ';
			str += '아이디에 공백을 사용하실 수 없습니다.';
			str += '</span>';
			$("#midDemo").html(str);
			myForm.user_id.focus();
			return false;
		}
		else if (!regMid.test(user_id) || user_id.length > 20) {
			str += '<span style="color:tomato">';
			str += '<i class="fa-solid fa-circle-info"></i>&nbsp; ';
			str += '아이디는 4~20자의 영문 소문자와 숫자만 사용가능합니다.';
			str += '</span>';
			$("#midDemo").html(str);
			myForm.user_id.focus();
			return false;
		}

		$.ajax({
			type: "post",
			url: "/javagreenS_ljs/user/userIdCheck",
			data: { user_id: user_id },
			success: function(data) {
				if (data == "idOk") {
					idCheckSw = 1;
					str += '<span style="color:royalblue">';
					str += '<i class="fa-solid fa-circle-info"></i>&nbsp;';
					str += '사용가능한 아이디입니다.';
					str += '</span>';
					$("#midDemo").html(str);
				}
				else {
					idCheckSw = 0;
					str += '<span style="color:tomato">';
					str += '<i class="fa-solid fa-circle-info"></i>&nbsp; ';
					str += '이미 사용중인 아이디입니다.';
					str += '</span>';
					$("#midDemo").html(str);
				}
			},
			error: function() {
				alert("전송오류.");
			}
		});

	});

	$('#user_pwd').keyup(function() {
		pwdCheckSw = 0;
		let user_pwd = myForm.user_pwd.value;
		let regPwd = /(?=.*[a-zA-Z])(?=.*?[#?!@$%^&*-]).{6,12}/;
		let str = '';

		if (user_pwd == "") {
			pwdCheckSw = 0;
			$("#pwdDemo").html("");
			myForm.user_pwd.focus();
			return false;
		}
		else if (!regPwd.test(user_pwd) || user_pwd.length > 12) {
			pwdCheckSw = 0;
			str += '<span style="color:tomato">';
			str += '<i class="fa-solid fa-circle-info"></i>&nbsp; ';
			str += '비밀번호는 1개이상의 문자와 특수문자 조합의 6~12 자리로 작성해주세요.';
			str += '</span>';
			$("#pwdDemo").html(str);
			myForm.user_pwd.focus();
			return false;
		}
		else if (regPwd.test(user_pwd)) {
			pwdCheckSw = 1;
			str += '<span style="color:royalblue">';
			str += '<i class="fa-solid fa-circle-info"></i>&nbsp;';
			str += '사용가능한 비밀번호입니다.';
			str += '</span>';
			$("#pwdDemo").html(str);
			myForm.user_pwd.focus();
			return false;
		}

	});
});


function emailCheck() {
	let email1 = myForm.email1.value;
	let email2 = myForm.email2.value;
	let email = email1 + '@' + email2;

	let regEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;

	if (email1 == "") {
		alert("이메일을 입력하세요.");
		myForm.email1.focus();
		return false;
	}
	else if (!regEmail.test(email)) {
		alert("이메일 형식에 맞지않습니다.");
		myForm.email1.focus();
		return false;
	}

	LoadingWithMask();

	$.ajax({
		type: "post",
		url: "mailSend",
		data: { email: email },
		success: function(data) {
			if (data != "") {
				document.getElementById("reciveForm").style.display = "block";

				let emailAddress = "";
				if (email2 == "naver.com") {
					emailAddress = "https://www.naver.com";
				}
				else if (email2 == "hanmail.net") {
					emailAddress = "https://www.daum.net";
				}
				else if (email2 == "hotmail.com") {
					emailAddress = "https://www.msn.com/ko-kr/";
				}
				else if (email2 == "gmail.com") {
					emailAddress = "https://www.google.com";
				}
				else if (email2 == "nate.com") {
					emailAddress = "https://www.nate.com";
				}
				else if (email2 == "yahoo.com") {
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
		error: function() {
			alert("전송오류.");
		}
	});
}


var timer = null;
var isRunning = false;
$(function() {
	$("#reciveBtn").click(function(e) {
		var display = $('.time');
		var leftSec = 180;
		// 남은 시간
		// 이미 타이머가 작동중이면 중지
		if (isRunning) {
			clearInterval(timer);
			display.html("");
			startTimer(leftSec, display);
		} else {
			startTimer(leftSec, display);

		}
	});
});


function startTimer(count, display) {

	var minutes, seconds;
	timer = setInterval(function() {
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
			$('.btn_chk').attr("disabled", "disabled");
			isRunning = false;
			sendNumber = "";
		}
	}, 1000);
	isRunning = true;
}

function checkAll() {
	if (!document.getElementById("agreeCheckAll").checked) {
		document.getElementById("agreeCheck1").checked = false;
		document.getElementById("agreeCheck2").checked = false;
		document.getElementById("agreeCheck3").checked = false;
		return false;
	}
	if (document.getElementById("agreeCheck1").checked) {
		document.getElementById("agreeCheck1").checked = false;
	}
	if (document.getElementById("agreeCheck2").checked) {
		document.getElementById("agreeCheck2").checked = false;
	}
	if (document.getElementById("agreeCheck3").checked) {
		document.getElementById("agreeCheck3").checked = false;
	}

	$('#agreeCheck1').click();
	$('#agreeCheck2').click();
	$('#agreeCheck3').click();

}


function numberCheck() {
	let reciveNumber = myForm.reciveNumber.value;
	if (reciveNumber != sendNumber) {
		if (sendNumber == "") {
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
		alert("인증되었습니다.");
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



function fCheck() {
	let user_id = myForm.user_id.value;
	let user_pwd = myForm.user_pwd.value;
	let name = myForm.name.value;
	let email1 = myForm.email1.value;
	let email2 = myForm.email2.value;
	let email = email1 + '@' + email2;
	let tel1 = myForm.tel1.value;
	let tel2 = myForm.tel2.value;
	let tel3 = myForm.tel3.value;
	let tel = myForm.tel1.value + "-" + myForm.tel2.value + "-" + myForm.tel3.value;

	let regTel = /\d{2,3}-\d{3,4}-\d{4}$/g;

	if (user_id == "") {
		alert("아이디를 입력하세요.");
		return false;
	}
	else if (user_pwd == "") {
		alert("비밀번호를 입력하세요.");
		myForm.user_pwd.focus();
		return false;
	}
	else if (name == "") {
		alert("성명을 입력하세요.");
		myForm.name.focus();
		return false;
	}
	else if (tel2 == "" || tel3 == "") {
		alert("연락처를 입력하세요.");
		myForm.tel2.focus();
		return false;
	}
	else if (email1 == "") {
		alert("이메일을 입력하세요.");
		myForm.email1.focus();
		return false;
	}
	else if (tel2 != "" && tel3 != "") {
		if (!regTel.test(tel)) {
			alert("전화번호 형식에 맞지않습니다.(000-0000-0000)");
			myForm.tel2.focus();
			return false;
		}
	}


	if (!document.getElementById("agreeCheck1").checked) {
		alert("The Garden 이용약관 동의는 필수사항입니다.");
		return false;
	}
	else if (!document.getElementById("agreeCheck2").checked) {
		alert("개인정보 수집 및 이용 동의는 필수사항입니다.");
		return false;
	}
	
	if (!telCheck()) {
		alert('이미 존재하는 번호입니다.');
		return false;
	}

	if (emailCheckSw == 0) {
		alert("이메일 인증을 진행해주세요.");
		return false;
	}
	else if (idCheckSw == 0) {
		alert("사용이 불가능한 아이디입니다. 다시 입력해주세요.");
		return false;
	}
	else if (pwdCheckSw == 0) {
		alert("비밀번호 형식에 맞춰 입력해주세요.");
		return false;
	}
	else {
		//묶여진 필드(email/tel)를 폼태그안에 hidden태그의 값으로 저장시켜준다.
		if (document.getElementById("agreeCheck3").checked) {
			myForm.agreement.value = "3";
		}
		else {
			myForm.agreement.value = "2";
		}
		myForm.email.value = email;
		myForm.tel.value = tel;

		myForm.submit();
	}
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
		alert('사용 가능합니다.');
	} else {
		alert('이미 존재하는 번호입니다.');
	}
}