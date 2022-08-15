let totalAmount = 0;
let totalPrice = 0;
let sale_price = '';
let seller_discount_flag = '';
let seller_discount_amount = 0;
let sw = 0;
let optionIdxArr = [];
let order_quantity = [];
let option_name = [];
let option_price = [];
let item_price = [];
let itemJson = new Object();
let order = new Object();
let strprice;
let reviewChartJson;

$(function() {
	sale_price = $("#sale_price").val();
	seller_discount_flag = $("#seller_discount_flag").val();
	seller_discount_amount = $("#seller_discount_amount").val();
	//totalAmount = $("#order_min_quantity").val();
	totalAmount = 0;
	setTotalPrice();
	
	
});

function setTotalPrice() {
	if(seller_discount_flag == 'y') {
		totalPrice = (Number(sale_price) - Number(seller_discount_amount)) * totalAmount;
		realPrice = Number(sale_price) - Number(seller_discount_amount);
	}
	else {
		totalPrice = Number(sale_price) * totalAmount;
	}
}

function optionSelect(ths) {
	const idx = $(ths).val();
	const option = $(ths).find('option:selected').data('label');
	strprice = $(ths).find('option:selected').data('price');
	let order_min_quantity = $("#order_min_quantity").val();
	const price1 = (Number(strprice) * Number(order_min_quantity));
	const price2 = Math.floor(price1).toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
	
	if(option == "") {
		return false;
	}
	else if($("#option_"+idx).length > 0){
		alert("이미 선택한 옵션입니다.");
		$("#optionSelect").val("").prop("selected", true);
		return false;
	}
	
	let optionDiv = $("#option_tmp_div").clone();
	
	optionDiv.attr("style", "display:block;");
	optionDiv.attr("id", "option_"+idx);
	optionDiv.find(".option").html(option);
	optionDiv.find(".option_cnt").html(order_min_quantity);
	optionDiv.find(".option_cnt").attr("data-idx", idx);
	optionDiv.find(".option_cnt").attr("data-cnt", order_min_quantity);
	optionDiv.find(".option_cnt").attr("id", "option_cnt_"+idx);
	if(price1 > 0) {
		optionDiv.find(".option_price").html("+&nbsp;" + price2 + "원" + "("+ strprice +"원 x "+order_min_quantity+")");
	}
	
	optionDiv.find(".option_price").attr("data-price", strprice);
	
	
	$("#optonDemo").append(optionDiv);
	
	$("#optionSelect").val("").prop("selected", true);
	
	totalPrice += (Number(strprice) * Number(order_min_quantity));
	
	if(seller_discount_flag == 'y') {
 		totalPrice += (Number(realPrice) * Number(order_min_quantity));
	}
	else {
		totalPrice += (Number(sale_price) * Number(order_min_quantity));
	}
	totalAmount = (Number(totalAmount) + Number(order_min_quantity));
	
	let total = Math.floor(totalPrice).toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
	$("#totalCnt").html(totalAmount);
	$("#totalPrice").html(total);
	$("#totalInfor").attr("style", "margin:30px; display:block; font-size:22px;");
	
	//옵션 idx, name, 가격, 수량 담기
	for(let i = 0; i < ($(".option_div").length)-1; i++) {
		if(optionIdxArr[i] == null) {
			optionIdxArr[i] = idx;
			order_quantity[i] = order_min_quantity;
			option_name[i] = option;
			option_price[i] = strprice;
		}
	}
}

