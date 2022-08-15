<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>반품 요청</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <style>
    	th {
    		width:35%;
    	}
    </style>
    <script>
    	function returnRequest() {
    		let return_reason = $("select[name=return_reason]").val();
			let return_bank_name = $("select[name=return_bank_name]").val();
			let return_bank_user_name = $("#return_bank_user_name").val();
			let return_bank_number = $("#return_bank_number").val();
			let file = $("#file").val();
			let maxSize = 1024 * 1024 * 20;
			
			if(return_reason == "") {
				alert("반품 사유를 선택하세요.");
				return false;
			}
			else if(return_bank_name == "") {
				alert("환불 받을 은행을 선택하세요.");
				return false;
			}
			else if(return_bank_user_name == "") {
				alert("예금주 성명을 입력하세요.");
				$("#return_bank_user_name").focus();
				return false;
			}
			else if(return_bank_number == "") {
				alert("계좌번호를 입력하세요.");
				$("#return_bank_number").focus();
				return false;
			}
			else if(file == "") {
				alert("사진 제출은 필수 입니다.");
				return false;
			}
			
			
			let fileSize = 0;
    		var files= document.getElementById("file").files;
    		for(let i=0; i< files.length; i++) {
    			
    			let fName = files[i].name;
    			
    			if(fName != "") {
	   				let ext = fName.substring(fName.lastIndexOf(".")+1);
	   	    		let uExt = ext.toUpperCase();
	
	   	    		if (uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "JPEG" && uExt != "JFIF") {
	   	 				alert("업로드 가능한 파일은 'JPG/GIF/PNG/JPEG/JFIF' 입니다.");
	   	    			return false;
	   	    		}
	   	    		else {
		   	    		fileSize += files[i].size;
	   	    		}
    			}
    		}
    		
    		if(fileSize > maxSize) {
    			alert("업로드 가능한 파일의 총 최대 용량은 20MByte 입니다.");
    			return false;
    		}    		
    		else {
    			returnForm.submit();
    		}
		}
    </script>
