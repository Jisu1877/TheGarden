<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품수정</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="${ctp}/ckeditor/ckeditor.js"></script>
    <script src="${ctp}/js/woo.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
	<script>
	'use strict';
	let seller_discount_flag = '${itemVO.seller_discount_flag}';
	let seller_point_flag = '${itemVO.seller_point_flag}';
	let item_option_flag = '${itemVO.item_option_flag}';
	let shipment_type_flag = '${itemVO.shipment_type}';
	let cntCheck = 1;
	let data = "";
	let i = 1;
	let j = 1;
	let imageFlag = 0;
	
	function itemUpdate() {
		let optionLength = $("input[name=option_names]").length;
		let option_idx = '';
		let optionName = '';
		let optionPrice = '';
		let optionStock = '';
		for(let i=0; i<optionLength; i++) {
			optionName += $("input[name=option_names]").eq(i).val() + "/";
			optionPrice += $("input[name=option_prices]").eq(i).val() + "/";
			optionStock += $("input[name=option_stock_quantities]").eq(i).val() + "/";
			option_idx += $("#option_name"+(i+1)).data('idx') + "/";
		}
		myForm.option_name.value = optionName;
		myForm.str_option_price.value = optionPrice;
		myForm.str_option_stock_quantity.value = optionStock;
		myForm.str_option_idx.value = option_idx;
		
		let item_name = myForm.item_name.value;
		let item_summary = myForm.item_summary.value;
		let sale_price = myForm.sale_price.value;
		let seller_discount_amount = myForm.seller_discount_amount.value;
		let seller_point = myForm.seller_point.value;
		let stock_quantity = myForm.stock_quantity.value;
		let order_min_quantity = myForm.order_min_quantity.value;
		let order_max_quantity = myForm.order_max_quantity.value;
		
		let titlephoto = document.getElementById("myphoto").value;
		//대표사진 변경이 안되었을 때..
		if(titlephoto == "") {
			myForm.titlephoto.value = "NO";
		}
		//추가사진이 1장이라도 있는지 확인하는 코드 필요
		let imageCount = $('.imageDiv').length;
		
		let maxSize = 1024 * 1024 * 20;
		let fileSize = 0;
		if (titlephoto.indexOf(" ") != -1) { // 혹시 파일명에 공백이 있으면~~~
			alert("업로드 파일명에 공백을 포함할 수 없습니다.");
			return false;
		}
		else if (titlephoto != "") {
			let ext = titlephoto.substring(titlephoto.lastIndexOf(".") + 1);
			let uExt = ext.toUpperCase();
			fileSize += document.getElementById("myphoto").files[0].size; //파일 선택이 1개밖에 안되기 때문에 0번 배열에만 파일이 있는 상태이다.

			if (uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "JPEG" && uExt != "JFIF") {
				alert("업로드 가능한 파일은 'JPG/GIF/PNG/JPEG/JFIF' 입니다.");
				return false;
			}
		}

		for (let i = 1; i <= cntCheck; i++) {
			let imsiName = "file" + i;
			if (document.getElementById(imsiName) != null) {
				let fName = document.getElementById(imsiName).value;

				if (fName.indexOf(" ") != -1) { // 혹시 파일명에 공백이 있으면~~~
					alert("업로드 파일명에 공백을 포함할 수 없습니다.");
					return false;
				}
				else if (fName != "") {
					imageFlag = 1;
					let ext = fName.substring(fName.lastIndexOf(".") + 1);
					let uExt = ext.toUpperCase();
					fileSize += document.getElementById(imsiName).files[0].size; //파일 선택이 1개밖에 안되기 때문에 0번 배열에만 파일이 있는 상태이다.

					if (uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "JPEG" && uExt != "JFIF") {
						alert("업로드 가능한 파일은 'JPG/GIF/PNG/JPEG/JFIF' 입니다.");
						return false;
					}
				}
			}
		}
		
		if (fileSize > maxSize) {
			alert("업로드할 파일의 총 최대 용량은 20MByte 입니다.");
			return false;
		}
		
		let text = CKEDITOR.instances['CKEDITOR'].getData();
		let origin_country = myForm.origin_country.value;
		let item_model_name = myForm.item_model_name.value;
		let after_service = myForm.after_service.value;
		
		let notice_value1 = myForm.notice_value1.value;
		let notice_value2 = myForm.notice_value2.value;
		let notice_value3 = myForm.notice_value3.value;
		let notice_value4 = myForm.notice_value4.value;
		let notice_value5 = myForm.notice_value5.value;
		
		let shipping_price = myForm.shipping_price.value;
		let shipping_free_amount = myForm.shipping_free_amount.value;
		let shipping_extra_charge = myForm.shipping_extra_charge.value;
		let shipping_return_price = myForm.shipping_return_price.value;
		
		//전송 전에 주소를 하나로 묶어서 전송처리 준비한다.
		//출고지
		let shipment_postcode = myForm.shipment_postcode.value;
		let shipment_roadAddress = myForm.shipment_roadAddress.value;
		let shipment_detailAddress = myForm.shipment_detailAddress.value;
		let shipment_extraAddress = myForm.shipment_extraAddress.value;
		let shipment_address = shipment_postcode + "/" + shipment_roadAddress + "/" + shipment_detailAddress + "/" + shipment_extraAddress + "/";
		
		//반송지
		let shipment_return_postcode = myForm.shipment_return_postcode.value;
		let shipment_return_roadAddress = myForm.shipment_return_roadAddress.value;
		let shipment_return_detailAddress = myForm.shipment_return_detailAddress.value;
		let shipment_return_extraAddress = myForm.shipment_return_extraAddress.value;
		let shipment_return_address = shipment_return_postcode + "/" + shipment_return_roadAddress + "/" + shipment_return_detailAddress + "/" + shipment_return_extraAddress + "/";
		
		//대표 키워드 하나로 묶어서 전송
		let item_keyword = "";
		var keywordLength = $("input[name=keyword]").length;
		for(let i=1; i<=keywordLength; i++) {
			if(document.getElementById("keyword"+i).value != "") {
				item_keyword += document.getElementById("keyword"+i).value + "/"
			}
		}
		
		//hidden값으로 저장
		myForm.shipment_address.value = shipment_address;
		myForm.shipment_return_address.value = shipment_return_address;
		myForm.item_keyword.value = item_keyword;
		
		if(item_name == "") {
			alert("상품명을 입력하세요.");
			myForm.item_name.focus();
			return false;
		}
		else if(item_name.length > 100) {
			alert("상품명은 100자 이내로 입력하세요.");
			myForm.item_name.focus();
			return false;
		}
		else if(item_summary == "") {
			alert("상품 간단설명을 입력하세요.");
			myForm.item_summary.focus();
			return false;
		}
		else if(item_summary.length > 200) {
			alert("상품 간단설명은 200자 이내로 입력하세요.");
			myForm.item_summary.focus();
			return false;
		}
		else if(sale_price == "") {
			alert("판매가를 입력하세요.");
			myForm.sale_price.focus();
			return false;
		}
		else if(seller_discount_amount == "" && seller_discount_flag == 'y') {
			alert("할인금액을 입력하세요.");
			myForm.seller_discount_amount.focus();
			return false;
		}
		else if(seller_point == "" && seller_point_flag == 'y') {
			alert("지급 포인트를 입력하세요.");
			myForm.seller_point.focus();
			return false;
		}
		else if(stock_quantity == "" && item_option_flag == 'y') {
			alert("재고 수량을 입력하세요.");
			myForm.stock_quantity.focus();
			return false;
		}
		else if(order_min_quantity == "") {
			alert("최소 주문 수량을 입력하세요.");
			myForm.order_min_quantity.focus();
			return false;
		}
		else if(imageCount == 1 && imageFlag == 0) {
			alert("추가 이미지는 최소 1장 이상 등록해야합니다.");
			return false;
		}
		else if(text == "") {
			alert("상품상세설명 내용을 입력하세요.");
			return false;
		}
		else if(notice_value1 == "" || notice_value2 == "" || notice_value3 == "" || notice_value4 == "" || notice_value5 == "") {
			alert("상품 정보 고시 내용은 모두 필수 입력사항입니다.");
			return false;
		}
		else if(origin_country == "") {
			alert("원산지를 입력하세요.");
			myForm.origin_country.focus();
			return false;
		}
		else if(item_model_name == "") {
			alert("모델명을 입력하세요.");
			myForm.item_model_name.focus();
			return false;
		}
		else if(after_service == "") {
			alert("A/S안내 내용을 입력하세요.");
			myForm.after_service.focus();
			return false;
		}
		else if(shipping_return_price == "") {
			alert("교환/반품 배송비를 입력하세요.");
			myForm.shipping_return_price.focus();
			return false;
		}
		else if(shipment_postcode == "" || shipment_roadAddress == "" || shipment_detailAddress == "") {
			alert("출고지 주소를 입력하세요.");
			myForm.shipment_postcode.focus();
			return false;
		}
		else if(shipment_return_postcode == "" || shipment_return_roadAddress == "" || shipment_return_detailAddress == "") {
			alert("반송지 주소를 입력하세요.");
			myForm.shipment_return_postcode.focus();
			return false;
		}
		else {
			let optionLength = $("input[name=option_name]").length;
			let optionNameArr = new Array(optionLength);
			let optionPriceArr = new Array(optionLength);
			let optionStockArr = new Array(optionLength);
			for(let i=0; i<optionLength; i++) {
				optionNameArr[i] = $("input[name=option_name]").eq(i).val();
				if(optionNameArr[i] == "" && item_option_flag == 'y') {
					alert("옵션명을 모두 작성해주세요.");
					return false;
				}
				optionPriceArr[i] = $("input[name=option_price]").eq(i).val();
				if(optionPriceArr[i] == "" && item_option_flag == 'y') {
					alert("옵션 추가금액을 모두 작성해주세요.");
					return false;
				}
				optionStockArr[i] = $("input[name=option_stock_quantity]").eq(i).val();
				if(optionStockArr[i] == "" && item_option_flag == 'y') {
					alert("옵션 재고수량을 모두 작성해주세요.");
					return false;
				}
			}
			
			//설정 여부에 따른 null 값 채워주기
			if(seller_discount_flag == 'n') {
				document.getElementById("seller_discount_amount").value = "0";
			}
			if(seller_point_flag == 'n') {
				document.getElementById("seller_point").value = "0";
			}
			myForm.stock_schedule_date.value = document.getElementById("stock_schedule_date").value;
			
			//CKEDITOR.instances.detail_content.getData();
			
			return true;
		}
	}

	//상품정보고시 일괄 정보 입력
	$(document).ready(function() {
	$("input:checkbox[id='noticeAllInput']").on('click', function() {
	      if ( $(this).prop('checked') ) {
	        myForm.notice_value1.value = "상품상세 참조";
			myForm.notice_value2.value = "상품상세 참조";
			myForm.notice_value3.value = "상품상세 참조";
			myForm.notice_value4.value = "상품상세 참조";
			myForm.notice_value5.value = "상품상세 참조";
	      }
	    });
	});


	//옵션여부 설정
	$(function(){
		$("input[name='item_option_flag']").change(function(){
			let item_option_flag_value = $("input[name='item_option_flag']:checked").val();
			if(item_option_flag_value == 'y') {
				document.getElementById("item_option_flagForm").style.display = "block";
				$("#stock_quantity").attr("readonly", true);
				//item_option_flag = 'y';
			}
			else {
				document.getElementById("item_option_flagForm").style.display = "none";
				$("#stock_quantity").attr("readonly", false);
				//item_option_flag = 'n';
			}
		});

	});

	//배송비 여부 설정
	$(document).ready(function(){
		$("input[name='shipment_type']").change(function(){
			let shipment_type_value = $("input[name='shipment_type']:checked").val();
			if(shipment_type_value == 1) {
				document.getElementById("shipmentPriceFrom").style.display = "none";
				shipment_type_flag = 1;
			}
			else {
				document.getElementById("shipmentPriceFrom").style.display = "block";
				shipment_type_flag = 2;
			}
		});

	});

	//할인여부 설정
	$(document).ready(function(){
		$("input[name='seller_discount_flag']").change(function(){
			let seller_flag = $("input[name='seller_discount_flag']:checked").val();
			if(seller_flag == 'y') {
				document.getElementById("seller_discount_flagForm").style.display = "block";
				seller_discount_flag = 'y';
			}
			else {
				document.getElementById("seller_discount_flagForm").style.display = "none";
				seller_discount_flag = 'n';
			}
		});

	});

	//포인트지급여부 설정
	$(document).ready(function(){
		$("input[name='seller_point_flag']").change(function(){
			let seller_point_flag_value = $("input[name='seller_point_flag']:checked").val();
			if(seller_point_flag_value == 'y') {
				document.getElementById("seller_pointForm").style.display = "block";
				seller_point_flag = 'y';
			}
			else {
				document.getElementById("seller_pointForm").style.display = "none";
				seller_point_flag = 'n';
			}
		});

	});

	function calPrice() {
		$("#calPriceForm").hide();
		$("#afterCalPrice").show();
		let sale_price = Number($("#sale_price").val());
		let discount_price = Number($("#seller_discount_amount").val());
		
		if(sale_price <= discount_price) {
			alert("할인금액은 판매가보다 적은 금액을 입력해야합니다.");
			myForm.seller_discount_amount.value = "";
			myForm.seller_discount_amount.focus();
			return false;
		}
		else if(discount_price < 1) {
			alert("할인금액은 최소 1원 이상이어야 합니다.");
			myForm.seller_discount_amount.value = "";
			myForm.seller_discount_amount.focus();
			return false;
		}
		
		let calPrice = sale_price - discount_price;
		
		$("#calPrice").html(calPrice);
	}

	function calPrice2() {
		$("#calPriceForm").hide();
		$("#afterCalPrice").show();
		let sale_price = Number($("#sale_price").val());
		let discount_price = Number($("#seller_discount_amount").val());
		
		let calPrice = sale_price - discount_price;
		
		$("#calPrice").html(calPrice);
	}

	function stock_quantityForm() {
		let stock_quantity = myForm.stock_quantity.value;
		
		if(stock_quantity < 0 && stock_quantity != "") {
			alert("재고 수량은 음수값을 입력할 수 없습니다.");
			myForm.stock_quantity.value = "";
			myForm.stock_quantity.focus();
			return false;
		}
		
		if(stock_quantity == 0 && stock_quantity != "") { 
			document.getElementById("schedule_date").style.display = "block";
		}
		else {
			document.getElementById("schedule_date").style.display = "none";
		}
	}

	function minValueCheck1() {
		let sale_price = myForm.sale_price.value;
		
		if(sale_price <= 0) {
			alert("판매가를 0원 이상 입력하세요.");
			myForm.sale_price.value = "";
			myForm.sale_price.focus();
			return false;
		}
		
	}

	function minValueCheck2() {
		let seller_point = myForm.seller_point.value;
		
		if(seller_point <= 0) {
			alert("지급 포인트를 0원 이상 입력하세요.");
			myForm.seller_point.value = "";
			myForm.seller_point.focus();
			return false;
		}
	}

	function minValueCheck3() {
		let order_min_quantity = myForm.order_min_quantity.value;
		
		if(order_min_quantity < 1 && order_min_quantity != "") {
			alert("최소 구매 수량은 1개 이상이어야 합니다.");
			myForm.order_min_quantity.value = "";
			myForm.order_min_quantity.focus();
			return false;
		}
	}

	function minValueCheck4() {
		let order_max_quantity = myForm.order_max_quantity.value;
		
		if(order_max_quantity < 1 && order_max_quantity != "") {
			alert("최대 구매 수량은 1개 이상이어야 합니다.");
			myForm.order_max_quantity.value = "";
			myForm.order_max_quantity.focus();
			return false;
		}
	}

	//옵션 추가 
	function addOptions(optionCnt,idx) {
		let count = optionCnt + i;
		let str = '';
		str += '<tr id="addoptionTr'+count+'">';	
		str += '<td width="5.1%"></td>';	
		str += '<td width="30%">';	
		str += '<input class="input w3-padding-16 w3-border form-control" id="option_name'+count+'" name="option_names" data-idx="0" type="text" placeholder="옵션 이름" required>';	
		str += '</td>';	
		str += '<td>';	
		str += '<input class="input w3-padding-16 w3-border form-control" onchange="optionPriceCheck('+count+')"  min="0" id="option_price'+count+'" name="option_prices" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true" placeholder="옵션 추가금액" required>';	
		str += '</td>';	
		str += '<td>';	
		str += '<input class="input w3-padding-16 w3-border form-control" onchange="optionStockCheck('+count+')" min="0" id="option_stock_quantity'+count+'" name="option_stock_quantities" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true" placeholder="재고수량" required>';	
		str += '</td>';	
		str += '<td width="5.1%">';	
		str += '<a href="javascript:deleteOptions('+count+')"><i class="fa-solid fa-trash-can" style="font-size: 20px; padding-top:5px;" title="옵션지우기"></i></a>';	
		str += '</td>';	
		str += '</tr>';	
		i++;
		$("#addOption").append(str);
	}

	//옵션삭제
	function deleteOptions(num,idx) {
		let ans = confirm("해당 옵션을 삭제 하시겠습니까? 이 작업은 수정등록 버튼을 누르지 않아도 바로 반영됩니다.");
		if(!ans) {
			return false;
		}
		
		$.ajax({
			type : "post",
			url : "deleteOption",
			data : {item_option_idx : idx},
			success : function(res) {
				
			},
			error : function() {
				
			}
		});
		
		$('tr').remove("#addoptionTr"+num);
	}

	//옵션 가격 체크
	function optionPriceCheck(num) {
		let optionPrice = $("#option_price"+num).val();
		
		if(optionPrice < 0) {
			alert("음수값을 입력하셨습니다.");
			document.getElementById("option_price"+num).value = 0;
			return false;
		}
	}

	//옵션 재고수량 체크 
	function optionStockCheck(num) {
		let optionStock = $("#option_stock_quantity"+num).val();
		
		if(optionStock < 0) {
			alert("음수값을 입력하셨습니다.");
			document.getElementById("option_stock_quantity"+num).value = 0;
			return false;
		}
	}


	$(function(){
		$("#categoryGroup").change(function(){
			let categoryGroup = $(this).val();
			if(categoryGroup == "") {
				alert("대분류를 선택하세요.");
				return false;
			}
			
			$.ajax({
				type : "post",
				url : "getCategory",
				data : {category_group_idx : categoryGroup},
				success : function(vos) {
					let cnt = 0;
					let str = '';
					str += '<option value="">중분류</option>';
					for(let i=0; i<vos.length; i++) {
						if(vos[i].category_name == null) break;
						cnt++;
						str += '<option value="'+vos[i].category_idx+'">'+vos[i].category_name+'</option>'
					}
					if(cnt > 0) {
						categoryFlag = 1;
					}
					else {
						categoryFlag = 0;
					}
					$("#category").html(str);
				},
				error : function() {
					
				}
			});
		});
	});

	 $.datepicker.setDefaults({
	    dateFormat: 'yy-mm-dd',
	    prevText: '이전 달',
	    nextText: '다음 달',
	    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	    monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	    dayNames: ['일', '월', '화', '수', '목', '금', '토'],
	    dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
	    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	    showMonthAfterYear: true,
	    yearSuffix: '년'
	    
	});


	$(function() {
		/*datepicker 세팅*/
		let today = new Date();
		$("#stock_schedule_date").datepicker();
		$('#stock_schedule_date').datepicker("option", "minDate", today);
		
	}); 



	// 대표이미지 미리보기
	function previewImage(targetObj, previewId) { 
		let fName = myForm.myphoto.value;
		let ext = fName.substring(fName.lastIndexOf(".")+1); //파일 확장자 발췌
		let uExt = ext.toUpperCase(); //확장자를 대문자로 변환
		let maxSize = 1024 * 1024 * 10 //업로드할 회원사진의 용량은 10MByte까지로 제한한다.
		
		let fileSize = document.getElementById("myphoto").files[0].size;  //첫번째 파일의 사이즈..! 아이디를 예약어인 file 로 주기.

		if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "JPEG" && uExt != "JFIF") {
			alert("업로드 가능한 파일은 'JPG/GIF/PNG/JPEG/JFIF'파일입니다.") 					
			return false;
		}
		else if(fName.indexOf(" ") != -1) { // 혹시 파일명에 공백이 있으면~~~
			alert("업로드 파일명에 공백을 포함할 수 없습니다.");
			return false;
		}
		else if(fileSize > maxSize) {
			alert("업로드 파일의 크기는 10MByte를 초과할 수 없습니다.");
			return false;
		}
		
		document.getElementById("addImageBtn").style.display = "none";
		document.getElementById("previewId").style.display = "block";
		
		var preview = document.getElementById(previewId);  
		var ua = window.navigator.userAgent; 
		if (ua.indexOf("MSIE") > -1) { 
			targetObj.select(); 
			try { 
				var src = document.selection.createRange().text; 
				var ie_preview_error = document .getElementById("ie_preview_error_" + previewId); 
				
				if (ie_preview_error) { 
					preview.removeChild(ie_preview_error); 
					
				} 
				
				var img = document.getElementById(previewId); //이미지가 뿌려질 곳 
				
				img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + src + "', sizingMethod='scale')"; 
				
			} catch (e) { 
				if (!document.getElementById("ie_preview_error_" + previewId)) { 
					var info = document.createElement("<p>"); 
					info.id = "ie_preview_error_" + previewId; info.innerHTML = "a"; 
					preview.insertBefore(info, null);
					
				} 
				
			} 
		
		} else {  
			var files = targetObj.files; 
			for ( var i = 0; i < files.length; i++) {
				var file = files[i];
				var imageType = /image.*/;   //이미지 파일일경우만.. 뿌려준다.
				if (!file.type.match(imageType)) 
					continue; 
				
				var prevImg = document.getElementById("prev_" + previewId);  //이전에 미리보기가 있다면 삭제
				if (prevImg) { 
					preview.removeChild(prevImg); 
					
				} 
				var img = document.createElement("img");  
				img.id = "prev_" + previewId; 
				img.classList.add("obj"); 
				img.file = file; 
				img.style.width = '300px';
				img.style.height = '300px'; 
				
				preview.appendChild(img); 
				
				if (window.FileReader) { // FireFox, Chrome, Opera 확인. 
					
					var reader = new FileReader(); 
					reader.onloadend = (function(aImg) { 
						return function(e) {
							aImg.src = e.target.result;
							
						}; 
						
					})(img); 
					reader.readAsDataURL(file);
					
				} else { // safari is not supported FileReader 
					//alert('not supported FileReader'); 
				if (!document.getElementById("sfr_preview_error_" + previewId)) {
					var info = document.createElement("p");
					info.id = "sfr_preview_error_" + previewId;
					info.innerHTML = "not supported FileReader";
					preview.insertBefore(info, null);
					
					}
					
				}
					
			}
				
		}
			
	}

	// 프로필 사진 삭제
	function previewDelete() {
		document.getElementById("addImageBtn").style.display = "block";
		document.getElementById("previewId").style.display = "none";
		document.getElementById("photoDelete").style.display = "none";
	}


	function deleteBox(cnt) {
		$("#fBox"+cnt).remove();
		j--;
	}

	function showToast(msg) {
		iqwerty.toast.toast(msg);
	}

	$(function() {
		$('body').on("keypress", function(e) {
			if (e.keyCode === 13) {
				e.preventDefault();
			}
		})
	});

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

	function fileBoxAppend() {
		let imageCount = $('.imageDiv').length;
		let imageCnt = imageCount + j;
		cntCheck = imageCnt;
		if(imageCnt >= 10) {
			alert("추가 이미지는 최대 9장까지 등록가능합니다.");
			return false;
		}
		let fileBox = "";
		fileBox += '<div id="fBox'+imageCnt+'" class="mb-3">';
		fileBox += '- image ';
		fileBox += '<input type="button" value="삭제" onclick="deleteBox('+imageCnt+')" class="w3-btn w3-2020-orange-peel w3-padding-small w3-small ml-2"/>';
		fileBox += '<input type="file" name="file" id="file'+imageCnt+'" class="w3-input"/>';
		fileBox += '<div>';
		$("#fileBoxInsert").append(fileBox);
		j++;
	}

	function photoDel(item_image_idx, image_name) {
		let ans = confirm("'"+image_name + "' 이미지를 삭제하시겠습니까?");
		if(!ans) return false;
		
		$.ajax({
			type : "post",
			url : "itemImageDel",
			data : {item_image_idx : item_image_idx,
				    image_name : image_name},
			success : function(data) {
				if(data == "1") {
					alert("이미지가 삭제되었습니다.");
					$('div').remove("#imageDiv"+item_image_idx);
				}
				else {
					alert("이미지 삭제 실패. 다시 시도해주세요.");
				}
			},
			error : function() {
				alert("전송오류.");
			}
		});
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
		<p style="margin-top:20px; font-size:23px;">상품 수정</p>
		<p><span style="color:red;">🔸&nbsp;</span> 표시가 있는 사항은 필수입력입니다.</p>
	</header>
 	
 	<!-- content  -->
 	<div class="w3-row-padding w3-margin-bottom">
		<form name="myForm" method="post" class="was-validated mt-3" enctype="multipart/form-data" onsubmit="return itemUpdate();">
 		<div class="w3-col s11">
 			<div class="box w3-border">
				<div class="w3-white w3-padding">
			    		<label for="user_id">카테고리 <span style="color:red;">🔸&nbsp;</span> <font color="red">(수정 불가)</font></label>
		    			<div>
		    				<b>대분류</b> | ${itemVO.category_group_name}&nbsp;&nbsp; 
		    				<c:if test="${itemVO.category_name == 'NO'}">
		    					<b>중분류</b> | 없음	
		    				</c:if>
		    				<c:if test="${itemVO.category_name != 'NO'}">
		    					<b>중분류</b> | ${itemVO.category_name} 
		    				</c:if>
		    			</div>
		    			<hr>
				    	<div class="form-group">
				    		<label for="item_name">상품명 <span style="color:red;">🔸&nbsp;</span></label>
				      		<div class="input-group mb-3">
				    			<input class="input w3-padding-16 w3-border form-control" id="item_name" name="item_name" type="text" placeholder="상품명을 입력하세요.(100자 이내)" value="${itemVO.item_name}" required>
				    		</div>
						    <div id="pwdDemo"></div>
				    	</div>
				    	<div class="form-group">
				    		<label for="item_summary">상품 간단 설명 <span style="color:red;">🔸&nbsp;</span></label>
				      		<div class="input-group mb-3">
				    			<input class="input w3-padding-16 w3-border form-control" id="item_summary" name="item_summary" type="text" placeholder="상품 간단 설명을 입력하세요.(200자 이내)" value="${itemVO.item_summary}" required>
				    		</div>
				    	</div><hr>
				    	<div class="form-group">
					      <label for="display_flag">전시상태 <span style="color:red;">🔸&nbsp;</span></label>
					      <div class="form-check-inline">
				        	<div class="form-check">
							    <input type="radio" class="display_flag" name="display_flag" value="y" ${itemVO.display_flag == 'y' ? 'checked' : ''}>&nbsp;&nbsp;전시&nbsp;&nbsp;&nbsp;
							    <input type="radio" class="display_flag" name="display_flag" value="n" ${itemVO.display_flag == 'n' ? 'checked' : ''}>&nbsp;&nbsp;전시중지 
							</div>
						  </div>
					  	</div>
					  	 <div class="w3-light-gray p-4">
						  	<div style="font-size:20px;">판매가</div><br>
						  	<div class="w3-row">
						  		<div class="w3-third">
						    	<div class="form-group">
							      <label for="sale_price">판매가 <span style="color:red;">🔸&nbsp;</span></label>
							      <div class="input-group mb-3" style="margin-bottom:0px">
						    			<input class="input w3-padding-16 w3-border form-control" value="${itemVO.sale_price}" id="sale_price" name="sale_price" type="number" onchange="minValueCheck1()" onkeyup="calPrice2()" placeholder="숫자만 입력" min="0" onkeydown="javascript: return event.keyCode == 69 ? false : true" required>
						    			<div class="input-group-append">
									      	<input type="button" value="원" size="2" class="btn w3-black"/>
									    </div>
					    		  </div>
						        </div>
						        </div>
						        <div class="w3-third"></div>
						        <div class="w3-third"></div>
					        </div>
					       <div class="form-group">
						      <label for="seller_discount_flag">할인 <span style="color:red;">🔸&nbsp;</span></label>
						      <div class="form-check-inline">
					        	<div class="form-check">
								    <input type="radio" class="seller_discount_flag" name="seller_discount_flag" value="y" ${itemVO.seller_discount_flag == 'y' ? 'checked' : ''} onkeypress="seller_discount_flag()">&nbsp;&nbsp;설정&nbsp;&nbsp;&nbsp;
								    <input type="radio" class="seller_discount_flag" name="seller_discount_flag" value="n" ${itemVO.seller_discount_flag == 'n' ? 'checked' : ''}>&nbsp;&nbsp;설정안함
								</div>
							  </div>
						  	</div>
						  	<div id="seller_discount_flagForm" ${itemVO.seller_discount_flag == 'n' ? 'style="display:none"' : ''}>
							  	<div class="w3-row">
							  		<div class="w3-third">
							    	<div class="form-group">
								      <label for="seller_discount_amount">할인금액 <span style="color:red;">🔸&nbsp;</span></label>
								      <div class="input-group mb-3" style="margin-bottom:0px">
							    			<input class="input w3-padding-16 w3-border form-control" id="seller_discount_amount" min="0" name="seller_discount_amount" type="number" onchange="calPrice()" value="${itemVO.seller_discount_amount}" placeholder="숫자만 입력" onkeydown="javascript: return event.keyCode == 69 ? false : true">
							    			<div class="input-group-append">
										      	<input type="button" value="원" size="2" class="btn w3-black" />
										    </div>
						    		  </div>
							        </div>
							        </div>
							        <div class="w3-third"></div>
							        <div class="w3-third"></div>
						        </div>
						        <div style="font-weight:bold;" id="calPriceForm">
						        	<span>최종 판매가&nbsp;:&nbsp;</span>
						        	<c:set var="calPriceFmt" value="${itemVO.sale_price - itemVO.seller_discount_amount}"/>
						        	<span><fmt:formatNumber value="${calPriceFmt}"/>원</span>
						        </div>
						         <div style="font-weight:bold; display:none" id="afterCalPrice">
						        	<span>최종 판매가&nbsp;:&nbsp;</span>
						        	<span id="calPrice"></span>
						        	<span>원</span>
						        </div>
					        </div>
					    </div><hr>
					    <div class="form-group">
					      <label for="seller_point_flag">포인트 지급 <span style="color:red;">🔸&nbsp;</span></label>
					      <div class="form-check-inline">
				        	<div class="form-check">
							    <input type="radio" class="seller_point_flag" name="seller_point_flag" value="y" ${itemVO.seller_point_flag == 'y' ? 'checked' : ''}>&nbsp;&nbsp;지급&nbsp;&nbsp;&nbsp;
							    <input type="radio" class="seller_point_flag" name="seller_point_flag" value="n" ${itemVO.seller_point_flag == 'n' ? 'checked' : ''}>&nbsp;&nbsp;미지급
							</div>
						  </div>
					  	</div>
					    <div id="seller_pointForm" class="w3-row" ${itemVO.seller_point_flag == 'n' ? 'style="display:none"' : ''}>
					  		<div class="w3-third">
					    	<div class="form-group">
						      <label for="seller_point">지급 포인트 <span style="color:red;">🔸&nbsp;</span></label>
						      <div class="input-group mb-3" style="margin-bottom:0px">
					    			<input class="input w3-padding-16 w3-border form-control" value="${itemVO.seller_point}" id="seller_point" min="0" name="seller_point" onchange="minValueCheck2()" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true" placeholder="숫자만 입력">
					    			<div class="input-group-append">
								      	<input type="button" value="Point" size="2" class="btn w3-black" />
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
							      <label for="stock_quantity">재고수량 <span style="color:red;">🔸&nbsp;</span><br>(옵션재고수량 입력시, 자동계산되어 등록됩니다.)</label>
							      <div class="input-group mb-3">
						    			<input class="input w3-padding-16 w3-border form-control" ${itemVO.item_option_flag == 'y' ? 'readonly' : ''} value="${itemVO.stock_quantity}" id="stock_quantity" min="0" name="stock_quantity" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true" onchange="stock_quantityForm()" placeholder="숫자만 입력" required>
						    			<div class="input-group-append">
									      	<input type="button" value="개" size="2" class="btn w3-black"/>
									    </div>
					    		  </div>
						        </div>
					        </div>
					        <div class="w3-third" id="schedule_date" ${itemVO.sold_out == 0 ? 'style="display:none"' : ''}>
					        	<div class="form-group">
							      <label for="stock_schedule_date">재입고 예정일자 <br>&nbsp;</label>
							      <div class="input-group mb-3">
						    			<input class="w3-input" id="stock_schedule_date" value="${itemVO.stock_schedule_date}" name="stock_schedule_date" type="text" placeholder="YYYY-DD-MM" autocomplete="off">
					    		  </div>
					        	</div>
					        </div>
					        <div class="w3-third"></div>
				        </div><hr>
					   <div class="w3-row">
					  		<div class="w3-third">
					    		<div class="form-group">
							      <label for="order_min_quantity">최소 주문 수량 <span style="color:red;">🔸&nbsp;</span></label>
							      <div class="input-group mb-3" style="margin-bottom:0px">
						    			<input class="input w3-padding-16 w3-border form-control" value="${itemVO.order_min_quantity}" min="1" id="order_min_quantity" onchange="minValueCheck3()" name="order_min_quantity" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true" placeholder="숫자만 입력" required>
						    			<div class="input-group-append">
									      	<input type="button" value="개" size="2" class="btn w3-black" />
									    </div>
					    		  </div>
						        </div>
					        </div>
					        <div class="w3-third" style="padding-left: 20px;">
					        	<div class="form-group" style="display:none">
							      <label for="order_max_quantity">최대 주문 수량 <span style="color:red;">🔸&nbsp;</span></label>
							      <div class="input-group mb-3" style="margin-bottom:0px">
						    			<input class="input w3-padding-16 w3-border form-control" value="${itemVO.order_max_quantity}" min="1" id="order_max_quantity" onchange="minValueCheck4()" name="order_max_quantity" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true" placeholder="숫자만 입력" required>
						    			<div class="input-group-append">
									      	<input type="button" value="개" size="2" class="btn w3-black" />
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
							  	<label for="item_option_flag" style="font-size:20px;">옵션</label>
							  	<div class="form-check-inline">
						        	<div class="form-check">
									    <input type="radio" class="item_option_flag" name="item_option_flag" value="y" ${itemVO.item_option_flag == 'y' ? 'checked' : ''}>&nbsp;&nbsp;사용&nbsp;&nbsp;&nbsp;
									    <input type="radio" class="item_option_flag" name="item_option_flag" value="n" ${itemVO.item_option_flag == 'n' ? 'checked' : ''}>&nbsp;&nbsp;사용안함
									</div>
								  </div>
							 </div>
							<div id="item_option_flagForm" ${itemVO.item_option_flag == 'n' ? 'style="display:none"' : ''}>
							  	<div class="w3-row">
							    	<div class="form-group">
								      <table class="w3-table w3-striped w3-bordered">
								      	<c:set var="i" value="1"/>
								      	<tr>
								      		<th><a onclick="javascript:addOptions(${itemVO.itemOptionList.size()})"><i class="fa-solid fa-square-plus" style="font-size: 20px;" title="옵션 추가하기"></i></a></th>
								      		<th>옵션명</th>
								      		<th>추가금액</th>
								      		<th>재고수량</th>
								      		<th></th>
								      	</tr>
								      	<c:forEach var="vo" items="${itemVO.itemOptionList}" varStatus="st">
								      	<tr id="addoptionTr${i}">
								      		<td>
								      		</td>
								      		<td>
								      			<input class="input w3-padding-16 w3-border form-control" id="option_name${i}" value="${vo.option_name}" name="option_names" data-idx="${vo.item_option_idx}" type="text" placeholder="옵션 이름">
								      		</td>
								      		<td>
								      			<input class="input w3-padding-16 w3-border form-control" value="${vo.option_price}" onchange="optionPriceCheck(1)" min="0" id="option_price${i}" name="option_prices" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true" placeholder="옵션 추가금액">
								      		</td>
								      		<td>
								      			<input class="input w3-padding-16 w3-border form-control" value="${vo.option_stock_quantity}" onchange="optionStockCheck(1)" min="0" id="option_stock_quantity${i}" name="option_stock_quantities" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true" placeholder="재고수량">
								      		</td>
								      		 <td width="5%">
								      		 	<c:if test="${i != 1}">
								      		 		<a href="javascript:deleteOptions(${i},${vo.item_option_idx})"><i class="fa-solid fa-trash-can" style="font-size: 20px; padding-top:5px;" title="옵션지우기"></i></a>
								      		 	</c:if>
								      		</td>
								      		<c:set var="i" value="${i + 1}"/>
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
						  	<label for="item_image" style="font-size:20px;">상품 이미지 <span style="color:red;">🔸&nbsp;</span></label>
						 </div>
					  	<div class="w3-row">
					    	<div class="w3-third">
					    		<div style="margin-bottom:10px;">대표 이미지 <span style="color:red;">🔸&nbsp;</span></div>
					    		<a onclick="javascript:$('#myphoto').click(); return false;" style="background-color: white">
						    		<div id="addImageBtn">
						    			<div><img src="${ctp}/data/item/${itemVO.item_image}" width="300px;"></div>
						    		</div>
						    		<div id='previewId'></div>
					    		</a>
				    			<input type="button" id="photoChange" value="변경" class="w3-btn w3-2020-orange-peel w3-padding-small w3-small mt-2" margin-top:5px; margin-left:6px;" onclick="javascript:$('#myphoto').click(); return false;"/>
				    			<input type="file" name="file" id="myphoto" onchange="previewImage(this,'previewId')" class="form-control input" accept=".png, .jpg, .jpeg, .jfif, .gif" hidden="true">
					        </div>
					        <div class="w3-third"></div>
					        <div class="w3-third"></div>
				        </div><br>
				        <div class="w3-row">
				        	<div class="w3-half">
			        			<label for="seller_point_flag" style="margin-left:5px; margin-right: 10px;">추가 이미지</label>
						        <input type="button" value="이미지 추가" onclick="fileBoxAppend()" class="btn w3-lime btn-sm mb-2"/>
				        		<span style="color:red;">🔸&nbsp;</span> 추가 이미지 최소 1장 등록 필수<br>
				        		<div class="mb-3">
					    			<div id="fBox1">
					    				- image
										<input type="file" name="file" id="file1" class="w3-input" accept=".png, .jpg, .jpeg, .jfif, .gif"/>
								    </div>
				    		 	 </div>
								<div id="fileBoxInsert"></div>
				        	</div>
				        	<div class="w3-half"></div>
			        	</div>
			        	<div class="mb-3">
				        	<input type="button" value="등록된 추가 이미지 조회" onclick="imageShow()" class="w3-btn w3-small w3-lime" id="imageShowBtn"/>
		        			<input type="button" value="닫기" onclick="imageHidden()" class="w3-btn w3-small w3-2020-orange-peel" id="imageHiddenBtn" style="display:none"/>
	        			</div>
			        	<div class="w3-row" id="hiddenImage" style="display:none">
		        			<c:forEach var="vo" items="${itemVO.itemImageList}">
				        		<div class="w3-third text-center">
				        			<div id="imageDiv${vo.item_image_idx}" class="imageDiv">
					        			<c:if test="${itemVO.item_image != vo.image_name}">
				        					<div><img src="${ctp}/data/item/${vo.image_name}" width="300px;"></div>
				        					<div>Image Name :  ${vo.image_name}</div>
											<c:if test="${st.count != 1}">
												<span class="iconify" data-icon="bi:arrow-return-right"></span>&nbsp;<a href="javascript:photoDel('${vo.item_image_idx}','${vo.image_name}');" class="badge badge-danger" data-index="${vo.item_image_idx}">삭제하기</a>
											</c:if>
				        				</c:if>
			        				</div>
				        		</div>
		        			</c:forEach>
			        	</div>
					    <hr>
					    <div class="form-group">
					      <label for="detail_content" style="font-size:20px;">상품상세설명 <span style="color:red;">🔸&nbsp;</span></label>
					  	</div>
						<div class="detail_content" id="detail_contentForm">
							<div style="margin-bottom: 10px;">- 상품상세설명 직접입력 <span style="color:red;">🔸&nbsp;</span></div>
							<textarea rows="10" name="detail_content" id="CKEDITOR" class="form-control" onchange="contentOnchange()">${itemVO.detail_content}</textarea>
						</div>
						<script>
				      	  CKEDITOR.replace("detail_content",{
				      		  height:500,
				      		  filebrowserUploadUrl : "${ctp}/imageUpload",
				      		  uploadUrl : "${ctp}/imageUpload"
				      	  });
			      	    </script>
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
					    			<input class="w3-input w3-2020-brilliant-white" value="${itemVO.brand}" id="brand" name="brand" type="text">
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
						    			<input class="w3-input w3-2020-brilliant-white" value="${itemVO.form}" id="form" name="form" type="text">
					    		  </div>
						        </div>
					        </div>
					        <div class="w3-third" style="margin-left: 20px">
					        	<div class="form-group">
							      <div class="mb-3">
						    			<label for="origin_country" style="margin-left:5px;">원산지<span style="color:red;">🔸&nbsp;</span> : </label>
						    			<input class="w3-input w3-2020-brilliant-white" value="${itemVO.origin_country}" id="origin_country" name="origin_country" type="text" required>
					    		  </div>
					        	</div>
					        </div>
					        <div class="w3-third"></div>
				        </div>
					  	<div class="w3-row">
					  		<div class="w3-third">
						    	<div class="form-group">
							      <div class="mb-3">
						    			<label for="item_model_name" style="margin-left:5px;">모델명<span style="color:red;">🔸&nbsp;</span> : </label>
						    			<input class="w3-input w3-2020-brilliant-white" value="${itemVO.item_model_name}" id="item_model_name" name="item_model_name" type="text" required>
					    		  </div>
						        </div>
					        </div>
					        <div class="w3-third" style="margin-left: 20px">
					        	<div class="form-group">
							      <div class="mb-3">
						    			<label for="after_service" style="margin-left:5px;">A/S안내<span style="color:red;">🔸&nbsp;</span> : </label>
						    			<input class="w3-input w3-2020-brilliant-white" value="${itemVO.after_service}" id="after_service" name="after_service" type="text" required>
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
					    			<label for="notice_title1" style="margin-left:5px;">품명/모델명<span style="color:red;">🔸&nbsp;</span> : </label>
					    			<input class="w3-input w3-2020-brilliant-white" value="${itemVO.notice_value1}" id="notice_value1" name="notice_value1" type="text" required>
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
						    			<label for="notice_title2" style="margin-left:5px;">법에 의한 인증, 허가 등을 받았음을 확인할 수 있는 경우 그에 대한 사항<span style="color:red;">🔸&nbsp;</span> : </label>
						    			<input class="w3-input w3-2020-brilliant-white" value="${itemVO.notice_value2}" id="notice_value2" name="notice_value2" type="text" required>
					    		  </div>
						        </div>
					        </div>
					        <div class="w3-half"></div>
				        </div>
					  	<div class="w3-row">
					  		<div class="w3-third">
						    	<div class="form-group">
							      <div class="mb-3">
						    			<label for="notice_title3" style="margin-left:5px;">제조자(사)<span style="color:red;">🔸&nbsp;</span> : </label>
						    			<input class="w3-input w3-2020-brilliant-white" value="${itemVO.notice_value3}" id="notice_value3" name="notice_value3" type="text" required>
					    		  </div>
						        </div>
					        </div>
					        <div class="w3-third" style="margin-left: 20px">
					        	<div class="form-group">
							      <div class="mb-3">
						    			<label for="notice_title4" style="margin-left:5px;">제조국<span style="color:red;">🔸&nbsp;</span> : </label>
						    			<input class="w3-input w3-2020-brilliant-white" value="${itemVO.notice_value4}" id="notice_value4" name="notice_value4" type="text" required>
					    		  </div>
					        	</div>
					        </div>
					        <div class="w3-third"></div>
				        </div>
				        <div class="w3-row">
					  		<div class="w3-third">
					    	<div class="form-group">
						      <div class="mb-3">
					    			<label for="notice_title5" style="margin-left:5px;">소비자상담 관련 전화번호<span style="color:red;">🔸&nbsp;</span> : </label>
					    			<input class="w3-input w3-2020-brilliant-white" value="${itemVO.notice_value5}" id="notice_value5" name="notice_value5" type="text" required>
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
	 				<div class="w3-light-gray p-4">
				    	<div style="font-size:20px;">배송</div>
				    	<div class="form-group" style="display:none">
					      <label for="shipment_type_flag">배송비 구분 <span style="color:red;">🔸&nbsp;</span></label>
					      <div class="form-check-inline">
				        	<div class="form-check">
							    <input type="radio" class="shipment_type" name="shipment_type" value="2" ${itemVO.shipment_type == 2 ? 'checked' : ''}>&nbsp;&nbsp;판매자 조건부&nbsp;&nbsp;&nbsp;
							    <input type="radio" class="shipment_type" name="shipment_type" value="1" ${itemVO.shipment_type == 1 ? 'checked' : ''}>&nbsp;&nbsp;무료배송
							</div>
						  </div>
					  	</div>
					  	<div id="shipmentPriceFrom">
<%-- 					  	<div id="shipmentPriceFrom" ${itemVO.shipment_type == 1 ? 'style="display:none"' : ''}> --%>
						  	<div class="w3-row" style="display:none">
						  		<div class="w3-third">
						    	<div class="form-group">
							      <label for="shipping_price">배송비 <span style="color:red;">🔸&nbsp;</span></label>
							      <div class="input-group mb-3" style="margin-bottom:0px">
						    			<input class="input w3-padding-16 w3-border form-control" value="3000" id="shipping_price" name="shipping_price" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true" placeholder="숫자만 입력">
						    			<div class="input-group-append">
									      	<input type="button" value="원" size="2" class="btn w3-black" />
									    </div>
					    		  </div>
						        </div>
						        </div>
						        <div class="w3-third"></div>
						        <div class="w3-third"></div>
					        </div>
						  	<div class="w3-row" style="display:none">
						  		<div class="w3-third">
						    	<div class="form-group">
							      <label for="shipping_free_amount">조건부 무료배송 금액 <span style="color:red;">🔸&nbsp;</span></label>
							      <div class="input-group mb-3" style="margin-bottom:0px">
						    			<input class="input w3-padding-16 w3-border form-control" value="3000" id="shipping_free_amount" name="shipping_free_amount" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true" placeholder="숫자만 입력">
						    			<div class="input-group-append">
									      	<input type="button" value="원" size="2" class="btn w3-black" />
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
							      <label for="shipping_extra_charge">제주도 추가 배송비 <span style="color:red;">🔸&nbsp;</span></label>
							      <div class="input-group mb-3" style="margin-bottom:0px">
						    			<input class="input w3-padding-16 w3-border form-control" value="3000" id="shipping_extra_charge" name="shipping_extra_charge" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true" placeholder="숫자만 입력" required>
						    			<div class="input-group-append">
									      	<input type="button" value="원" size="2" class="btn w3-black" />
									    </div>
					    		  </div>
						        </div>
						        </div>
						        <div class="w3-third"></div>
						        <div class="w3-third"></div>
					        </div>
				        </div>
				        <hr>
				        <div class="form-group">
					      <label for="item_return_flag">반품 가능여부 <span style="color:red;">🔸&nbsp;</span></label>
					      <div class="form-check-inline">
				        	<div class="form-check">
							    <input type="radio" class="item_return_flag" name="item_return_flag" value="y" ${itemVO.item_return_flag == 'y' ? 'checked' : ''}>&nbsp;&nbsp;가능&nbsp;&nbsp;&nbsp;
							    <input type="radio" class="item_return_flag" name="item_return_flag" value="n" ${itemVO.item_return_flag == 'n' ? 'checked' : ''}>&nbsp;&nbsp;불가능
							</div>
						  </div>
					  	</div>
					  	<div class="w3-row">
					  		<div class="w3-third">
					    	<div class="form-group">
						      <label for="shipping_return_price">교환/반품 배송비(편도기준) <span style="color:red;">🔸&nbsp;</span></label>
						      <div class="input-group mb-3" style="margin-bottom:0px">
					    			<input class="input w3-padding-16 w3-border form-control" value="${itemVO.shipping_return_price}" id="shipping_return_price" name="shipping_return_price" type="number" onkeydown="javascript: return event.keyCode == 69 ? false : true" placeholder="숫자만 입력" required>
					    			<div class="input-group-append">
								      	<input type="button" value="원" size="2" class="btn w3-black" />
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
							      <label for="shipment_address">출고지<span style="color:red;">🔸&nbsp;</span> </label><br>
									<div class="input-group mb-1">
										<input type="text" name="shipment_postcode"value="${shipment_address[0]}" id="sample6_postcode1" placeholder="우편번호" class="form-control w3-border" required>
										<div class="input-group-append">
											<input type="button" onclick="sample6_execDaumPostcode(1)" value="우편번호 찾기" class="btn w3-2020-orange-peel">
										</div>
									</div>
									<input type="text" name="shipment_roadAddress" value="${shipment_address[1]}" id="sample6_address1" size="50" placeholder="주소" class="form-control mb-1 w3-border" required>
									<div class="input-group mb-1">
										<input type="text" name="shipment_detailAddress" value="${shipment_address[2]}" id="sample6_detailAddress1" placeholder="상세주소" class="form-control w3-border" required> &nbsp;&nbsp;
										<div class="input-group-append">
											<input type="text" name="shipment_extraAddress" value="${shipment_address[3]}" id="sample6_extraAddress1" placeholder="참고항목" class="form-control w3-border">
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
							      <label for="shipment_return_address">반송지<span style="color:red;">🔸&nbsp;</span> </label><br>
									<div class="input-group mb-1">
										<input type="text" name="shipment_return_postcode" value="${shipment_return_address[0]}" id="sample6_postcode2" placeholder="우편번호" class="form-control w3-border" required>
										<div class="input-group-append">
											<input type="button" onclick="sample6_execDaumPostcode(2)" value="우편번호 찾기" class="btn w3-2020-orange-peel">
										</div>
									</div>
									<input type="text" name="shipment_return_roadAddress" value="${shipment_return_address[1]}" id="sample6_address2" size="50" placeholder="주소" class="form-control mb-1 w3-border" required>
									<div class="input-group mb-1">
										<input type="text" name="shipment_return_detailAddress" value="${shipment_return_address[2]}" id="sample6_detailAddress2" placeholder="상세주소" class="form-control w3-border" required> &nbsp;&nbsp;
										<div class="input-group-append">
											<input type="text" name="shipment_return_extraAddress" value="${shipment_return_address[3]}" id="sample6_extraAddress2" placeholder="참고항목" class="form-control w3-border">
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
					    			<input class="w3-input w3-2020-sunlight" value="${keywords[0]}" id="keyword1" name="keyword" type="text">
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
						    			<input class="w3-input w3-2020-sunlight" value="${keywords[1]}" id="keyword2" name="keyword" type="text">
					    		  </div>
						        </div>
					        </div>
					        <div class="w3-third" style="margin-left: 20px">
					        	<div class="form-group">
							      <div class="mb-3">
						    			<label for="keyword4" style="margin-left:5px;">키워드4 : </label>
						    			<input class="w3-input w3-2020-sunlight" value="${keywords[3]}" id="keyword4" name="keyword" type="text">
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
						    			<input class="w3-input w3-2020-sunlight" value="${keywords[2]}" id="keyword3" name="keyword" type="text">
					    		  </div>
						        </div>
					        </div>
					        <div class="w3-third" style="margin-left: 20px">
					        	<div class="form-group">
							      <div class="mb-3">
						    			<label for="keyword5" style="margin-left:5px;">키워드5 : </label>
						    			<input class="w3-input w3-2020-sunlight" value="${keywords[4]}" id="keyword5" name="keyword" type="text">
					    		  </div>
					        	</div>
					        </div>
					        <div class="w3-third"></div>
				        </div><hr>
				        
				        <input type="hidden" name="shipment_address">
				        <input type="hidden" name="shipment_return_address">
				        <input type="hidden" name="item_keyword">
				        <input type="hidden" name="option_name">
				        <input type="hidden" name="str_option_price">
				        <input type="hidden" name="str_option_stock_quantity">
				        <input type="hidden" name="str_option_idx">
				        <input type="hidden" name="titlephoto">
				        <input type="hidden" name="item_idx" value="${itemVO.item_idx}">
				        <input type="hidden" name="item_code" value="${itemVO.item_code}">
					    <div>
					    	<p style="text-align: center;">
					    		<a href="${ctp}/admin/item/itemList" class="w3-btn w3-2019-brown-granite">돌아가기</a>
					    		<input type="submit" class="w3-btn w3-2021-desert-mist" value="수정내용 등록">
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