function couponSelect() {
	let point = document.getElementById("point").value;
	let payment_price = $("#total_price").data("price");
	let coupon_user_idx = $("select[name=couponList]").val();
	let rate = $("#optionCoupon_"+coupon_user_idx).data("rate");
	
	if(point != "") {
		let ans = confirm("포인트 할인과 쿠폰 할인 중 하나만 적용할 수 있습니다.\n쿠폰 적용을 선택하시겠습니까?");
			
			if(!ans) {
				$("#couponList").val("0").attr("selected", true);
				return false;
			}
			else {
				$("#point").val("");
				$("#couponList").val(coupon_user_idx).attr("selected", true);
			}
	}
	
	let discount = Number(payment_price) * Number(rate/100);
	
	let payment_price_cal = Number(payment_price) - Number(discount); 
	
	document.getElementById("pointUse").style.display = "block";
	document.getElementById("pointUse").innerHTML = " - " + discount.toString().replace(/\B(?=(\d{3})+(?!\d))/g,',') + "원<font size='3'>("+rate+"% 적용)</font>";
	document.getElementById("priceCalc").style.display = "block";
	
	document.getElementById("priceCalc").innerHTML = " = " + payment_price_cal.toLocaleString() + "원";	
	$(".calcPrice").attr("data-cal", payment_price_cal);
	$(".calcPrice").data("cal", payment_price_cal);
	$("#coupon_amount").val(discount);
	$("#coupon_user_idx").val(coupon_user_idx);
}