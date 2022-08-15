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
.box {
  	box-shadow: 0 4px 5px rgba(0, 0, 0, 0.6);
}
div, ul, li {-webkit-box-sizing: border-box;-moz-box-sizing: border-box;box-sizing: border-box;padding:0;margin:0}
a {text-decoration:none;}

.quickmenu {position:absolute; top:50%;margin-top:-50px;background:#fff; margin-left:50px;}
/* .quickmenu ul {position:relative;float:left;width:100%;display:inline-block;*display:inline;border:1px solid #ddd;}
.quickmenu ul li {float:left;width:100%;border-bottom:1px solid #ddd;text-align:center;display:inline-block;*display:inline;}
.quickmenu ul li a {position:relative;float:left;width:100%;height:30px;line-height:30px;text-align:center;color:#999;font-size:9.5pt;}
.quickmenu ul li a:hover {color:#000;}
.quickmenu ul li:last-child {border-bottom:0;} */

.content {position:relative;min-height:1000px;}

.total_price {
	font-size: 20px;
	font-weight: bold;
	margin: 20px;
}


#sub2 {
	display: none;
}

@media screen and (max-width:1200px) { 
 	.quickmenu {
 		display: none;
 	}
 	#sub2 {
		display: block;
	}
}
</style>
<script>
	let item_idx = [];
	let item_name = [];
	let item_image = [];
	let item_price = [];
	let item_option_flag = [];
	let option_idx = [];
	let option_name = [];
	let option_price = [];
	let quantity = [];
	let cart_idx = [];

	$(document).ready(function(){
	  var currentPosition = parseInt($(".quickmenu").css("top"));
	  $(window).scroll(function() {
	    var position = $(window).scrollTop(); 
	    $(".quickmenu").stop().animate({"top":position+currentPosition+"px"},1000);
	  });
	});
	function checkAll(check) {
		$("input[name=check_item]").prop("checked", check);
		calcTotalPrice(check);
	}
	
	function calcTotalPrice(check) {
		let total = 0;
		$("[data-price]").each(function() {
			const isItemAvailable = !$(this).data('available');
			if (isItemAvailable === true) {
				total += $(this).data('price');
			}
		});
		
		let i = 0;
		while(item_idx.length > 0) {
			item_idx.pop();
			item_name.pop();
			item_image.pop();
			item_price.pop();
			item_option_flag.pop();
			option_idx.pop();
			option_name.pop();
			option_price.pop();
			quantity.pop();
		}
		
		$("input[name=check_item]:checked").each(function() {
			const idx = $(this).data('idx');
			const price = $("#section_" + idx).find(".data_holder").data('price');
			item_idx[i] = $("#section_" + idx).find("#item_idx").val();
			item_name[i] = $("#section_" + idx).find("#item_name").val();
			item_image[i] = $("#section_" + idx).find("#item_image").val();
			item_price[i] = price;
			item_option_flag[i] = $("#section_" + idx).find("#item_option_flag").val();
			option_idx[i] = $("#section_" + idx).find("#option_idx").val();
			option_name[i] = $("#section_" + idx).find("#option_name").val();
			option_price[i] = $("#section_" + idx).find("#option_price").val();
			quantity[i] = $("#section_" + idx).find("#quantity").val();
			cart_idx[i] = $("#section_" + idx).find("#cart_idx").val();
			i++;
		});
		
		const result = check? total : 0;
		const total_price = Math.floor(result).toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
		$(".total_price").html(total_price + "원");
		$(".total_price").attr("data-total", result);
		$(".total_price").data("total", result);
		$("input[name=order_total_amount]").val(result);
		
	}
	
	function calcSelected(cartIdx) {
		let total = 0;
		let i = 0;
		while(item_idx.length > 0) {
			item_idx.pop();
			item_name.pop();
			item_image.pop();
			item_price.pop();
			item_option_flag.pop();
			option_idx.pop();
			option_name.pop();
			option_price.pop();
			quantity.pop();
		}
		
		$("input[name=check_item]:checked").each(function() {
			const idx = $(this).data('idx');
			const price = $("#section_" + idx).find(".data_holder").data('price');
			total += price;
			item_idx[i] = $("#section_" + idx).find("#item_idx").val();
			item_name[i] = $("#section_" + idx).find("#item_name").val();
			item_image[i] = $("#section_" + idx).find("#item_image").val();
			item_price[i] = price;
			item_option_flag[i] = $("#section_" + idx).find("#item_option_flag").val();
			option_idx[i] = $("#section_" + idx).find("#option_idx").val();
			option_name[i] = $("#section_" + idx).find("#option_name").val();
			option_price[i] = $("#section_" + idx).find("#option_price").val();
			quantity[i] = $("#section_" + idx).find("#quantity").val();
			cart_idx[i] = $("#section_" + idx).find("#cart_idx").val();
			i++;
		});
		const total_price = Math.floor(total).toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
		$(".total_price").html(total_price + "원");
		$(".total_price").attr("data-total", total);
		$(".total_price").data("total", total);
		$("input[name=order_total_amount]").val(total);
	}
	
	function myFunction(x) {
	  if (x.matches) { // If media query matches
		  $("#main").removeClass("w3-col");
		  $("#sub").removeClass("w3-col");
		  
	  } else {
		  $("#main").addClass("w3-col");
		  $("#sub").addClass("w3-col");
	  }
	}

	var x = window.matchMedia("(max-width: 1200px)")
	myFunction(x) // Call listener function at run time
	x.addListener(myFunction) // Attach listener function on state changes
	
	function minus(cartIdx, min_quantity, quantity) {
		
		let calQuantity = Number(quantity) - 1;
		
		if(calQuantity < min_quantity) {
			alert("해당 상품의 최소 구매 수량은 "+min_quantity+"개 입니다.");
			return false;
		}
		
		$.ajax({
			type : "post",
			url : "${ctp}/cart/cartMinus",
			data : {cartIdx : cartIdx},
			success : function(data) {
				if(data == '1') {
					location.reload();
				}
				else {
					alert("수량 조정 실패.");
				}
			},
			error : function() {
				alert("전송오류.");	
			}
		});
	}
	
	function plus(cartIdx) {
		$.ajax({
			type : "post",
			url : "${ctp}/cart/cartPlus",
			data : {cartIdx : cartIdx},
			success : function(data) {
				if(data == '1') {
					location.reload();
				}
				else {
					alert("수량 조정 실패.");
				}
			},
			error : function() {
				alert("전송오류.");	
			}
		});
	}
	
	function cartDelete(cartIdx) {
		$.ajax({
			type : "post",
			url : "${ctp}/cart/cartDelete",
			data : {cartIdx : cartIdx},
			success : function(data) {
				if(data == '1') {
					location.reload();
				}
				else {
					alert("목록 삭제 실패. 다시 시도해주세요.");
				}
			},
			error : function() {
				alert("전송오류.");
			}
		});
	}
	
	/* 주문하기 */
	function order() {
		//주문총액
		let order_total_amount = $(".total_price").data("total");

		if(order_total_amount == 0) {
			alert("주문할 상품을 선택하세요.");
			return false;
		}
		
		cartForm.order_item_idx.value = item_idx;
		cartForm.order_item_name.value = item_name;
		cartForm.order_item_image.value = item_image;
		cartForm.order_item_price.value = item_price;
		cartForm.order_item_option_flag.value = item_option_flag;
		cartForm.order_option_idx.value = option_idx;
		cartForm.order_option_name.value = option_name;
		cartForm.order_option_price.value = option_price;
		cartForm.order_quantity.value = quantity;
		$("input[name=cart_idx]").val(cart_idx);
		
		cartForm.submit();		
	}