function minus(ths) {
	const id = $(ths).parents("div.option_div").attr("id");
	let arr = id.split("_");
	let amount = $(ths).parents().find("#"+id).find("#option_cnt_"+arr[1]).attr('data-cnt');
	let order_min_quantity = $("#order_min_quantity").val();		
	amount--;
	
	if(order_min_quantity > amount) {
		$("#optionSelect").val("").prop("selected", true);
		alert("최소 구매 가능 수량은 " +order_min_quantity+ "개 입니다.");
		return false;
	}
	totalAmount--;
	
	let price = $("#"+id).find(".option_price").data('price');
	let price2 = price * Number(amount);
	let price3 = Math.floor(price2).toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
	if(price2 > 0) {
		$("#"+id).find(".option_price").html("+&nbsp;" +price3 + "원" + "("+ strprice +"원 x "+amount+")");
	}
	$(ths).siblings("span.option_cnt").html(amount);
	totalPrice -= price;
	if(seller_discount_flag == 'y') {
 		totalPrice -= realPrice;
	}
	else {
		totalPrice -= Number(sale_price);
	}
	$(ths).siblings("span.option_cnt").attr("data-cnt", amount);
	
	let total = Math.floor(totalPrice).toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
	$("#totalCnt").html(totalAmount);
	$("#totalPrice").html(total);
	
	let idx = $("#"+id).find(".option_cnt").data('idx');
	//옵션 수량 수정
	for(let i = 0; i < ($(".option_div").length)-1; i++) {
		if(optionIdxArr[i] == idx) {
			order_quantity[i] = Number(order_quantity[i]) - 1;
		}
	}
}

function plus(ths) {
	const id = $(ths).parents("div.option_div").attr("id");
	let arr = id.split("_");
	let amount = $(ths).parents().find("#"+id).find("#option_cnt_"+arr[1]).attr('data-cnt');
	const price = ($("#"+id).find(".option_price").data('price')) * (Number(amount) + 1);
	const price2 = Math.floor(price).toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
	amount++;
	totalAmount++;

	$(ths).siblings("span.option_cnt").html(amount);
	
	totalPrice += $("#"+id).find(".option_price").data('price');
	if(seller_discount_flag == 'y') {
 		totalPrice += realPrice;
	}
	else {
		totalPrice += Number(sale_price);
	}
	if(price > 0) {
		$("#"+id).find(".option_price").html("+&nbsp;" + price2 + "원" + "("+ strprice +"원 x "+amount+")");
	}
	let total = Math.floor(totalPrice).toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
	$("#totalCnt").html(totalAmount);
	$("#totalPrice").html(total);
	$(ths).siblings("span.option_cnt").attr("data-cnt", amount);
	
	let idx = $("#"+id).find(".option_cnt").data('idx');
	//옵션 수량 수정
	for(let i = 0; i < ($(".option_div").length)-1; i++) {
		if(optionIdxArr[i] == idx) {
			order_quantity[i] = Number(order_quantity[i]) + 1;
			if(seller_discount_flag == 'y') {
				item_Price[i] = ((Number(sale_price) - Number(seller_discount_amount)) * order_quantity[i]) + price;
			}
			else {
				item_price[i] = Number(sale_price) * order_quantity[i] + price;
			}
		}
	}
	
}

function deleteOption(ths) {
	const id = $(ths).parents("div.option_div").attr("id");
	let arr = id.split("_");
	let amount = $(ths).parents().find("#"+id).find("#option_cnt_"+arr[1]).attr('data-cnt');
	amount = Number(amount);
	totalAmount -= amount;
	let price = $("#"+id).find(".option_price").data('price');
	let price2 = Number(price) * Number(amount);
	
	let idx = $("#"+id).find(".option_cnt").data('idx');
	//옵션 idx, name, 가격, 수량 삭제		
	const arrIndex = optionIdxArr.indexOf(String(idx));
	if (arrIndex > -1) { // only splice array when item is found
		optionIdxArr.splice(arrIndex, 1); // 2nd parameter means remove one item only
		order_quantity.splice(arrIndex, 1); // 2nd parameter means remove one item only
		console.log(optionIdxArr, order_quantity);
	}
	
	$( 'div' ).remove('#'+id);
	
	totalPrice -= price2;
	
	if(seller_discount_flag == 'y') {
 		totalPrice -= (realPrice * amount);
	}
	else {
		totalPrice -= (Number(sale_price) * amount);
	}
	
	let total = Math.floor(totalPrice).toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
	$("#totalCnt").html(totalAmount);
	$("#totalPrice").html(total);
	if($(".option_div").length < 2) {
		setTotalPrice();
	}
	
}

