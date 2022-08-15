<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 수정</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="${ctp}/ckeditor/ckeditor.js"></script>
    <script src="${ctp}/js/woo.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <style>
		body,h1 {font-family: "Montserrat", sans-serif}
		a {
			text-decoration: none;	
		}
		a:hover {
			color : black;
			text-decoration: none;	
		}
		.box {
	   		box-shadow: 0 16px 18px -20px rgba(0, 0, 0, 0.7);
		}
		#schedule_date {
			padding-left:20px;
		}
		input[type="radio"] {
			height: 100%;
		  	margin-top: 4px;
		  	vertical-align: middle;
		}
	</style>
	<script>
		let user_idx;
		let user_id;
	
		$(function() {
			/*datepicker 세팅*/
			$.datepicker.setDefaults({
			    dateFormat: 'yy-mm-dd',
			    prevText: '이전 달',
			    nextText: '다음 달',
			    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			    monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			    dayNames: ['일', '월', '화', '수', '목', '금', '토'],
			    dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
			    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			    showMonthAfterYear: true,
			    yearSuffix: '년'
			    
			});
			$("#deny_date").datepicker();
			$("#leave_date").datepicker();
			
			user_idx = $('#user_idx').val();
			user_id = $('#user_id').val();
			
			delivery(user_idx);
			point(user_id);
			coupon(user_idx);
			leave(user_id);
			
			const target = getTarget();
			if (target != null && target != '') {
				openTab(target);
			}
		});
		
		function openTab(name) {
			var i;
			var x = document.getElementsByClassName("tab");
			for (i = 0; i < x.length; i++) {
				x[i].style.display = "none";
			}
			document.getElementById(name).style.display = "block";
		}
		
		function delivery(idx) {
    		let url = "${ctp}/admin/user/delivery?user_idx=" + idx;
    		$.get(url, function(res) {
    			$('#delivery-tab').append(res);
    		});
    	}
		
		function point(id) {
			let url = '${ctp}/admin/user/point?user_id=' + id;
    		$.get(url, function(res) {
    			$('#point-tab').append(res);
    		});
		}
		
		function coupon(idx) {
    		let url = "${ctp}/user/couponListOpen?user_idx=" + idx;
    		$.get(url, function(res) {
    			$('#coupon-tab').append(res);
    		});
    	}
		
		function leave(id) {
			let url = "${ctp}/admin/user/leave?user_id=" + id;
    		$.get(url, function(res) {
    			$('#leave-tab').append(res);
    		});
		}
		
		function getTarget() {
			let searchParams = new URLSearchParams(location.href);
			return searchParams.get('target');
		}
		
	</script>
</head>
<body>

