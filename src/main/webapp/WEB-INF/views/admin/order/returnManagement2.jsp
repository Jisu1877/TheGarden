<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>반품 상품 수거완료 처리</title>
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
			
			if(memo == "") {
				alert("관리자 메세지는 필수 입력 사항입니다.");
				$("#exchange_admin_memo").focus();
				return false;
			}
			else {
				returnOkForm.submit();
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
				<form name="returnOkForm" method="post" action="${ctp}/admin/order/returnOk">
					<table class="table table-borderless">
						<tr>
							<th>승인 여부</th>
							<td>반품 요청 승인</td>
						</tr>
						<tr>
							<th>관리자 메세지</th>
							<td>
								<textarea rows="5" name="return_admin_memo" id="return_admin_memo" class="form-control">${reVO.return_admin_memo}</textarea>
							</td>
						</tr>
						<tr>
							<th>수거 택배사<br>(※ 승인 시 필수선택)</th>
							<td>
								<input type="text" value="${reVO.bring_shipping_company}" disabled class="w3-input">
							</td>
						</tr>
						<tr>
							<th>수거 송장 번호<br>(※ 승인 시 필수입력)</th>
							<td>
								<input type="number" class="w3-input" value="${reVO.bring_invoice_number}" name="bring_invoice_number" id="bring_invoice_number" disabled>
							</td>
						</tr>
						<tr>
							<td colspan="2" class="text-center">
								<input type="button" value="환불 완료 처리" onclick="processOk()" class="btn w3-black btn-sm"/>
							</td>
						</tr>
					</table>
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