<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<style>
	body, h1 {
		font-family: "Montserrat", sans-serif
	}
	
	a {
		text-decoration: none;
	}
	
	a:hover {
		color: black;
		text-decoration: none;
	}
	
	.box {
		box-shadow: 0 16px 18px -20px rgba(0, 0, 0, 0.7);
	}
	
	#schedule_date {
		padding-left: 20px;
	}
</style>
	<script>
		async function submitForm() {
			if (!confirm('정말 탈퇴 처리하시겠습니까?')) {
				return false;
			}
			
			return true;
		}
	</script>
</head>
<body class="w3-light-grey">
	<!-- !PAGE CONTENT! -->
	<div class="w3-main">
	
	    <!-- Header -->
		<header class="w3-bar w3-border w3-2020-sunlight">
			<span class="w3-bar-item w3-padding-16" style="font-size:18px;">탈퇴 처리</span>
		</header>
	 	
	 	<!-- content  -->
	 	<div class="w3-row-padding w3-margin-bottom">
			<form action="./leave" method="POST" class="was-validated mt-3" onsubmit="return submitForm();">
				<input type="hidden" name="user_id" value="${userVO.user_id}">
				
				<div class="w3-col">
					<div class="box w3-border">
						<div class="w3-white w3-padding">
							<div class="form-group">
								<label for="item_name">탈퇴 처리 사유<span style="color: red;">🔸&nbsp;</span></label>
								<div class="input-group mb-3">
									<textarea name="leave_reason" id="leave_reason" rows="5" class="input w3-border form-control" required></textarea>
								</div>
								<div id="pwdDemo"></div>
							</div>
							<hr>
							<div>
								<p style="text-align: center;">
									<input type="submit" class="w3-btn w3-2021-desert-mist" value="탈퇴 처리">
									<a href="#" class="w3-btn w3-2019-brown-granite" onclick="window.close();">닫기</a>
								</p>
							</div>
						</div>
					</div>
				</div>
				<div class="w3-col s1"></div>
			</form>
		 </div>
	</div>
</body>
</html>