function minus2(ths) {
	let amount = $(ths).siblings("span.option_cnt").html();
	let order_min_quantity = $("#order_min_quantity").val();		
	amount--;
	
	if(order_min_quantity > amount) {
		$("#optionSelect").val("").prop("selected", true);
		alert("최소 구매 가능 수량은 " +order_min_quantity+ "개 입니다.");
		return false;
	}
	totalAmount--;
	
	$(ths).siblings("span.option_cnt").html(amount);
	
	if(seller_discount_flag == 'y') {
 		totalPrice -= realPrice;
	}
	else {
		totalPrice -= Number(sale_price);
	}
	let total = Math.floor(totalPrice).toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
	$("#totalCnt").html(totalAmount);
	$("#totalPrice").html(total);
}

function plus2(ths) {
	let amount = $(ths).siblings("span.option_cnt").html();
	let order_min_quantity = $("#order_min_quantity").val();	
	amount++;
	if(totalAmount == 0) {
		totalAmount += order_min_quantity;
	}
	totalAmount++;
	
	$(ths).siblings("span.option_cnt").html(amount);

	if(totalPrice == 0) {
		if(seller_discount_flag == 'y') {
 			totalPrice += realPrice;
		}
		else {
			totalPrice += Number(sale_price);
		}
	}
		
	if(seller_discount_flag == 'y') {
 		totalPrice += realPrice;
	}
	else {
		totalPrice += Number(sale_price);
	}
	
	let total = Math.floor(totalPrice).toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
	$("#totalCnt").html(totalAmount);
	$("#totalPrice").html(total);
}


/* 찜하기 */
function like(idx) {
	let loginFlag = $("#loginFlag").val();
	
	if(loginFlag == 'no') {
		alert("로그인이 필요한 서비스입니다.");
		let url = "/javagreenS_ljs/user/userLoginOther";
  		let winX = 1300;
        let winY = 700;
        let x = (window.screen.width/2) - (winX/2);
        let y = (window.screen.height/2) - (winY/2)
		window.open(url, "nWin", "width="+winX+",height="+winY+", left="+x+", top="+y+", resizable = no, scrollbars = no");
		setInterval(function(){
			$("#navBar").load(location.href+" #navBar>*","");
		}, 2000);
		return false;
	}
	
	$.ajax({
		type : "post",
		url : "/javagreenS_ljs/user/wishlistInsert",
		data : {item_idx : idx},
		async: false,
		success : function (res) {
			if(res == '1') {
				location.reload();					
				return false;
			}
			else if(res == "2") {
				alert("로그인이 필요한 서비스입니다.");
				location.href="${ctp}/user/userLogin";
				return false;
			}
		},
		error : function () {
			alert("전송 오류");
		}
	});
}

/* 찜 해제하기 */
function unlike(idx) {
	let loginFlag = $("#loginFlag").val();
	
	if(loginFlag == 'no') {
		alert("로그인이 필요한 서비스입니다.");
		let url = "/javagreenS_ljs/user/userLoginOther";
  		let winX = 1300;
        let winY = 700;
        let x = (window.screen.width/2) - (winX/2);
        let y = (window.screen.height/2) - (winY/2)
		window.open(url, "nWin", "width="+winX+",height="+winY+", left="+x+", top="+y+", resizable = no, scrollbars = no");
		setInterval(function(){
			$("#navBar").load(location.href+" #navBar>*","");
		}, 2000);
		return false;
	}
	
	$.ajax({
		type : "post",
		url : "/javagreenS_ljs/user/wishlistDelete",
		data : {item_idx : idx},
		async: false,
		success : function (res) {
			if(res == '1') {
				location.reload();					
				return false;
			}
			else if(res == "2") {
				alert("로그인이 필요한 서비스입니다.");
				location.href="${ctp}/user/userLogin";
				return false;
			}
		},
		error : function () {
			alert("전송 오류");
		}
	});
}


