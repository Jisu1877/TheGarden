$(document).ready(function(){       
   $( "#start, #end" ).datepicker({
	      dateFormat: 'yy-mm-dd',
		  prevText: '이전 달',
		  nextText: '다음 달',
		  monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		  monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		  dayNames: ['일', '월', '화', '수', '목', '금', '토'],
		  dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
		  dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		  showMonthAfterYear: true,
		  showButtonPanel: true,
		  currentText: '오늘 날짜로 이동',
		  yearSuffix: '년',
		  closeText: '닫기',
		  showAnim: 'slideDown'
		  //beforeShowDay: disableSelectedDates
    });
   let today = new Date();
   today.setDate(today.getDate());
   
   //$('#start').datepicker("option", "minDate", today);
   $('#start').datepicker("option", "onClose", function (selectedDate){
	   $("#end").datepicker( "option", "minDate", selectedDate );
	   });
   
   $('#end').datepicker();
   $('#end').datepicker("option", "minDate", $("#start").val());
   $('#end').datepicker("option", "maxDate", today);
   $('#end').datepicker("option", "onClose", function (selectedDate){
       $("#start").datepicker( "option", "maxDate", selectedDate );
      });
});


$(function() {
	init();
});

function init() {
	setRowspan();
	setRowspan2();
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

function setRowspan2() {
	let temp_idx = 0;
	
	$("tbody tr").each(function() {
		const idx = $(this).data('idx');
		const list = $('.id_' + idx);
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

/* 주문상태 변경처리 */
function orderCodeChange1(idx) {
	$.ajax({
		type : "post",
		url : "/javagreenS_ljs/admin/order/orderCodeChange",
		data : {idx : idx,
				code : 2},
		success : function(data) {
			if(data == "1") {
				location.reload();
			}
		},
		error : function() {
			alert("전송오류.");
		}
	});
}

/* 취소 요청 처리 */
function orderCancelRequest(ilstIdx,orderIdx) {
	let url = "/javagreenS_ljs/admin/order/orderCancelRequest?orderIdx="+orderIdx+"&listIdx=" + ilstIdx;
	let winX = 700;
    let winY = 700;
    let x = (window.screen.width/2) - (winX/2);
    let y = (window.screen.height/2) - (winY/2)
	window.open(url, "nWin", "width="+winX+",height="+winY+", left="+x+", top="+y+", resizable = no, scrollbars = no");
}

/* 취소 내용 확인  */
function orderCancelInfor(listIdx, orderIdx) {
	let url = "/javagreenS_ljs/order/orderCancelInfor?orderIdx="+orderIdx+"&listIdx=" + listIdx;
	let winX = 500;
    let winY = 650;
    let x = (window.screen.width/2) - (winX/2);
    let y = (window.screen.height/2) - (winY/2)
	window.open(url, "nWin", "width="+winX+",height="+winY+", left="+x+", top="+y+", resizable = no, scrollbars = no");
}

/* 배송 완료 처리 */
function deliveryOk(idx) {
	$.ajax({
		type : "post",
		url : "/javagreenS_ljs/admin/order/orderCodeChange",
		data : {idx : idx,
				code : 5},
		success : function(data) {
			if(data == "1") {
				location.reload();
			}
		},
		error : function() {
			alert("전송오류.");
		}
	});
}

/* 배송 완료 처리(교환상품) */
function deliveryOk2(idx) {
	$.ajax({
		type : "post",
		url : "/javagreenS_ljs/admin/order/orderCodeChange",
		data : {idx : idx,
				code : 17},
		success : function(data) {
			if(data == "1") {
				location.reload();
			}
		},
		error : function() {
			alert("전송오류.");
		}
	});
}

/* 교환 처리 내역 확인 */
function orderExchangeInfor(listIdx) {
	let url = "/javagreenS_ljs/order/orderExchangeInfor?order_list_idx="+listIdx;
	let winX = 700;
    let winY = 750;
    let x = (window.screen.width/2) - (winX/2);
    let y = (window.screen.height/2) - (winY/2)
	window.open(url, "nWin", "width="+winX+",height="+winY+", left="+x+", top="+y+", resizable = no, scrollbars = no");
}

/* 반품 처리 내역 확인 */
function orderReturnInfor(listIdx) {
	let url = "/javagreenS_ljs/order/orderReturnInfor?order_list_idx="+listIdx;
	let winX = 700;
    let winY = 750;
    let x = (window.screen.width/2) - (winX/2);
    let y = (window.screen.height/2) - (winY/2)
	window.open(url, "nWin", "width="+winX+",height="+winY+", left="+x+", top="+y+", resizable = no, scrollbars = no");
}

/* 배송 내역 */
function shippingInfor(list_idx) {
	let url = "/javagreenS_ljs/order/shippingInfor?order_list_idx="+list_idx;
	let winX = 750;
    let winY = 750;
    let x = (window.screen.width/2) - (winX/2);
    let y = (window.screen.height/2) - (winY/2)
	window.open(url, "nWin", "width="+winX+",height="+winY+", left="+x+", top="+y+", resizable = no, scrollbars = no");
}