<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품정보 조회</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="${ctp}/ckeditor/ckeditor.js"></script>
    <script src="${ctp}/js/woo.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <%-- <script src="${ctp}/js/itemInsert.js"></script> --%>
    <style>
		body,h1 {font-family: "Montserrat", sans-serif}
		a {
			text-decoration: none;	
		}
		a:hover {
			color : black;
			text-decoration: none;	
		}
		.box {
	   		box-shadow: 0 16px 18px -20px rgba(0, 0, 0, 0.7);
		}
		#schedule_date {
			padding-left:20px;
		}
	</style>
	<script type="text/javascript">
		function imageShow() {
			$("#hiddenImage").slideDown(400);
			$("#imageShowBtn").hide();
			$("#imageHiddenBtn").show();
		}
		
		function imageHidden() {
			$("#hiddenImage").slideUp(400);
			$("#imageShowBtn").show();
			$("#imageHiddenBtn").hide();
		}
	</script>
</head>
<body class="w3-light-grey">
<!-- Top container -->
<jsp:include page="/WEB-INF/views/include/admin_nav.jsp" />
<jsp:include page="/WEB-INF/views/include/admin_sidebarMenu.jsp" />

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:300px;margin-top:43px;">

    <!-- Header -->
	<header class="w3-container" style="padding-top:22px;">
		<p style="margin-top:20px; font-size:23px;">상품정보 조회</p>
	</header>
 	
 	<!-- content  -->
 	<div class="w3-row-padding w3-margin-bottom">
		<form name="myForm" method="post" class="was-validated mt-3" enctype="multipart/form-data" onsubmit="return itemInsert();">
 		<div class="w3-col s11">
 			<div class="box w3-border">
				<div class="w3-white w3-padding">
				    	<div class="form-group">
				    		<label for="user_id">카테고리 </label>
				    			<div>
				    				<b>대분류</b> | ${itemVO.category_group_name}&nbsp;&nbsp; 
				    				<c:if test="${itemVO.category_name == 'NO'}">
				    					<b>중분류</b> | 없음	
				    				</c:if>
				    				<c:if test="${itemVO.category_name != 'NO'}">
				    					<b>중분류</b> | ${itemVO.category_name} 
				    				</c:if>
				    			</div>
				    	</div>
				    	<div class="form-group">
				    		<label for="item_name">상품명 </label>
				      		<div class="input-group mb-3">
				    			<input class="input w3-padding-16 w3-border form-control" id="item_name" name="item_name" type="text" value="${itemVO.item_name}" readonly>
				    		</div>
						    <div id="pwdDemo"></div>
				    	</div>
				    	<div class="form-group">
				    		<label for="item_summary">상품 간단 설명 </label>
				      		<div class="input-group mb-3">
				    			<input class="input w3-padding-16 w3-border form-control" id="item_summary" name="item_summary" type="text" value="${itemVO.item_summary}" readonly>
				    		</div>
				    	</div><hr>
				    	<div class="form-group">
					      <label for="display_flag">전시상태&nbsp; : &nbsp;</label>
					    <!--   <div class="form-check-inline">
				        	<div class="form-check"> -->
				        		<c:if test="${itemVO.display_flag == 'y'}">
				        			전시 중
				        		</c:if>
				        		<c:if test="${itemVO.display_flag == 'n'}">
				        			전시 중지
				        		</c:if>
							    <%-- <input type="radio" class="display_flag" name="display_flag" value="y" ${itemVO.display_flag == 'y' ? 'checked' : ''}>&nbsp;&nbsp;전시&nbsp;&nbsp;&nbsp;
							    <input type="radio" class="display_flag" name="display_flag" value="n" ${itemVO.display_flag == 'n' ? 'checked' : ''}>&nbsp;&nbsp;전시중지 --%>
							<!-- </div>
						  </div> -->
					  	</div>
					  	 <div class="w3-light-gray p-4">
						  	<div style="font-size:20px;">판매가</div><br>
						  	<div class="w3-row">
						  		<div class="w3-third">
						    	<div class="form-group">
							      <label for="sale_price">판매가 </label>
							      <div class="input-group mb-3" style="margin-bottom:0px">
						    			<input class="input w3-padding-16 w3-border form-control" id="sale_price" name="sale_price" type="number" onchange="minValueCheck1()" value="${itemVO.sale_price}" min="0" onkeydown="javascript: return event.keyCode == 69 ? false : true" readonly>
						    			<div class="input-group-append">
									      	<input type="button" value="원" size="2" class="btn w3-black" disabled='disabled' />
									    </div>
					    		  </div>
						        </div>
						        </div>
						        <div class="w3-third"></div>
						        <div class="w3-third"></div>
					        </div>
					       <div class="form-group">
						      <label for="seller_discount_flag">할인&nbsp; : &nbsp;</label>
						      <!-- <div class="form-check-inline">
					        	<div class="form-check"> -->
								    <c:if test="${itemVO.seller_discount_flag == 'y'}">
					        			할인 설정 적용 중
					        		</c:if>
					        		<c:if test="${itemVO.seller_discount_flag == 'n'}">
					        			할인 설정 안함
					        		</c:if>
								    <!-- <input type="radio" class="seller_discount_flag" name="seller_discount_flag" value="y" onkeypress="seller_discount_flag()">&nbsp;&nbsp;설정&nbsp;&nbsp;&nbsp;
								    <input type="radio" class="seller_discount_flag" name="seller_discount_flag" value="n" checked>&nbsp;&nbsp;설정안함 -->
								<!-- </div>
							  </div> -->
						  	</div>
						  	<div id="seller_discount_flagForm" ${itemVO.seller_discount_flag == 'n' ? 'style="display:none"' : ''}>
							  	<div class="w3-row">
							  		<div class="w3-third">
							    	<div class="form-group">
								      <label for="seller_discount_amount">할인금액 </label>
								      <div class="input-group mb-3" style="margin-bottom:0px">
							    			<input class="input w3-padding-16 w3-border form-control" id="seller_discount_amount" min="0" name="seller_discount_amount" type="number" onchange="calPrice()" value="${itemVO.seller_discount_amount}" onkeydown="javascript: return event.keyCode == 69 ? false : true" readonly>
							    			<div class="input-group-append">
										      	<input type="button" value="원" size="2" class="btn w3-black" disabled='disabled' />
										    </div>
						    		  </div>
							        </div>
							        </div>
							        <div class="w3-third"></div>
							        <div class="w3-third"></div>
						        </div>
						         <div style="font-weight:bold;">
						        	<span>최종 판매가&nbsp;:&nbsp;</span>
						        	<c:set var="calPriceFmt" value="${itemVO.sale_price - itemVO.seller_discount_amount}"/>
						        	<span><fmt:formatNumber value="${calPriceFmt}"/>원</span>
						        </div>
					        </div>
					    </div><hr>
					    <div class="form-group">
					      <label for="seller_point_flag">포인트 지급&nbsp; : &nbsp; </label>
				      		  <c:if test="${itemVO.seller_point_flag == 'y'}">
			        				지급
			        		  </c:if>
			        		  <c:if test="${itemVO.seller_point_flag == 'n'}">
			        				미지급
			        		  </c:if>
					     <!--  <div class="form-check-inline">
				        	<div class="form-check">
							    <input type="radio" class="seller_point_flag" name="seller_point_flag" value="y">&nbsp;&nbsp;지급&nbsp;&nbsp;&nbsp;
							    <input type="radio" class="seller_point_flag" name="seller_point_flag" value="n" checked>&nbsp;&nbsp;미지급
							</div>
						  </div> -->
					  	</div>
					    <div id="seller_pointForm" class="w3-row" ${itemVO.seller_point_flag == 'n' ? 'style="display:none"' : ''}>
					  		<div class="w3-third">
					    	<div class="form-group">
						      <label for="seller_point">지급 포인트 </label>
						      <div class="input-group mb-3" style="margin-bottom:0px">
					    			<input class="input w3-padding-16 w3-border form-control" id="seller_point" min="0" name="seller_point" onchange="minValueCheck2()" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true" value="${itemVO.seller_point}" readonly>
					    			<div class="input-group-append">
								      	<input type="button" value="Point" size="2" class="btn w3-black" disabled='disabled' />
								    </div>
				    		  </div>
					        </div>
					        </div>
					        <div class="w3-third"></div>
					        <div class="w3-third"></div>
				        </div><hr>
					    <div class="w3-row">
					  		<div class="w3-third">
						    	<div class="form-group">
							      <label for="stock_quantity">재고수량 <br>(옵션재고수량 입력시, 자동계산되어 등록됩니다.)</label>
							      <div class="input-group mb-3">
						    			<input class="input w3-padding-16 w3-border form-control" id="stock_quantity" min="0" name="stock_quantity" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true" onchange="stock_quantityForm()" value="${itemVO.stock_quantity}" readonly>
						    			<div class="input-group-append">
									      	<input type="button" value="개" size="2" class="btn w3-black" disabled='disabled' />
									    </div>
					    		  </div>
						        </div>
					        </div>
					        <div class="w3-third" id="schedule_date" ${itemVO.sold_out == 0 ? 'style="display:none"' : ''}>
					        	<div class="form-group">
							      <label for="stock_schedule_date">재입고 예정일자 <br>&nbsp;</label>
							      <div class="input-group mb-3">
						    			<input class="w3-input" id="stock_schedule_date" name="stock_schedule_date" type="text" value="${itemVO.stock_schedule_date}" readonly>
					    		  </div>
					        	</div>
					        </div>
					        <div class="w3-third"></div>
				        </div><hr>
					   <div class="w3-row">
					  		<div class="w3-third">
					    		<div class="form-group">
							      <label for="order_min_quantity">최소 주문 수량 </label>
							      <div class="input-group mb-3" style="margin-bottom:0px">
						    			<input class="input w3-padding-16 w3-border form-control" min="1" id="order_min_quantity" value="${itemVO.order_min_quantity}" onchange="minValueCheck3()" name="order_min_quantity" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true" placeholder="숫자만 입력" readonly>
						    			<div class="input-group-append">
									      	<input type="button" value="개" size="2" class="btn w3-black" disabled='disabled' />
									    </div>
					    		  </div>
						        </div>
					        </div>
					        <div class="w3-third" style="padding-left: 20px;">
					        	<div class="form-group" style="display:none">
							      <label for="order_max_quantity">최대 주문 수량 </label>
							      <div class="input-group mb-3" style="margin-bottom:0px">
						    			<input class="input w3-padding-16 w3-border form-control" min="1" id="order_max_quantity" value="${itemVO.order_max_quantity}" onchange="minValueCheck4()" name="order_max_quantity" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true" placeholder="숫자만 입력" readonly>
						    			<div class="input-group-append">
									      	<input type="button" value="개" size="2" class="btn w3-black" disabled='disabled' />
									    </div>
					    		  </div>
						        </div>
					        </div>
					        <div class="w3-third"></div>
				        </div>
					  <p><br></p>
				</div>
 			</div>
 		 	<div class="box w3-border" style="margin-top: 20px;">
				<div class="w3-white w3-padding">
					  	<div class="w3-light-gray p-4">
					  		<div class="form-group" style="margin-bottom: 15px;">
							  	<label for="item_option_flag" style="font-size:20px;">옵션 &nbsp; : &nbsp;</label>
							  	<c:if test="${itemVO.item_option_flag == 'y'}">
			        				사용
				        		</c:if>
				        		<c:if test="${itemVO.item_option_flag == 'n'}">
				        		    사용안함
				        		</c:if>
							  	<!-- <div class="form-check-inline">
						        	<div class="form-check">
									    <input type="radio" class="item_option_flag" name="item_option_flag" value="y">&nbsp;&nbsp;사용&nbsp;&nbsp;&nbsp;
									    <input type="radio" class="item_option_flag" name="item_option_flag" value="n" checked>&nbsp;&nbsp;사용안함
									</div>
								  </div> -->
							 </div>
							<div id="item_option_flagForm" ${itemVO.item_option_flag == 'n' ? 'style="display:none"' : ''}>
							  	<div class="w3-row">
							    	<div class="form-group">
								      <table class="w3-table w3-striped w3-bordered">
								      	<tr>
								      		<th>
								      		</th>
								      		<th>옵션명</th>
								      		<th>추가금액</th>
								      		<th>재고수량</th>
								      		<!-- <th></th> -->
								      	</tr>
								      	<c:forEach var="vo" items="${itemVO.itemOptionList}" varStatus="st">
								      	<tr>
								      		<td>
								      			${st.count}
								      		</td>
								      		<td>
								      			<input class="input w3-padding-16 w3-border form-control" value="${vo.option_name}" name="option_names" type="text" placeholder="옵션 이름" readonly>
								      		</td>
								      		<td>
								      			<input class="input w3-padding-16 w3-border form-control" value="${vo.option_price}" onchange="optionPriceCheck(1)" min="0" id="option_price1" name="option_prices" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true" placeholder="옵션 추가금액" readonly>
								      		</td>
								      		<td>
								      			<input class="input w3-padding-16 w3-border form-control" value="${vo.option_stock_quantity}" onchange="optionStockCheck(1)" min="0" id="option_stock_quantity1" name="option_stock_quantities" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true" placeholder="재고수량" readonly>
								      		</td>
								      		<!-- <td width="5%">
								      		</td> -->
								      	</tr>
								      	</c:forEach>
								      </table>
								      <table class="w3-table w3-striped w3-bordered" id="addOption">
								      	
								      </table>
							        </div>
						        </div>
					        </div>
					    </div><hr>
				  		<div class="form-group" style="margin-bottom: 15px;">
						  	<label for="item_image" style="font-size:20px;">상품 이미지 </label>
						 </div>
					  	<div class="w3-row">
					    	<div class="w3-third">
					    		<div style="margin-bottom:10px;">대표 이미지 </div>
					    		<!-- <a onclick="javascript:$('#myphoto').click(); return false;" style="background-color: white"> -->
						    		<div id="addImageBtn">
						    			<div><img src="${ctp}/data/item/${itemVO.item_image}" width="300px;"></div>
						    		</div>
						    		<div id='previewId'></div>
					    	<!-- 	</a> -->
				    		<!-- 	<input type="button" id="photoDelete" value="삭제" class="w3-btn w3-2020-orange-peel w3-padding-small w3-small" style="display:none; margin-top:5px; margin-left:6px;" onclick="previewDelete()"/>
				    			<input type="file" name="file" id="myphoto" onchange="previewImage(this,'previewId')" class="form-control input" accept=".png, .jpg, .jpeg, .jfif, .gif" hidden="true"> -->
					        </div>
					        <div class="w3-third"></div>
					        <div class="w3-third"></div>
				        </div><br>
				        <div class="w3-row">
				        	<div class="w3-half mb-3">
				        		<div>
				        			<label for="seller_point_flag" style="margin-left:5px; margin-right: 10px;">추가 이미지 &nbsp;<i class="fa-solid fa-circle-right"></i></label>
				        			<input type="button" value="추가 이미지 조회" onclick="imageShow()" class="w3-btn w3-small w3-lime" id="imageShowBtn"/>
				        			<input type="button" value="닫기" onclick="imageHidden()" class="w3-btn w3-small w3-2020-orange-peel" id="imageHiddenBtn" style="display:none"/>
			        			</div>
				        	</div>
				        	<div class="w3-half"></div>
			        	</div>
			        	<div class="w3-row" id="hiddenImage" style="display:none">
		        			<c:forEach var="vo" items="${itemVO.itemImageList}">
				        		<div class="w3-third text-center">
				        			<c:if test="${itemVO.item_image != vo.image_name}">
			        					<div><img src="${ctp}/data/item/${vo.image_name}" width="300px;" class="mb-4"></div>
			        				</c:if>
				        		</div>
		        			</c:forEach>
			        	</div>
					    <hr>
					    <div class="form-group">
					      <label for="detail_content" style="font-size:20px;">상품상세설명 &nbsp;<i class="fa-solid fa-circle-right"></i> &nbsp;
						  	<input type="button" value="상세설명 보기" onclick="document.getElementById('id01').style.display='block'" class="w3-btn w3-small w3-2020-orange-peel"/>
					      </label>
					  	</div>

						  <div id="id01" class="w3-modal">
						    <div class="w3-modal-content w3-animate-opacity">
						      <header class="w3-container w3-2020-orange-peel"> 
						        <span onclick="document.getElementById('id01').style.display='none'" class="w3-button w3-hover-yellow w3-display-topright"><i class="fa-solid fa-x"></i></span>
						        <h2>상품 상세 설명</h2>
						      </header>
						      <div style="overflow:hidden;">
						      	${itemVO.detail_content}
						      </div>
						    </div>
						  </div>
			        </div>
			</div>
			<div class="box w3-border" style="margin-top: 20px;">
				<div class="w3-white w3-padding">
					  	<div style="font-size:20px;">상품 주요 정보</div><br>
					  	<div class="w3-row">
					  		<div class="w3-third">
					    	<div class="form-group">
						      <div class="mb-3">
					    			<label for="brand" style="margin-left:5px;">브랜드 : </label>
					    			<input class="w3-input w3-2020-brilliant-white" id="brand" value="${itemVO.brand}" name="brand" type="text" readonly>
				    		  </div>
					        </div>
					        </div>
					        <div class="w3-third"></div>
					        <div class="w3-third"></div>
				        </div>
					  	<div class="w3-row">
					  		<div class="w3-third">
						    	<div class="form-group">
							      <div class="mb-3">
						    			<label for="form" style="margin-left:5px;">형태 : </label>
						    			<input class="w3-input w3-2020-brilliant-white" id="form" value="${itemVO.form}" name="form" type="text" readonly>
					    		  </div>
						        </div>
					        </div>
					        <div class="w3-third" style="margin-left: 20px">
					        	<div class="form-group">
							      <div class="mb-3">
						    			<label for="origin_country" style="margin-left:5px;">원산지 : </label>
						    			<input class="w3-input w3-2020-brilliant-white" id="origin_country" value="${itemVO.origin_country}" name="origin_country" type="text" readonly>
					    		  </div>
					        	</div>
					        </div>
					        <div class="w3-third"></div>
				        </div>
					  	<div class="w3-row">
					  		<div class="w3-third">
						    	<div class="form-group">
							      <div class="mb-3">
						    			<label for="item_model_name" style="margin-left:5px;">모델명 : </label>
						    			<input class="w3-input w3-2020-brilliant-white" id="item_model_name" value="${itemVO.item_model_name}" name="item_model_name" type="text" readonly>
					    		  </div>
						        </div>
					        </div>
					        <div class="w3-third" style="margin-left: 20px">
					        	<div class="form-group">
							      <div class="mb-3">
						    			<label for="after_service" style="margin-left:5px;">A/S안내 : </label>
						    			<input class="w3-input w3-2020-brilliant-white" id="after_service" value="${itemVO.after_service}" name="after_service" type="text" readonly>
					    		  </div>
					        	</div>
					        </div>
					        <div class="w3-third"></div>
				        </div><hr>
					  	<div class="w3-row">
					  		<div class="w3-third">
							<div><span  style="font-size:20px;">상품 정보 고시</span></div>
							 - 기타 재화 -<br><br>
					    	<div class="form-group">
						      <div class="mb-3">
					    			<label for="notice_title1" style="margin-left:5px;">품명/모델명 : </label>
					    			<input class="w3-input w3-2020-brilliant-white" id="notice_value1" value="${itemVO.notice_value1}" name="notice_value1" type="text" readonly>
				    		  </div>
					        </div>
					        </div>
					        <div class="w3-third">
					        	<input type="checkbox" id="noticeAllInput" name="noticeAllInput"> 상품상세 참조로 전체 입력
					        </div>
					        <div class="w3-third"></div>
				        </div>
					  	<div class="w3-row">
					  		<div class="w3-half">
						    	<div class="form-group">
							      <div class="mb-3">
						    			<label for="notice_title2" style="margin-left:5px;">법에 의한 인증, 허가 등을 받았음을 확인할 수 있는 경우 그에 대한 사항 : </label>
						    			<input class="w3-input w3-2020-brilliant-white" id="notice_value2" value="${itemVO.notice_value2}" name="notice_value2" type="text" readonly>
					    		  </div>
						        </div>
					        </div>
					        <div class="w3-half"></div>
				        </div>
					  	<div class="w3-row">
					  		<div class="w3-third">
						    	<div class="form-group">
							      <div class="mb-3">
						    			<label for="notice_title3" style="margin-left:5px;">제조자(사) : </label>
						    			<input class="w3-input w3-2020-brilliant-white" id="notice_value3" value="${itemVO.notice_value3}" name="notice_value3" type="text" readonly>
					    		  </div>
						        </div>
					        </div>
					        <div class="w3-third" style="margin-left: 20px">
					        	<div class="form-group">
							      <div class="mb-3">
						    			<label for="notice_title4" style="margin-left:5px;">제조국 : </label>
						    			<input class="w3-input w3-2020-brilliant-white" id="notice_value4" value="${itemVO.notice_value4}" name="notice_value4" type="text" readonly>
					    		  </div>
					        	</div>
					        </div>
					        <div class="w3-third"></div>
				        </div>
				        <div class="w3-row">
					  		<div class="w3-third">
					    	<div class="form-group">
						      <div class="mb-3">
					    			<label for="notice_title5" style="margin-left:5px;">소비자상담 관련 전화번호 : </label>
					    			<input class="w3-input w3-2020-brilliant-white" id="notice_value5" value="${itemVO.notice_value5}" name="notice_value5" type="text" readonly>
				    		  </div>
					        </div>
					        </div>
					        <div class="w3-third"></div>
					        <div class="w3-third"></div>
				        </div>
				</div>
 			</div>
			
			<div class="box w3-border" style="margin-top: 20px;">
				<div class="w3-white w3-padding">
	 				<!-- <div class="w3-light-gray p-4">
				    	<div style="font-size:20px;">배송</div> -->
				    	<%-- <div class="form-group">
					      <label for="shipment_type_flag">배송비 구분 &nbsp; :  &nbsp;</label>
					      <c:if test="${itemVO.shipment_type == 1}">
		        				무료배송
			        		</c:if>
			        		<c:if test="${itemVO.shipment_type == 2}">
			        		    판매자 조건부
			        	  </c:if> --%>
					      <!-- <div class="form-check-inline">
				        	<div class="form-check">
							    <input type="radio" class="shipment_type" name="shipment_type" value="2" checked>&nbsp;&nbsp;판매자 조건부&nbsp;&nbsp;&nbsp;
							    <input type="radio" class="shipment_type" name="shipment_type" value="1">&nbsp;&nbsp;무료배송
							</div>
						  </div> -->
					  	<%-- </div>
					  	<div id="shipmentPriceFrom" ${itemVO.shipment_type == 1 ? 'style="display:none"' : ''}>
						  	<div class="w3-row">
						  		<div class="w3-third">
						    	<div class="form-group">
							      <label for="shipping_price">배송비 </label>
							      <div class="input-group mb-3" style="margin-bottom:0px">
						    			<input class="input w3-padding-16 w3-border form-control" value="${itemVO.shipping_price}" id="shipping_price" name="shipping_price" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true" placeholder="숫자만 입력" readonly>
						    			<div class="input-group-append">
									      	<input type="button" value="원" size="2" class="btn w3-black" disabled='disabled' />
									    </div>
					    		  </div>
						        </div>
						        </div>
						        <div class="w3-third"></div>
						        <div class="w3-third"></div>
					        </div>
						  	<div class="w3-row">
						  		<div class="w3-third">
						    	<div class="form-group">
							      <label for="shipping_free_amount">조건부 무료배송 금액 </label>
							      <div class="input-group mb-3" style="margin-bottom:0px">
						    			<input class="input w3-padding-16 w3-border form-control" value="${itemVO.shipping_free_amount}" id="shipping_free_amount" name="shipping_free_amount" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true" placeholder="숫자만 입력" readonly>
						    			<div class="input-group-append">
									      	<input type="button" value="원" size="2" class="btn w3-black" disabled='disabled' />
									    </div>
					    		  </div>
						        </div>
						        </div>
						        <div class="w3-third"></div>
						        <div class="w3-third"></div>
					        </div> --%>
					        <br>
					        <div class="w3-row" style="display:none">
						  		<div class="w3-third">
						    	<div class="form-group">
							      <label for="shipping_extra_charge">제주도 추가 배송비 </label>
							      <div class="input-group mb-3" style="margin-bottom:0px">
						    			<input class="input w3-padding-16 w3-border form-control" value="${itemVO.shipping_extra_charge}" id="shipping_extra_charge" name="shipping_extra_charge" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true" placeholder="숫자만 입력" readonly>
						    			<div class="input-group-append">
									      	<input type="button" value="원" size="2" class="btn w3-black" disabled='disabled' />
									    </div>
					    		  </div>
						        </div>
						        </div>
						        <div class="w3-third"></div>
						        <div class="w3-third"></div>
					        </div>
					        <div class="form-group">
						      <label for="item_return_flag">반품 가능여부 &nbsp; : &nbsp;</label>
						      <c:if test="${itemVO.item_return_flag == 'y'}">
			        				가능
				        		</c:if>
				        		<c:if test="${itemVO.item_return_flag == 'n'}">
				        		    불가능
				        	  </c:if>
						     <!--  <div class="form-check-inline">
					        	<div class="form-check">
								    <input type="radio" class="item_return_flag" name="item_return_flag" value="y" checked>&nbsp;&nbsp;가능&nbsp;&nbsp;&nbsp;
								    <input type="radio" class="item_return_flag" name="item_return_flag" value="n">&nbsp;&nbsp;불가능
								</div>
							  </div> -->
					  	<div class="w3-row">
					  		<div class="w3-third">
					    	<div class="form-group">
						      <label for="shipping_return_price">교환/반품 배송비(편도기준) </label>
						      <div class="input-group mb-3" style="margin-bottom:0px">
					    			<input class="input w3-padding-16 w3-border form-control" value="${itemVO.shipping_return_price}" id="shipping_return_price" name="shipping_return_price" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true" placeholder="숫자만 입력" readonly>
					    			<div class="input-group-append">
								      	<input type="button" value="원" size="2" class="btn w3-black" disabled='disabled' />
								    </div>
				    		  </div>
					        </div>
					        </div>
					        <div class="w3-third"></div>
					        <div class="w3-third"></div>
				        </div><hr>
				        <div class="w3-row">
				        	<div class="w3-half">
						        <div class="form-group">
						          <c:set var="shipment_address" value="${fn:split(itemVO.shipment_address,'/')}"/>
							      <label for="shipment_address">출고지 </label><br>
									<div class="input-group mb-1">
										<input type="text" name="shipment_postcode" value="${shipment_address[0]}" id="sample6_postcode1" placeholder="우편번호" class="form-control w3-border" readonly>
									</div>
									<input type="text" name="shipment_roadAddress" value="${shipment_address[1]}" id="sample6_address1" size="50" placeholder="주소" class="form-control mb-1 w3-border" readonly>
									<div class="input-group mb-1">
										<input type="text" name="shipment_detailAddress" value="${shipment_address[2]}" id="sample6_detailAddress1" placeholder="상세주소" class="form-control w3-border" readonly> &nbsp;&nbsp;
										<div class="input-group-append">
											<input type="text" name="shipment_extraAddress" value="${shipment_address[3]}" id="sample6_extraAddress1" placeholder="참고항목" class="form-control w3-border" readonly>
										</div>
									</div>
							   </div>
						   </div>
						   <div class="w3-half"></div>
						</div>
				        <div class="w3-row">
				        	<div class="w3-half">
						        <div class="form-group">
						        <c:set var="shipment_return_address" value="${fn:split(itemVO.shipment_return_address,'/')}"/>
							      <label for="shipment_return_address">반송지 </label><br>
									<div class="input-group mb-1">
										<input type="text" name="shipment_return_postcode" value="${shipment_return_address[0]}" id="sample6_postcode2" placeholder="우편번호" class="form-control w3-border" readonly>
									</div>
									<input type="text" name="shipment_return_roadAddress" value="${shipment_return_address[1]}" id="sample6_address2" size="50" placeholder="주소" class="form-control mb-1 w3-border" readonly>
									<div class="input-group mb-1">
										<input type="text" name="shipment_return_detailAddress" value="${shipment_return_address[2]}" id="sample6_detailAddress2" placeholder="상세주소" class="form-control w3-border" readonly> &nbsp;&nbsp;
										<div class="input-group-append">
											<input type="text" name="shipment_return_extraAddress" value="${shipment_return_address[3]}" id="sample6_extraAddress2" placeholder="참고항목" class="form-control w3-border" readonly>
										</div>
									</div>
							   </div>
						   </div>
						   <div class="w3-half"></div>
						</div>
			        </div><hr>
					  	<div style="font-size:20px;">상품 대표 키워드</div><br>
					  	<c:set var="keywords" value="${fn:split(itemVO.item_keyword,'/')}" />
					  	<div class="w3-row">
					  		<div class="w3-third">
					    	<div class="form-group">
						      <div class="mb-3">
					    			<label for="keyword1" style="margin-left:5px;">키워드1 : </label>
					    			<input class="input form-control" value="${keywords[0]}" id="keyword1" name="keyword" type="text" readonly>
				    		  </div>
					        </div>
					        </div>
					        <div class="w3-third"></div>
					        <div class="w3-third"></div>
				        </div>
					  	<div class="w3-row">
					  		<div class="w3-third">
						    	<div class="form-group">
							      <div class="mb-3">
						    			<label for="keyword2" style="margin-left:5px;">키워드2 : </label>
						    			<input class="input form-control" value="${keywords[1]}" id="keyword2" name="keyword" type="text" readonly>
					    		  </div>
						        </div>
					        </div>
					        <div class="w3-third" style="margin-left: 20px">
					        	<div class="form-group">
							      <div class="mb-3">
						    			<label for="keyword4" style="margin-left:5px;">키워드4 : </label>
						    			<input class="input form-control" value="${keywords[3]}" id="keyword4" name="keyword" type="text" readonly>
					    		  </div>
					        	</div>
					        </div>
					        <div class="w3-third"></div>
				        </div>
					  	<div class="w3-row">
					  		<div class="w3-third">
						    	<div class="form-group">
							      <div class="mb-3">
						    			<label for="keyword3" style="margin-left:5px;">키워드3 : </label>
						    			<input class="input form-control" value="${keywords[2]}" id="keyword3" name="keyword" type="text" readonly>
					    		  </div>
						        </div>
					        </div>
					        <div class="w3-third" style="margin-left: 20px">
					        	<div class="form-group">
							      <div class="mb-3">
						    			<label for="keyword5" style="margin-left:5px;">키워드5 : </label>
						    			<input class="input form-control" value="${keywords[4]}" id="keyword5" name="keyword" type="text" readonly>
					    		  </div>
					        	</div>
					        </div>
					        <div class="w3-third"></div>
				        </div><hr>
					    <div>
					    	<p style="text-align: center;">
					    		<a href="${ctp}/admin/item/itemList" class="w3-btn w3-2019-brown-granite">돌아가기</a>
					    		<a href="${ctp}/admin/item/itemUpdate?item_code=${itemVO.item_code}" class="w3-btn w3-2021-desert-mist">수정하기</a>
					    	</p>
					    </div>
					</div>
	 			</div>
			</div>
 		<div class="w3-col s1"></div>
    </form>
	</div>
</div>
</body>
</html>