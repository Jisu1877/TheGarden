<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>오프라인 매장 등록</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
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
		.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
		.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
		.map_wrap {position:relative;width:100%;height:500px;}
		#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
		.bg_white {background:#fff;}
		#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
		#menu_wrap .option{text-align: center;}
		#menu_wrap .option p {margin:10px 0;}  
		#menu_wrap .option button {margin-left:5px;}
		#placesList li {list-style: none;}
		#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
		#placesList .item span {display: block;margin-top:4px;}
		#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
		#placesList .item .info{padding:10px 0 10px 55px;}
		#placesList .info .gray {color:#8a8a8a;}
		#placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
		#placesList .info .tel {color:#009900;}
		#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
		#placesList .item .marker_1 {background-position: 0 -10px;}
		#placesList .item .marker_2 {background-position: 0 -56px;}
		#placesList .item .marker_3 {background-position: 0 -102px}
		#placesList .item .marker_4 {background-position: 0 -148px;}
		#placesList .item .marker_5 {background-position: 0 -194px;}
		#placesList .item .marker_6 {background-position: 0 -240px;}
		#placesList .item .marker_7 {background-position: 0 -286px;}
		#placesList .item .marker_8 {background-position: 0 -332px;}
		#placesList .item .marker_9 {background-position: 0 -378px;}
		#placesList .item .marker_10 {background-position: 0 -423px;}
		#placesList .item .marker_11 {background-position: 0 -470px;}
		#placesList .item .marker_12 {background-position: 0 -516px;}
		#placesList .item .marker_13 {background-position: 0 -562px;}
		#placesList .item .marker_14 {background-position: 0 -608px;}
		#placesList .item .marker_15 {background-position: 0 -654px;}
		#pagination {margin:10px auto;text-align: center;}
		#pagination a {display:inline-block;margin-right:10px;}
		#pagination .on {font-weight: bold; cursor: default;color:#777;}
	    .map_wrap {position:relative;width:100%;height:350px;}
	    .title {font-weight:bold;display:block;}
	    .hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
	    #centerAddr {display:block;margin-top:2px;font-weight: normal;}
	    .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
	</style>
</head>
<body class="w3-light-grey">
<!-- Nav  -->
<jsp:include page="/WEB-INF/views/include/admin_nav.jsp" />
<jsp:include page="/WEB-INF/views/include/admin_sidebarMenu.jsp" />
<!-- !PAGE CONTENT! -->
<div class="w3-main w3-collapse" style="margin-left:250px;margin-top:43px;">
	<div class="w3-row-padding w3-margin-bottom">
	 <!-- Header -->
	 <header style="padding-top:22px">
		<div class="w3-bottombar w3-light-gray w3-padding" style="margin-bottom:20px;">
	   		<span style="font-size:23px;">오프라인 매장 등록</span>
	   </div>
	 </header>
		<div id="map" style="width:1060px;height:500px;position:relative;overflow:hidden;"></div>
		<div id="clickLatlng" style="display:none"></div>
	    <div class="hAddr">
       	 	<span class="title">지도중심기준 행정동 주소정보</span>
        	<span id="centerAddr"></span>
    	</div>
		<div style="margin:20px;">
			<div class="w3-half">
				<div id="searchForm">
					<label><i class="fa-solid fa-location-dot"></i> 등록할 가맹점 주소를 입력하세요</label><br>
					<div class="input-group">
						<input type="text" class="input w3-padding-16 w3-border form-control" onkeyup="enterkey()" id="inputAddress" placeholder="주소 입력""/>
						<div class="input-group-append">
							<input type="button" value="검색" onclick="search()" class="w3-black"/>
						</div>
					</div>
				</div>
				<div id="inforForm" style="display:none">
					<label><i class="fa-solid fa-arrow-pointer"></i> 지도 위에 표시된 가맹점 위치를 클릭하세요.</label><br>
					<a type="button" class="w3-btn w3-gray w3-round-large w3-padding-small" href="${ctp}/admin/offlineStoreInsert">다시 검색</a>
				</div>
				<form name="offlineStoreInsertForm" method="post" action="${ctp}/offline/storeInsert">
					<div id="insertForm" style="display:none">
						<div>
							<label><i class="fa-solid fa-location-dot"></i> 가맹점 이름 : </label>
							<input type="text" class="input w3-padding-16 w3-border form-control" id="name" style="width:40%" name="store_name"/>
						</div>
						<div class="mt-2">
							<label><i class="fa-solid fa-location-dot"></i> 상세 주소(추가 주소) : </label>
							<input type="text" class="input w3-padding-16 w3-border form-control" id="name" style="width:60%" name="detail_address"/>
						</div>
						<label class="mt-2"><i class="fa-solid fa-location-dot"></i>가맹점 전화번호 : </label>
						<div class="input-group mb-3">
						      <div class="input-group-prepend">
							      <select name="tel1" id="tel1" class="w3-select w3-border">
								    <option value="010" selected>010</option>
								    <option value="02">02</option>
								    <option value="031">031</option>
								    <option value="032">032</option>
								    <option value="041">041</option>
								    <option value="042">042</option>
								    <option value="043">043</option>
							        <option value="051">051</option>
							        <option value="052">052</option>
							        <option value="055">055</option>
							        <option value="061">061</option>
							        <option value="062">062</option>
								  </select>
							 		<span>&nbsp; &nbsp;</span><span style="margin-top:6px">-</span> <span>&nbsp; &nbsp;</span>
						      </div>
						      <input type="text" name="tel2" id="tel2" size=8 maxlength=4 class="w3-border"/><span>&nbsp; &nbsp;</span><span style="margin-top:6px">-</span><span>&nbsp; &nbsp;</span>
						      <input type="text" name="tel3" id="tel3" size=8 maxlength=4 class="w3-border"/>&nbsp; &nbsp;
						</div> 
						<div>
						  	<input type="button" class="w3-btn w3-lime w3-round-large w3-padding-small" value="등록" onclick="offlineStoreInsert()">&nbsp; &nbsp;
						  	<a type="button" class="w3-btn w3-gray w3-round-large w3-padding-small" href="${ctp}/admin/offlineStoreInsert">다시 검색</a>
						</div>
						<input type="hidden" name="lat" id="lat"/>
						<input type="hidden" name="lng" id="lng"/>
						<input type="hidden" name="rode_address" id="rodeAddress"/>
						<input type="hidden" name="address" id="address"/>
						<input type="hidden" name="store_tel" id="store_tel"/>
						<input type="hidden" name="qr_url" id="qr_url"/>
					</div>
				</form>
				<br>
				<p><br></p>
			</div>
			<div class="w3-half pl-5">
				<div class="mb-2">
					<i class="fa-solid fa-circle-info"></i> 가맹점 등록 방법<br>
				</div>
				<div>
					1. 가맹점 주소를 입력한다.<br>
					2. 가맹점 위치를 지도 상에서 선택한다.<br>
					3. 가맹점 정보를 입력 후 등록 버튼을 클릭한다.<br>
				</div>
			</div>
		</div>
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=519384171cff5916d36308792f665979&libraries=services"></script>
		<script>
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		        level: 1 // 지도의 확대 레벨
		    };
	
			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption); 
			
			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder();
			
			search('사직대로 109');
					
			// 지도를 클릭한 위치에 표출할 마커입니다
			var marker = new kakao.maps.Marker({ 
			    // 지도 중심좌표에 마커를 생성합니다 
			    position: map.getCenter() 
			}); 
			// 지도에 마커를 표시합니다
			marker.setMap(map);
	
			// 지도에 클릭 이벤트를 등록합니다
			// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
			kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
			    
			    // 클릭한 위도, 경도 정보를 가져옵니다 
			    var latlng = mouseEvent.latLng; 
			    
			    // 마커 위치를 클릭한 위치로 옮깁니다
			    marker.setPosition(latlng);
			    
			    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
			    message += '경도는 ' + latlng.getLng() + ' 입니다';
			    
			    var resultDiv = document.getElementById('clickLatlng'); 
			    resultDiv.innerHTML = message;
			    
			    $("#lat").val(latlng.getLat());
			    $("#lng").val(latlng.getLng());
			    
			});
			
			function search(addr) {
				if (addr == null || addr == '') {
					addr = $("#inputAddress").val();
					
					$("#searchForm").attr('style', 'display:none');
					$("#inforForm").attr('style', 'display:block');
				}
				
				
				// 주소로 좌표를 검색합니다
				geocoder.addressSearch(addr, function(result, status) {
				
				    // 정상적으로 검색이 완료됐으면 
				     if (status === kakao.maps.services.Status.OK) {
				
				        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
				
				         // 결과값으로 받은 위치를 마커로 표시합니다
				        var marker = new kakao.maps.Marker({
				            map: map,
				            position: coords
				        });
					
				        // 인포윈도우로 장소에 대한 설명을 표시합니다
 				       /*  var infowindow = new kakao.maps.InfoWindow({
				            content: '<div style="width:150px;text-align:center;padding:6px 0;">검색하신 위치입니다.</div>'
				        });
				        infowindow.open(map, marker); */
				        
				        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				        map.setCenter(coords);
				    } 
				});
			}
			
	
			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder();
	
			var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
			    infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
	
			// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
			searchAddrFromCoords(map.getCenter(), displayCenterInfo);
	
			// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
			kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
			    searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
			        if (status === kakao.maps.services.Status.OK) {
			            var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
			            detailAddr += '<div class="w3-white">지번 주소 : ' + result[0].address.address_name + '</div>';
			            
			            var content = '<div class="bAddr">' +
			                            '<span class="title">주소정보</span>' + 
			                            detailAddr + 
			                        '</div>';
	
			            // 마커를 클릭한 위치에 표시합니다 
			            marker.setPosition(mouseEvent.latLng);
			            marker.setMap(map);
	
			            // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
			            infowindow.setContent(content);
			            infowindow.open(map, marker);
			            
			            $("#rodeAddress").val(result[0].road_address.address_name);
			            $("#address").val(result[0].address.address_name);
			            
			            $("#searchForm").attr('style', 'display:none');
						$("#inforForm").attr('style', 'display:none');
						$("#insertForm").attr('style', 'display:block');
			        }   
			    });
			});
	
			// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
			kakao.maps.event.addListener(map, 'idle', function() {
			    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
			});
	
			function searchAddrFromCoords(coords, callback) {
			    // 좌표로 행정동 주소 정보를 요청합니다
			    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
			}
	
			function searchDetailAddrFromCoords(coords, callback) {
			    // 좌표로 법정동 상세 주소 정보를 요청합니다
			    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
			}
	
			// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
			function displayCenterInfo(result, status) {
			    if (status === kakao.maps.services.Status.OK) {
			        var infoDiv = document.getElementById('centerAddr');
	
			        for(var i = 0; i < result.length; i++) {
			            // 행정동의 region_type 값은 'H' 이므로
			            if (result[i].region_type === 'H') {
			                infoDiv.innerHTML = result[i].address_name;
			                break;
			            }
			        }
			    }    
			}
			
			function offlineStoreInsert() {
				let name = $("#name").val();
				let tel1 = $("#tel1").val();
			    let tel2 = $("#tel2").val();
			    let tel3 = $("#tel3").val();
			    let tel = tel1 + "-" + tel2 + "-" + tel3;
			    
			    let regTel = /^\d{2,3}-\d{3,4}-\d{4}$/;
			    
			    if(name == "") {
			    	alert("가맹점 이름을 입력하세요");
			    	return false;
			    }
			    
			    if(tel1 == "" || tel2 == "" || tel3 == "") {
			    	alert("가맹점 전화번호를 입력하세요.");
			    	return false;
			    }
			    
			    if(name.length > 20) {
			    	alert("가맹점 이름은 20자 이내로 입력하세요.");
			    }
			    
		    	if(tel2 != "" && tel3 != "") {
					if(!regTel.test(tel)) {
				        alert("전화번호 형식에 맞지않습니다.(000-0000-0000)");
				        return false;
				    }
			    }
		    	
		    	let ans = confirm("지도상에 조회되는 주소가 가맹점의 주소가 맞습니까?");
		    	if(!ans) {
		    		return false;
		    	}
		    	
		    	$("#store_tel").val(tel);
		    	
		    	let lat = $("#lat").val();
		    	let lng = $("#lng").val();
		    	
		    	let qr_url = 'https://map.kakao.com/link/to/' + name + ','  + lat + ',' + lng;
		    	
		    	$("#qr_url").val(qr_url);
		    	
		    	offlineStoreInsertForm.submit();
			}
			
			function enterkey() {
				if (window.event.keyCode == 13) {
					 search();
			    }
			}
			</script>
		</div>
	</div>
</div>
</body>
</html>