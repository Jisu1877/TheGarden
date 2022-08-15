<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>교환 요청 처리</title>
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
			width: 30%;
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
			let memo = $("#exchange_admin_memo").val();
			let number = $("#exchange_invoice_number").val();
			let company = $("select[name=exchange_shipping_company]").val();
			
			if(memo == "") {
				alert("관리자 메세지는 필수 입력 사항입니다.");
				$("#exchange_admin_memo").focus();
				return false;
			}
			else if(company == "") {
				alert("택배사 선택을 해주세요.");
				return false;
			}
			else if(number == "") {
				alert("송장 번호를 입력해주세요.");
				$("#exchange_invoice_number").focus();
				return false;
			}
			else {
				exchangeShippingForm.submit();
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
					<span class="w3-yellow">교환 요청 내용</span>
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
						<td>${exVO.exchange_reason}</td>
					</tr>
					<tr>
						<th>회원 메세지</th>
						<td>${exVO.user_message}</td>
					</tr>
					<tr>
						<th>요청일</th>
						<td>${exVO.created_date}</td>
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
					<c:forEach var="image" items="${exVO.photo.split('/')}">
	        			<div class="imageDiv">
        					<div><img src="${ctp}/data/order/${image}" width="300px;"></div>
        					<div>Image Name :  ${image}</div>
        				</div>
        			</c:forEach>
        		</div>
			</div>
			<div class="w3-half w3-padding">
				<div style="font-size:18px;" class="mb-2">
					<span class="w3-yellow">교환 요청 관리</span>
				</div>
				<form name="exchangeShippingForm" method="post" action="${ctp}/admin/order/exchangeShipping">
					<table class="table table-borderless">
						<tr>
							<th>승인 여부</th>
							<td>교환승인</td>
						</tr>
						<tr>
							<th>관리자 메세지</th>
							<td>
								<textarea rows="5" name="exchange_admin_memo" id="exchange_admin_memo" class="form-control">${exVO.exchange_admin_memo}</textarea>
							</td>
						</tr>
						<tr>
							<th>수거 택배사</th>
							<td>
								<input type="text" value="${exVO.bring_shipping_company}" disabled class="w3-input">
							</td>
						</tr>
						<tr>
							<th>수거 송장 번호</th>
							<td>
								<input type="text" value="${exVO.bring_invoice_number}" disabled class="w3-input">
							</td>
						</tr>
						<tr>
							<th>교환상품 발송 택배사</th>
							<td>
								<select name="exchange_shipping_company" class="w3-select" style="width:40%">
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
							<th>교환상품 송장 번호</th>
							<td>
								<c:if test="${exVO.bring_status == 0}">
									<input type="number" class="w3-input" name="exchange_invoice_number" id="exchange_invoice_number">
								</c:if>
							</td>
						</tr>
						<tr>
							<td colspan="2" class="text-center">
								<input type="button" value="교환 상품 발송" onclick="processOk()" class="btn w3-2020-grape-compote btn-sm"/>
							</td>
						</tr>
					</table>
					<input type="hidden" name="order_exchange_idx" value="${exVO.order_exchange_idx}">
					<input type="hidden" name="order_list_idx" value="${listVO.order_list_idx}">
				</form>
			</div>
	    </div>
    </div>
</div>
</body>
</html>