<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배송정보 등록</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<link rel="icon" href="${ctp}/images/favicon.png">
<script src="${ctp}/js/woo.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	 function deliveryInsert() {
		let title = deliveryForm.title.value;
		let delivery_name = deliveryForm.delivery_name.value;
		let message = deliveryForm.message.value;
		let default_flag = deliveryForm.default_flag.value;
		 
		let tel1 = deliveryForm.tel1.value;
	    let tel2 = deliveryForm.tel2.value; 
	    let tel3 = deliveryForm.tel3.value;
	    let delivery_tel = deliveryForm.tel1.value + "-" + deliveryForm.tel2.value + "-" + deliveryForm.tel3.value;
	     
	    let postcode = deliveryForm.shipment_postcode.value;
	    let roadAddress = deliveryForm.shipment_roadAddress.value;
	    let detailAddress = deliveryForm.shipment_detailAddress.value;
	    let extraAddress = deliveryForm.shipment_extraAddress.value;
	     
	    let regTel = /\d{2,3}-\d{3,4}-\d{4}$/g;
			
		if(title == "") {
			alert("배송정보 이름을 입력하세요.");
			deliveryForm.title.focus();
			return false;
		}
		else if(delivery_name == "") {
			alert("수령인 성명을 입력하세요.");
			deliveryForm.delivery_name.focus();
			return false;
		}
		else if(tel2 == "" || tel3 == "") {
			alert("연락처를 입력하세요.");
			deliveryForm.tel2.focus();
			return false;
		}
		else if(postcode == "" || roadAddress == "" || detailAddress == "") {
			alert("참고항목을 제외한 모든 주소는 필수 입력 사항입니다.");
			deliveryForm.postcode.focus();
			return false;
		}
		else if(tel2 != "" && tel3 != "") {
			if(!regTel.test(delivery_tel)) {
		        alert("전화번호 형식에 맞지않습니다.(000-0000-0000)");
		        deliveryForm.tel2.focus();
		        return false;
		    }
	    }
		 
 		let data = {
			title : title,
			delivery_name : delivery_name,
			delivery_tel : delivery_tel,
			postcode : postcode,
			roadAddress : roadAddress,
			detailAddress : detailAddress,
			extraAddress : extraAddress,
			message : message,
			default_flag : default_flag
		}
		
		 $.ajax({
			type : "post",
			url : "${ctp}/delivery/deliveryInsert",
			data : data,
			success : function(res) {
				if(res == "1") {
					alert("배송지 정보 등록이 완료되었습니다.");
					window.opener.location.reload();
					window.close();
				}
				else {
					alert("배송지 정보 등록 실패. 다시 시도해주세요.");
				}
			},
			error : function() {
				alert("전송 오류.");
			}
		});  
	 }
</script>
</head>
<body>
<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px">
	<div class="w3-bar w3-border w3-2021-illuminating">
	  <span class="w3-bar-item w3-padding-16" style="font-size:18px;">배송지 등록</span>
	</div>
	<div style="margin-top:40px; padding:10px;">
		<div class="w3-row-padding w3-padding-16">
			<div class="w3-col m1 w3-margin-bottom"></div>
			<div class="w3-col m10 w3-margin-bottom">
			    <form name="deliveryForm" method="post">
			    	<div class="form-group">
			    		<label for="title"><span style="color:red;">*&nbsp;</span>배송정보 이름</label>
			      		<div class="input-group mb-3">
			    			<input class="input w3-padding-16 w3-border form-control" id="title" name="title" type="text" placeholder="ex)회사/우리집">
			    		</div>
			    	</div>
			    	<div class="form-group">
			    		<label for="delivery_name"><span style="color:red;">*&nbsp;</span>수령인 성명 </label>
			      		<div class="input-group mb-3">
			    			<input class="input w3-padding-16 w3-border form-control" id="delivery_name" name="delivery_name" type="text" placeholder="수령인 성명을 입력하세요.">
			    		</div>
			    	</div>
			    	<div class="form-group">
				      <label for="delivery_tel"><span style="color:red;">*&nbsp;</span>수령인 연락처 </label>
				      <div class="input-group mb-3">
					      <div class="input-group-prepend">
							      <select name="tel1" id="tel1" class="w3-select w3-border">
									    <option value="010" selected>010</option>
									    <option value="02">서울</option>
									    <option value="031">경기</option>
									    <option value="032">인천</option>
									    <option value="041">충남</option>
									    <option value="042">대전</option>
									    <option value="043">충북</option>
							        <option value="051">부산</option>
							        <option value="052">울산</option>
							        <option value="061">전북</option>
							        <option value="062">광주</option>
									  </select><span>&nbsp; &nbsp;</span><span style="margin-top:6px">-</span> <span>&nbsp; &nbsp;</span>
					      </div>
					      <input type="text" name="tel2" id="tel2" size=8 maxlength=4 class="w3-border"/><span>&nbsp; &nbsp;</span><span style="margin-top:6px">-</span><span>&nbsp; &nbsp;</span>
					      <input type="text" name="tel3" id="tel3" size=8 maxlength=4 class="w3-border"/>&nbsp; &nbsp;
					  </div> 
				   </div>
				  <div class="form-group">
		    		<label for="message">배송 메세지</label>
		      		<div class="input-group mb-3">
		    			<input class="input w3-padding-16 w3-border form-control" id="message" name="message" type="text" placeholder="배송 기사님께 전달할 메세지를 작성하세요.">
		    		</div>
			      </div>
			      <div class="form-group">
				      <label for="shipment_address"><span style="color:red;">*&nbsp;</span> 배송 주소 </label><br>
						<div class="input-group mb-1">
							<input type="text" name="shipment_postcode" id="sample6_postcode1" placeholder="우편번호" class="form-control w3-border" required>
							<div class="input-group-append">
								<input type="button" onclick="sample6_execDaumPostcode(1)" value="우편번호 찾기" class="btn w3-2021-illuminating">
							</div>
						</div>
						<input type="text" name="shipment_roadAddress" id="sample6_address1" size="50" placeholder="주소" class="form-control mb-1 w3-border" required>
						<div class="input-group mb-1">
							<input type="text" name="shipment_detailAddress" id="sample6_detailAddress1" placeholder="상세주소" class="form-control w3-border" required> &nbsp;&nbsp;
							<div class="input-group-append">
							<input type="text" name="shipment_extraAddress" id="sample6_extraAddress1" placeholder="참고항목" class="form-control w3-border">
						</div>
					</div>
				  </div>
				  <p><br></p>
			      <p style="text-align: center;"><button class="btn w3-2021-buttercream w3-round-large" type="button" onclick="deliveryInsert()" style="width:40%">정보 등록</button></p>
				  <input type="hidden" name="delivery_tel" />
				  <input type="hidden" name="postcode" />
				  <input type="hidden" name="roadAddress" />
				  <input type="hidden" name="detailAddress" />
				  <input type="hidden" name="extraAddress" />
				  <input type="hidden" name="default_flag" value="${flag}"/>
			    </form>
		    </div>
		    <div class="w3-col m1 w3-margin-bottom">
		    </div>
	    </div>
	</div>
</div>
</body>
</html>