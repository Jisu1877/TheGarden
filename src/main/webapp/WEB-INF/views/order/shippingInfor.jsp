<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 상세 정보</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <style>
    	th {
    		width:24%;
    	}
    </style>
    <script type="text/javascript">
    	$(function() {
			$("#messageInputbtn").hide();
		});
    
    	function messageInput(sw) {
    		if(sw == 0) {
	    		$("#memoNo").removeAttr("disabled");
    		}
    		if(sw == 1) {
    			$("#memoYes").removeAttr("disabled");
    		}
    		
    		document.getElementById("messagebtn").style.display = "none";
    		$("#messageInputbtn").show();
    	}
    	
    	function messageInputOk(sw,idx) {
    		let memo;
    		if(sw == 0) {
    			memo = $("#memoNo").val();
    		}
    		if(sw == 1) {
    			memo = $("#memoYes").val();
    		}
    		
    		$.ajax({
				type : "post",
				url : "${ctp}/admin/order/orderMemoInput",
				data : {memo : memo,
						idx : idx},
				success : function(data) {
					if(data == "1") {
						location.reload();
					}
				},
				error : function() {
					alert("전송오류.");
				}
    		});
		}
    	
    	function invoiceSerach(company) {
    		let address = "";
			if(company == 'CJ대한통운') {
				address = "https://www.cjlogistics.com/ko/tool/parcel/tracking";
			}
			else if(company == '롯데택배') {
				address = "https://www.lotteglogis.com/home/reservation/tracking/index";
			}
			else if(company == '우체국택배') {
				address = "https://service.epost.go.kr/iservice/";
			}
			else if(company == '로젠택배') {
				address = "https://www.ilogen.com/m/personal/tkSearch";
			}
			else if(company == '한진택배') {
				address = "https://www.hanjin.co.kr/kor/CMS/DeliveryMgr/WaybillSch.do?mCode=MN038";
			}
			else if(company == '경동택배') {
				address = "https://kdexp.com/";
			}
			else if(company == '대신택배') {
				address = "http://www.ds3211.co.kr/";
			}
			window.open(address, "newWin", "width:300, height:300");
		}
    	
    	function copy(number) {
    		navigator.clipboard.writeText(number);
		}
    </script>
</head>
<body>
<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px">
	<div class="w3-bar w3-border w3-2021-ultimate-gray">
	  <span class="w3-bar-item w3-padding-16" style="font-size:18px;">배송 내역</span>
	</div>
	<div style="margin-top:40px; padding:10px;">
		<div class="w3-row-padding w3-padding-16">
			<div class="w3-col m1 w3-margin-bottom"></div>
			<div class="w3-col m10 w3-margin-bottom">
				<div>
					<label class="w3-yellow"><b>주문 정보</b></label>
					<table class="table w3-bordered">
						<tr>
							<th>주문번호</th>
							<td>${shippingInfor.order_number}</td>
						</tr>
						<tr>
							<th>주문목록번호</th>
							<td>${shippingInfor.order_list_idx}</td>
						</tr>
						<tr>
							<th>상품명</th>
							<td>${shippingInfor.item_name}</td>
						</tr>
						<c:if test="${shippingInfor.item_option_flag == 'y'}">
							<tr>
								<th>옵션명</th>
								<td>${shippingInfor.option_name}</td>
							</tr>
						</c:if>
						<tr>
							<th>수량</th>
							<td>${shippingInfor.order_quantity}개</td>
						</tr>
					</table>
					<br>
					<label class="w3-yellow"><b>배송지 정보</b></label>
					<table class="table w3-bordered">
						<tr>
							<th>배송지명</th>
							<td>${shippingInfor.title}</td>
						</tr>
						<tr>
							<th>수령인 성명</th>
							<td>${shippingInfor.delivery_name}</td>
						</tr>
						<tr>
							<th>수령인 연락처</th>
							<td>${shippingInfor.delivery_tel}</td>
						</tr>
						<tr>
							<th>배송지</th>
							<td>
								(${shippingInfor.postcode})<br> ${shippingInfor.roadAddress} ${shippingInfor.detailAddress} ${shippingInfor.extraAddress}  
							</td>
						</tr>
						<tr>
							<th>배송 메세지</th>
							<td>${shippingInfor.message}</td>
						</tr>
					</table>
					<br>
					<label class="w3-yellow"><b>배송 정보</b></label><br>
					<table class="table w3-bordered">
						<tr>
							<th>택배사</th>
							<td>${shippingInfor.shipping_company}</td>
						</tr>
						<tr>
							<th>송장번호</th>
							<td><a href="javascript:copy(${shippingInfor.invoice_number})" id="invoice">${shippingInfor.invoice_number}</a> &nbsp;
								<a href="javascript:invoiceSerach('${shippingInfor.shipping_company}');"><span class="badge badge-success">송장조회</span></a>
							</td>
						</tr>
						<tr>
							<th>발송일</th>
							<td>${fn:substring(shippingInfor.shipping_date, 0, 19)}</td>
						</tr>
					</table>
				</div>
				<br>
				<div class="text-center mt-3"><a class="w3-btn w3-2019-princess-blue" onclick="window.close();">닫기</a></div>
		    </div>
		    <div class="w3-col m1 w3-margin-bottom">
		    </div>
	    </div>
	</div>
</div>
</body>
</html>