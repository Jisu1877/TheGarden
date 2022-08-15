<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<% pageContext.setAttribute("newLine", "\n"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품정보조회</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<link rel="icon" href="${ctp}/images/favicon.png">
<link rel="stylesheet" type="text/css" href="${ctp}/css/itemView.css" />
<script src="https://cdn.rawgit.com/igorlino/elevatezoom-plus/1.1.6/src/jquery.ez-plus.js"></script>
<script src="${ctp}/js/itemView.js"></script>
<!-- Styles -->
<style>
#chartdiv {
  width: 100%;
  height: 500px;
}
.w3-radius {
	border-radius: 20px;
}

div, ul, li {-webkit-box-sizing: border-box;-moz-box-sizing: border-box;box-sizing: border-box;padding:0;margin:0}
a {text-decoration:none;}

.quickmenu {position:absolute;width:90px;top:50%;margin-top:-50px;right:10px;background:#fff;}
.quickmenu ul {position:relative;float:left;width:100%;display:inline-block;*display:inline;border:1px solid #ddd;}
.quickmenu ul li {float:left;width:100%;border-bottom:1px solid #ddd;text-align:center;display:inline-block;*display:inline;}
.quickmenu ul li a {position:relative;float:left;width:100%;line-height:30px;text-align:center;color:#000;font-size:9.5pt;}
.quickmenu ul li a:hover {}
.quickmenu ul li:last-child {border-bottom:0;}

.content {position:relative;min-height:1000px;}
</style>
<script>
	$(function() {
		var currentPosition = parseInt($(".quickmenu").css("top"));
		$(window).scroll(function() {
		    var position = $(window).scrollTop(); 
		    $(".quickmenu").stop().animate({"top":position+currentPosition+"px"},800);
		});
		
		itemJson = ${itemJson};
		reviewChartJson = ${reviewChartJson};
		let chartData = makeReviewChartData(reviewChartJson);
		console.log(reviewChartJson, chartData);
		
		drawChart('chartdiv', chartData);
	});
	
	function makeReviewChartData(arr) {
		let reviewChartArray = new Array();
		
		for (let i = 0; i < 5; i++) {
			let dataForChart = new Object();
			let review = findReviewByRating(i+1);
			
			if (review != null) {
				dataForChart.value = review.ratingValue;
			} else {
				dataForChart.value = 0;
			}
			dataForChart.label = (i+1) + '점';
			reviewChartArray.push(dataForChart);
		}
		
		return reviewChartArray;
	}
	
	function findReviewByRating(rating) {
		for (const review of reviewChartJson) {
			if (review.rating == rating) {
				return review;
			}
		}
		return null;
	}
	
</script>
</head>
<body>
<!-- Nav  -->
<span id="navBar">
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
</span>
<jsp:include page="/WEB-INF/views/include/header2.jsp" />
<div class="quickmenu" style="font-family:Montserrat,sans-serif">
  <ul>
    <li><a href="${ctp}/main/mainHome">HOME</a></li>
    <li><a href="#header" class="w3-black">TOP&nbsp; <i class="fa-solid fa-angles-up"></i></a></li>
    <c:if test="${!empty recentList}">
    <li style="font-size:13px;">최근 본 상품</li>
    	<c:set var="item" value=""/>
    	<c:forEach var="vo" items="${recentList}">
    	<c:if test="${item != vo.item_idx}">
	    	<li>
	    		<a href="${ctp}/item/itemView?item_code=${vo.item_code}" style="padding:5px;">
	    			<img src="${ctp}/data/item/${vo.item_image}" width="100%">
	    		</a>
	    	</li>
    	</c:if>
    	<c:set var="item" value="${vo.item_idx}"/>
    	</c:forEach>
    </c:if>
  </ul>
</div>
<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px" onmouseover="hoverMenuClose()">
	<div class="container" style="margin-bottom:100px; margin-top:70px;">
    	<div class="w3-content" style="max-width:1200px;">
    		<div class="w3-col m5 l6">
   				<div class="box">
   					<div id="small">
					 <img class="mySlides" src="${ctp}/data/item/${itemVO.item_image}" style="width:100%;">
   					 <c:forEach var="vo" items="${itemVO.itemImageList}" varStatus="st">
   					 	<img class="mySlides" src="${ctp}/data/item/${vo.image_name}" style="width:100%;display:none">
					 </c:forEach>
					  <div class="w3-row-padding w3-section">
					  	<img class="demo w3-opacity w3-hover-opacity-off" src="${ctp}/data/item/${itemVO.item_image}" style="width:52px; cursor:pointer" onclick="currentDiv(1)">
					    <c:forEach var="vo" items="${itemVO.itemImageList}" varStatus="st">
						 	<c:if test="${itemVO.item_image != vo.image_name}">
						 		<img class="demo w3-opacity w3-hover-opacity-off" src="${ctp}/data/item/${vo.image_name}" style="width:52px; cursor:pointer" onclick="currentDiv(${st.count + 1})">
						  	</c:if>
					 	</c:forEach>
					  </div>
   					</div>
   					<div id="elevate">
		    			<img class="mySlides" id="elevate_zoom" src="${ctp}/data/item/${itemVO.item_image}" data-zoom-image="${ctp}/data/item/${itemVO.item_image}" style="width:510px;">
						 <div class="w3-row-padding w3-section" id="image_list">
						     <a data-image="${ctp}/data/item/${itemVO.item_image}" data-zoom-image="${ctp}/data/item/${itemVO.item_image}" onclick="resetEzPlus(this)">
					  		 	<img class="w3-opacity w3-hover-opacity-off" src="${ctp}/data/item/${itemVO.item_image}" style="width:52px;cursor:pointer">
						     </a>
							 <c:forEach var="vo" items="${itemVO.itemImageList}" varStatus="st">
							 	<c:if test="${itemVO.item_image != vo.image_name}">
							 		<a data-image="${ctp}/data/item/${vo.image_name}" data-zoom-image="${ctp}/data/item/${vo.image_name}" onclick="resetEzPlus(this)">
							  			<img class="w3-opacity w3-hover-opacity-off" src="${ctp}/data/item/${vo.image_name}" style="width:52px;cursor:pointer">
							 		</a>
							  	</c:if>
						 	</c:forEach>
					 	</div>
				 	</div>
				</div>
			</div>
		</div>
		<div class="mb-2 montserrat">
			<a href="${ctp}/main/mainHome">홈</a> &nbsp; <i class="fa-solid fa-angle-right"></i> &nbsp;
			<a href="${ctp}/main/categorySearch?code=${category_group_code}&name=${itemVO.category_group_name}">${itemVO.category_group_name}</a>
			<span class="w3-dropdown-click">
				<a onclick="myFunction()"><i class="fa-solid fa-caret-down"></i></a> &nbsp;
				<div id="Demo" class="w3-dropdown-content w3-bar-block w3-border">
					<c:forEach var="category" items="${itemVO.categoryGroupList}">
					    <a href="${ctp}/main/categorySearch?code=${category.category_group_code}&name=${category.category_group_name}" class="w3-bar-item w3-btn">${category.category_group_name}</a>
					</c:forEach>
			    </div>
			</span>
			<c:if test="${itemVO.category_name != 'NO'}">
				<i class="fa-solid fa-angle-right"></i> &nbsp; 
				<a href="${ctp}/main/categorySearch2?code=${category_group_code}&name=${itemVO.category_name}&idx=${category_idx}&groupName=${category.category_group_name}">${itemVO.category_name}</a>
			</c:if>
		</div>
		<div class="w3-col m7 l6" style="margin-bottom:50px;">
			<div class="box w3-border">
				<div style="font-size: 20px; padding:30px; margin: 10px;">
					<b>${itemVO.item_summary}</b>
				</div>
				<div class="w3-left" style="margin-left:37px;">❤️ <span>${itemVO.wish}</span></div><br>
				<div style="padding-right:30px; text-align:right; font-size: 20px; margin-right:10px;">
	        		<c:if test="${itemVO.seller_discount_flag == 'n'}">
	        			<c:set var="priceFmt" value="${itemVO.sale_price}"/>
		        		<fmt:formatNumber value="${priceFmt}"/>원
	        		</c:if>
	        		<c:if test="${itemVO.seller_discount_flag == 'y'}">
	        		<div style="font-size: 19px; color:brown">
	        			<!-- (할인율) = (할인액) / (정가) X 100 -->
	        			<c:set var="calDiscountFmt" value="${(itemVO.seller_discount_amount / itemVO.sale_price) * 100}"/>
	        			<fmt:formatNumber type="number" maxFractionDigits="0"  value="${calDiscountFmt}" />
	        			<i class="fa-solid fa-percent"></i> 할인
	        		</div>
					<span id="discountPrice" style="font-size:16px;">
						<c:set var="priceFmt" value="${itemVO.sale_price}"/>
		        		<fmt:formatNumber value="${priceFmt}"/>원
		        	</span>
	        		<span>
		        		&nbsp;<i class="fa-solid fa-arrow-trend-down" style="font-size: 16px"></i>&nbsp;
		        		<c:set var="calPriceFmt" value="${itemVO.sale_price - itemVO.seller_discount_amount}"/>
		        		<fmt:formatNumber value="${calPriceFmt}"/>원
	        		</span>
	        		</c:if>
				</div>
				<div class="w3-border" style="margin:30px; padding:10px;">
					<div class="w3-row">
						<c:if test="${itemVO.seller_point_flag == 'y'}">
							<c:set var="point" value="${itemVO.seller_point + 100}"/>
							&nbsp;&nbsp;최대 적립포인트&nbsp;&nbsp;&nbsp;
							${point}Point
							<span class="w3-dropdown-click">
								<a onclick="myFunction2()"><i class="fa-solid fa-circle-question"></i></a>
								<div id="pointDemo" class="w3-dropdown-content w3-bar-block w3-border montserrat" style="padding:10px; font-size: 12px;">
									더 가든 고객을 위한 혜택!
									<hr>
									구매적립 <i class="fa-solid fa-caret-right"></i> ${itemVO.seller_point}Point<br>
									리뷰적립 <i class="fa-solid fa-caret-right"></i> 100Point
									<hr>
									- 모든 포인트와 쿠폰은 구매확정 이후 적립 및 발급됩니다.
							    </div>
							</span>
						</c:if>
						<c:if test="${itemVO.seller_point_flag == 'n'}">
							&nbsp;&nbsp;최대 적립포인트&nbsp;&nbsp;&nbsp;
							100Point
							<span class="w3-dropdown-click">
								<a onclick="myFunction2()"><i class="fa-solid fa-circle-question"></i></a>
								<div id="pointDemo" class="w3-dropdown-content w3-bar-block w3-border montserrat" style="padding:10px; font-size: 12px;">
									더 가든 고객을 위한 혜택!
									<hr>
									리뷰적립 <i class="fa-solid fa-caret-right"></i> 100Point<br>
									<span style="font-size: 8px;">구매적립이 없는 상품입니다.</span>
									<hr>
									- 모든 포인트와 쿠폰은 구매확정 이후 적립 및 발급됩니다.
							    </div>
							</span>
						</c:if>
						</div>
						<div class="w3-border" id="benefits">
							<span><font color="red"><b>TIP.</b> </font>추가 혜택 누리는 방법</span><br>
							<i class="fa-solid fa-circle-check"></i>&nbsp; 가입 후 첫 구매시 10% 할인쿠폰 발급<br>
							<i class="fa-solid fa-circle-check"></i>&nbsp; 10만원 이상 결제시 10% 할인쿠폰 발급
						</div>
					</div>
					<div style="margin:30px;">
						<c:if test="${itemVO.item_return_flag == 'n'}">
							<div style="color:navy"><i class="fa-solid fa-circle-info"></i> 단순변심 반품불가 상품입니다. 신중히 구매 부탁드립니다.</div>
						</c:if>
						<hr>
					</div>
					<%-- <div style="margin-left:30px;">남은 재고 수량 : ${itemVO.stock_quantity}</div> --%>
					<div style="margin-left:30px; font-size:14px;">( 최소 구매 수량 : ${itemVO.order_min_quantity}개&nbsp;)</div>
					<c:if test="${itemVO.item_option_flag == 'y'}">
						<div class="w3-border" style="margin:30px;">
							<select id="optionSelect" name="optionSelect" class="w3-select" onchange="optionSelect(this)">
									<option value="" selected>옵션을 선택하세요.</option>
								<c:forEach var="vo" items="${itemVO.itemOptionList}" varStatus="st">
									<option id="option${st.count}" value="${vo.item_option_idx}" data-label="${vo.option_name}" data-price="${vo.option_price}" <c:if test="${vo.option_sold_out eq '1'}">disabled</c:if>>
										${vo.option_name}(+${vo.option_price})
										<c:if test="${vo.option_sold_out eq '1'}"><span> [품절] </span></c:if>
									</option>
								</c:forEach>
							</select>
						</div>
						<div style="margin:30px;">
							<hr>
						</div>
					</c:if>
					<div style="margin:30px;" id="optonDemo"></div>
					<c:if test="${itemVO.item_option_flag == 'n'}">
						<div class="w3-row" style="margin:30px;">
							<div class="w3-half">
								<a onclick="minus2(this)"><i class="fa-solid fa-square-minus" style="font-size:23px"></i></a>
								<span class="option_cnt" style="font-size:16px; vertical-align:top; margin:10px" data-cnt="0">${itemVO.order_min_quantity}</span>
								<a onclick="plus2(this)"><i class="fa-solid fa-square-plus" style="font-size:23px"></i></a>
							</div>
							<div class="w3-half" style="text-align:right; font-size:19px">
								<span class="option_price"></span>
							</div>
						</div>
						<div id="totalInfor" class="w3-row" style="margin:30px; font-size:22px;">
						<div class="w3-half">
							총 상품금액
						</div>
						<div class="w3-half" style="text-align:right;">
							<span><font size="2">총 수량(<span id="totalCnt">${itemVO.order_min_quantity}</span>개)</font></span>
							<c:if test="${itemVO.seller_discount_flag == 'n'}">
								<c:set var="priceFmt2" value="${itemVO.sale_price * itemVO.order_min_quantity}"/>
								<span id="totalPrice"><fmt:formatNumber value="${priceFmt2}"/></span>원
							</c:if>
							<c:if test="${itemVO.seller_discount_flag == 'y'}">
								<c:set var="priceFmt3" value="${(itemVO.sale_price - itemVO.seller_discount_amount) * itemVO.order_min_quantity}"/>
								<span id="totalPrice"><fmt:formatNumber value="${priceFmt3}"/></span>원
							</c:if>
						</div>
						</div>
					</c:if>
					<div id="totalInfor" class="w3-row" style="display:none">
						<div class="w3-half">
							총 상품금액
						</div>
						<div class="w3-half" style="text-align:right;">
							<span><font size="2">총 수량(<span id="totalCnt"></span>개)</font></span>
							<span id="totalPrice"></span>원
						</div>
					</div>
					<div style="margin:30px;">
						<c:if test="${itemVO.sold_out == 0}">
							<a class="w3-button w3-2021-marigold form-control btn-lg" style="font-family: 'Montserrat', sans-serif" onclick="buyItem()">바로구매</a>
						</c:if>
						<c:if test="${itemVO.sold_out == 1}">
							<c:if test="${itemVO.stock_schedule_date != ''}">
								<div class="mb-2" style="color:tomato"><i class="fa-solid fa-circle-info"></i> 재입고 예정일 : ${itemVO.stock_schedule_date} </div>
							</c:if>
							<button class="w3-button w3-2020-flame-scarlet form-control btn-lg" style="font-family: 'Montserrat', sans-serif" disabled="disabled">품절</button>
						</c:if>
					</div>
					<div class="w3-row w3-center" style="margin:30px; font-family: 'Montserrat', sans-serif">
						<div class="w3-third">
							<a href="javascript:ItemQnaOpen('${itemVO.item_idx}','${loginFlag}')" class="w3-button w3-white w3-hover-white w3-border w3-round-large" style="width:90%">
								<span class="iconify" data-icon="fluent:chat-bubbles-question-20-filled" style="font-size:20px;"></span>&nbsp;상품문의
								<!-- <span class="iconify" data-icon="ooui:ongoing-conversation-rtl"></span>&nbsp;문의하기 -->
							</a>
						</div>
						<div class="w3-third">
							<c:if test="${loginFlag == 'no'}">
								<a class="w3-button w3-white w3-hover-white w3-border w3-round-large" style="width:90%" href="javascript:like(${itemVO.item_idx})">
									<span class="iconify" data-icon="akar-icons:heart"></span>&nbsp;찜하기
								</a>
							</c:if>
							<c:if test="${loginFlag == 'yes'}">
								<c:if test="${empty wishlist}">
									<a class="w3-button w3-white w3-hover-white w3-border w3-round-large" style="width:90%" href="javascript:like(${itemVO.item_idx})">
										<span class="iconify" data-icon="akar-icons:heart"></span>&nbsp;찜하기
									</a>
								</c:if>
								<c:if test="${not empty wishlist}">
									<c:set var="flag" value="false"/>
									<c:forEach var="wish" items="${wishlist}" varStatus="stsss">
										<c:if test="${flag == false}">
											<c:if test="${itemVO.item_idx == wish.item_idx}">
												<a class="w3-button w3-white w3-hover-white w3-border w3-round-large" style="width:90%" href="javascript:unlike(${itemVO.item_idx})">
													❤️&nbsp;찜하기&nbsp;
												</a>
												<c:set var="flag" value="true"/>
											</c:if>
											<c:if test="${not flag}">
												<c:if test="${stsss.last}">
													<a class="w3-button w3-white w3-hover-white w3-border w3-round-large" style="width:90%" href="javascript:like(${itemVO.item_idx})">
														<span class="iconify" data-icon="akar-icons:heart"></span>&nbsp;찜하기&nbsp;
													</a>
												</c:if>
											</c:if>
										</c:if>
									</c:forEach>
								</c:if>
							</c:if>
						</div>
						<div class="w3-third">
							<a class="w3-button w3-white w3-hover-white w3-border w3-round-large" style="width:90%" onclick="inputCart()">
								<i class="fa-solid fa-cart-arrow-down"></i>&nbsp;장바구니
							</a>
						</div>
					</div>
				</div>
			</div>
			<div class="w3-row">
			    <a href="javascript:void(0)" onclick="openCity(event, 'infor');">
			      <div class="w3-third tablink w3-bottombar w3-hover-light-grey w3-padding">상세정보</div>
			    </a>
			    <a href="javascript:void(0)" onclick="openCity(event, 'review');">
			      <div class="w3-third tablink w3-bottombar w3-hover-light-grey w3-padding">리뷰</div>
			    </a>
			    <a href="javascript:void(0)" onclick="openCity(event, 'QA');">
			      <div class="w3-third tablink w3-bottombar w3-hover-light-grey w3-padding">Q&A</div>
			    </a>
			</div>
			<div id="infor" class="w3-container info" style="display:none">
			    <h4 style="font-family: 'MaruBuriBold';">상품 정보</h4>
			    <table class="table table-border">
					<tr>
						<td>상품코드</td><td>${itemVO.item_code}</td>
						<td>브랜드</td><td>${itemVO.brand}</td>
					</tr>			    
					<tr>
						<td>모델명</td><td>${itemVO.item_model_name}</td>
						<td>원산지</td><td>${itemVO.origin_country}</td>
					</tr>			    
					<tr>
						<td>형태</td><td>${itemVO.form}</td>
						<td>A/S안내</td><td>${itemVO.after_service}</td>
					</tr>			    
			    </table>
			    <div class="text-center">
			    	${itemVO.detail_content}
			    </div>
			    <hr>
			    <div class="text-left mb-4">
			    	<h4>#keyword</h4>
					<c:set var="keywords" value="${fn:split(itemVO.item_keyword,'/')}" />
					<c:forEach var="keyword" items="${keywords}" varStatus="g">
						<c:if test="${keyword != ''}">
							<a href="${ctp}/item/keywordSearch?keyword=${keyword}" style="font-size:12px;" class="w3-2021-buttercream">#${keyword}</a>
						</c:if>
					</c:forEach> 
				</div>
				<hr>
				<h4 style="font-family: 'MaruBuriBold';">상품 정보 고시</h4>
				<table class="table table-border">
					<tr>
						<td>품명/모델명</td><td>${itemVO.notice_value1}</td>
					</tr>			    
					<tr>
						<td>법에 의한 인증, 허가 등을 받았음을 확인할 수 있는 경우 그에 대한 사항</td><td>${itemVO.notice_value2}</td>
					</tr>			    
					<tr>
						<td>제조자(사)</td><td>${itemVO.notice_value3}</td>
					</tr>			    
					<tr>
						<td>제조국</td><td>${itemVO.notice_value4}</td>
					</tr>			    
					<tr>
						<td>소비자상담 관련 전화번호</td><td>${itemVO.notice_value5}</td>
					</tr>			    
			    </table>
			</div>
			<div id="review" class="w3-container info">
				<div class="w3-row-padding">
					<div class="w3-half">
					    <div style="padding-top:70px; vertical-align:middle;" class="text-center">
					    	<font size="4">사용자 총 평점</font><br>
					    	<c:if test="${rating != null}">
					    		<font size="4">⭐ <fmt:formatNumber type="number" pattern="0.0" value="${rating.rating_cal}"/></font>
					    	</c:if>
					    	<c:if test="${rating == null}">
					    		<font size="4">⭐ 0.0</font>
					    	</c:if>
					    </div>
				    </div>
				    <div class="w3-half">
				    	<div id="chartdiv" style="width:70%; height:260px;"></div>
				    </div>
			    </div>
			    <hr>
			    <div>
			    	<h2>Review</h2><br>
			    </div>
			    	<c:if test="${rating == null}">
			    		작성된 리뷰가 없습니다.
			    	</c:if>
			    	<c:forEach var="vo" items="${reviewList}">
					    <div class="w3-row-padding" style="margin-bottom:40px;">
				    		<div class="w3-col l1 m1">
					  			<div class="w3-display-container">
									<img src="${ctp}/data/user/${vo.user_image}" alt="${vo.user_image}" style="width:80%; margin-top:0px;" class="w3-radius">
							    </div>
			  				</div>
			  				<div class="w3-col l7 m8 ml-2">
			  					<div>
				  					<c:if test="${vo.rating == 5}">
				  						⭐⭐⭐⭐⭐ <font size="4">5</font>
				  					</c:if>
				  					<c:if test="${vo.rating == 4}">
				  						⭐⭐⭐⭐ <font size="4">4</font>
				  					</c:if>
				  					<c:if test="${vo.rating == 3}">
				  						⭐⭐⭐ <font size="4">3</font>
				  					</c:if>
				  					<c:if test="${vo.rating == 2}">
				  						⭐⭐ <font size="4">2</font>
				  					</c:if>
				  					<c:if test="${vo.rating == 1}">
				  						⭐ <font size="4">1</font>
				  					</c:if>
			  					</div>
			  					<div class="ml-2" style="color:gray; font-size:13px;">
			  						<span>${fn:substring(vo.user_id, 0, 3)}*****</span>
			  						&nbsp;${fn:substring(vo.review_date, 0, 10)}
			  					</div>
			  					<div class="mt-2" style="font-size: 15px;">
			  						<b>${fn:replace(vo.review_subject, newLine, '<br>')}</b>
			  					</div>
			  					<div style="color:gray; font-size:14px;">
			  						${fn:replace(vo.review_contents, newLine, '<br>')}
			  					</div>
		  					</div>
		  					<div class="w3-col m3">
		  						<div style="text-align:right">
			  						<c:if test="${vo.photo != ''}">
			  							<c:set var="photo" value="${fn:split(vo.photo, '/')}"/>
			  							<a href="javascript:showImage(${vo.review_idx})">
			  								<img src="${ctp}/data/review/${photo[0]}" alt="${photo[0]}" style="width:40%; margin-top:0px;" class="w3-radius">
			  							</a>
			  						</c:if>
		  						</div>
		  					</div>
				    	</div>
			    		<a href="javascript:hideImage(${vo.review_idx})">
					    	<div class="w3-row-padding" id="showImage${vo.review_idx}" style="display:none">
					    		<c:set var="images" value="${fn:split(vo.photo, '/')}"/>
					    		<c:forEach var="image" items="${images}">
					    			<img src="${ctp}/data/review/${image}" alt="${image}" style="width:30%; margin-top:0px;">
					    		</c:forEach>
					    	</div>
			    		</a>
				    	<hr>
	    		</c:forEach>
			</div>
			<div id="QA" class="w3-container info" style="display:none; font-family:Montserrat,sans-serif;">
			    <div class="m-3">
			    	<span style="font-size:23px;"><b>Q&A</b></sapn>
			    	<a class="btn btn-outline-secondary w3-round-large w3-small w3-padding-small ml-4" href="javascript:ItemQnaOpen('${itemVO.item_idx}','${loginFlag}')">문의 작성</a>
			    </div>
			    <table class="w3-table w3-bordered" style="font-size:14px;">
			    	<tr class="text-center w3-2020-ash">
		    			<td width="10%">답변상태</td>
		    			<td width="70%">내용</td>
		    			<td width="10%">작성자</td>
		    			<td width="10%">작성일</td>
		    		</tr>
			    	<c:forEach var="vo" items="${itemQnaList}">
			    		<tr>
			    			<td class="w3-text-gray">
			    				<c:if test="${vo.admin_answer_yn == 'n'}">미답변</c:if>
			    				<c:if test="${vo.admin_answer_yn == 'y'}">답변 완료</c:if>
			    			</td>
			    			<td>
			    				<c:if test="${vo.admin_answer_yn == 'y'}">
				    				<a href="javascript:showAnswer('${vo.view_yn}','${user_id}','${vo.user_id}','${vo.item_qna_idx}')">
			    				</c:if>
					    				<c:if test="${vo.view_yn == 'n'}"><span style="color:gray;"><i class="fa-solid fa-lock"></i> 비밀글입니다.</span></c:if>
					    				<c:if test="${vo.view_yn == 'y'}">${vo.item_qna_content}</c:if>
			    				<c:if test="${vo.admin_answer_yn == 'y'}">
				    				</a>
				    			</c:if>
			    			</td>
			    			<td>
			    				${fn:substring(vo.user_id,0,3)}****
			    			</td>
			    			<td>
			    				${fn:substring(vo.write_date,0,10)}
			    			</td>
			    		</tr>
			    	</c:forEach>
		    		<c:if test="${itemQnaList.size() == 0}">
		    			<tr>
		    				<td colspan="4" class="text-center">상품 문의 내역이 없습니다.</td>
		    			</tr>
		    		</c:if>
			    </table>
			</div>
			</div>
		</div>
	</div>
</div>


<input type="hidden" id="item_idx" value="${itemVO.item_idx}">
<input type="hidden" id="item_name" value="${itemVO.item_name}">
<input type="hidden" id="item_image" value="${itemVO.item_image}">
<input type="hidden" id="order_min_quantity" value="${itemVO.order_min_quantity}">
<input type="hidden" id="order_max_quantity" value="${itemVO.order_max_quantity}">
<input type="hidden" id="stock_quantity" value="${itemVO.stock_quantity}">
<input type="hidden" id="sale_price" value="${itemVO.sale_price}">
<input type="hidden" id="seller_discount_flag" value="${itemVO.seller_discount_flag}">
<input type="hidden" id="item_option_flag" value="${itemVO.item_option_flag}">
<input type="hidden" id="seller_discount_amount" value="${itemVO.seller_discount_amount}">

<input type="hidden" id="loginFlag" value="${loginFlag}">


<div class="option_div" id="option_tmp_div" style="display:none;" data-option="">
	<div class="w3-row">
		<div class="w3-half">
			<div class="mb-1 option"></div>
		</div>
		<div class="w3-half" style="text-align:right; font-size:19px;">
			<a onclick="deleteOption(this)"><i class="fa-solid fa-xmark"></i></a>
		</div>
		<div class="w3-row">
			<div class="w3-half">
				<a onclick="minus(this)"><i class="fa-solid fa-square-minus" style="font-size:23px"></i></a>
				<span class="option_cnt" style="font-size:16px; vertical-align:top; margin:10px" data-cnt="0"></span>
				<a onclick="plus(this)"><i class="fa-solid fa-square-plus" style="font-size:23px"></i></a>
			</div>
			<div class="w3-half" style="text-align:right; font-size:19px">
				<span class="option_price"></span>
			</div>
		</div>
	</div>
	<hr>
</div>
<form name="payForm" method="get" action="${ctp}/order/orderCheck">
	<input type="hidden" name="order_item_idx">
	<input type="hidden" name="order_item_name">
	<input type="hidden" name="order_item_image">
	<input type="hidden" name="order_item_price">
	<input type="hidden" name="order_item_option_flag">
	<input type="hidden" name="order_option_idx">
	<input type="hidden" name="order_option_name">
	<input type="hidden" name="order_option_price">
	<input type="hidden" name="order_quantity">
	<input type="hidden" name="order_total_amount">
	<input type="hidden" name="cart_idx">
</form>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script>
 $(function() {
	initEzPlus();
	document.getElementById("infor").style.display = "block";
});

 function initEzPlus() {
	$('#elevate_zoom').ezPlus({
	    gallery: 'image_list',
	    cursor: 'pointer',
	    galleryActiveClass: 'active',
	    imageCrossfade: true,
	    loadingIcon: 'http://www.elevateweb.co.uk/spinner.gif',
	    scrollZoom: true,
	    zoomLevel: 0.5,
	    borderSize : 1,
	    zoomWindowWidth: 510,
	    zoomWindowHeight: 510,
	    responsive: true,
	    zoomWindowPosition: 1,
	    zoomWindowOffsetX: 10
	});
}

function resetEzPlus(img) {
// 	$('#elevate_zoom').attr('src', img.src);
// 	$('#elevate_zoom').ezPlus({
// 		gallery: 'image_list',
// 	    cursor: 'pointer',
// 	    galleryActiveClass: 'active',
// 	    loadingIcon: 'http://www.elevateweb.co.uk/spinner.gif',
// 	    scrollZoom: true,
// 	    zoomLevel: 0.5,
// 	    borderSize : 1,
// 	    zoomWindowWidth: 510,
// 	    zoomWindowHeight: 510,
// 	    responsive: true,
// 	    zoomWindowPosition: 1,
// 	    zoomWindowOffsetX: 10
// 	});
}

 
function currentDiv(n) {
  showDivs(slideIndex = n);
}

function showDivs(n) {
  var i;
  var x = document.getElementsByClassName("mySlides");
  var dots = document.getElementsByClassName("demo");
  if (n > x.length) {slideIndex = 1}
  if (n < 1) {slideIndex = x.length}
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";
  }
  for (i = 0; i < dots.length; i++) {
    dots[i].className = dots[i].className.replace(" w3-opacity-off", "");
  }
  x[slideIndex-1].style.display = "block";
  dots[slideIndex-1].className += " w3-opacity-off";
}
 
function myFunction() {
  var x = document.getElementById("Demo");
  if (x.className.indexOf("w3-show") == -1) { 
    x.className += " w3-show";
  } else {
    x.className = x.className.replace(" w3-show", "");
  }
}

function myFunction2() {
  var x = document.getElementById("pointDemo");
  if (x.className.indexOf("w3-show") == -1) { 
    x.className += " w3-show";
  } else {
    x.className = x.className.replace(" w3-show", "");
  }
}

function openCity(evt, name) {
  var i, x, tablinks;
  x = document.getElementsByClassName("info");
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";
  }
  tablinks = document.getElementsByClassName("tablink");
  for (i = 0; i < x.length; i++) {
    tablinks[i].className = tablinks[i].className.replace(" w3-border-green", "");
  }
  document.getElementById(name).style.display = "block";
  evt.currentTarget.firstElementChild.className += " w3-border-green";
}

</script>
</body>
</html>