/* 구매하기 */
function buyItem() {
	
	let loginFlag = $("#loginFlag").val();
	
	if(loginFlag == 'no') {
		alert("로그인이 필요한 서비스입니다.");
		let url = "/javagreenS_ljs/user/userLoginOther";
  		let winX = 1300;
        let winY = 700;
        let x = (window.screen.width/2) - (winX/2);
        let y = (window.screen.height/2) - (winY/2)
		window.open(url, "nWin", "width="+winX+",height="+winY+", left="+x+", top="+y+", resizable = no, scrollbars = no");
		setInterval(function(){
			$("#navBar").load(location.href+" #navBar>*","");
		}, 2000);
		return false;
	}
	
	let item_option_flag = $("#item_option_flag").val();
	//상품을 선택했는지 확인
	if(optionIdxArr.length == 0 && item_option_flag == 'y') {
		alert("옵션을 선택하세요.");
		return false;
	}
	
	//주문/결제 창으로 넘어가기 준비
	if(totalAmount == 0) {
		totalAmount = 1;
	}
	if(order_quantity.length == 0) {
		order_quantity[0] = totalAmount;
	}
	if(option_name.length == 0) {
		option_name[0] = " ";
	}
	if(option_price.length == 0) {
		option_price[0] = " ";
	}
	if(totalPrice == 0) {
		if(seller_discount_flag == 'y') {
 			totalPrice += realPrice;
		}
		else {
			totalPrice += Number(sale_price);
		}
	}
	
	// 옵션 선택 시 해당 옵션을 order 객체에 초기화
	order.order_option_idx = optionIdxArr;
	//order.order_item_price = totalPrice;
	order.order_option_name = option_name;
	order.order_option_price = option_price.map(String);
	order.order_quantity = order_quantity;
	order.order_total_amount = totalPrice;
	
	//상품 가격을 배열로 각각 담아야 한다.(옵션 선택시)
	if(itemJson.item_option_flag == 'y')
	for(let i=0; i<optionIdxArr.length; i++) {
		if(seller_discount_flag == 'y') {
			item_price[i] = ((Number(sale_price) - Number(seller_discount_amount)) * order_quantity[i]) + option_price[i];
		}
		else {
			item_price[i] = (Number(sale_price) * order_quantity[i]) + option_price[i];
		}
	}
	
	order.order_item_price = item_price.length == 0 ? totalPrice : item_price;
	
	let length = order.order_option_idx.length;
	length = length == 0 ? 1 : length;
	
	order.order_item_idx = Array(length).fill(itemJson.item_idx.toString());
	order.order_item_name = Array(length).fill(itemJson.item_name);
	order.order_item_image = Array(length).fill(itemJson.item_image);
	order.order_item_option_flag = Array(length).fill(itemJson.item_option_flag);
	order.cart_idx = Array(length).fill('0');
	
	const params = new URLSearchParams(order).toString();
	
	location.href = '/javagreenS_ljs/order/orderCheck?' + params;
	
	/*
	const formData = new FormData();
	
	formData.append('order_item_idx', itemJson.item_idx.toString());
	formData.append('order_item_name', itemJson.item_name);
	formData.append('order_item_image', itemJson.item_image);
	formData.append('order_item_option_flag', itemJson.item_option_flag);
	formData.append('cart_idx', '0');
	formData.append('order_option_idx', optionIdxArr);
	formData.append('order_item_price', totalPrice);
	formData.append('order_option_name', option_name);
	formData.append('order_option_price', option_price.map(String));
	formData.append('order_quantity', order_quantity);

	const request = new XMLHttpRequest();
	request.open("GET", "/javagreenS_ljs/order/orderCheck");
	request.send(formData);
	*/
}

