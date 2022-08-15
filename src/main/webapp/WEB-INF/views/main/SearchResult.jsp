<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 검색</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <link rel="stylesheet" href="${ctp}/css/main.css">
</head>
<body>
<!-- Nav  -->
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/header2.jsp" />

<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px" onmouseover="hoverMenuClose()">
	<div style="margin-bottom:100px; margin-top:70px;">
    	<h3 style="text-align:center; font-family:'MaruBuriSemiBold';">'${groupName} ${name} ' 검색결과(${vos.size()})</h3>
  		<div class="w3-row-padding w3-padding-16 w3-center" id="item_list_all">
		  	<c:forEach var="itemVO" items="${vos}">
		  		<div class="w3-quarter">
			  		<a href="${ctp}/item/itemView?item_code=${itemVO.item_code}">
			  			<div class="w3-display-container">
			  				<c:if test="${itemVO.stock_quantity == 1}">
						        <div class="w3-display-topleft w3-2021-marigold w3-padding">품절 임박</div>
			  				</c:if>
							<img src="${ctp}/data/item/${itemVO.item_image}" alt="${itemVO.item_image}" style="width:100%; margin-top:0px;">
					    </div>
						<div>
							<h5 class="text-left w3-white" style="font-family:'MaruBuriSemiBold'">
								<strong>
									 ${fn:substring(itemVO.item_summary, 0, 21)}
								    <c:if test="${fn:length(itemVO.item_summary) > 20}">
								    ...
								    </c:if>
				  					<%-- ${itemVO.item_summary} --%>
				  				</strong>
							</h5>
						</div>
						<div class="text-left">
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
						        		<i class="fa-solid fa-arrow-trend-down"></i>&nbsp;
						        		<c:set var="calPriceFmt" value="${itemVO.sale_price - itemVO.seller_discount_amount}"/>
						        		<fmt:formatNumber value="${calPriceFmt}"/>원
					        		</span>
					        		<span style="font-size: 19px; margin-left: 10px; color:brown">
					        			<!-- (할인율) = (할인액) / (정가) X 100 -->
					        			<c:set var="calDiscountFmt" value="${(itemVO.seller_discount_amount / itemVO.sale_price) * 100}"/>
					        			<fmt:formatNumber type="number" maxFractionDigits="0"  value="${calDiscountFmt}" />
					        			<i class="fa-solid fa-percent"></i> <span  style="font-family:'MaruBuriSemiBold';">할인</span>
					        		</span>
					        	</b></div>
							</c:if>
						</div>
			  		</a>
					<div class="text-left mb-4">
						<c:set var="keywords" value="${fn:split(itemVO.item_keyword,'/')}" />
						<c:forEach var="keyword" items="${keywords}" varStatus="g">
							<c:if test="${keyword != ''}">
								<a href="${ctp}/item/keywordSearch?keyword=${keyword}" style="font-size:12px;" class="w3-2021-buttercream">#${keyword}</a>
							</c:if>
						</c:forEach> 
					</div>
		  		</div>
		  	</c:forEach>
		</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>