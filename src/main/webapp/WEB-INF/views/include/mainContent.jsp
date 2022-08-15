<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<script>
	let storeList = JSON.parse('${storeJson}');
	console.log(storeList);
	
	function categorySearch(code,name) {
		location.href="${ctp}/main/categorySearch?code="+code+"&name="+name;
	}
	
	function categorySearch2(code,idx,name,groupName) {
		location.href="${ctp}/main/categorySearch2?code="+code+"&name="+name+"&idx="+idx+"&groupName="+groupName;
	}
	
</script>
  <!-- Category 보이기  -->
  <div style="margin-bottom: 50px; margin-left: 16px;">
	<div class="w3-bar" style="font-size: 13px;">
	   <c:forEach var="vo" items="${categoryVOS}" varStatus="st">
			<div class="w3-dropdown-hover">
				<button class="btn w3-white w3-hover-white" style="font-size: 18px; border-radius:0" onclick="categorySearch('${vo.category_group_code}','${vo.category_group_name}')">${vo.category_group_name}</button>
				<div class="w3-dropdown-content w3-bar-block w3-hover-white">
					<c:set var="i" value="0"/>
					<c:forEach var="cVO" items="${vo.categoryList}">
						<a onclick="categorySearch2('${vo.category_group_code}',${cVO.category_idx},'${cVO.category_name}','${vo.category_group_name}')" class="w3-bar-item btn">${cVO.category_name}</a>
					 </c:forEach>
				</div>
			</div>
		</c:forEach>
	</div>
  </div>
  <jsp:include page="/WEB-INF/views/include/mainItemContent.jsp" />

 
  <hr id="about">

  <!-- About Section -->
  <div class="w3-container w3-padding-32 w3-center">  
    <h2>The Garden Offline Store</h2><br>
    <div id="map" style="height:450px; font-family: 'Montserrat', sans-serif"></div>
    <div class="w3-padding-32">
      <h4><b><span id="store_name"></span></b></h4>
      <h6><i><span id="store_address"></span></i></h6>
      <h6><i><span id="store_tel"></span></i></h6>
      <div id="qr_code"></div>
    </div>
  </div>
  <hr>
  
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=519384171cff5916d36308792f665979&libraries=services,clusterer"></script>
  <script>
		var map = new kakao.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
		    center : new kakao.maps.LatLng(37.715133, 126.734086), // 지도의 중심좌표
		    level : 12 // 지도의 확대 레벨
		});

		var clusterer = new kakao.maps.MarkerClusterer({
		    map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체
		    averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정
		    minLevel: 10, // 클러스터 할 최소 지도 레벨
		    disableClickZoom: true // 클러스터 마커를 클릭했을 때 지도가 확대되지 않도록 설정한다
		});
		
	    var infowindowList = new Array();
	    var markers = $(storeList).map(function(i, store) {
	        var marker = new kakao.maps.Marker({
	            position : new kakao.maps.LatLng(store.lat, store.lng)
	        });
	        
	        var iwContent = 
	        	'<div style="padding:5px;">'+'<a href="javascript:showInfor('+store.offline_store_idx+')">' + store.store_name + '</a>'+'<br><a href="https://map.kakao.com/link/map/' + store.store_name + ',' + store.lat + ',' + store.lng + '" style="color:blue" target="_blank">큰지도보기</a> ' +
	        	' <a href="https://map.kakao.com/link/to/' + store.store_name + ',' + store.lat + ',' + store.lng + '" style="color:blue" target="_blank">길찾기</a></div>'; // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
		    iwPosition = new kakao.maps.LatLng(store.lat, store.lng); //인포윈도우 표시 위치입니다
		    
	     	// 인포윈도우를 생성합니다
	    	var infowindow = new kakao.maps.InfoWindow({
	    	    position : iwPosition, 
	    	    content : iwContent,
	    	    removable : true
	    	});
		    
	    	kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
	    	kakao.maps.event.addListener(marker, 'click', makeOverListener(map, marker, infowindow));
	    	
	    	infowindowList.push(infowindow);
	    	
	    	return marker;
	    });
		
	    // 클러스터러에 마커들을 추가합니다
	    clusterer.addMarkers(markers);
		
		// 마커 클러스터러에 클릭이벤트를 등록합니다
		// 마커 클러스터러를 생성할 때 disableClickZoom을 true로 설정하지 않은 경우
		// 이벤트 헨들러로 cluster 객체가 넘어오지 않을 수도 있습니다
		kakao.maps.event.addListener(clusterer, 'clusterclick', function(cluster) {
		    var level = map.getLevel()-1;
		    map.setLevel(level, {anchor: cluster.getCenter()});
		});
	    
	 	// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
	    function makeOverListener(map, marker, infowindow) {
	        return function() {
	        	hideAllInfowindows();
	        	
	            infowindow.open(map, marker);
	        };
	    }
	 	
	 	function hideAllInfowindows() {
	 		for (const infowin of infowindowList) {
        		infowin.close();
        	}
	 	}
		
	 	function showInfor(idx) {
	 		 var markers = $(storeList).map(function(i, store) {
	 			if(store.offline_store_idx == idx)	{
	 				$("#store_name").html(store.store_name);
	 				
	 				let address = store.rode_address + "("+store.address+")";
	 				
	 				if(store.detail_address != null) {
	 					address = store.rode_address + "("+store.address+") " + store.detail_address;
	 				}
	 				
	 				let tel = "가맹점 연락처 : " + store.store_tel;
	 				
	 				let qr_image = '<img src="/javagreenS_ljs/data/qrCode/'+store.qr_image+'" alt="'+store.qr_image+'" width="150px;"><br><i>Read Me!</i>';
	 				
	 				$("#store_address").html(address);
	 				$("#store_tel").html(tel);
	 				$("#qr_code").html(qr_image);
	 			}
	 		 });
		}
	</script>
  
  