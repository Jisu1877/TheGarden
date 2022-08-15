<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<script>
	function like(idx) {
		
		$.ajax({
			type : "post",
			url : "${ctp}/user/wishlistInsert",
			data : {item_idx : idx},
			async: false,
			success : function (res) {
				if(res == '1') {
					location.reload();					
					return false;
				}
				else if(res == "2") {
					alert("로그인이 필요한 서비스입니다.");
					location.href="${ctp}/user/userLogin";
					return false;
				}
			},
			error : function () {
				alert("전송 오류");
			}
		});
		
	}
	
	function unlike(idx) {
		$.ajax({
			type : "post",
			url : "${ctp}/user/wishlistDelete",
			data : {item_idx : idx},
			async: false,
			success : function (res) {
				if(res == '1') {
					location.reload();					
					return false;
				}
				else if(res == "2") {
					alert("로그인이 필요한 서비스입니다.");
					location.href="${ctp}/user/userLogin";
					return false;
				}
			},
			error : function () {
				alert("전송 오류");
			}
		});
	}
</script>
<!-- 현재 판매 중인 신상품 List-->
 <p style="text-align:center;"><span class="w3-white w3-xlarge mt-2">신상품</span></p>
  <div class="w3-row-padding w3-padding-16 w3-center">
  	<c:set var="sw" value="1"/>
  	<c:forEach var="itemVO" items="${itemNewList}" varStatus="st">
	  <c:if test="${sw == '1'}">
  		<div class="w3-quarter">
	  		<a href="${ctp}/item/itemView?item_code=${itemVO.item_code}">
	  			<div class="w3-display-container">
	  				<c:if test="${itemVO.sold_out == 0}">
			        <div class="w3-display-topleft w3-2019-princess-blue w3-padding" style="font-size:8px;">NEW</div>
			        </c:if>
	  				<c:if test="${itemVO.sold_out == 1}">
			        <div class="w3-display-topleft w3-2020-flame-scarlet w3-padding" style="font-size:8px;">Sold Out</div>			        
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
					<c:forEach var="wish" items="${wishlist}" varStatus="sts">
						<c:if test="${flag == false}">
							<div class="w3-right like">
								<c:if test="${itemVO.item_idx == wish.item_idx}">
									<a href="javascript:unlike(${itemVO.item_idx})">❤️</a>
									<span>${itemVO.wish}</span>
									<c:set var="flag" value="true"/>
								</c:if>
								<c:if test="${not flag}">
									<c:if test="${sts.last}">
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
  			<c:set var="sw" value="0"/>
  		</c:if>
  	</c:if>
  	</c:forEach>
  </div>
  
<!-- 현재 판매 중인 Best List-->
 <p style="text-align:center; margin-top:30px;"><span class="w3-white w3-xlarge mt-2">베스트</span></p>
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
  
 
<!-- 현재 판매 중인 전체상품 List-->
 <p style="text-align:center; margin-top:30px"><span class="w3-white w3-xlarge mt-5">전체 상품</span></p>
 <div class="text-right mr-4 mb-2">
    <a href="javascript:void(0)" onclick="openTab(event, '1');">
     	<span id="span1" class="span_check" style="display:none;"><i class="fa-solid fa-check"></i></span>
      	<span class="tablink">인기도순 | </span>
    </a>
    <a href="javascript:void(0)" onclick="openTab(event, '2');">
    	<span id="span2" class="span_check" style="display:none;"><i class="fa-solid fa-check"></i></span>
      	<span class="tablink">누적 판매순 | </span>
    </a>
    <a href="javascript:void(0)" onclick="openTab(event, '3');">
      	<span id="span3" class="span_check" style="display:none;"><i class="fa-solid fa-check"></i></span>
      	<span class="tablink">낮은 가격순 | </span>
    </a>
    <a href="javascript:void(0)" onclick="openTab(event, '4');">
      	<span id="span4" class="span_check" style="display:none;"><i class="fa-solid fa-check"></i></span>
      	<span class="tablink">최신 등록순 | </span>
    </a>
    <a href="javascript:void(0)" onclick="openTab(event, '5');">
      	<span id="span5" class="span_check" style="display:none;"><i class="fa-solid fa-check"></i></span>
      	<span class="tablink">리뷰 많은순 | </span>
    </a>
    <a href="javascript:void(0)" onclick="openTab(event, '6');">
      	<span id="span6" class="span_check" style="display:none;"><i class="fa-solid fa-check"></i></span>
      	<span class="tablink">평점 높은순 </span>
    </a>
  </div>
  <div id="1" class="w3-container tab" style="display:none">
    <jsp:include page="/WEB-INF/views/main/itemPopularSort.jsp"/>
  </div>
  <div id="2" class="w3-container tab" style="display:none">
    <jsp:include page="/WEB-INF/views/main/itemSaleSort.jsp"/>
  </div>
  <div id="3" class="w3-container tab" style="display:none">
    <jsp:include page="/WEB-INF/views/main/itemLowPriceSort.jsp"/>
  </div>
  <div id="4" class="w3-container tab" style="display:none">
    <jsp:include page="/WEB-INF/views/main/itemNewSort.jsp"/>
  </div>
  <div id="5" class="w3-container tab" style="display:none">
    <jsp:include page="/WEB-INF/views/main/itemLotsReviewsSort.jsp"/>
  </div>
  <div id="6" class="w3-container tab" style="display:none">
    <jsp:include page="/WEB-INF/views/main/itemRatingSort.jsp"/>
  </div>
  
  <script>
	function openTab(evt, tabIdx) {
	  var i, x, tablinks;
	  x = document.getElementsByClassName("tab");
	  for (i = 0; i < x.length; i++) {
	    x[i].style.display = "none";
	  }
	  tablinks = document.getElementsByClassName("tablink");
	  for (i = 0; i < x.length; i++) {
	    tablinks[i].className = tablinks[i].className.replace(" w3-border-red", "");
	  }
	  document.getElementById(tabIdx).style.display = "block";
	  evt.currentTarget.firstElementChild.className += " w3-border-red";
	  
	  $('.span_check').hide();
	  $('#span' + tabIdx).show();
	  $("#item_list_all").hide();
	}
  </script>
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
  