</head>
<body>
<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px">
   	<div class="w3-bar w3-border w3-black">
	  <span class="w3-bar-item w3-padding-16" style="font-size:18px;">반품 요청</span>
	</div>
	<div style="margin-top:10px; padding:10px;">
		<div class="w3-row-padding w3-padding-16">
			<div class="w3-col m1 w3-margin-bottom"></div>
			<div class="w3-col m10 w3-margin-bottom">
				<div class="mb-2">
					<i class="fa-solid fa-circle-info"></i> 반품 사유가 '단순 변심'일 경우 환불 금액에서 각 상품별 규정에 따라 수거 배송비가 차감됨을 알려드립니다.
				</div>
				<div>
					<i class="fa-solid fa-circle-info"></i> 부분 반품의 경우 포인트 혹은 쿠폰 사용으로 할인을 받았다면, <font color="tomato">가장 먼저 반품하는 상품에서 차감</font>되어 환불됩니다.
				</div>
				<label class="w3-yellow mt-3"><b>주문 정보</b></label>
				<table class="table w3-bordered">
					<tr>
						<th>주문 번호</th>
						<td>${vo.order_number}</td>
					</tr>
					<tr>
						<th>주문 목록 번호</th>
						<td>${vo.order_list_idx}</td>
					</tr>
					<tr>
						<th>상품금액</th>
						<td><fmt:formatNumber value="${vo.item_price}"/>원</td>
					</tr>
					<tr>
						<th>차감금액</th>
						<td><fmt:formatNumber value="${vo.use_point  + vo.coupon_amount}"/>원</td>
					</tr>
					<tr>
						<th>배송비 차감 금액<br><font size="2">('단순변심'에만 해당)</font></th>
						<td><fmt:formatNumber value="${itemVO.shipping_return_price}"/>원</td>
					</tr>
					<tr>
						<th>환불 예상 금액</th>
						<td>
							<c:set var="refund" value="${vo.item_price - (vo.use_point + vo.coupon_amount)}"/>
							<fmt:formatNumber value="${refund}"/>원<font size="2">(배송비 차감 포함 X)</font>
						</td>
					</tr>
				</table>
				<br>
				<label class="w3-yellow"><b>배송지 정보</b></label>
				<table class="table w3-bordered">
					<tr>
						<th>배송지명</th>
						<td>${deliveryVO.title}</td>
					</tr>
					<tr>
						<th>수령인 성명</th>
						<td>${deliveryVO.delivery_name}</td>
					</tr>
					<tr>
						<th>수령인 연락처</th>
						<td>${deliveryVO.delivery_tel}</td>
					</tr>
					<tr>
						<th>배송지</th>
						<td>
							(${deliveryVO.postcode})<br> ${deliveryVO.roadAddress} ${deliveryVO.detailAddress} ${deliveryVO.extraAddress}  
						</td>
					</tr>
					<tr>
						<th>배송 메세지</th>
						<td>${deliveryVO.message}</td>
					</tr>
				</table>
				<br>
				<form name="returnForm" method="post" enctype="multipart/form-data">
					<label class="w3-yellow"><b>반품 요청 정보</b></label>
					<table class="table w3-bordered">
						<tr>
							<th>반품사유</th>
							<td>
								<select name="return_reason" id="return_reason" class="w3-select w3-border">
								    <option value="" selected>반품 사유를 선택하세요</option>
								    <option value="단순변심">단순변심</option>
								    <option value="상품불량">상품불량</option>
								    <option value="오배송">오배송</option>
								    <option value="기타">기타</option>
								</select>
							 </td>
						</tr>
						<tr>
							<th>환불 받을 은행</th>
							<td>
								<select name="return_bank_name" class="w3-select w3-border">
			                        <option value="" selected>은행명을 선택하세요</option>
			                        <option value="경남은행">경남은행</option>
			                        <option value="광주은행">광주은행</option>
			                        <option value="국민은행">국민은행</option>
			                        <option value="농협중앙회">농협중앙회</option>
			                        <option value="농협회원조합">농협회원조합</option>
			                        <option value="대구은행">대구은행</option>
			                        <option value="도이치은행">도이치은행</option>
			                        <option value="부산은행">부산은행</option>
			                        <option value="산업은행">산업은행</option>
			                        <option value="상호저축은행">상호저축은행</option>
			                        <option value="새마을금고">새마을금고</option>
			                        <option value="수협중앙회">수협중앙회</option>
			                        <option value="신한금융투자">신한금융투자</option>
			                        <option value="신한은행">신한은행</option>
			                        <option value="신협중앙회">신협중앙회</option>
			                        <option value="외환은행">외환은행</option>
			                        <option value="우리은행">우리은행</option>
			                        <option value="우체국">우체국</option>
			                        <option value="전북은행">전북은행</option>
			                        <option value="제주은행">제주은행</option>
			                        <option value="카카오뱅크">카카오뱅크</option>
			                        <option value="케이뱅크">케이뱅크</option>
			                        <option value="하나은행">하나은행</option>
			                        <option value="한국씨티은행">한국씨티은행</option>
			                        <option value="HSBC">HSBC은행</option>
			                        <option value="제일은행">SC제일은행</option>
								</select>	
							</td>
						</tr>
						<tr>
							<th>예금주</th>
							<td>
								<input class="input w3-border form-control" id="return_bank_user_name" name="return_bank_user_name" type="text"/>
							</td>
						</tr>
						<tr>
							<th>계좌번호</th>
							<td>
								<input class="input w3-border form-control" id="return_bank_number" name="return_bank_number" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true"/>
							</td>
						</tr>
						<tr>
							<th>사진 첨부</th>
							<td>
								<input type="file" class="w3-file" name="file" id="file" multiple="multiple" class="form-control-file border" accept=".png, .jpg, .jpeg, .jfif, .gif">
							</td>
						</tr>
						<tr>
							<th>전달 메세지</th>
							<td>
								<textarea rows="3" name="user_message" id="user_message" class="form-control" placeholder="관리자에게 전달하고 싶은 메세지를 작성하세요."></textarea>
							</td>
						</tr>
					</table>
				<div class="text-center">
					<a class="w3-btn w3-black" onclick="returnRequest()">반품 요청</a>&nbsp;
					<a class="w3-btn w3-2021-illuminating" onclick="window.close();">닫기</a>
				</div>
				<input type="hidden" name="order_idx" value="${vo.order_idx}">
				<input type="hidden" name="order_list_idx" value="${vo.order_list_idx}">
				<input type="hidden" name="return_price" value="${refund}">
				<input type="hidden" name="use_point" value="${vo.use_point}">
				<input type="hidden" name="coupon_amount" value="${vo.coupon_amount}">
				<input type="hidden" name="shipping_return_price" value="${itemVO.shipping_return_price}">
				</form>
		    </div>
		    <div class="w3-col m1 w3-margin-bottom">
		    </div>
	    </div>
	</div>
</div>
</body>
</html>