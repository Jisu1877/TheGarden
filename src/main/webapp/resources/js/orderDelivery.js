'use strict';

$(function() {
	init();
});

function init() {
	setRowspan();
	setRowspan3();
}

function setRowspan() {
	let temp_idx = 0;
	
	$("tbody tr").each(function() {
		const idx = $(this).data('idx');
		const list = $('.idx_' + idx);
		const length = list.length;
		
		if (temp_idx == idx) {
			return true; // continue;
		}
		
		list.attr('rowspan', length);
		list.not(':first').remove();
		temp_idx = idx;
	});
}

function setRowspan3() {
	let temp_idx = 0;
	
	$("tbody tr").each(function() {
		const idx = $(this).data('idx');
		const list = $('.infor_' + idx);
		const length = list.length;
		
		if (temp_idx == idx) {
			return true; // continue;
		}
		
		list.attr('rowspan', length);
		list.not(':first').remove();
		temp_idx = idx;
	});
}


/* 상세조회 */
function orderListInfor(idx) {
	let url = "/javagreenS_ljs/admin/order/orderInfor?idx="+idx;
	let winX = 700;
    let winY = 700;
    let x = (window.screen.width/2) - (winX/2);
    let y = (window.screen.height/2) - (winY/2)
	window.open(url, "nWin", "width="+winX+",height="+winY+", left="+x+", top="+y+", resizable = no, scrollbars = no");
}

/* 송장입력 엑셀 파일 다운로드 */
function excelDown() {
	let company = $("select[name=courier_company_choice]").val();
	
	let ans = confirm("엑셀 출력 시 택배사명이 '"+company+"'로 출력됩니다.\n변경은 택배사 일괄 변경에서 원하는 택배사를 선택하세요.");
	
	if(!ans) return false;
	
	$("#company").val(company);
	
	excelDownForm.submit();
}

/* 엑셀 파일 읽어온 뒤 발송 처리 */
function sendProcess() {
	let url = "/javagreenS_ljs/admin/order/sendProcess";
	let winX = 600;
    let winY = 490;
    let x = (window.screen.width/2) - (winX/2);
    let y = (window.screen.height/2) - (winY/2)
	window.open(url, "nWin", "width="+winX+",height="+winY+", left="+x+", top="+y+", resizable = no, scrollbars = no");
}

/* 개별 송장 입력 */
function invoiceinsert(order_number,order_list_idx) {
	let company = $("select[name=courier_company_"+order_list_idx+"]").val();
	let invoice_number = $("#order_delivery_number_"+order_list_idx).val();
	
	if(invoice_number == "") {
		alert("송장번호를 입력하세요.");
		return false;
	}
	
	$.ajax({
		type : "post",
		url : "/javagreenS_ljs/admin/order/invoiceinsert",
		data : {order_list_idx : order_list_idx,
				order_number : order_number,
				shipping_company : company,
				invoice_number : invoice_number
		},
		success : function(res) {
			if(res == "1") {
				alert("개별 발송 처리가 완료되었습니다.");
				location.reload();
			}
		},
		error : function() {
			alert("전송오류");
		}
	});
}