/* 장바구니 담기 */
function inputCart() {
	/*
		필요한 자료 리스트
		1. 회원 고유번호(session에서 받아오기)
		2. 상품 고유번호
		3. 회원 아이디(session에서 받아오기)
		4. 옵션 고유번호(배열)
		7. 주문 수량
		8. 옵션 사용여부
	*/
	let item_option_flag = $("#item_option_flag").val();
	//상품을 선택했는지 확인
	if(optionIdxArr.length == 0 && item_option_flag == 'y') {
		alert("옵션을 선택하세요.");
		return false;
	}
	
		
	let loginFlag = $("#loginFlag").val();
	
	if(loginFlag == 'no') {
		alert("로그인이 필요한 서비스입니다.");
		let url = "/javagreenS_ljs/user/userLoginOther";
  		let winX = 1300;
        let winY = 700;
        let x = (window.screen.width/2) - (winX/2);
        let y = (window.screen.height/2) - (winY/2)
		window.open(url, "nWin", "width="+winX+",height="+winY+", left="+x+", top="+y+", resizable = no, scrollbars = no");
		setInterval(function(){
			$("#navBar").load(location.href+" #navBar>*","");
		}, 2000);
		return false;
	}
	
	/*
	//장바구니 담기전
	//로그인 상태인지 확인
	$.ajax({
		type : "post",
		url : "/javagreenS_ljs/user/loginCheck",
		async: false,
		success : function(data) {
			if(data == '0') {
				alert("로그인이 필요한 서비스입니다.");
				let url = "/javagreenS_ljs/user/userLoginOther";
	      		let winX = 1300;
	            let winY = 700;
	            let x = (window.screen.width/2) - (winX/2);
	            let y = (window.screen.height/2) - (winY/2)
	   			window.open(url, "nWin", "width="+winX+",height="+winY+", left="+x+", top="+y+", resizable = no, scrollbars = no");
	   			setInterval(function(){
					$("#navBar").load(location.href+" #navBar>*","");
				}, 2000);
				return false;
			}
		},
		error : function() {
			alert("전송오류.");
		}
	});
	*/
	
	let item_idx = $("#item_idx").val();
	if(totalAmount == 0) {
		totalAmount = 1;
	}
	
	let data = {
		item_idx : item_idx,
		item_option_flag : item_option_flag,
		optionIdxArr : optionIdxArr,
		option_quantity : order_quantity,
		quantity : totalAmount,
		total_price : totalPrice
	}
	
	$.ajax({
		type : "post",
		traditional: true,
		url : "/javagreenS_ljs/cart/inputCart",
		data : data,
		success : function(res) {
			if(res == '1') {
				let an = confirm("장바구니에 상품을 담았습니다. \n장바구니로 이동하시겠습니까?");
				if(an) {
					location.href="/javagreenS_ljs/cart/cartList";
				}
				else {
					location.reload();
				}
			}
		},
		error : function() {
			/*alert("전송오류.");*/
		}
	});
	
}

function showImage(idx) {
	$("#showImage"+idx).slideDown(300);
}

function hideImage(idx) {
	$("#showImage"+idx).slideUp(300);
}

function ItemQnaOpen(item_idx,flag) {
	if(flag == 'no') {
		alert("로그인 후 이용하실 수 있습니다.");
		return false;
	}
	else {
		let url = "/javagreenS_ljs/itemQna/itemQnaInsert?item_idx="+item_idx;
		let winX = 600;
	    let winY = 780;
	    let x = (window.screen.width/2) - (winX/2);
	    let y = (window.screen.height/2) - (winY/2);
		window.open(url, "nWin", "width="+winX+",height="+winY+", left="+x+", top="+y+", resizable = no, scrollbars = no");
	}
}

