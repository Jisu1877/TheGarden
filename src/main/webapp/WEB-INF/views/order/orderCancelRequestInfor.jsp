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
    <title>처리 내용 확인</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <style>
    	th {
    		width:30%;
    	}
    </style>
    <script>
    	function orderCancelRequest(ilstIdx,price,point,orderIdx) {
			let cancel_reason = $("select[name=cancel_reason]").val();
			let return_bank_name = $("select[name=return_bank_name]").val();
			let return_bank_user_name = $("#return_bank_user_name").val();
			let return_bank_number = $("#return_bank_number").val();
			
			if(cancel_reason == "") {
				alert("취소 사유를 선택하세요.");
				return false;
			}
			else if(return_bank_name == "") {
				alert("환불 받을 은행을 선택하세요.");
				return false;
			}
			else if(return_bank_user_name == "") {
				alert("예금주 성명을 입력하세요.");
				return false;
			}
			else if(return_bank_number == "") {
				alert("계좌번호를 입력하세요.");
				return false;
			}
			
			let num1 = Number(price);
			
			$.ajax({
				type : "post",
				url : "/javagreenS_ljs/order/orderCancelRequestOk",
				data : {
 					cancel_reason : cancel_reason,
					return_bank_name : return_bank_name,
					return_bank_user_name : return_bank_user_name,
					return_bank_number : return_bank_number,
					order_list_idx : ilstIdx,
					return_price : num1,
					use_point : point,
					order_idx : orderIdx
				},
				success : function(data) {
					if(data == "1") {
						alert("주문 취소요청이 완료되었습니다.");
						window.opener.location.reload();
						window.close();
					}
				},
				error : function () {
				 	alert("전송오류.");
				}
				
			});
		}
    </script>
</head>
<body>
<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px">
   	<div class="w3-bar w3-border w3-2020-mosaic-blue">
	  <span class="w3-bar-item w3-padding-16" style="font-size:18px;">처리 내용 확인</span>
	</div>
	<div style="margin-top:10px; padding:10px;">
		<div class="w3-row-padding w3-padding-16">
			<div class="w3-col m1 w3-margin-bottom"></div>
			<div class="w3-col m10 w3-margin-bottom">
				<label class="w3-yellow mt-3"><b>취소 요청 정보</b></label>
				<table class="table w3-bordered">
					<tr>
						<th>주문 목록 번호</th>
						<td>${vo.order_list_idx}</td>
					</tr>
					<tr>
						<th>최종 환불금액</th>
						<td><fmt:formatNumber value="${vo.return_price}"/>원</td>
					</tr>
					<tr>
						<th>취소 사유</th>
						<td>${vo.cancel_reason}</td>
					</tr>
					<tr>
						<th>취소 요청일</th>
						<td>${fn:substring(vo.created_date, 0, 19)}</td>
					</tr>
				</table>
				<br>
				<label class="w3-yellow"><b>처리 내용</b></label>
				<table class="table w3-bordered">
					<tr>
						<th>승인 여부</th>
						<td>
							<c:if test="${vo.request_answer == 'n' }">
								<font color="red">취소 반려</font>
							</c:if>
							<c:if test="${vo.request_answer == 'y' }">
								<font color="red">취소 승인</font>
							</c:if>
						</td>
					</tr>
					<tr>
						<th>관리자 메세지</th>
						<td>
							${fn:replace(vo.cancel_admin_memo, newLine, '<br>')}
						</td>
					</tr>
				</table>
				<div class="text-center">
					<a class="w3-btn w3-2020-mosaic-blue" onclick="window.close();">닫기</a>
				</div>
		    </div>
		    <div class="w3-col m1 w3-margin-bottom">
		    </div>
	    </div>
	</div>
</div>
</body>
</html>