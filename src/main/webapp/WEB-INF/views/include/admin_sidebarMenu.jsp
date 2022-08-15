<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<style>
	.menu {
		font-size: 16px;
		border-bottom: 1px solid white;
		padding-bottom: 17px;
		padding-top: 17px;
	}
	button {
		border-style: none;
	}
	a:hover {
		color : burlywood;
		font-weight : 600;
		cursor: pointer;
	}
</style>
<script>
//Open and close sidebar
function sidebarMenuopen() {
  document.getElementById("mySidebar").style.width = "30%";
  document.getElementById("mySidebar").style.display = "block";
}

function sidebarMenuClose() {
  document.getElementById("mySidebar").style.display = "none";
}

function userImageChange() {
	
	let user_image = document.getElementById("user_image").value;
	
	let maxSize = 1024 * 1024 * 20;
	let fileSize = 0;
	
	if (user_image.indexOf(" ") != -1) { // 혹시 파일명에 공백이 있으면~~~
		alert("업로드 파일명에 공백을 포함할 수 없습니다.");
		return false;
	}
	else if (user_image != "") {
		let ext = user_image.substring(user_image.lastIndexOf(".") + 1);
		let uExt = ext.toUpperCase();
		fileSize += document.getElementById("user_image").files[0].size; //파일 선택이 1개밖에 안되기 때문에 0번 배열에만 파일이 있는 상태이다.

		if (uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "JPEG" && uExt != "JFIF") {
			alert("업로드 가능한 파일은 'JPG/GIF/PNG/JPEG/JFIF' 입니다.");
			return false;
		}
	}

	if (fileSize > maxSize) {
		alert("업로드할 파일의 총 최대 용량은 20MByte 입니다.");
		return false;
	}
	
	$("#myPhoto").val(user_image);
	
	userImageForm.submit();
}
</script>
<%-- <!-- Sidebar -->
<nav class="w3-sidebar w3-black w3-animate-top w3-large" style="display:none;padding-top:150px" id="mySidebar">
  <a href="javascript:void(0)" onclick="sidebarMenuClose()" class="w3-button w3-black w3-hover-black w3-xlarge w3-padding w3-display-topright" style="padding:6px 24px; margin-top: 50px;">
    <i class="fa fa-remove"></i>
  </a>
  <div class="w3-bar-block w3-right">
  	<h4>일반상품 관리</h4>
	<a href="${ctp}/admin/category/categoryHome" class="w3-bar-item w3-button w3-text-grey w3-hover-black">카테고리관리</a>
	<a href="${ctp}/admin/item/itemInsert" class="w3-bar-item w3-button w3-text-grey w3-hover-black">상품등록</a>
	<a href="${ctp}/admin/item/itemList" class="w3-bar-item w3-button w3-text-grey w3-hover-black">상품조회/수정</a>
  </div>
</nav>
 --%>

