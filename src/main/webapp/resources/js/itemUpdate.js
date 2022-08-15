'use strict';
let categoryFlag = 0;
let seller_discount_flag = 0;
let seller_point_flag = 0;
let item_option_flag = 0;
let optionStockCnt = 0;
let shipment_type_flag = 0;
let cntCheck = 0;
let data = "";
let i = 1;
let j = 1;

function itemUpdate() {
	let optionLength = $("input[name=option_names]").length;
	let optionName = '';
	let optionPrice = '';
	let optionStock = '';
	for(let i=0; i<optionLength; i++) {
		optionName += $("input[name=option_names]").eq(i).val() + "/";
		optionPrice += $("input[name=option_prices]").eq(i).val() + "/";
		optionStock += $("input[name=option_stock_quantities]").eq(i).val() + "/";
	}
	myForm.option_name.value = optionName;
	myForm.str_option_price.value = optionPrice;
	myForm.str_option_stock_quantity.value = optionStock;
	
	let item_name = myForm.item_name.value;
	let item_summary = myForm.item_summary.value;
	let sale_price = myForm.sale_price.value;
	let seller_discount_amount = myForm.seller_discount_amount.value;
	let seller_point = myForm.seller_point.value;
	let stock_quantity = myForm.stock_quantity.value;
	let order_min_quantity = myForm.order_min_quantity.value;
	let order_max_quantity = myForm.order_max_quantity.value;
	
	let titlephoto = document.getElementById("myphoto").value;
	//추가사진이 1장이라도 있는지 확인하는 코드 필요
	//let file1 = document.getElementById("file1").value;
	
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
	else if(seller_discount_amount == "" && seller_discount_flag == 1) {
		alert("할인금액을 입력하세요.");
		myForm.seller_discount_amount.focus();
		return false;
	}
	else if(seller_point == "" && seller_point_flag == 1) {
		alert("지급 포인트를 입력하세요.");
		myForm.seller_point.focus();
		return false;
	}
	else if(stock_quantity == "" && item_option_flag == 0) {
		alert("재고 수량을 입력하세요.");
		myForm.stock_quantity.focus();
		return false;
	}
	else if(order_min_quantity == "") {
		alert("최소 주문 수량을 입력하세요.");
		myForm.order_min_quantity.focus();
		return false;
	}
	else if(order_max_quantity == "") {
		alert("최대 주문 수량을 입력하세요.");
		myForm.order_max_quantity.focus();
		return false;
	}
	else if(order_min_quantity > order_max_quantity) {
		alert("최대 주문 수량은 최소 주문 수량보다 적을 수 없습니다.");
		myForm.order_max_quantity.focus();
		return false;
	}
	else if(titlephoto == "") {
		alert("대표 이미지 등록은 필수 사항입니다.");
		return false;
	}
	/*else if(file1 == "") {
		alert("추가 이미지는 최소 1장 이상 등록해야합니다.");
		return false;
	}*/
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
	else if(shipping_price == "" && shipment_type_flag != 1) {
		alert("배송비를 입력하세요.");
		myForm.shipping_price.focus();
		return false;
	}
	else if(shipping_free_amount == "" && shipment_type_flag != 1) {
		alert("조건부 무료배송 금액을 입력하세요.");
		myForm.shipping_free_amount.focus();
		return false;
	}
	else if(shipping_extra_charge == "" && shipment_type_flag != 1) {
		alert("제주도 추가 배송비를 입력하세요.");
		myForm.shipping_extra_charge.focus();
		return false;
	}
	else if(shipping_price <= 0 && shipment_type_flag != 1) {
		alert("배송비를 0원 이상의 금액으로 입력하세요.");
		myForm.shipping_price.focus();
		return false;
	}
	else if(shipping_free_amount <= 0 && shipment_type_flag != 1) {
		alert("조건부 무료배송 금액을 0원 이상의 금액으로 입력하세요.");
		myForm.shipping_free_amount.focus();
		return false;
	}
	else if(shipping_extra_charge < 0 && shipment_type_flag != 1) {
		alert("제주도 추가 배송비 금액에 음수값을 입력할 수 없습니다.");
		myForm.shipping_extra_charge.focus();
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
			if(optionNameArr[i] == "" && item_option_flag == 1) {
				alert("옵션명을 모두 작성해주세요.");
				return false;
			}
			optionPriceArr[i] = $("input[name=option_price]").eq(i).val();
			if(optionPriceArr[i] == "" && item_option_flag == 1) {
				alert("옵션 추가금액을 모두 작성해주세요.");
				return false;
			}
			optionStockArr[i] = $("input[name=option_stock_quantity]").eq(i).val();
			if(optionStockArr[i] == "" && item_option_flag == 1) {
				alert("옵션 재고수량을 모두 작성해주세요.");
				return false;
			}
		}
		
		//설정 여부에 따른 null 값 채워주기
		if(seller_discount_flag == 0) {
			document.getElementById("seller_discount_amount").value = "0";
		}
		if(seller_point_flag == 0) {
			document.getElementById("seller_point").value = "0";
		}
		myForm.stock_schedule_date.value = document.getElementById("stock_schedule_date").value;
		
		CKEDITOR.instances.detail_content.getData();
		
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
$(document).ready(function(){
	$("input[name='item_option_flag']").change(function(){
		let item_option_flag_value = $("input[name='item_option_flag']:checked").val();
		if(item_option_flag_value == 'y') {
			document.getElementById("item_option_flagForm").style.display = "block";
			$("#stock_quantity").attr("disabled", true);
			item_option_flag = 1;
		}
		else {
			document.getElementById("item_option_flagForm").style.display = "none";
			$("#stock_quantity").attr("disabled", false);
			item_option_flag = 0;
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
			shipment_type_flag = 0;
		}
	});

});

//할인여부 설정
$(document).ready(function(){
	$("input[name='seller_discount_flag']").change(function(){
		let seller_flag = $("input[name='seller_discount_flag']:checked").val();
		if(seller_flag == 'y') {
			document.getElementById("seller_discount_flagForm").style.display = "block";
			seller_discount_flag = 1;
		}
		else {
			document.getElementById("seller_discount_flagForm").style.display = "none";
			seller_discount_flag = 0;
		}
	});

});

//포인트지급여부 설정
$(document).ready(function(){
	$("input[name='seller_point_flag']").change(function(){
		let seller_point_flag_value = $("input[name='seller_point_flag']:checked").val();
		if(seller_point_flag_value == 'y') {
			document.getElementById("seller_pointForm").style.display = "block";
			seller_point_flag = 1;
		}
		else {
			document.getElementById("seller_pointForm").style.display = "none";
			seller_point_flag = 0;
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
function addOptions(optionCnt) {
	let count = optionCnt + i;
	let str = '';
	str += '<tr id="addoptionTr'+count+'">';	
	str += '<td width="5.1%"></td>';	
	str += '<td width="30%">';	
	str += '<input class="input w3-padding-16 w3-border form-control" id="option_name'+count+'" name="option_names" type="text" placeholder="옵션 이름" required>';	
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
function deleteOptions(num) {
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
		data : {item_image_idx : item_image_idx},
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