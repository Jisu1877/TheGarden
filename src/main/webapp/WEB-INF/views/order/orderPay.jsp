<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문/결제</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<link rel="icon" href="${ctp}/images/favicon.png">
<script src="${ctp}/js/orderPay.js"></script>
<script>
	/* 배송지 등록하기 */
	function deliveryInsert(flag) {
		let default_flag = '';
		if(flag == 'n') {
			default_flag = 'y';
		}
		else {
			default_flag = 'n';
		}
		
		let url = "${ctp}/delivery/deliveryInsert?flag="+default_flag;
		let winX = 700;
	    let winY = 600;
	    let x = (window.screen.width/2) - (winX/2);
	    let y = (window.screen.height/2) - (winY/2)
		window.open(url, "nWin", "width="+winX+",height="+winY+", left="+x+", top="+y+", resizable = no, scrollbars = no");
	}
	
	/* 배송지 목록 조회*/
	function deliveryList(user_idx) {
		let url = "${ctp}/delivery/deliveryList?user_idx=" + user_idx;
		let winX = 700;
	    let winY = 600;
	    let x = (window.screen.width/2) - (winX/2);
	    let y = (window.screen.height/2) - (winY/2)
		window.open(url, "nWin", "width="+winX+",height="+winY+", left="+x+", top="+y+", resizable = no, scrollbars = no");
	}
	
	
	//전액사용 버튼을 눌렀을 시..
	function PointUseAll() {
		let ownPoint = ${userVO.point};
		let payment_price = $("#total_price").data("price");
		let payment_price_cal = 0;
		let coupon_user_idx = $("select[name=couponList]").val();
		
		if(coupon_user_idx != "0") {
			let ans = confirm("포인트 할인과 쿠폰 할인 중 하나만 적용할 수 있습니다.\n포인트 적용을 선택하시겠습니까?");
			
			if(!ans) {
				return false;
			}
			else {
				$("#couponList").val("0").attr("selected", true);
			}
			
		}
		
		// 보유포인트가 결제금액보다 많으면..
		if(ownPoint > payment_price) {
			document.getElementById("point").value = payment_price;
			let point2 = document.getElementById("point").value;
				//포인트를 입력했다가 지우면..
				if(point2 == "") {
					document.getElementById("pointUse").style.display = "block";
					document.getElementById("pointUse").innerHTML = "- 0 Point";
					
					payment_price_cal = Number(payment_price) - Number(point2); 
					
					document.getElementById("priceCalc").style.display = "block";
					document.getElementById("priceCalc").innerHTML = " = "+payment_price_cal.toLocaleString() + "원";
					$(".calcPrice").attr("data-cal", payment_price_cal);
					$(".calcPrice").data("cal", payment_price_cal);
					
					return false;
				}
				//포인트 사용할시..
				document.getElementById("pointUse").style.display = "block";
				
				document.getElementById("pointUse").innerHTML = " - " + point2.toString().replace(/\B(?=(\d{3})+(?!\d))/g,',') + " Point";
				
				payment_price_cal = Number(payment_price) - Number(point2); 
				
				document.getElementById("priceCalc").style.display = "block";
				document.getElementById("priceCalc").innerHTML = payment_price_cal.toLocaleString() + "원";
				$(".calcPrice").attr("data-cal", payment_price_cal);
				$(".calcPrice").data("cal", payment_price_cal);
				
		}
		// 보유포인트가 결제금액보다 많지않으면..
		else {
			document.getElementById("point").value = ownPoint;
			let point2 = document.getElementById("point").value;
				//포인트 사용하지 않을시..
				if(point2 == "") {
					document.getElementById("pointUse").style.display = "block";
					document.getElementById("pointUse").innerHTML = "- 0 Point";
					
					payment_price_cal = Number(payment_price) - Number(point2); 
					
					document.getElementById("priceCalc").style.display = "block";
					document.getElementById("priceCalc").innerHTML = " = " + payment_price_cal.toLocaleString() + "원";	
					$(".calcPrice").attr("data-cal", payment_price_cal);
					$(".calcPrice").data("cal", payment_price_cal);
					return false;
				}
				document.getElementById("pointUse").style.display = "block";
				
				document.getElementById("pointUse").innerHTML = " - " + point2.toString().replace(/\B(?=(\d{3})+(?!\d))/g,',') + " Point";
				
				payment_price_cal = Number(payment_price) - Number(point2); 
				
				document.getElementById("priceCalc").style.display = "block";
				
				document.getElementById("priceCalc").innerHTML = " = " + payment_price_cal.toLocaleString() + "원";	
				$(".calcPrice").attr("data-cal", payment_price_cal);
				$(".calcPrice").data("cal", payment_price_cal);
				
		}
		
	}
	
	function PointUse() {
		let point = document.getElementById("point").value;
		let ownPoint = ${userVO.point};
		let payment_price = $("#total_price").data("price");
		let coupon_user_idx = $("select[name=couponList]").val();
		
		if(coupon_user_idx != "0") {
			let ans = confirm("포인트 할인과 쿠폰 할인 중 하나만 적용할 수 있습니다.\n포인트 적용을 선택하시겠습니까?");
			
			if(!ans) {
				return false;
			}
			else {
				$("#couponList").val("0").attr("selected", true);
			}
			
		}
		
		
		if(point > ownPoint) {
			alert("보유하신 포인트보다 많은 포인트를 입력하셨습니다.");
			document.getElementById("point").value = "";
			document.getElementById("point").focus();
			return false;
		}
		else if(point > payment_price) {
			alert("결제금액보다 많은 포인트를 입력하셨습니다.");
			document.getElementById("point").value = "";
			document.getElementById("point").focus();
			return false;
		}
		else if(point < 0) {
			alert("포인트는 음수값을 입력할 수 없습니다.");
			document.getElementById("point").value = "";
			document.getElementById("point").focus();
			return false;
		}
		else {
			//포인트를 사용안한다고 지우면..
			if(point == "") {
				document.getElementById("pointUse").style.display = "block";
				document.getElementById("pointUse").innerHTML = "- 0 Point";
				
				let payment_price_cal = Number(payment_price) - Number(point); 
				
				document.getElementById("priceCalc").style.display = "block";
				document.getElementById("priceCalc").innerHTML = " = "+payment_price_cal.toLocaleString() + "원";
				$(".calcPrice").attr("data-cal", payment_price_cal);
				$(".calcPrice").data("cal", payment_price_cal);
				
				return false;
			}
			else {
				document.getElementById("pointUse").style.display = "block";
				
				document.getElementById("pointUse").innerHTML = " - " + point.toString().replace(/\B(?=(\d{3})+(?!\d))/g,',') + " Point";
				
				let payment_price_cal = Number(payment_price) - Number(point); 
				
				document.getElementById("priceCalc").style.display = "block";
				
				document.getElementById("priceCalc").innerHTML = " = " + payment_price_cal.toLocaleString() + "원";	
				$(".calcPrice").attr("data-cal", payment_price_cal);
				$(".calcPrice").data("cal", payment_price_cal);
			}
		}
	}
	
	/* 결제하기  */
	function order() {
		let deliveryFlag = $("input[name=deliveryFlag]").val();
		let coupon_user_idx = $("select[name=couponList]").val();
		
		if(deliveryFlag == 'n') {
			alert("배송지를 등록한 후 결제할 수 있습니다.");
			return false;
		}
		
		let order_total_amount = $("#total_price").data("price");
		let point = document.getElementById("point").value;
		let priceCalc = 0;
		if(point != "") { // 포인트 사용 시
			priceCalc = Number($(".calcPrice").attr("data-cal"));
			$("#coupon_amount").val(0);
			$("#coupon_user_idx").val(0);
		} else if (coupon_user_idx != "0") { // 쿠폰 사용 시
			priceCalc = Number($(".calcPrice").attr("data-cal"));			
		} else { // 둘 다 사용 안 함
			$("#coupon_amount").val(0);
			$("#coupon_user_idx").val(0);
		}
		
		$("#order_total_amount").val(order_total_amount);
		$("#use_point").val(point);
		$("#order_total_amount_calc").val(priceCalc);
		
		payForm.submit();
	}
