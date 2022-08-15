<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>교환 요청</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <style>
    	th {
    		width:35%;
    	}
    </style>
    <script>
    	function exchangeRequest() {
			let exchange_reason = $("select[name=exchange_reason]").val();
			let file = $("#file").val();
			let maxSize = 1024 * 1024 * 20;
			
			if(exchange_reason == "") {
				alert("취소 사유를 선택하세요.");
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
    			exchangeForm.submit();
    		}
		}
    </script>
</head>
<body>
<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px">
   	<div class="w3-bar w3-border w3-2020-orange-peel">
	  <span class="w3-bar-item w3-padding-16" style="font-size:18px;">교환 요청</span>
	</div>
	<div style="margin-top:10px; padding:10px;">
		<div class="w3-row-padding w3-padding-16">
			<div class="w3-col m1 w3-margin-bottom"></div>
			<div class="w3-col m10 w3-margin-bottom">
				<div class="mb-2">
					<i class="fa-solid fa-circle-info"></i> 식물의 특성상 '단순변심' 교환은 어려우니 양해부탁드리며,<br> 다른 상품으로의 교환은 불가능하오니 반품 처리 후 구매를 진행하시면 됩니다.
				</div>
				<div class="mb-2">
					<i class="fa-solid fa-circle-info"></i> 상품 수거가 완료된 후 교환 상품 발송이 시작됨을 알려드립니다.
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
						<th>상품명</th>
						<td>${itemVO.item_name}</td>
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
				<form name="exchangeForm" method="post" enctype="multipart/form-data">
					<label class="w3-yellow"><b>교환 요청 정보</b></label>
					<table class="table w3-bordered">
						<tr>
							<th>교환사유</th>
							<td>
								<select name="exchange_reason" id="exchange_reason" class="w3-select w3-border">
								    <option value="" selected>교환 사유를 선택하세요</option>
								    <option value="상품불량">상품불량</option>
								    <option value="오배송">오배송</option>
								    <option value="기타">기타</option>
								</select>
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
					<a class="w3-btn w3-2020-fired-brick" onclick="exchangeRequest()">교환 요청</a>&nbsp;
					<a class="w3-btn w3-2021-illuminating" onclick="window.close();">닫기</a>
				</div>
				<input type="hidden" name="order_idx" value="${vo.order_idx}">
				<input type="hidden" name="order_list_idx" value="${vo.order_list_idx}">
				</form>
		    </div>
		    <div class="w3-col m1 w3-margin-bottom">
		    </div>
	    </div>
	</div>
</div>
</body>
</html>