<!-- !PAGE CONTENT! -->
<div class="w3-main">
 	<!-- content  -->
 	<div class="w3-margin-bottom">
	<form:form commandName="user" id="userForm" name="userForm" action="./userInforUpdate" method="post" cssClass="was-validated" enctype="multipart/form-data" onsubmit="userUpdate(this); return false;">
		<div class="w3-col m2">&nbsp;</div>
			<div class="w3-col m8 mb-4">
				<!-- Header -->
				<header>
					<div class="w3-bar w3-black">
					  <a class="w3-bar-item w3-button" onclick="openTab('user-tab')">회원관리</a>
					  <a class="w3-bar-item w3-button" onclick="openTab('delivery-tab')">배송지관리</a>
					  <a class="w3-bar-item w3-button" onclick="openTab('point-tab')">포인트관리</a>
					  <a class="w3-bar-item w3-button" onclick="openTab('coupon-tab')">쿠폰관리</a>
					  <a class="w3-bar-item w3-button" onclick="openTab('leave-tab')">탈퇴처리</a>
					</div>
				</header>
				<div id="user-tab" class="tab">
					<header class="w3-bar w3-border w3-2020-sunlight">
						<span class="w3-bar-item w3-padding-16" style="font-size:18px;">회원 정보</span>
					</header>
					<div class="w3-border w3-round-large w3-white">
						<div class="w3-padding">
							<div class="form-group">
								<label for="item_summary">ID  </label>
								<div class="input-group mb-3">
									<form:input path="user_id" cssClass="input w3-padding-16 w3-border form-control" required="true" readonly="true" />
								</div>
							</div>
							<div class="form-group">
								<label for="item_summary">이름  </label>
								<div class="input-group mb-3">
									<form:input path="name" cssClass="input w3-padding-16 w3-border form-control" required="true" />
								</div>
							</div>
							<div class="form-group">
								<label for="item_summary">성별  </label>
								<div class="input-group mb-3">
									<form:radiobutton path="gender" value="m" label="남자" cssClass="mr-2" required="true" />
									<form:radiobutton path="gender" value="f" label="여자" cssClass="ml-2 mr-2" required="true" />
								</div>
							</div>
							<div class="form-group">
								<label for="item_summary">이메일  </label>
								<div class="input-group mb-3">
									<form:input path="email" cssClass="input w3-padding-16 w3-border form-control" required="true" />
								</div>
							</div>
							<div class="form-group">
								<label for="item_summary">전화번호  </label>
								<div class="input-group mb-3">
									<form:input path="tel" cssClass="input w3-padding-16 w3-border form-control" required="true" readonly="true"/>
								</div>
							</div>
							<div class="form-group">
								<label for="item_summary">사진  </label>
								<div class="mb-3">
									<img src="${ctp}/data/user/${user.user_image}" style="height:200px;width:200px margin-bottom:10px;" alt="userImage"><br>
									<span>${user.user_image}</span>
								</div>
							</div>
							<div class="form-group">
								<label for="item_summary">상태  </label>
								<div class="input-group mb-3">
									<span style="font-weight:bold;">
										<c:if test="${user.status_code eq '9'}">탈퇴</c:if>
										<c:if test="${user.status_code eq '0'}">활동중</c:if>
									</span>
									<form:hidden path="status_code" cssClass="input w3-padding-16 w3-border" />
									<%-- <form:select path="status_code" cssClass="input w3-padding-16 w3-border" required="true">
										<c:forEach var="status" items="${statusList}">
											<form:option value="${status.index}">${status.label}</form:option>
										</c:forEach>
									</form:select> --%>
								</div>
							</div>
							<div class="form-group">
								<label for="item_summary">로그인 횟수  </label>
								<div class="input-group mb-3">
									<form:input path="login_count" cssClass="input w3-padding-16 w3-border form-control" required="true" readonly="true" />
								</div>
							</div>
							<div class="form-group">
								<label for="item_summary">구매 횟수  </label>
								<div class="input-group mb-3">
									<form:input path="buy_count" cssClass="input w3-padding-16 w3-border form-control" required="true" readonly="true" />
								</div>
							</div>
							<div class="form-group">
								<label for="item_summary">구매 총액  </label>
								<div class="input-group mb-3">
									<form:input path="buy_price" cssClass="input w3-padding-16 w3-border form-control" required="true" readonly="true" />
								</div>
							</div>
							<div class="form-group">
								<label for="item_summary">레벨  </label>
								<div class="input-group mb-3">
									<form:select path="level" cssClass="input w3-padding-16 w3-border" required="true">
										<c:forEach var="level" items="${levelList}">
											<form:option value="${level.index}">${level.label}</form:option>
										</c:forEach>
									</form:select>
								</div>
							</div>
							<div class="form-group">
								<label for="item_summary">포인트  </label>
								<a href="#" onclick="point('${user.user_id}'); return false;">포인트 내역</a>
								<div class="input-group mb-3">
									<form:input path="point" cssClass="input w3-padding-16 w3-border form-control" required="true" disabled="true" />
								</div>
							</div>
							<div class="form-group">
								<label for="item_summary">동의 여부  </label>
								<div class="input-group mb-3">
									<form:select path="agreement" cssClass="input w3-padding-16 w3-border" required="true" disabled="true">
										<c:forEach var="agree" items="${agreeList}">
											<form:option value="${agree.value}">${agree.label}</form:option>
										</c:forEach>
									</form:select>
								</div>
							</div>
							<div class="form-group">
								<label for="item_summary">마지막 로그인 일시  </label>
								<div class="input-group mb-3">
									<form:input path="login_date" cssClass="input w3-padding-16 w3-border form-control" required="true" readonly="true" />
								</div>
							</div>
							<div class="form-group">
								<label for="item_summary">회원가입일  </label>
								<div class="input-group mb-3">
									<form:input path="created_date" cssClass="input w3-padding-16 w3-border form-control" required="true" readonly="true" />
								</div>
							</div>
							<div class="form-group">
								<label for="item_summary">수정일  </label>
								<div class="input-group mb-3">
									<form:input path="updated_date" cssClass="input w3-padding-16 w3-border form-control" readonly="true" />
								</div>
							</div>
							<c:if test="${not empty user.leave_date}">
								<div class="form-group">
									<label for="item_summary">탈퇴일  </label>
									<div class="input-group mb-3">
										<form:input path="leave_date" value="${fn:substring(user.leave_date, 0, 10)}" cssClass="input w3-padding-16 w3-border form-control" readonly="true" />
									</div>
								</div>
								<div class="form-group">
									<label for="item_summary">탈퇴 사유  </label>
									<div class="input-group mb-3">
										<form:input path="leave_reason" cssClass="input w3-padding-16 w3-border form-control" readonly="true" />
									</div>
								</div>
							</c:if>
							<hr>
							<div>
								<p style="text-align: center;">
									<a href="#" onclick="window.close(); return false;" class="w3-btn w3-2019-brown-granite">닫기</a>
									<input type="submit" class="w3-btn w3-2021-desert-mist" value="수정내용 등록">
								</p>
							</div>
						</div>
					</div>
				</div>
				<div id="delivery-tab" class="tab" style="display:none"></div>
				<div id="point-tab" class="tab" style="display:none"></div>
				<div id="coupon-tab" class="tab" style="display:none"></div>
				<div id="leave-tab" class="tab" style="display:none"></div>
				<input type="hidden" name="user_idx" id="user_idx" value="${user.user_idx}">
			</div>
		</form:form>
	</div>
</div>
</body>
</html>