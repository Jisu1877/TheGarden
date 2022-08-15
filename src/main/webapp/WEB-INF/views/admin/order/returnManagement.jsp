<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>반품 요청 처리</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
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
	   		margin-right: 10px;
		}
		.tableStyle {
			width : 100%;
	  		overflow-x : auto;
	  		white-space:nowrap;
	  	}
	  	.switch {
		  position: relative;
		  display: inline-block;
		  width: 60px;
		  height: 34px;
		}
		
		.switch input { 
		  opacity: 0;
		  width: 0;
		  height: 0;
		}
		
		.slider {
		  position: absolute;
		  cursor: pointer;
		  top: 0;
		  left: 0;
		  right: 0;
		  bottom: 0;
		  background-color: #ccc;
		  -webkit-transition: .4s;
		  transition: .4s;
		}
		
		.slider:before {
		  position: absolute;
		  content: "";
		  height: 26px;
		  width: 26px;
		  left: 4px;
		  bottom: 4px;
		  background-color: white;
		  -webkit-transition: .4s;
		  transition: .4s;
		}
			  	
	  	input:checked + .slider {
		  background-color: #2196F3;
		}
		
		input:focus + .slider {
		  box-shadow: 0 0 1px #2196F3;
		}
		
		input:checked + .slider:before {
		  -webkit-transform: translateX(26px);
		  -ms-transform: translateX(26px);
		  transform: translateX(26px);
		}
		
		/* Rounded sliders */
		.slider.round {
		  border-radius: 34px;
		}
		
		.slider.round:before {
		  border-radius: 50%;
		}
		th {
			width: 28%;
		}
	</style>
	<script>
		function imageShow() {
			$("#hiddenImage").slideDown(400);
			$("#imageShowBtn").hide();
			$("#imageHiddenBtn").show();
		}
	
		function imageHidden() {
			$("#hiddenImage").slideUp(400);
			$("#imageHiddenBtn").hide();
			$("#imageShowBtn").show();
		}
		
		/* 교환 승인.거부 처리 */
		function processOk() {
			let memo = $("#return_admin_memo").val();
			let flag = $("input[name=request_flag]:checked").val();
			let number = $("#bring_invoice_number").val();
			let company = $("select[name=bring_shipping_company]").val();
			
			if(memo == "") {
				alert("관리자 메세지는 필수 입력 사항입니다.");
				$("#exchange_admin_memo").focus();
				return false;
			}
			else if(flag == 'y' && company == "") {
				alert("반품 승인 시에는 택배사 선택이 필수 사항입니다.");
				return false;
			}
			else if(flag == 'y' && number == "") {
				alert("반품 승인 시에는 수거 송장 번호를 입력하셔야 합니다.");
				$("#bring_invoice_number").focus();
				return false;
			}
			else {
				requestAnsForm.submit();
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
 	<div class="w3-row-padding w3-margin-bottom" style="padding-top:22px;">
		<div class="w3-row" style="margin-bottom:10px;">
			<div class="w3-half w3-padding">
				<div style="font-size:18px;" class="mb-2">
					<span class="w3-yellow">반품 요청 내용</span>
				</div>
				<table class="table w3-white">
					<tr>
						<th>주문번호</th>
						<td>${listVO.order_number}</td>
					</tr>
					<tr>
						<th>상품명</th>
						<td>${listVO.item_name}</td>
					</tr>
					<tr>
						<th>교환 사유</th>
						<td>${reVO.return_reason}</td>
					</tr>
					<tr>
						<th>회원 메세지</th>
						<td>${reVO.user_message}</td>
					</tr>
					<tr>
						<th>요청일</th>
						<td>${reVO.created_date}</td>
					</tr>
					<tr>
						<th>최종 환불 금액</th>
						<td>
							<fmt:formatNumber value="${reVO.return_price}"/>원
						</td>
					</tr>
					<tr>
						<th>환불 받을 은행</th>
						<td>${reVO.return_bank_name}</td>
					</tr>
					<tr>
						<th>예금주</th>
						<td>${reVO.return_bank_user_name}</td>
					</tr>
					<tr>
						<th>계좌번호</th>
						<td>${reVO.return_bank_number}</td>
					</tr>
					<tr>
						<th>첨부사진</th>
						<td>
							<input type="button" value="첨부 사진 조회" onclick="imageShow()" class="btn w3-small w3-lime" id="imageShowBtn"/>
        					<input type="button" value="닫기" onclick="imageHidden()" class="btn w3-small w3-2020-orange-peel" id="imageHiddenBtn" style="display:none"/>
						</td>
					</tr>
				</table>
	        	<div cl!ass="w3-row" id="hiddenImage" style="display:none">
					<c:forEach var="image" items="${reVO.photo.split('/')}">
	        			<div class="imageDiv">
        					<div><img src="${ctp}/data/order/${image}" width="300px;"></div>
        					<div>Image Name :  ${image}</div>
        				</div>
        			</c:forEach>
        		</div>
			</div>
			<div class="w3-half w3-padding">
				<div style="font-size:18px;" class="mb-2">
					<span class="w3-yellow">반품 요청 관리</span>
				</div>
				<form name="requestAnsForm" method="post" action="${ctp}/admin/order/returnAns">
					<table class="table table-borderless">
						<tr>
							<th>승인 여부</th>
							<td>
								<div class="form-check-inline">
						        	<div class="form-check">
									    <input type="radio" name="request_flag" value="y" checked>&nbsp;&nbsp;반품 승인&nbsp;&nbsp;&nbsp;
									    <input type="radio" name="request_flag" value="n">&nbsp;&nbsp;반품 반려
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<th>관리자 메세지</th>
							<td>
								<textarea rows="5" name="return_admin_memo" id="return_admin_memo" class="form-control"></textarea>
							</td>
						</tr>
						<tr>
							<th>수거 택배사<br>(※ 승인 시 필수선택)</th>
							<td>
								<select name="bring_shipping_company" class="w3-select" style="width:40%">
									<option value="" selected>택배사 선택</option>
									<option value="CJ대한통운">CJ대한통운</option>
									<option value="롯데택배">롯데택배</option>
									<option value="우체국택배">우체국택배</option>
									<option value="로젠택배">로젠택배</option>
									<option value="한진택배">한진택배</option>
									<option value="경동택배">경동택배</option>
									<option value="대신택배">대신택배</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>수거 송장 번호<br>(※ 승인 시 필수입력)</th>
							<td>
								<input type="number" class="w3-input" name="bring_invoice_number" id="bring_invoice_number">
							</td>
						</tr>
						<tr>
							<td colspan="2" class="text-center">
								<input type="button" value="처리 완료" onclick="processOk()" class="btn w3-black btn-sm"/>
							</td>
						</tr>
					</table>
					<input type="hidden" name="order_idx" value="${reVO.order_idx}">
					<input type="hidden" name="order_return_idx" value="${reVO.order_return_idx}">
					<input type="hidden" name="order_list_idx" value="${listVO.order_list_idx}">
					<input type="hidden" name="use_point" value="${reVO.use_point}">
					<input type="hidden" name="coupon_amount" value="${reVO.coupon_amount}">
				</form>
			</div>
	    </div>
    </div>
</div>
</body>
</html>