<!-- Sidebar/menu -->
<nav class="w3-sidebar w3-collapse w3-2019-brown-granite" style="z-index:3; width:250px; overflow:scroll" id="mySidebar"><br>
  <div class="w3-container w3-row">
    <div class="w3-col s12 w3-bar w3-center">
      <p class="w3-center" style="margin-top:10px;">
      	<img src="${ctp}/data/user/${userVO.user_image}" class="w3-circle" style="height:100px;width:100px">
      	<form name="userImageForm" method="post" action="${ctp}/user/adminImageChange" enctype="multipart/form-data">
         	<a href="javascript:$('#user_image').click()" title="프로필 사진 변경" style="font-size:13px;">프로필 사진 변경</a>
         	<input type="file" id="user_image" name="user_image" style="display:none" accept=".png, .jpg, .jpeg, .jfif, .gif" onchange="userImageChange();">
         	<input type="hidden" name="myPhoto" id="myPhoto">
         </h5>
         </form>
      </p>
     <span>Welcome, <strong> ${sUser_id}</strong></span><br>
    </div>
  </div>
  <hr>
  <div class="w3-container">
  	<div class="w3-dropdown-click">
	  <button onclick="slideDown(2)" class="w3-2019-brown-granite menu"><strong>판매 관리</strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <i class="fa-solid fa-sort-down"></i></button>
	  <div id="Demo2" class="w3-bar-block w3-2020-ash" style="display: none">
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="${ctp}/admin/order/orderList">통합 주문 관리</a></button>
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="${ctp}/admin/order/orderDelivery">배송 처리 관리</a></button>
	  </div>
	</div>
  	<div class="w3-dropdown-click">
	  <button onclick="slideDown(1)" class="w3-2019-brown-granite menu"><strong>상품 관리</strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <i class="fa-solid fa-sort-down"></i></button>
	  <div id="Demo1" class="w3-bar-block w3-2020-ash" style="display: none">
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="${ctp}/admin/category/categoryHome">카테고리 관리</a></button>
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="${ctp}/admin/item/itemInsert">상품 등록</a></button>
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="${ctp}/admin/item/itemList">상품 관리</a></button>
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="${ctp}/itemQna/itemQnaList">상품 문의 관리</a></button>
	  </div>
	</div>
  	<!-- <div class="w3-dropdown-click">
	  <button onclick="slideDown(3)" class="w3-2019-brown-granite menu"><strong>경매판매 관리</strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <i class="fa-solid fa-sort-down"></i></button>
	  <div id="Demo3" class="w3-bar-block w3-2020-ash" style="display: none">
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="">경매상품 관리</a></button>
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="">판매자 관리</a></button>
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="">낙찰(주문) 관리</a></button>
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="">배송현황 관리</a></button>
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="">구매확정 내역</a></button>
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="">취소 관리</a></button>
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="">반품 관리</a></button>
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="">판매방해 관리</a></button>
	  </div>
	</div> -->
  	<div class="w3-dropdown-click">
	  <button onclick="slideDown(4)" class="w3-2019-brown-granite menu"><strong>회원 관리</strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <i class="fa-solid fa-sort-down"></i></button>
	  <div id="Demo4" class="w3-bar-block w3-2020-ash" style="display: none">
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="${ctp}/admin/user/userList">회원 정보 관리</a></button> <!-- 컨트롤러 따로 만들어서 진행..! -->
	  </div>
	</div>
  	<div class="w3-dropdown-click">
	  <button onclick="slideDown(5)" class="w3-2019-brown-granite menu"><strong>게시물 관리</strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <i class="fa-solid fa-sort-down"></i></button>
	  <div id="Demo5" class="w3-bar-block w3-2020-ash" style="display: none">
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="${ctp}/notice/noticeList">공지사항 관리</a></button>
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="${ctp}/admin/plant/boardList">식물 상담실 관리</a></button>
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="${ctp}/review/reviewList">리뷰 관리</a></button>
	  </div>
	</div>
  	<div class="w3-dropdown-click">
	  <button onclick="slideDown(6)" class="w3-2019-brown-granite menu"><strong>문의 관리</strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <i class="fa-solid fa-sort-down"></i></button>
	  <div id="Demo6" class="w3-bar-block w3-2020-ash" style="display: none">
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="${ctp}/inquiry/inquiryList">1:1 문의 관리</a></button>
	  </div>
	</div>
  	<div class="w3-dropdown-click">
	  <button onclick="slideDown(7)" class="w3-2019-brown-granite menu"><strong>기타 관리</strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <i class="fa-solid fa-sort-down"></i></button>
	  <div id="Demo7" class="w3-bar-block w3-2020-ash" style="display: none">
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="${ctp}/offline/offlineStoreInsert">오프라인 매장 등록</a></button>
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="${ctp}/offline/offlineStoreList">오프라인 매장 관리</a></button>
	    <button class="w3-bar-item w3-2019-brown-granite"><a href="${ctp}/extraFile/extraFileList">임시 파일 관리</a></button>
	  </div>
	</div>
  </div>
</nav>

<script>
let sw = 0;
function slideDown(flag) {
	if(sw == 0) {
		$(".w3-2020-ash").hide();
		$("#Demo"+flag).slideDown(400);
		sw = 1;
	}
	else {
		$("#Demo"+flag).slideUp(400);
		sw = 0;
	}
}
</script>