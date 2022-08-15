<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>장바구니</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <style>
    	#discountPrice {
			text-decoration: line-through;
		}
    </style>
</head>
<body>
<!-- Nav  -->
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/header2.jsp" />

<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px" onmouseover="hoverMenuClose()">
	<div class="container" style="margin-bottom:100px; margin-top:70px;">
    	<div class="w3-bottombar w3-light-grey w3-padding">
    		<input type="checkbox" class="w3-check">&nbsp;
    		장바구니[${cartVOS.size()}]
    		<c:set var="i" value="${cartVOS.size()}"/>
    	</div>
    	<form>
   		<div class="w3-row" style="padding:20px;">
   			<div class="w3-third">
   				<c:forEach var="itemVO" items="${itemVOS}">
	   				<div class="w3-row">
	   					<div class="w3-half">
	   						<input type="checkbox" class="w3-check">&nbsp;&nbsp;&nbsp;
	 						<img src="${ctp}/data/item/${itemVO.item_image}" width="100px;"/>
	   					</div>
	   					<div class="w3-half">
		   					${itemVO.item_name}<br>
		   					<c:if test="${itemVO.seller_discount_flag == 'n'}">
								<c:set var="priceFmt" value="${itemVO.sale_price}"/>
					        	<div class="mt-2"><b><fmt:formatNumber value="${priceFmt}"/>원</b></div>
							</c:if>
							<c:if test="${itemVO.seller_discount_flag == 'y'}">
								<div class="w3-row mt-2"><b>
						        	<span id="discountPrice">
										<c:set var="priceFmt" value="${itemVO.sale_price}"/>
						        		<fmt:formatNumber value="${priceFmt}"/>원
						        	</span>
					        		<span>
						        		<i class="fa-solid fa-arrow-trend-down"></i>
						        		<c:set var="calPriceFmt" value="${itemVO.sale_price - itemVO.seller_discount_amount}"/>
						        		<fmt:formatNumber value="${calPriceFmt}"/>원
					        		</span><br>
					        		<span style="font-size: 13px; color:brown">
					        			<!-- (할인율) = (할인액) / (정가) X 100 -->
					        			<c:set var="calDiscountFmt" value="${(itemVO.seller_discount_amount / itemVO.sale_price) * 100}"/>
					        			(<fmt:formatNumber type="number" maxFractionDigits="0"  value="${calDiscountFmt}" />
					        			<i class="fa-solid fa-percent"></i> 할인)
					        		</span>
					        	</b></div>
							</c:if>
	   					</div>
	   				</div>
	   				<hr>
   				</c:forEach>
   			</div>
   			<div class="w3-third w3-padding">
   				<c:forEach var="cartVO" items="${cartVOS}">
   					<c:if test="${cartVO.item_option_flag == 'n'}">
	   					<div class="w3-row">
	   						상품 주문 수량 : <span id="totalQuantity${cartVO.cart_idx}">${cartVO.total_quantity}</span> 개<br>
	   					</div>
   					</c:if>
   					<c:if test="${cartVO.item_option_flag == 'y'}">
	   					<div class="w3-row">
	   						상품 주문 수량 : <span id="totalQuantity${cartVO.cart_idx}">${cartVO.option_quantity}</span> 개<br>
	   					</div>
   					</c:if>
   				</c:forEach>
   			</div>
   			<div class="w3-third"></div>
   		</div>
    	</form>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>