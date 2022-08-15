<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<style>
body,h1 {font-family: "Montserrat", sans-serif}
.w3-row-padding img {margin-bottom: 12px}
a {
	text-decoration: none !important;
}
a:hover {
	color : black;
	font-weight: bold;
	cursor: pointer;
}

ul {
	 list-style:none;
	 text-align:center;
}
.sub {
	margin: 10px;
	font-size: 17px;
}
#SidebarMenu {
	display: none;
}
#hoverMenu {
	display: none;
	box-shadow: 0 17px 20px -18px rgba(0, 0, 0, 1);
}

@media screen and (max-width:800px) { 
	#title {
		display: none;
	}
	#hoverMenuBtn {
		display: none;
	}
	#SidebarMenu {
		display: block;
	}
}
body {
  animation: fadein 1s;
  -moz-animation: fadein 1s; /* Firefox */
  -webkit-animation: fadein 1s; /* Safari and Chrome */
  -o-animation: fadein 1s; /* Opera */
}
@keyframes fadein {
    from {
        opacity:70%;
    }
    to {
        opacity:1;
    }
}
@-moz-keyframes fadein { /* Firefox */
    from {
        opacity:70%;
    }
    to {
        opacity:1;
    }
}
@-webkit-keyframes fadein { /* Safari and Chrome */
    from {
  		 opacity:70%;
    }
    to {
        opacity:1;
    }
}
@-o-keyframes fadein { /* Opera */
    from {
        opacity:70%;
    }
    to {
        opacity: 1;
    }
}

</style>
<script type="text/javascript">
	$(document).ready(function(){ 
		//장바구니 담긴 개수 알아오기
		$.ajax({
			type : "post",
			url : "${ctp}/cart/cartCheck",
			success : function (data) {
				$("#cartCnt").html(data);
			},
			error : function () {
			}
		});
		
	 }); 
	
	function hoverMenuOpen() {
		$("#hoverMenu").stop().slideDown(500);
		document.getElementById("pageContent").style.opacity = "70%";
	}
	
 	function hoverMenuClose() {
		$("#hoverMenu").stop().slideUp(500);
		document.getElementById("pageContent").style.opacity = "1";
	}
 	
	// Toggle grid padding
	function myFunction() {
	  var x = document.getElementById("myGrid");
	  if (x.className === "w3-row") {
	    x.className = "w3-row-padding";
	  } else { 
	    x.className = x.className.replace("w3-row-padding", "w3-row");
	  }
	}
	
	// Open and close sidebar
	function sidebarMenuopen() {
	  document.getElementById("mySidebar").style.width = "50%";
	  document.getElementById("mySidebar").style.display = "block";
	}
	
	function sidebarMenuClose() {
	  document.getElementById("mySidebar").style.display = "none";
	}
	
	function inquiryInsert() {
		let loginFlag = $(".loginFlag").val();
		
		if(loginFlag == 'no') {
			alert("로그인이 필요한 서비스입니다.");
			return false;
		}
		
		let url = "${ctp}/main/inquiryInsert";
		let winX = 650;
	    let winY = 650;
	    let x = (window.screen.width/2) - (winX/2);
	    let y = (window.screen.height/2) - (winY/2);
		window.open(url, "nWin", "width="+winX+",height="+winY+", left="+x+", top="+y+", resizable = no, scrollbars = no");
	}
</script>

<!-- Sidebar -->
<nav class="w3-sidebar w3-black w3-animate-top w3-xlarge" style="display:none;padding-top:150px" id="mySidebar">
  <a href="javascript:void(0)" onclick="sidebarMenuClose()" class="w3-button w3-black w3-hover-black w3-xlarge w3-padding w3-display-topright" style="padding:6px 24px; margin-top: 50px;">
    <i class="fa fa-remove"></i>
  </a>
  <div class="w3-bar-block w3-center">
  	<c:if test="${empty sUser_id}">
  		<a href="${ctp}/user/userLogin" class="w3-bar-item w3-button w3-text-grey w3-hover-black">LOGIN</a>
  		<a href="${ctp}/user/userJoin" class="w3-bar-item w3-button w3-text-grey w3-hover-black">JOIN</a>
  	</c:if>
  	<c:if test="${!empty sUser_id}">
  		<a href="${ctp}/user/userLogout" class="w3-bar-item w3-button w3-text-grey w3-hover-black">LOGOUT</a>
  	</c:if>
  	<c:if test="${sLevel == 0}">
  		<a href="${ctp}/admin/mainHome" class="w3-bar-item w3-button w3-text-grey w3-hover-black">ADMIN</a>
  	</c:if>
  	<a href="${ctp}/main/bestItem" class="w3-bar-item w3-button w3-text-grey w3-hover-black">베스트 상품</a>
  	<a href="${ctp}/plant/boardList" class="w3-bar-item w3-button w3-text-grey w3-hover-black">식물 상담실</a>
  	<a href="${ctp}/notice/list" class="w3-bar-item w3-button w3-text-grey w3-hover-black">공지사항</a>
  	<!-- <a href="#" class="w3-bar-item w3-button w3-text-grey w3-hover-black">FAQ</a> -->
  	<a href="${ctp}/user/myPageOpen" class="w3-bar-item w3-button w3-text-grey w3-hover-black">마이페이지</a>
  	<a href="javascript:inquiryInsert()" class="w3-bar-item w3-button w3-text-grey w3-hover-black">1:1문의</a>
  </div>
