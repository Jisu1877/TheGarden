<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 조회/수정</title>
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
	   		margin-right: 10px;
		}
		.tableStyle {
			width : 100%;
	  		overflow-x : auto;
	  		white-space:nowrap;
	  		border-radius: 15px;
	  		background-color: white;
	  	}
	  	.switch {
		  position: relative;
		  display: inline-block;
		  width: 60px;
		  height: 34px;
		}
		
		.switch input { 
		  opacity: 0;
		  width: 0;
		  height: 0;
		}
		
		.slider {
		  position: absolute;
		  cursor: pointer;
		  top: 0;
		  left: 0;
		  right: 0;
		  bottom: 0;
		  background-color: #ccc;
		  -webkit-transition: .4s;
		  transition: .4s;
		}
		
		.slider:before {
		  position: absolute;
		  content: "";
		  height: 26px;
		  width: 26px;
		  left: 4px;
		  bottom: 4px;
		  background-color: white;
		  -webkit-transition: .4s;
		  transition: .4s;
		}
			  	
	  	input:checked + .slider {
		  background-color: #2196F3;
		}
		
		input:focus + .slider {
		  box-shadow: 0 0 1px #2196F3;
		}
		
		input:checked + .slider:before {
		  -webkit-transform: translateX(26px);
		  -ms-transform: translateX(26px);
		  transform: translateX(26px);
		}
		
		/* Rounded sliders */
		.slider.round {
		  border-radius: 34px;
		}
		
		.slider.round:before {
		  border-radius: 50%;
		}
	</style>
	<script>
		let itemCode = "";
		let remember = 0;
		/*function checkOnlyOne(element, code) {
			
		  itemCode = code;
		  const checkboxes 
		      = document.getElementsByName("itemCheck");
		  
		  checkboxes.forEach((cb) => {
		    cb.checked = false;
		  });
		  
		  element.checked = true;
		  
		  $("input[name=itemCheck]").prop("checked", false);
		  $(element).prop("checked", true);
		}*/
		
		function itemCheck(idx) {
			if($("#itemCheck"+idx).is(":checked") == true) {
				$("input:checkbox[id='itemCheck"+idx+"']").prop("checked", false);
				remember = 0;
			}
			else {
				$("input[name=itemCheck]").prop("checked", false);
				$("input:checkbox[id='itemCheck"+idx+"']").prop("checked", true);
				remember = 1;
			}
		}
		
		function itemInquire() {
			if(remember == 0){
				alert("조회를 원하는 상품을 선택하세요.");
				return false;
			}
			itemCode = $("input[name=itemCheck]:checked").data("code");
			location.href = "${ctp}/admin/item/itemInquire?item_code="+itemCode;
		}
		
		function itemUpdate() {
			if(remember == 0){
				alert("수정을 원하는 상품을 선택하세요.");
				return false;
			}
			itemCode = $("input[name=itemCheck]:checked").data("code");
			location.href = "${ctp}/admin/item/itemUpdate?item_code="+itemCode;
		}
		
		function itemDelete() {
			if(remember == 0){
				alert("삭제를 원하는 상품을 선택하세요.");
				return false;
			}
			
			let ans = confirm("정말로 해당 상품을 삭제하시겠습니까?");
			if(!ans) return false;
			
			itemCode = $("input[name=itemCheck]:checked").data("code");
			location.href = "${ctp}/admin/item/itemDelete?item_code="+itemCode;
		}
		
		function displayFlag(idx,flag) {
			$.ajax({
				type : "post",
				url : "${ctp}/admin/item/displayFlagSW",
				data : {item_idx : idx,
						display_flag : flag},
				success : function(res) {
					location.reload();
				},
				error : function() {
					alert("전송오류.");
				}
			});
		}
		
    	//페이지사이즈 검색
      	function pageCheck() {
			let pageSize = $("#pageSize").val();
			location.href="${ctp}/admin/item/itemList?part=${searchVO.part}&pag=${pag}&pageSize="+pageSize;
		}
    	
      	//분류별 검색
    	function partCheck() {
			let part = $("select[name=part]").val();
			let pageSize = $("#pageSize").val();
			location.href="${ctp}/admin/item/itemList?part="+part+"&pag=${pag}&pageSize="+pageSize;
		}
      	
    	/* 상세 검색*/
		function submitForm() {
			searchForm.submit();
		}
	</script>