</script>
</head>
<body>
<!-- Nav  -->
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/header2.jsp" />

<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px" onmouseover="hoverMenuClose()">
	<div style="margin-bottom:100px; margin-left:30px; margin-right:30px;">
    	<form name="cartForm" method="get" action="${ctp}/order/orderCheck">
   		<div class="w3-row" style="padding:20px;">
   			<div class="w3-col m9 l9" id="main">
   			<div class="m-2">
   				<b style="font-size:17px;">장바구니</b> &nbsp; 
   				<i class="fa-solid fa-angle-right"></i> &nbsp; 주문/결제 &nbsp;
   				<i class="fa-solid fa-angle-right"></i> &nbsp; 완료
   			</div>
	    	<div class="w3-bottombar w3-light-grey w3-padding" style="margin-bottom: 20px;">
	    		<input type="checkbox" class="w3-check" name="check_all" onclick="checkAll(this.checked);">&nbsp;
	    		장바구니[${cartList.size()}]
	    	</div>
   			<table class="w3-table" style="font-size:17px;">
   				<c:forEach var="cartVO" items="${cartList}" varStatus="st">
   					<tr id="section_${cartVO.cart_idx}">
   						<td width="10%">
		   					<input type="checkbox" class="w3-check" id="check_${cartVO.cart_idx}" onchange="calcSelected();" data-idx="${cartVO.cart_idx}" ${cartVO.flag != cartVO.item_option_flag || cartVO.option_display_flag == 'n' || cartVO.display_flag == 'n' || cartVO.item_delete_flag == 'y' ? 'disabled="disabled"' : 'name="check_item"'} >
   						</td>
   						<td width="20%">
   							<img src="${ctp}/data/item/${cartVO.item_image}" width="150px;" ${cartVO.flag != cartVO.item_option_flag || cartVO.option_display_flag == 'n' || cartVO.display_flag == 'n' || cartVO.item_delete_flag == 'y' ? 'style="opacity:20%"' : ''}/>
   						</td>
   						<td width="25%">
   							<c:if test="${cartVO.seller_discount_flag == 'n'}">
								<c:set var="priceFmt" value="${cartVO.sale_price}"/>
					        	<div class="mt-2"><b><fmt:formatNumber value="${priceFmt}"/>원</b></div>
							</c:if>
							<c:if test="${cartVO.seller_discount_flag == 'y'}">
								<div class="w3-row mt-2"><b>
						        	<span id="discountPrice">
										<c:set var="priceFmt" value="${cartVO.sale_price}"/>
						        		<fmt:formatNumber value="${priceFmt}"/>원
						        	</span>
					        		<span>
						        		<i class="fa-solid fa-arrow-trend-down"></i>
						        		<c:set var="calPriceFmt" value="${cartVO.sale_price - cartVO.seller_discount_amount}"/>
						        		<fmt:formatNumber value="${calPriceFmt}"/>원
					        		</span><br>
					        		<span style="font-size: 13px; color:brown">
					        			<!-- (할인율) = (할인액) / (정가) X 100 -->
					        			<c:set var="calDiscountFmt" value="${(cartVO.seller_discount_amount / cartVO.sale_price) * 100}"/>
					        			(<fmt:formatNumber type="number" maxFractionDigits="0"  value="${calDiscountFmt}" />
					        			<i class="fa-solid fa-percent"></i> 할인)
					        		</span>
					        	</b></div>
							</c:if>
   						</td>
   						<td>
   							<b>${cartVO.item_name}</b><br>
	   						<c:if test="${cartVO.flag == cartVO.item_option_flag && cartVO.option_display_flag != 'n' && cartVO.display_flag != 'n' && cartVO.item_delete_flag == 'n' }">
		   						상품 주문 수량 : <span id="totalQuantity${cartVO.cart_idx}">${cartVO.quantity}</span> 개<br>
			   					<c:if test="${cartVO.item_option_flag == 'y'}">
			   						옵션 : ${cartVO.option_name} (+ <span>${cartVO.option_price}</span> x ${cartVO.quantity})
			   					</c:if>
			   					<div class="mt-3">
					   					<a onclick="minus(${cartVO.cart_idx},${cartVO.order_min_quantity},${cartVO.quantity})"><i class="fa-solid fa-square-minus" style="font-size:23px"></i></a>&nbsp;
										<a onclick="plus(${cartVO.cart_idx})"><i class="fa-solid fa-square-plus" style="font-size:23px"></i></a>
								</div>
							</c:if>
							<c:set var="isItemAvailable" value="${cartVO.flag != cartVO.item_option_flag || cartVO.option_display_flag == 'n' || cartVO.display_flag == 'n' || cartVO.item_delete_flag == 'y'}" />
							<c:if test="${isItemAvailable eq true}">
								<div style="color:tomato">해당 상품은 상품 정보가<br> 변경된 상품입니다.</div>						
		 					</c:if>
   						</td>
						<td>
							<b>상품 금액</b><br>
							<c:set var="addPrice" value="${cartVO.item_option_flag == 'y' ? cartVO.option_price : 0}" />
							<c:if test="${cartVO.seller_discount_flag == 'y'}">
								<b><span class="data_holder" data-price="${(calPriceFmt + addPrice) * cartVO.quantity}" data-available="${isItemAvailable}"><fmt:formatNumber value="${(calPriceFmt + addPrice) * cartVO.quantity}"/>원</span></b>
							</c:if>
							<c:if test="${cartVO.seller_discount_flag == 'n'}">
								<b><span class="data_holder" data-price="${(priceFmt + addPrice) * cartVO.quantity}" data-available="${isItemAvailable}"><fmt:formatNumber value="${(priceFmt + addPrice) * cartVO.quantity}"/>원</span></b>
							</c:if>
						</td>
						<td>
							<a onclick="cartDelete(${cartVO.cart_idx})"><i class="fa-solid fa-xmark"></i></a>
						</td>
						<input type="hidden" id="item_idx" value="${cartVO.item_idx}">
				   		<input type="hidden" id="item_name" value="${cartVO.item_name}">
				   		<input type="hidden" id="item_image" value="${cartVO.item_image}">
				   		<input type="hidden" id="item_option_flag" value="${cartVO.item_option_flag }">
				   		<c:if test="${cartVO.item_option_flag == 'y'}">
					   		<input type="hidden" id="option_idx" value="${cartVO.item_option_idx}">
					   		<input type="hidden" id="option_name" value="${cartVO.option_name}">
					   		<input type="hidden" id="option_price"  value="${cartVO.option_price}">
				   		</c:if>
				   		<c:if test="${cartVO.item_option_flag == 'n'}">
				   			<input type="hidden" id="option_name" value=" ">
					   		<input type="hidden" id="option_price"  value="0">
				   		</c:if>
				   		<input type="hidden" id="quantity" value="${cartVO.quantity}">
				   		<input type="hidden" id="cart_idx" value="${cartVO.cart_idx}">
					</tr>
   				</c:forEach>
			</table>
			</div>
			<div class="w3-col m3 l3" id="sub">
				<div>
					<div class="quickmenu">
					  <ul>
					    <li style="font-size:21px;"><b>총 선택상품 금액</b></li>
					    <li class="total_price" data-total="0"></li>
					    <li><input type="button" value="주문하기" class="w3-2021-desert-mist btn-lg" onclick="order()" style="width:100%"></li>
					  </ul>
					</div>
				</div>
			</div>
   		</div>
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
    	<div class="w3-row" style="text-align:center; margin-top: 30px;" id="sub2">
   			<hr>
    		<div style="font-size:21px;"><b>총 선택 상품 금액</b></div>
    		<div class="total_price" data-total="0"></div>
    		<div class="mb-4"><input type="button" value="주문하기" class="w3-2021-desert-mist btn-lg" style="width:50%"></div>
    	</div>
    	<c:if test="${cartList.size() == 0}">
    		<div style="margin-left:30px;">
	   			<div>
					<span class="w3-tag w3-xxxlarge w3-padding w3-2021-marigold w3-center">
					    <strong>
					    The shopping cart is empty !
					    </strong>
					</span>
	   			</div>
	   			<div class="mt-4">
					<a href="#" class="w3-btn w3-2021-mint">베스트 상품 보러가기</a>
	   			</div>
   			</div>
    	</c:if>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>