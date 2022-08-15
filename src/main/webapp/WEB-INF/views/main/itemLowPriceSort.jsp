<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<style>
	#item_list_sort > div {
		min-height: 520px;
	}	
</style>
<div id="item_list_sort" class="w3-row-padding w3-padding-16 w3-center">
  	<c:set var="a" value="0"/>
  	<c:forEach var="itemVO" items="${itemLowPriceList}" varStatus="st">
  		<div class="w3-quarter">
	  		<a href="${ctp}/item/itemView?item_code=${itemVO.item_code}">
	  			<div class="w3-display-container">
	  				<c:if test="${itemVO.sold_out == 1}">
			        	<div class="w3-display-topleft w3-2020-flame-scarlet w3-padding" style="font-size:8px;">Sold Out</div>			        
			        </c:if>
	  				<c:if test="${itemVO.stock_quantity == 1}">
				        <div class="w3-display-topleft w3-2021-marigold w3-padding" style="font-size:10px;">품절 임박</div>
	  				</c:if>
					<img src="${ctp}/data/item/${itemVO.item_image}" alt="${itemVO.item_image}" style="width:100%; margin-top:0px;">
			    </div>
   				<div class="mb-2 text-left" style="font-size:14px;">
	        		<i class="fa-solid fa-star"><span> 
	        		<fmt:formatNumber type="number" pattern="0.0" value="${itemVO.cal_rating}"/>&nbsp;/&nbsp;5</span></i>
	        	</div>			    
				<div>
					<h5 class="text-left w3-white" style="font-family:'MaruBuriSemiBold'">
						<strong>
							 ${fn:substring(itemVO.item_summary, 0, 19)}
						    <c:if test="${fn:length(itemVO.item_summary) > 18}">
						    ...
						    </c:if>
		  				</strong>
					</h5>
				</div>
				<c:if test="${empty wishlist}">
					<div class="w3-right like">
						<a href="javascript:like(${itemVO.item_idx})"><i class="fa-regular fa-heart"></i></a>
						<span>${itemVO.wish}</span>
					</div>
				</c:if>
				<c:if test="${not empty wishlist}">
					<c:set var="flag" value="false"/>
					<c:forEach var="wish" items="${wishlist}" varStatus="stsss">
						<c:if test="${flag == false}">
							<div class="w3-right like">
								<c:if test="${itemVO.item_idx == wish.item_idx}">
									<a href="javascript:unlike(${itemVO.item_idx})">❤️</a>
									<span>${itemVO.wish}</span>
									<c:set var="flag" value="true"/>
								</c:if>
								<c:if test="${not flag}">
									<c:if test="${stsss.last}">
										<a href="javascript:like(${itemVO.item_idx})"><i class="fa-regular fa-heart"></i></a>
										<span>${itemVO.wish}</span>
									</c:if>
								</c:if>
							</div>
						</c:if>
					</c:forEach>
				</c:if>
				<div class="text-left">
					<c:if test="${itemVO.seller_discount_flag == 'n'}">
						<c:set var="priceFmt" value="${itemVO.sale_price}"/>
			        	<div class="mt-2"><b><fmt:formatNumber value="${priceFmt}"/>원</b></div>
					</c:if>
					<c:if test="${itemVO.seller_discount_flag == 'y'}">
						<b>
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
			        			<i class="fa-solid fa-percent"></i> 할인
			        		</span>
			        	</b>
					</c:if>
				</div>
	  		</a>
			<div class="text-left pb-4">
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