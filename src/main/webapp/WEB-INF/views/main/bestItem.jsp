<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Best</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <link rel="stylesheet" href="${ctp}/css/main.css">
    <style type="text/css">
		#discountPrice {
			text-decoration: line-through;
		}
		img {
			margin-top: 10px;
		}
		#pageContent {
	   		font-family: 'MaruBuriExtraLight';
			font-family: 'MaruBuriLight;
			font-family: 'MaruBuri';
			font-family: 'MaruBuriBold';
			font-family: 'MaruBuriSemiBold';
	   	} 
	</style>
</head>
<body>
<!-- Nav  -->
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<!-- Header -->
<jsp:include page="/WEB-INF/views/include/header2.jsp" />

<script>
	let storeList = JSON.parse('${storeJson}');
	console.log(storeList);
	
	function categorySearch(code,name) {
		location.href="${ctp}/main/categorySearch?code="+code+"&name="+name;
	}
	
	function categorySearch2(code,idx,name,groupName) {
		location.href="${ctp}/main/categorySearch2?code="+code+"&name="+name+"&idx="+idx+"&groupName="+groupName;
	}
	
	function showAllItems() {
		$("#allItems").attr("style", "display:block");
		$("#allItemsShowBtn").attr("style", "display:none");
	}
</script>
<div id="pageContent" class="w3-content" style="max-width:1500px" onmouseover="hoverMenuClose()">
  <!-- Shop -->
  <div id="shop">
	<p style="margin-left: 20px; font-family: 'Montserrat', sans-serif">
		<span class="w3-white w3-xxlarge mt-2">SHOP</span>
	  	<span style="font-size: 18px; margin-left: 10px;"> The Garden 전 상품 무료배송!</span>
	  	<span class="w3-tag w3-round w3-green w3-border w3-border-white">
			FREE Shipping
	    </span>
	</p>
  </div>
  <!-- Category 보이기  -->
  <div style="margin-bottom: 50px; margin-left: 16px;">
	<div class="w3-bar" style="font-size: 13px;">
	   <c:forEach var="vo" items="${categoryVOS}" varStatus="st">
			<div class="w3-dropdown-hover">
				<button class="btn w3-white w3-hover-white" style="font-size: 18px; border-radius:0" onclick="categorySearch('${vo.category_group_code}','${vo.category_group_name}')">${vo.category_group_name}</button>
				<div class="w3-dropdown-content w3-bar-block w3-hover-white">
					<c:set var="i" value="0"/>
					<c:forEach var="cVO" items="${vo.categoryList}">
						<a onclick="categorySearch2('${vo.category_group_code}',${cVO.category_idx},'${cVO.category_name}','${vo.category_group_name}')" class="w3-bar-item btn">${cVO.category_name}</a>
					 </c:forEach>
				</div>
			</div>
		</c:forEach>
	</div>
  </div>
	
	<!-- 현재 판매 중인 Best List-->
 <p style="text-align:center; margin-top:30px;"><span class="w3-white w3-xlarge mt-2">베스트 상품</span></p>
  <div class="w3-row-padding w3-padding-16 w3-center">
  	<c:set var="bestsw" value="1"/>
  	<c:set var="j" value="0"/>
  	<c:forEach var="itemVO" items="${itemBestList}" varStatus="st">
	  <c:if test="${bestsw == '1'}">
  		<div class="w3-quarter">
	  		<a href="${ctp}/item/itemView?item_code=${itemVO.item_code}">
	  			<div class="w3-display-container">
	  				<c:if test="${itemVO.sold_out == 0}">
			        	<div class="w3-display-topleft w3-2021-mint w3-padding" style="font-size:11px;">Best</div>
			        </c:if>
	  				<c:if test="${itemVO.sold_out == 1}">
			        <div class="w3-display-topleft w3-2020-flame-scarlet w3-padding" style="font-size:8px;">Sold Out</div>			        
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
				<c:if test="${empty wishlist}">
					<div class="w3-right like">
						<a href="javascript:like(${itemVO.item_idx})"><i class="fa-regular fa-heart"></i></a>
						<span>${itemVO.wish}</span>
					</div>
				</c:if>
				<c:if test="${not empty wishlist}">
					<c:set var="flag" value="false"/>
					<c:forEach var="wish" items="${wishlist}" varStatus="stss">
						<c:if test="${flag == false}">
							<div class="w3-right like">
								<c:if test="${itemVO.item_idx == wish.item_idx}">
									<a href="javascript:unlike(${itemVO.item_idx})">❤️</a>
									<span>${itemVO.wish}</span>
									<c:set var="flag" value="true"/>
								</c:if>
								<c:if test="${not flag}">
									<c:if test="${stss.last}">
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
			<div class="text-left mb-4">
				<c:set var="keywords" value="${fn:split(itemVO.item_keyword,'/')}" />
				<c:forEach var="keyword" items="${keywords}" varStatus="g">
					<c:if test="${keyword != ''}">
						<a href="${ctp}/item/keywordSearch?keyword=${keyword}" style="font-size:12px;" class="w3-2021-buttercream">#${keyword}</a>
					</c:if>
				</c:forEach> 
			</div>
  		</div>
  		<c:if test="${st.count == 4}">
  			<c:set var="bestsw" value="0"/>
  		</c:if>
  	</c:if>
  	</c:forEach>
  </div>
  
  <div class="text-center" id="allItemsShowBtn"><a class="w3-btn w3-2021-mint w3-round-large" onclick="showAllItems()">전체 상품 보기</a></div>
  
  <!-- 현재 판매 중인 전체상품 List-->
  <div id="allItems" style="display:none">
	 <p style="text-align:center; margin-top:30px"><span class="w3-white w3-xlarge mt-5">전체 상품</span></p>
	  <div id="item_list_all" class="w3-row-padding w3-padding-16 w3-center">
	  	<c:set var="a" value="0"/>
	  	<c:forEach var="itemVO" items="${itemVOS}" varStatus="st">
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
  </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>