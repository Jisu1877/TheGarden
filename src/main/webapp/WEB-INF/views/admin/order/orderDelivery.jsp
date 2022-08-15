<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>배송 처리 관리</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <script src="${ctp}/js/orderDelivery.js"></script>
    <style>
		body,h1 {font-family: "Montserrat", sans-serif}
		a {
			text-decoration: none;	
		}
		a:hover {
			color : black;
			text-decoration: none;	
		}
		.tableStyle {
	  		width:100%;
	  		overflow-x : auto;
	  		white-space:nowrap;
	  		border-radius: 15px;
	  		background-color: white;
	  	}
	  	td {
	  		vertical-align: middle;
	  	}
	</style>
	<script>
		//페이지사이즈 검색
		function pageCheck() {
			let pageSize = $("#pageSize").val();
			let search = $("select[name=search]").val();
			let searchValue = $("#searchValue").val();
			
			location.href="${ctp}/admin/order/orderDelivery?part=2&pag=${pag}&pageSize="+pageSize+"&search="+search+"&searchValue="+searchValue;
		}
	
		/* 상세 검색*/
		function searchCheck() {
			let search = $("select[name=search]").val();
			let searchValue = $("#searchValue").val();
			let pageSize = $("#pageSize").val();
			
			if(search != "" && searchValue == "") {
				alert("상세 조건을 선택하세요.");
				return false;
			}
			if(search == "" && searchValue != "") {
				alert("상세 검색 내용을 입력하세요.");
				return false;
			}
			
			location.href="${ctp}/admin/order/orderDelivery?part=2&pag=${pag}&pageSize="+pageSize+"&search="+search+"&searchValue="+searchValue;
		}
		
		/* 리셋 */
		function reset() {
			location.href="${ctp}/admin/order/orderDelivery";
		}
		
		/* 택배사 일괄변경 */
		function courier_company_change() {
			let company = $("select[name=courier_company_choice]").val();
			
			$(".courier_company").val(company).prop("selected", true);
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
			<div class="w3-bottombar w3-light-gray w3-padding" style="margin-bottom: 20px;">
		    	<span style="font-size:23px;">배송 처리 관리</span>
		    </div>
		</header>
        <div class="w3-row-padding" style="margin:0 -16px;">
          <div class="w3-third w3-margin-bottom">
          	<div><span style="font-size:14px;"></span></div>
            <label><i class="fa-solid fa-circle-info"></i>&nbsp; 상세 조건</label>
            <select name="search" id="search" class="w3-select w3-border">
   				<option value="">상세 조건 선택</option>
   				<option value="delivery_name" ${search == 'delivery_name' ? 'selected' : '' }>수취인명</option>
   				<option value="delivery_tel" ${search == 'delivery_tel' ? 'selected' : '' }>수취인연락처</option>
   				<option value="name" ${search == 'name' ? 'selected' : '' }>구매자명</option>
   				<option value="tel" ${search == 'tel' ? 'selected' : '' }>구매자연락처</option>
   				<option value="user_id" ${search == 'user_id' ? 'selected' : '' }>구매자 ID</option>
   				<option value="order_number" ${search == 'order_number' ? 'selected' : '' }>주문번호</option>
   				<option value="item_idx" ${search == 'item_idx' ? 'selected' : '' }>상품번호</option>
   				<%-- <option value="7" ${code == 7 ? 'selected' : '' }>송장번호</option> --%>
   			</select>
          </div>
          <div class="w3-third w3-margin-bottom">
          	<label>&nbsp;</label>
          	<input type="text" class="w3-input w3-border" type="text" placeholder="상세검색 내용 입력" name="searchValue" id="searchValue" value="${searchValue}" />
          </div>
          <div class="w3-third w3-margin-bottom">
          	<label>&nbsp;</label><br>
     		<a class="w3-button w3-2019-soybean" onclick="searchCheck()"><i class="fa fa-search w3-margin-right"></i> Search</a>
     		<label>&nbsp;</label>
       			<a class="w3-button w3-2019-terrarium-moss w3-right mr-3" onclick="reset()"><i class="fa-solid fa-arrows-rotate w3-margin-right"></i>Search Reset</a>
    	  </div>
        </div>
   	    <div class="w3-row-padding">
       		<div class="w3-third w3-margin-bottom" style="margin-left:0px; padding-left:0px;">
       			<label>&nbsp;</label>
	     		<select name="pageSize" id="pageSize" onchange="pageCheck()" class="w3-select w3-left" style="width:20%">
					<option value="5" ${pageVo.pageSize == 5 ? 'selected' : '' }>5건</option>
					<option value="10" ${pageVo.pageSize == 10 ? 'selected' : '' }>10건</option>
					<option value="15" ${pageVo.pageSize == 15 ? 'selected' : '' }>15건</option>
					<option value="20" ${pageVo.pageSize == 20 ? 'selected' : '' }>20건</option>
				</select>
       		</div>
   	  		<div class="w3-third w3-margin-bottom"></div>
       		<div class="w3-third w3-margin-bottom">
       		</div>
        </div>
        <div class="w3-margin-bottom">
        	<div>
		    	<form name="excelDownForm" action="${ctp}/excel/deliveryDownload" method="get">
					<a class="w3-button w3-2020-ultramarine-green w3-left w3-small" onclick="excelDown()">
						<span class="iconify" data-icon="icomoon-free:file-excel"></span> 엑셀 다운로드
					</a>
					<input type="hidden" name="company" id="company"/>
				</form>
			</div>
			<div>
				&nbsp;&nbsp;택배사 일괄 변경 : 
				<select name="courier_company_choice" onchange="courier_company_change()" class="w3-select" style="width:15%">
					<option value="CJ대한통운" selected>CJ대한통운</option>
					<option value="롯데택배">롯데택배</option>
					<option value="우체국택배">우체국택배</option>
					<option value="로젠택배">로젠택배</option>
					<option value="한진택배">한진택배</option>
					<option value="경동택배">경동택배</option>
					<option value="대신택배">대신택배</option>
				</select>
			</div>
			<div>
				<a class="w3-button w3-2019-eden w3-small" onclick="sendProcess()">
					<span class="iconify" data-icon="icomoon-free:file-excel"></span> 엑셀 일괄 발송처리
				</a>
			</div>
	    </div>
		<div class="w3-responsive tableStyle">
			<table class="w3-table table-bordered" style="border-collapse:separate;">
				<thead>
		        	<tr class="w3-2021-mint">
		        		<th class="text-center">주문번호</th>
		        		<th class="text-center">상품번호</th>
		        		<th class="text-center">상품명</th>
		        		<th class="text-center">수량</th>
		        		<th class="text-center">결제금액</th>
		        		<th class="text-center">주문일시</th>
		        		<th class="text-center">상세정보</th>
		        		<th class="text-center">주문상태</th>
		        		<th class="text-center">택배사</th>
		        		<th class="text-center">송장번호</th>
		        		<th class="text-center">처리</th>
		        	</tr>
				</thead>
				<tbody>
	        	<c:forEach var="vo" items="${orderList}">
	        		<tr data-idx="${vo.order_idx}">
	        			<td width="5%" class="text-center idx_${vo.order_idx}" style="vertical-align: middle;">${vo.order_number}</td>
	        			<td width="5%" class="text-center" style="padding:0px; vertical-align: middle;">${vo.item_idx}</td>
	        			<td>
	        				 ${fn:substring(vo.item_name, 0, 10)}
						    <c:if test="${fn:length(vo.item_name) > 9}">
						    ...
						    </c:if>
	        			</td>
	        			<td class="text-center">${vo.order_quantity} 개</td>
	        			<td class="text-center">
	        				<fmt:formatNumber value="${vo.item_price}"/> 원	
	        			</td>
	        			<td class="text-center" style="vertical-align: middle;">
	        				${fn:substring(vo.created_date, 0, 10)}
	        			</td>
	        			<td class="text-center infor_${vo.order_idx}" style="vertical-align: middle;">
	        				<a onclick="orderListInfor(${vo.order_idx})">조회</a>
	        			</td>
	        			<td class="text-center" width="7%">
	        				<c:if test="${vo.order_status_code == '1'}">
								<font size="3" color="gray">결제완료</font>
							</c:if>					
							<c:if test="${vo.order_status_code == '2'}">
								<font size="3" color="gray">주문확인</font>
							</c:if>					
							<c:if test="${vo.order_status_code == '3'}">
								<font size="3" color="red">취소완료</font>
							</c:if>					
							<c:if test="${vo.order_status_code == '4'}">
								<font size="3" color="gray">배송중</font>
							</c:if>					
							<c:if test="${vo.order_status_code == '5'}">
								<font size="3" color="gray">배송완료</font>
							</c:if>					
							<c:if test="${vo.order_status_code == '6'}">
								<font size="3" color="gray">구매완료</font>
							</c:if>					
							<c:if test="${vo.order_status_code == '7'}">
								<font size="3" color="red">교환신청 처리 중</font>
							</c:if>					
							<c:if test="${vo.order_status_code == '8'}">
								<font size="3" color="red">교환승인 완료</font>
							</c:if>					
							<c:if test="${vo.order_status_code == '9'}">
								<font size="3" color="red">배송중(교환)</font>
							</c:if>					
							<c:if test="${vo.order_status_code == '10'}">
								<font size="3" color="red">교환거부</font>
							</c:if>					
							<c:if test="${vo.order_status_code == '11'}">
								<font size="3" color="red">환불신청 처리 중</font>
							</c:if>					
							<c:if test="${vo.order_status_code == '12'}">
								<font size="3" color="red">환불승인</font>
							</c:if>					
							<c:if test="${vo.order_status_code == '13'}">
								<font size="3" color="red">환불완료</font>
							</c:if>					
							<c:if test="${vo.order_status_code == '14'}">
								<font size="3" color="red">환불거부</font>
							</c:if>
							<c:if test="${vo.order_status_code == '15'}">
								<font size="3" color="blue">취소 요청</font>
							</c:if>
							<c:if test="${vo.order_status_code == '16'}">
								<font size="3" color="gray">취소 반려</font>
							</c:if>
	        			</td>
	        			<td width="10%">
	        				<select name="courier_company_${vo.order_list_idx}" id="courier_company" class="select w3-left courier_company">
								<option value="CJ대한통운" selected>CJ대한통운</option>
								<option value="롯데택배">롯데택배</option>
								<option value="우체국택배">우체국택배</option>
								<option value="로젠택배">로젠택배</option>
								<option value="한진택배">한진택배</option>
								<option value="경동택배">경동택배</option>
								<option value="대신택배">대신택배</option>
							</select>
	        			</td>
	        			<td width="7%">
	        				<input type="text" class="input" id="order_delivery_number_${vo.order_list_idx}">
	        			</td>
	        			<td class="text-center">
							<a onclick="invoiceinsert(${vo.order_number},${vo.order_list_idx})" class="btn w3-2021-mint btn-sm">입력</a>
	        			</td>
	        		</tr>
	        	</c:forEach>
	        	</tbody>
	        </table>
	    </div>
	    <!-- 블록 페이징 처리 -->
	  <div class="w3-center w3-padding-32">
	 	 <div class="mb-2"><b>${pageVo.pag} Page</b></div>
	    <div class="w3-bar w3-white">
	      <c:if test="${pageVo.curBlock > 0}">
		      <a href="${ctp}/admin/order/orderDelivery?part=2&pag=1&pageSize=${pageVo.pageSize}&search=${search}&searchValue=${searchValue}" class="w3-bar-item w3-button w3-hover-black">«</a>
		      <a href="${ctp}/admin/order/orderDelivery?part=2&pag=${pageVo.curBlockStartPage - 1}&pageSize=${pageVo.pageSize}&search=${search}&searchValue=${searchValue}" class="w3-bar-item w3-button w3-hover-black">＜</a>
	      </c:if>
	      <c:forEach var="i" begin="${pageVo.curBlockStartPage}" end="${pageVo.curBlockEndPage}">
	      	<c:if test="${pageVo.pag eq i}"><span style="background:gray; color:white;"></c:if>
		      <a href="${ctp}/admin/order/orderDelivery?part=2&pag=${i}&pageSize=${pageVo.pageSize}&search=${search}&searchValue=${searchValue}" class="w3-bar-item w3-button w3-hover-black">${i}</a>
		    <c:if test="${pageVo.pag eq i}"></span></c:if>
	      </c:forEach>
		  <c:if test="${pageVo.curBlock < pageVo.lastBlock}">
		  	<a href="${ctp}/admin/order/orderDelivery?part=2&pag=${pageVo.curBlockEndPage + 1}&pageSize=${pageVo.pageSize}&search=${search}&searchValue=${searchValue}" class="w3-bar-item w3-button w3-hover-black">＞</a>
		  	<a href="${ctp}/admin/order/orderDelivery?part=2&pag=${pageVo.totPage}&pageSize=${pageVo.pageSize}&search=${search}&searchValue=${searchValue}" class="w3-bar-item w3-button w3-hover-black">»</a>
		  </c:if>
	    </div>
	  </div>	
 	</div>
</div>
</body>
</html>