/* 상품 문의 내용 */
function showAnswer(viewflag,session_user_id,user_id,item_qna_idx) {
	if(viewflag == 'n') {
		if(session_user_id == user_id)	{
			let url = "/javagreenS_ljs/itemQna/itemQnaPwdCheck?item_qna_idx="+item_qna_idx;
			let winX = 650;
		    let winY = 650;
		    let x = (window.screen.width/2) - (winX/2);
		    let y = (window.screen.height/2) - (winY/2);
			window.open(url, "nWin", "width="+winX+",height="+winY+", left="+x+", top="+y+", resizable = no, scrollbars = no");
			return false;
		}	
		else {
			alert("해당 상품 문의를 작성한 회원만 조회할 수 있습니다.");
			return false;
		}
	}
	else {
		let url = "/javagreenS_ljs/itemQna/itemQnaContent?item_qna_idx="+item_qna_idx;
		let winX = 650;
	    let winY = 650;
	    let x = (window.screen.width/2) - (winX/2);
	    let y = (window.screen.height/2) - (winY/2);
		window.open(url, "nWin", "width="+winX+",height="+winY+", left="+x+", top="+y+", resizable = no, scrollbars = no");
	}
}


function drawChart(chartElement, chartData) {
	am5.addLicense("AM5C1231231321");
	
	am5.ready(function() {
		// Create root element
		// https://www.amcharts.com/docs/v5/getting-started/#Root_element
		var root = am5.Root.new(chartElement);


		// Set themes
		// https://www.amcharts.com/docs/v5/concepts/themes/
		root.setThemes([
			am5themes_Animated.new(root)
		]);


		// Create chart
		// https://www.amcharts.com/docs/v5/charts/xy-chart/
		var chart = root.container.children.push(am5xy.XYChart.new(root, {
			panX: true,
			panY: true,
			wheelX: "none",
			wheelY: "none"
		}));

		// We don't want zoom-out button to appear while animating, so we hide it
		chart.zoomOutButton.set("forceHidden", true);


		// Create axes
		// https://www.amcharts.com/docs/v5/charts/xy-chart/axes/
		var xRenderer = am5xy.AxisRendererX.new(root, {
			minGridDistance: 30
		});
		
		xRenderer.grid.template.set("visible", false);

		var xAxis = chart.xAxes.push(am5xy.CategoryAxis.new(root, {
			maxDeviation: 0.3,
			categoryField: "label",
			renderer: xRenderer
		}));

		var yAxis = chart.yAxes.push(am5xy.ValueAxis.new(root, {
			maxDeviation: 0.3,
			min: 0,
			renderer: am5xy.AxisRendererY.new(root, {})
		}));


		// Add series
		// https://www.amcharts.com/docs/v5/charts/xy-chart/series/
		var series = chart.series.push(am5xy.ColumnSeries.new(root, {
			name: "Series 1",
			xAxis: xAxis,
			yAxis: yAxis,
			valueYField: "value",
			categoryXField: "label"
		}));

		// Rounded corners for columns
		series.columns.template.setAll({
			cornerRadiusTL: 5,
			cornerRadiusTR: 5
		});

		// Make each column to be of a different color
		series.columns.template.adapters.add("fill", function(fill, target) {
			return chart.get("colors").getIndex(series.columns.indexOf(target));
		});

		series.columns.template.adapters.add("stroke", function(stroke, target) {
			return chart.get("colors").getIndex(series.columns.indexOf(target));
		});

		// Add Label bullet
		series.bullets.push(function() {
			return am5.Bullet.new(root, {
				locationY: 1,
				sprite: am5.Label.new(root, {
					text: "{valueYWorking.formatNumber('#.')}",
					fill: root.interfaceColors.get("alternativeText"),
					centerY: 0,
					centerX: am5.p50,
					populateText: true
				})
			});
		});

		// Set data
		var data = chartData;

		xAxis.data.setAll(data);
		series.data.setAll(data);

		// Get series item by category
		function getSeriesItem(category) {
			for (var i = 0; i < series.dataItems.length; i++) {
				var dataItem = series.dataItems[i];
				if (dataItem.get("categoryX") == category) {
					return dataItem;
				}
			}

		}

		// Make stuff animate on load
		// https://www.amcharts.com/docs/v5/concepts/animations/
		series.appear(1000);
		chart.appear(1000, 100);

		yAxis.hide();
	}); // end am5.ready()
}