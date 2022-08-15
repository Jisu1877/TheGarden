<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>결제</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	
	<script>
		IMP.init('imp21064327');
		
		IMP.request_pay({
		    pg : 'inicis', // version 1.1.0부터 지원.
		    pay_method : 'card',
		    merchant_uid : 'merchant_' + new Date().getTime(),
		    name : '${vo.name}',
		    amount : ${vo.amount}, //판매 가격
		    buyer_email : '${vo.buyer_email}',
		    buyer_name : '${vo.buyer_name}',
		    buyer_tel : '${vo.buyer_tel}',
		    buyer_addr : '${vo.buyer_addr}',
		    buyer_postcode : '${vo.buyer_postcode}'
		}, function(rsp) {
			  var paySw = 'no';
		    if ( rsp.success ) {
		        var msg = ' ';
		        msg += '고유ID : ' + rsp.imp_uid;
		        msg += '상점 거래ID : ' + rsp.merchant_uid;
		        msg += '결제 금액 : ' + rsp.paid_amount;
		        msg += '카드 승인번호 : ' + rsp.apply_num;
		        paySw = 'ok';
		    } else {
		        var msg = '결제에 실패하였습니다.';
		        msg += '에러내용 : ' + rsp.error_msg;
		    }
		    alert(msg);
		    if(paySw == 'no') {
			    alert("장바구니로 이동합니다.");
		    	location.href='${ctp}/cart/cartList';
		    }
		    else {
					var temp = "";
					temp += '?name=${vo.name}';
					temp += '&amount=${vo.amount}';
					temp += '&buyer_email=${vo.buyer_email}';
					temp += '&buyer_name=${vo.buyer_name}';
					temp += '&buyer_tel=${vo.buyer_tel}';
					temp += '&buyer_addr=${vo.buyer_addr}';
					temp += '&buyer_postcode=${vo.buyer_postcode}';
					temp += '&imp_uid=' + rsp.imp_uid;
					temp += '&merchant_uid=' + rsp.merchant_uid;
					temp += '&paid_amount=' + rsp.paid_amount;
					temp += '&apply_num=' + rsp.apply_num; 
					location.href='${ctp}/order/paymentResult'+temp;
		    }
		});
	</script>
	<style>
		body,h1 {font-family: "Raleway", sans-serif}
		body, html {height: 100%}
		.bgimg {
		  background-image: url('${ctp}/images/payMain.jpg');
		  min-height: 100%;
		  background-position: center;
		  background-size: cover;
		}
	</style>
</head>
<body>
<!-- Nav  -->
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="bgimg w3-display-container w3-animate-opacity w3-text-white">
  <div class="w3-display-middle">
    <!-- <h1 class="w3-jumbo w3-animate-top">Payment in progress</h1> -->
    <h1 class="w3-jumbo w3-animate-top">결제 진행 중</h1>
    <hr class="w3-border-grey" style="margin:auto;width:40%">
    <p class="w3-large w3-center">Payment in progress</p>
  </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>