</nav>

<!-- Nav  -->
<div class="w3-top w3-white">
	<a href="${ctp}/main/mainHome" style="text-decoration: none">
	    <img src="${ctp}/images/logo.png" alt="logo" style="width:47px; margin-left:5px;" id="mainImage">
	</a>
	<c:if test="${empty sUser_id}">
		<span class="w3-button w3-white w3-hover-white w3-large mt-2"><a href="${ctp}/user/userLogin">LOGIN</a></span>
		<span class="w3-button w3-white w3-hover-white w3-large mt-2"><a href="${ctp}/user/userJoin">JOIN</a></span>
	</c:if>
	<c:if test="${!empty sUser_id}">
		<span class="w3-button w3-white w3-hover-white w3-large mt-2"><a href="${ctp}/user/userLogout">LOGOUT</a></span>
	</c:if>
	<span class="w3-button w3-white w3-hover-khaki w3-xlarge w3-right" id="SidebarMenu" onclick="sidebarMenuopen()">
		<i class="fa fa-bars"></i>
	</span> 
	<span class="w3-button w3-white w3-hover-khaki w3-xlarge w3-right" id="hoverMenuBtn" onmouseover="hoverMenuOpen()">
		<i class="fa fa-bars"></i>
	</span> 
	<c:if test="${sLevel == 0}">
		<span class="w3-button w3-white w3-hover-white w3-large mt-2"><a href="${ctp}/admin/mainHome">ADMIN</a></span>
	</c:if>
	<a href="${ctp}/cart/cartList" class="w3-button w3-white w3-hover-white w3-xlarge w3-right"><i class="fa fa-shopping-cart"></i><span class="badge badge-pill w3-2021-marigold" id="cartCnt" style="font-size:11px;"></span></a>
	<div class="w3-clear"></div>
	<div id="hoverMenu" class="w3-white">
		<div class="w3-row" id="hoverMenuContent">
			<div class="w3-quarter">
				<ul>
					<li><span class="w3-white w3-hover-white w3-xlarge mt-2"><b>Shop</b></span></li>
					<li>&nbsp;</li>
					<li class="sub"><a href="${ctp}/main/bestItem">베스트 상품</a></li>
					<li class="sub"><a href="${ctp}/main/offlineStore">오프라인 매장</a></li>
					<li>&nbsp;</li>
				</ul>
			</div>
			<div class="w3-quarter">
				<ul>
					<li><span class="w3-white w3-hover-white w3-xlarge mt-2"><b>Gardening</b></span></li>
					<li>&nbsp;</li>
					<li class="sub"><a href="${ctp}/plant/boardList">식물 상담실</a></li>
				</ul>
			</div>
			<div class="w3-quarter">
				<ul>
					<li><span class="w3-white w3-hover-white w3-xlarge mt-2"><b>Notice</b></span></li>
					<li>&nbsp;</li>
					<li class="sub"><a href="${ctp}/notice/list">공지사항</a></li>
<!-- 					<li class="sub"><a href="javascript:msg()">FAQ</a></li> -->
				</ul>
			</div>
			<div class="w3-quarter">
				<ul>
					<li><span class="w3-white w3-hover-white w3-xlarge mt-2"><b>Member</b></span></li>
					<li>&nbsp;</li>
					<li class="sub"><a href="${ctp}/user/myPageOpen">마이페이지</a></li>
					<li class="sub"><a href="javascript:inquiryInsert()">1:1 문의</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>
<c:if test="${empty sUser_id}">
	<input type="hidden" class="loginFlag" value="no"/>
</c:if>
<c:if test="${!empty sUser_id}">
	<input type="hidden" class="loginFlag" value="yes"/>
</c:if>
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript">
	// 사용할 앱의 JavaScript 키를 설정해 주세요.
	Kakao.init('519384171cff5916d36308792f665979');
	// 채널 1:1 채팅 버튼을 생성합니다.
	Kakao.Channel.createChatButton({
	  container: '#kakao-talk-channel-chat-button',
	  channelPublicId: '_WgLIxj',
	  title: 'consult',
	  size: 'small',
	  color: 'mono',
	  shape: 'pc',
	  supportMultipleDensities: true,
	});
	
    // 채널 추가하기 버튼을 생성합니다.
    Kakao.Channel.createAddChannelButton({
      container: '#kakao-talk-channel-add-button',
      channelPublicId: '_WgLIxj',
      size: 'small',
      supportMultipleDensities: true,
    });
</script>