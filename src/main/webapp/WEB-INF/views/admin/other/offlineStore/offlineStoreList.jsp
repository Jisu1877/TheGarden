<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>오프라인 매장 관리</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="stylesheet" href="${ctp}/css/admin.css"></style>
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
		function search() {
			let searchValue = $("#searchValue").val();
			
			if(searchValue == "") {
				alert("검색어를 입력하세요");
				return false;
			}
			else {
				searchForm.submit();
			}
		}
		
	  	function searchCheck() {
	  		searchForm.submit();
		}
		
	  	function storeDelete(idx) {
			let ans = confirm("해당 가맹점을 삭제하시겠습니까?");
			if(!ans) return false;
			
			location.href="${ctp}/offline/storeDelete?offline_store_idx=" + idx;
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
		    	<span style="font-size:23px;">오프라인 매장 관리</span>
		    </div>
		</header>
    	<form name="searchForm" method="get" action="${ctp}/offline/offlineStoreList">
			<div class="w3-row">
				<div class="w3-half">
				   	<div class="input-group mt-2 mb-4">
						<select name="search" class="w3-select w3-round-large mr-2 w3-border" style="width:20%">
				   			<option value="store_name" ${searchVO.search == 'store_name' ? 'selected' : ''}>가맹점 명</option>
				   			<option value="store_tel" ${searchVO.search == 'store_tel' ? 'selected' : ''}>전화번호</option>
			 				<option value="rode_address" ${searchVO.search == 'user_id' ? 'selected' : ''}>도로명 주소</option>
			 				<option value="address" ${searchVO.search == 'user_id' ? 'selected' : ''}>지번 주소</option>
				   		</select>
				   		<input type="text" name="searchValue" id="searchValue" value="${searchVO.searchValue}" class="w3-input w3-border w3-round-large mr-2" style="width:30%">
				   		<a href="javascript:search()" class="w3-button w3-khaki w3-hover-khaki w3-round-large mr-3" style="width:13%;">검색</a>
	   					<a href="${ctp}/offline/offlineStoreList" class="w3-button w3-white w3-hover-white w3-round-large">Reset</a>
			   		</div>
		   		</div>
		   		<div class="w3-half">
		   			<div class="w3-quarter">&nbsp;</div>
		   			<div class="w3-quarter">&nbsp;</div>
		   			<div class="w3-quarter">&nbsp;</div>
		   			<div class="w3-quarter">
				   		<div class="input-group mt-2 mb-4">
				   			<select name="pageSize"  id="pageSize" onchange="searchCheck()" class="w3-select w3-round-large mr-2 w3-border" style="width:100%">
								<option value="5" ${searchVO.pageSize == 5 ? 'selected' : '' }>5건</option>
								<option value="10" ${searchVO.pageSize == 10 ? 'selected' : '' }>10건</option>
								<option value="15" ${searchVO.pageSize == 15 ? 'selected' : '' }>15건</option>
								<option value="20" ${searchVO.pageSize == 20 ? 'selected' : '' }>20건</option>
							</select>
				   		</div>
			   		</div>
			   	</div>
	   		</div>
   		</form>
 	    <div class="w3-responsive tableStyle">
			<table class="w3-table w3-striped" style="border-collapse:separate;">
				<thead>
		        	<tr class="w3-2021-burnt-coral">
		        		<th class="text-center">고유번호</th>
		        		<th class="text-center">가맹점 명</th>
		        		<th class="text-center">전화번호</th>
		        		<th class="text-center">도로명주소</th>
		        		<th class="text-center">상세주소</th>
		        		<th class="text-center">등록일</th>
		        		<th class="text-center">비고</th>
		        	</tr>
				</thead>
				<tbody>
					<c:forEach var="vo" items="${storeList}">
						<tr>
							<td class="text-center">${vo.offline_store_idx}</td>
							<td class="text-center">${vo.store_name}</td>
							<td class="text-center">${vo.store_tel}</td>
							<td class="text-center">${vo.rode_address}</td>
							<td class="text-center">${vo.detail_address}</td>
							<td class="text-center">${fn:substring(vo.create_date,0,10)}</td>
							<td class="text-center" style="width:10%">
								<a href="javascript:storeDelete(${vo.offline_store_idx})" class="w3-btn w3-2020-flame-scarlet w3-round-large w3-padding-small w3-small">삭제</a>
							</td>
						</tr>
					</c:forEach>
					<tr>
						<td colspan="8" class="p-1 m-1 text-center">
							<c:if test="${storeList.size() == 0}">
								조회되는 매장이 없습니다.
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
		      <a href="${ctp}/offline/offlineStoreList${searchVO.getParams(searchVO)}&pag=1" class="w3-bar-item w3-button w3-hover-black">«</a>
		      <a href="${ctp}/offline/offlineStoreList${searchVO.getParams(searchVO)}&pag=${searchVO.curBlockStartPage - 1}" class="w3-bar-item w3-button w3-hover-black">＜</a>
	      </c:if>
	      <c:forEach var="i" begin="${searchVO.curBlockStartPage}" end="${searchVO.curBlockEndPage}">
	      	<c:if test="${searchVO.pag eq i}"><span style="background:gray; color:white;"></c:if>
	      	<a href="${ctp}/offline/offlineStoreList${searchVO.getParams(searchVO)}&pag=${i}" class="w3-bar-item w3-button w3-hover-gray">${i}</a>
	      	<c:if test="${searchVO.pag eq i}"></span></c:if>
	      </c:forEach>
	      <c:if test="${searchVO.curBlock < searchVO.lastBlock}">
	      	<a href="${ctp}/offline/offlineStoreList${searchVO.getParams(searchVO)}&pag=${searchVO.curBlockEndPage + 1}" class="w3-bar-item w3-button w3-hover-black">＞</a>
		  	<a href="${ctp}/offline/offlineStoreList${searchVO.getParams(searchVO)}&pag=${searchVO.totPage}" class="w3-bar-item w3-button w3-hover-black">»</a>
	      </c:if>
		  <c:if test="${searchVO.pag != searchVO.totPage}">
		  </c:if>
	    </div>
	  </div>	
	</div>
</div>
</body>
</html>