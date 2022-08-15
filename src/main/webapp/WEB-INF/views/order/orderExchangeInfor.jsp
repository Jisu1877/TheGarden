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
    <title>교환 요청 처리 내용</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <style>
    	th {
    		width:37%;
    	}
    </style>
    <script>
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
   	<div class="w3-bar w3-border w3-2020-orange-peel">
	  <span class="w3-bar-item w3-padding-16" style="font-size:18px;">교환 요청 처리 내용</span>
	</div>
	<div style="margin-top:10px; padding:10px;">
		<div class="w3-row-padding w3-padding-16">
			<div class="w3-col m1 w3-margin-bottom"></div>
			<div class="w3-col m10 w3-margin-bottom">
				<label class="w3-yellow mt-3"><b>교환 요청 정보</b></label>
				<table class="table w3-bordered">
					<tr>
						<th>주문 번호</th>
						<td>${listVO.order_number}</td>
					</tr>
					<tr>
						<th>주문 목록 번호</th>
						<td>${exVO.order_list_idx}</td>
					</tr>
					<tr>
						<th>교환 요청 사유</th>
						<td>${exVO.exchange_reason}</td>
					</tr>
					<tr>
						<th>회원 메세지</th>
						<td>${fn:replace(exVO.user_message, newLine, '<br>')}</td>
					</tr>
					<tr>
						<th>교환 요청일</th>
						<td>${exVO.created_date}</td>
					</tr>
				</table>
				<br>
				<label class="w3-yellow"><b>처리 내용</b></label>
				<table class="table w3-bordered">
					<tr>
						<th>승인 여부</th>
						<td>
							<c:if test="${exVO.request_flag == 'n' }">
								<font color="red">교환 반려</font>
							</c:if>
							<c:if test="${exVO.request_flag == 'y' }">
								<font color="red">교환 승인</font>
							</c:if>
						</td>
					</tr>
					<tr>
						<th>관리자 메세지</th>
						<td>
							${fn:replace(exVO.exchange_admin_memo, newLine, '<br>')}
						</td>
					</tr>
					<c:if test="${exVO.request_flag == 'y' }">
						<tr>
							<th>수거 택배사</th>
							<td>${exVO.bring_shipping_company}</td>
						</tr>
						<tr>
							<th>수거 송장번호</th>
							<td>
								<a href="javascript:copy(${exVO.bring_invoice_number})" id="invoice">${exVO.bring_invoice_number}</a> &nbsp;
								<a href="javascript:invoiceSerach('${exVO.bring_shipping_company}');"><span class="badge badge-success">송장조회</span></a>
							</td>
						</tr>
						<tr>
							<th>승인 날짜</th>
							<td>${exVO.request_answer_date}</td>
						</tr>
					</c:if>
					<c:if test="${exVO.bring_status == 1}">
						<tr>
							<th>교환 상품 발송 택배사</th>
							<td>${exVO.exchange_shipping_company}</td>
						</tr>
						<tr>
							<th>교환 상품 발송 송장번호</th>
							<td>
								<a href="javascript:copy(${exVO.exchange_invoice_number})" id="invoice">${exVO.exchange_invoice_number}</a> &nbsp;
								<a href="javascript:invoiceSerach('${exVO.exchange_shipping_company}');"><span class="badge badge-success">송장조회</span></a>
							</td>
						</tr>
						<tr>
							<th>교환 상품 발송 날짜</th>
							<td>${exVO.exchange_delivery_date}</td>
						</tr>
						<tr>
							<th>교환 완료 여부</th>
							<td>
								<c:if test="${exVO.exchange_status == 0}">
									<font color="gray">미완료</font>
								</c:if>
								<c:if test="${exVO.exchange_status == 1}">
									완료
								</c:if>
							</td>
						</tr>
					</c:if>
				</table>
				<div class="text-center">
					<a class="w3-btn w3-2020-orange-peel" onclick="window.close();">닫기</a>
				</div>
		    </div>
		    <div class="w3-col m1 w3-margin-bottom">
		    </div>
	    </div>
	</div>
</div>
</body>
</html>