</script>
<style>
  	#total_price, #pointUse, #priceCalc {
	font-size: 20px;
	font-weight: bold;
	margin: 20px;
}
</style>
</head>
<body>
<!-- Nav  -->
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/header2.jsp" />

<!-- !PAGE CONTENT! -->
<div id="pageContent" style="max-width:1500px" onmouseover="hoverMenuClose()">
	<div style="margin-bottom:100px; margin-left:30px; margin-right:30px;">
    	<form name="payForm" method="post">
   		<div class="w3-row" style="padding:20px;">
   			<div class="m-2">
   				장바구니 &nbsp; 
   				<i class="fa-solid fa-angle-right"></i> &nbsp; <b style="font-size:17px;">주문/결제</b> &nbsp;
   				<i class="fa-solid fa-angle-right"></i> &nbsp; 완료
   			</div>
   			<div class="w3-col m7 l7">
	    	<div class="w3-bottombar w3-light-grey w3-padding" style="margin-bottom: 20px;">
	    		주문내역
	    	</div>
	    	<div style="margin-bottom: 30px;">
	    		<table class="w3-table" style="font-size:17px;">
   				<c:forEach var="orderVO" items="${orderListTemp}" varStatus="st">
   					<tr>
   						<td>
   							<b>${st.count}.</b>
   						</td>
   						<td>
   							<img src="${ctp}/data/item/${orderVO.item_image}" width="150px;"/>
   						</td>
   						<td>
   							<b>${orderVO.item_name}</b><br>
	   						상품 주문 수량 : <span>${orderVO.order_quantity}</span> 개<br>
		   					<c:if test="${orderVO.item_option_flag == 'y'}">
		   						옵션 : ${orderVO.option_name}<br>
		   					</c:if>
   						</td>
						<td>
							<b>상품 금액</b><br>
							<fmt:formatNumber value="${orderVO.item_price}"/>원</span></b>
						</td>
					</tr>
   				</c:forEach>
			</table>
		  </div>
			<hr>
			<div style="margin-top: 20px; text-align: center">
			    <div style="font-size:21px;"><b>총 결제 금액</b></div>
			    <div id="total_price" data-price="${orderVO.order_total_amount}">
			    	<fmt:formatNumber value="${orderVO.order_total_amount}"/>원 
			    </div>
		    	<div id="pointUse" style="display:none"></div> 
		    	<div id="priceCalc" class="calcPrice" data-cal="0" style="display:none; font-size:22px;"></div>
			    <div>
			    	<input type="button" value="결제하기" class="w3-2021-desert-mist btn-lg" onclick="order()" style="width:30%">
			    </div>
			</div>
			</div>
			<div class="w3-col m5 l5" id="delivery">
		    	<div class="w3-bottombar w3-2021-buttercream w3-padding" style="margin-bottom: 20px;">
		    		배송지 정보
		    	</div>
		    	<c:if test="${deliveryFlag == 'n'}">
		    	<div class="text-center" style="font-size: 17px; margin-bottom:30px;">
		    		<div class="mb-2"><i class="fa-solid fa-triangle-exclamation" style="color:orange"></i>&nbsp;등록된 배송정보 없음<br></div>
		    		<input type="button" value="배송지 등록" class="w3-2021-buttercream btn" style="width:50%" onclick="deliveryInsert('${deliveryFlag}')">
		    	</div>
		    	</c:if>
		    	<c:if test="${deliveryFlag == 'y'}">
		    		<div class="w3-padding">
	    				<div><i class="fa-solid fa-location-dot" style="margin-bottom:10px"></i>&nbsp;선택 주소(${deliveryVO.title})</div>
		    			<table class="w3-table">
		    				<tr>
		    					<td width="20%" class="text-center">수령인</td>
		    					<td>| ${deliveryVO.delivery_name}</td>
		    				</tr>
		    				<tr>
		    					<td width="20%" class="text-center">연락처</td>
		    					<td>| ${deliveryVO.delivery_tel}</td>
		    				</tr>
		    				<tr>
		    					<td width="20%" class="text-center">주소</td>
		    					<td>| (${deliveryVO.postcode})${deliveryVO.roadAddress} ${deliveryVO.detailAddress} ${deliveryVO.extraAddress}</td>
		    				</tr>
		    				<tr>
		    					<td width="20%" class="text-center">배송메세지</td>
		    					<td>| 
		    						<c:if test="${deliveryVO.message == ''}">
		    							없음
		    						</c:if>
		    						<c:if test="${deliveryVO.message != ''}">
			    						${deliveryVO.message}
		    						</c:if>
		    					</td>
		    				</tr>
		    			</table>
		    		</div>
		    		<hr>
		    		<div class="mb-3" style="text-align:center">
			    		<input type="button" value="배송지 추가" class="w3-2021-buttercream btn" style="width:40%" onclick="deliveryInsert('y')">
			    		<input type="button" value="배송지 목록" class="w3-2021-buttercream btn" style="width:40%" onclick="deliveryList(${user_idx})">
		    		</div>
		    	</c:if>
	    		<div class="w3-bottombar w3-2021-desert-mist w3-padding" style="margin-bottom: 20px;">
		    		혜택 적용
		    	</div>
		    	<div class="w3-padding" style="margin-bottom: 20px;">
    				<div><i class="fa-solid fa-won-sign"></i>&nbsp; 포인트 사용 (<span>보유 포인트 : <fmt:formatNumber value="${userVO.point}"/>Point</span>)</div>
	    			<table class="w3-table">
	    				<tr>
	    					<td>
								<div class="input-group">
					    			<input class="input" width="60%" id="point" name="usePoint" type="number" onchange="PointUse()" onkeydown="javascript: return event.keyCode == 69 ? false : true">
					    			<div class="input-group-append">
								      	<input type="button" value="전액 사용" class="btn w3-2021-buttercream" onclick="PointUseAll()"/>
								    </div>
					    		</div>
							</td>
	    				</tr>
	    			</table>
    				<div class="mt-3"><i class="fa-solid fa-ticket"></i>&nbsp; 쿠폰 적용</div>
	    			<table class="w3-table">
	    				<tr>
	    					<td>
								<select class="w3-select" id="couponList" name="couponList" onchange="couponSelect()">
									<option value="0">적용할 쿠폰을 선택하세요.</option>
									<c:forEach var="vo" items="${couponList}">
										<option value="${vo.coupon_user_idx}" data-rate="${vo.discount_rate}" id="optionCoupon_${vo.coupon_user_idx}">
											${vo.reason}(${vo.discount_rate}% 할인)
											&nbsp;[만료일 : ${vo.expiry_date}]
										</option>
									</c:forEach>
								</select>
							</td>
	    				</tr>
	    			</table>
	    		</div>
	    		<div class="w3-bottombar w3-2020-sunlight w3-padding" style="margin-bottom: 20px;">
		    		주문자 정보
		    	</div>
		    	<div class="w3-padding" style="margin-bottom: 20px;">
    				<div><i class="fa-solid fa-user"></i>&nbsp;
    					<a href="${ctp}/user/userInforUpdate" style="font-size:12px;">회원정보 수정하기</a>
    				</div>
	    			<table class="w3-table">
	    				<tr>
	    					<td width="20%">주문자</td>
	    					<td>| ${userVO.name}</td>
	    				</tr>
	    				<tr>
	    					<td width="20%">연락처</td>
	    					<td>| ${userVO.tel}</td>
	    				</tr>
	    				<tr>
	    					<td width="20%">이메일</td>
	    					<td>| ${userVO.email}</td>
	    				</tr>
	    				<tr>
	    					<td width="20%">회원등급</td>
	    					<td>| 
	    						<c:if test="${userVO.level == 1}">
	    							Gold
	    						</c:if>
	    						<c:if test="${userVO.level == 2}">
	    							Silver
	    						</c:if>
	    						<c:if test="${userVO.level == 0}">
	    							Admin
	    						</c:if>
	    						<span class="w3-dropup-click">
									<a onclick="myFunction2()"><i class="fa-solid fa-circle-question"></i></a>
									<div id="pointDemo" class="w3-dropdown-content w3-bar-block w3-border montserrat" style="padding:10px; font-size: 12px;">
										더 가든은 회원 등급제를 운영하고 있습니다.<br>
										(Silver/Gold)
										<hr>
										Gold 레벨 변경 요건은?<br>
										- 로그인 횟수 50회 이상<br>
										- 구매 횟수 10회 이상<br>
										- 구매 총 가격 30만원 이상
										<hr>
										Gold 레벨의 혜택은?<br>
										- 식물 상담실 상담글 작성 가능
										- 포인트 2배 적립
								    </div>
								</span>
	    					</td>
	    				</tr>
	    				<tr>
	    					<td width="20%">보유 포인트</td>
	    					<td>| <fmt:formatNumber value="${userVO.point}"/> Point</td>
	    				</tr>
	    			</table>
	    		</div>
			</div>
		  </div>
   		</div>
   		<c:if test="${deliveryFlag == 'y'}">
   			<input type="hidden" name="deliveryFlag" value="y">
   		</c:if>
   		<c:if test="${deliveryFlag == 'n'}">
   			<input type="hidden" name="deliveryFlag" value="n">
   		</c:if>
   		<input type="hidden" name="order_total_amount" id="order_total_amount">
   		<input type="hidden" name="point" id="use_point">
   		<input type="hidden" name="coupon_amount" id="coupon_amount">
   		<input type="hidden" name="coupon_user_idx" id="coupon_user_idx">
   		<input type="hidden" name="order_total_amount_calc" id="order_total_amount_calc">
    	</form>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script>
function myFunction2() {
  var x = document.getElementById("pointDemo");
  if (x.className.indexOf("w3-show") == -1) { 
    x.className += " w3-show";
  } else {
    x.className = x.className.replace(" w3-show", "");
  }
}
</script>
</body>
</html>