</head>
<body class="w3-light-grey">
<!-- Nav  -->
<jsp:include page="/WEB-INF/views/include/admin_nav.jsp" />
<jsp:include page="/WEB-INF/views/include/admin_sidebarMenu.jsp" />

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:250px;margin-top:43px;">

 	<!-- content  -->
 	<div class="w3-row-padding w3-margin-bottom">
 	
	    <!-- Header -->
		<header style="padding-top:22px;">
			<div class="w3-bottombar w3-light-grey w3-padding" style="margin-bottom: 20px; font-size:23px;">
		    	상품 관리
		    </div>
		</header>
		
		<!-- 상세 검색 -->
		<form id="searchForm" name="searchForm" method="GET" action="${ctp}/admin/item/itemList" onsubmit="return searchCheck();">
			<div class="w3-row">
				<div class="w3-half mt-2 mb-4">
				   	<div class="input-group">
						<select name="search" class="w3-select w3-round-large mr-2 w3-border" style="width:15%">
				   			<option value="item_name" ${searchVO.search == 'item_name' ? 'selected' : ''}>상품명</option>
				   			<option value="item_code" ${searchVO.search == 'item_code' ? 'selected' : ''}>상품코드</option>
				   		</select>
				   		<input type="text" name="searchValue" id="searchValue" value="${searchVO.searchValue}" class="w3-input w3-border w3-round-large mr-2" style="width:30%">
				   		<a href="javascript:submitForm()" class="w3-button w3-khaki w3-hover-khaki w3-round-large mr-3" style="width:13%;">검색</a>
	   					<a href="${ctp}/admin/item/itemList" class="w3-button w3-white w3-hover-white w3-round-large">Reset</a>
			   		</div>
		   		</div>
		   		<div class="w3-half mt-2 mb-4">
		   			<div class="w3-col m8">
		   				<a href="javascript:itemInquire()" class="w3-btn w3-round-large w3-2021-buttercream">상품조회</a>&nbsp;&nbsp;
						<a href="javascript:itemUpdate()" class="w3-btn w3-round-large w3-2020-sunlight">상품수정</a>&nbsp;&nbsp;
						<a href="javascript:itemDelete()" class="w3-btn w3-round-large w3-2021-desert-mist">상품삭제</a>&nbsp;&nbsp;
		   			</div>
		   			<div class="w3-col m4">
	   					<select name="pageSize"  id="pageSize" onchange="submitForm();" class="w3-select w3-round-large mr-2 w3-border w3-right" style="width:30%;">
							<option value="5" ${searchVO.pageSize == 5 ? 'selected' : '' }>5건</option>
							<option value="10" ${searchVO.pageSize == 10 ? 'selected' : '' }>10건</option>
							<option value="15" ${searchVO.pageSize == 15 ? 'selected' : '' }>15건</option>
							<option value="20" ${searchVO.pageSize == 20 ? 'selected' : '' }>20건</option>
						</select>
			   			<select name="part"  id="part" onchange="submitForm();" class="w3-select w3-round-large mr-2 w3-border w3-right" style="width:45%;">
							<option value="전체" ${searchVO.part == '전체' ? 'selected' : ''}>전체</option>
							<option value="판매중" ${searchVO.part == '판매중' ? 'selected' : ''}>판매중</option>
							<option value="전시중지" ${searchVO.part == '전시중지' ? 'selected' : ''}>전시중지</option>
							<option value="품절" ${searchVO.part == '품절' ? 'selected' : ''}>품절</option>
						</select>
		   			</div>
			   	</div>
	   		</div>
   		</form>
		<div class="w3-responsive tableStyle">
			<table class="w3-table w3-striped" style="border-collapse:separate;">
				<thead>
		        	<tr class="w3-2021-inkwell">
		        		<th><i class="fa-solid fa-check"></i></th>
		        		<th class="text-center">상품코드</th>
		        		<th class="text-center">상품명</th>
		        		<th class="text-center" width="15%">판매가</th>
		        		<th class="text-center" width="15%">할인가</th>
		        		<th class="text-center">포인트지급</th>
		        		<th class="text-center">지급포인트</th>
		        		<th class="text-center">판매상태</th>
		        		<th class="text-center">전시상태</th>
		        		<th class="text-center">재고수량</th>
		        		<th class="text-center">재입고 예정일</th>
		        		<th class="text-center">상품등록일</th>
		        	</tr>
				</thead>
				<tbody>
	        	<c:forEach var="vo" items="${vos}">
	        		<tr onclick="itemCheck(${vo.item_idx})">
	        			<td class="text-center">
	        				<input type="checkbox" id="itemCheck${vo.item_idx}" name="itemCheck" data-code="${vo.item_code}" onclick="itemCheck(${vo.item_idx})">
	        			</td>
	        			<td class="text-center">${vo.item_code}</td>
	        			<td>${vo.item_name}</td>
	        			<td class="text-center">
	        				<c:set var="priceFmt" value="${vo.sale_price}"/>
			        		<fmt:formatNumber value="${priceFmt}"/>원
	        			</td>
	        			<td class="text-center">
	        				<c:set var="discountPriceFmt" value="${vo.seller_discount_amount}"/>
			        		<fmt:formatNumber value="${discountPriceFmt}"/>원
	        			</td>
	        			<td class="text-center">
	        				<c:if test="${vo.seller_point_flag == 'y'}">
	        					<i class="fa-solid fa-o"></i>
	        				</c:if>
	        				<c:if test="${vo.seller_point_flag == 'n'}">
	        					<i class="fa-solid fa-x"></i>
	        				</c:if>
	        			</td>
	        			<td class="text-center">
	        				<c:if test="${vo.seller_point_flag == 'y'}">
	        					${vo.seller_point}Point
	        				</c:if>
	        				<c:if test="${vo.seller_point_flag == 'n'}">
	        					-
	        				</c:if>
	        			</td>
	        			<td class="text-center">
	        				<c:if test="${vo.sold_out == '0' && vo.display_flag == 'y'}">
	       						판매 중
	        				</c:if>
	        				<c:if test="${vo.sold_out == '0' && vo.display_flag == 'n'}">
	       						전시중지
	        				</c:if>
	        				<c:if test="${vo.sold_out == '1'}">
	        					품절
	        				</c:if>
	        			</td>
	        			<td class="text-center">
	        				<label class="switch">
	        					<input type="checkbox" ${vo.display_flag == 'y' ? 'checked' : ''} onclick="displayFlag('${vo.item_idx}','${vo.display_flag}')">
						  		<span class="slider round"></span>
							</label>
	        			</td>
	        			<td class="text-center">
	        				${vo.stock_quantity}개
	        			</td>
	        			<td class="text-center">
	        				<c:if test="${vo.sold_out == '1'}">
	        					${vo.stock_schedule_date}
	        					<c:if test="${vo.stock_schedule_date == ''}">
	        						등록 요망
	        					</c:if>
	        				</c:if>
	        				<c:if test="${vo.sold_out == '0'}">
	        					-
	        				</c:if>
	        			</td>
	        			<td class="text-center">
	        				${fn:substring(vo.created_date, 0,19)}
	        			</td>
	        		</tr>
	        	</c:forEach>
	        	<tr>
	        		<td colspan="12" class="p-1 m-1 text-center">
	        			<c:if test="${fn:length(vos) < 1}">
	        				조회된 내역이 없습니다.
	        			</c:if>
	        		</td>
	        	</tr>
	        	</tbody>
        	</table>
     	</div>
		<!-- 블록 페이징 처리 -->
		<div class="w3-center w3-padding-32">
			<div class="mb-2"><b>${searchVO.pag} Page</b></div>
				<div class="w3-bar w3-white">
					<c:if test="${searchVO.curBlock > 0}">
						<a href="${ctp}/admin/item/itemList${searchVO.getParams(searchVO)}&pag=1" class="w3-bar-item w3-button w3-hover-black">«</a>
						<a href="${ctp}/admin/item/itemList${searchVO.getParams(searchVO)}&pag=${searchVO.curBlockStartPage - 1}" class="w3-bar-item w3-button w3-hover-black">＜</a>
					</c:if>
					<c:forEach var="i" begin="${searchVO.curBlockStartPage}" end="${searchVO.curBlockEndPage}">
						<c:if test="${searchVO.pag eq i}"><span style="background:gray; color:white;"></c:if>
							<a href="${ctp}/admin/item/itemList${searchVO.getParams(searchVO)}&pag=${i}" class="w3-bar-item w3-button w3-hover-gray">${i}</a>
						<c:if test="${searchVO.pag eq i}"></span></c:if>
					</c:forEach>
					<c:if test="${searchVO.curBlock < searchVO.lastBlock}">
						<a href="${ctp}/admin/item/itemList${searchVO.getParams(searchVO)}&pag=${searchVO.curBlockEndPage + 1}" class="w3-bar-item w3-button w3-hover-black">＞</a>
						<a href="${ctp}/admin/item/itemList${searchVO.getParams(searchVO)}&pag=${searchVO.totPage}" class="w3-bar-item w3-button w3-hover-black">»</a>
					</c:if>
					<c:if test="${searchVO.pag != searchVO.totPage}">
					</c:if>
		  		</div>
			</div>
 		</div>
	</div>
</body>
</html>