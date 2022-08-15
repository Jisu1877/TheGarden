<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 관리</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="stylesheet" href="${ctp}/css/admin.css"></style>
    <link rel="icon" href="${ctp}/images/favicon.png">
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
		
	  	function noticeDelete(idx) {
			let ans = confirm("해당 공지 글을 삭제하시겠습니까?");
			if(!ans) return false;
			
			location.href="${ctp}/notice/noticeDelete?notice_idx=" + idx;
		}
	  	
	  	function noticeUpdate(idx) {
	  		location.href="${ctp}/notice/noticeUpdate?notice_idx=" + idx;
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
		    	<span style="font-size:23px;">공지사항 관리</span>
	   			<a href="${ctp}/notice/noticeInsert" class="w3-btn w3-2020-ultramarine-green w3-round-large w3-right">공지 등록</a>
		    </div>
		</header>
		<form name="searchForm" method="get" action="${ctp}/notice/noticeList">
			<div class="w3-row">
				<div class="w3-half">
				   	<div class="input-group mt-2 mb-4">
						<select name="search" class="w3-select w3-round-large mr-2 w3-border" style="width:15%">
				   			<option value="notice_title" ${searchVO.search == 'notice_title' ? 'selected' : ''}>제목</option>
				   			<option value="notice_content" ${searchVO.search == 'notice_content' ? 'selected' : ''}>내용</option>
				   		</select>
				   		<input type="text" name="searchValue" id="searchValue" value="${searchVO.searchValue}" class="w3-input w3-border w3-round-large mr-2" style="width:30%">
				   		<a href="javascript:search()" class="w3-button w3-khaki w3-hover-khaki w3-round-large mr-3" style="width:13%;">검색</a>
	   					<a href="${ctp}/notice/noticeList" class="w3-button w3-white w3-hover-white w3-round-large">Reset</a>
			   		</div>
		   		</div>
		   		<div class="w3-half">
		   			<div class="w3-quarter">&nbsp;</div>
		   			<div class="w3-quarter">&nbsp;</div>
		   			<div class="w3-quarter">
				   		<div class="input-group mt-2 mb-4">
				   			<select name="part"  id="part" onchange="searchCheck()" class="w3-select w3-round-large mr-2 w3-border" style="width:100%">
								<option value="">전체</option>
								<option value="y" ${searchVO.part == 'y' ? 'selected' : '' }>팝업 사용</option>
								<option value="n" ${searchVO.part == 'n' ? 'selected' : '' }>팝업 미사용</option>
							</select>
				   		</div>
		   			</div>
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
		        	<tr class="w3-2020-ultramarine-green">
		        		<th class="text-center">고유번호</th>
		        		<th class="text-center">제목</th>
		        		<th class="text-center">등록일</th>
		        		<th class="text-center">조회수</th>
		        		<th class="text-center">팝업여부</th>
		        		<th class="text-center">수정/삭제</th>
		        	</tr>
				</thead>
				<tbody>
					<c:forEach var="vo" items="${noticeList}">
							<tr>
								<td class="text-center">
									${vo.notice_idx}
								</td>
								<td class="text-center">${vo.notice_title}</td>
								<td class="text-center">${vo.create_date}</td>
								<td class="text-center">${vo.views}</td>
								<td class="text-center">
			        				<c:if test="${vo.popup_yn == 'y'}">
			        					<i class="fa-solid fa-o"></i>
			        				</c:if>
			        				<c:if test="${vo.popup_yn == 'n'}">
			        					<i class="fa-solid fa-x"></i>
			        				</c:if>
								</td>
								<td class="text-center" style="width:10%">
									<a href="javascript:noticeUpdate(${vo.notice_idx})" class="w3-button w3-2021-illuminating w3-round-large w3-padding-small w3-small mr-1">수정</a>
									<a href="javascript:noticeDelete(${vo.notice_idx})" class="w3-button w3-brown w3-hover-brown w3-round-large w3-padding-small w3-small">삭제</a>
								</td>
							</tr>
					</c:forEach>
					<tr>
						<td colspan="6" class="p-1 m-1 text-center">
							<c:if test="${fn:length(noticeList) < 1}">
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
		      <a href="${ctp}/notice/noticeList${searchVO.getParams(searchVO)}&pag=1" class="w3-bar-item w3-button w3-hover-black">«</a>
		      <a href="${ctp}/notice/noticeList${searchVO.getParams(searchVO)}&pag=${searchVO.curBlockStartPage - 1}" class="w3-bar-item w3-button w3-hover-black">＜</a>
	      </c:if>
	      <c:forEach var="i" begin="${searchVO.curBlockStartPage}" end="${searchVO.curBlockEndPage}">
	      	<c:if test="${searchVO.pag eq i}"><span style="background:gray; color:white;"></c:if>
		      <a href="${ctp}/notice/noticeList${searchVO.getParams(searchVO)}&pag=${i}" class="w3-bar-item w3-button w3-hover-black">${i}</a>
		    <c:if test="${searchVO.pag eq i}"></span></c:if>
	      </c:forEach>
		  <c:if test="${searchVO.curBlock < searchVO.lastBlock}">
		  	<a href="${ctp}/notice/noticeList${searchVO.getParams(searchVO)}&pag=${searchVO.curBlockEndPage + 1}" class="w3-bar-item w3-button w3-hover-black">＞</a>
		  	<a href="${ctp}/notice/noticeList${searchVO.getParams(searchVO)}&pag=${searchVO.totPage}" class="w3-bar-item w3-button w3-hover-black">»</a>
		  </c:if>
	    </div>
	  </div>
	</div>
</div>
</body>
</html>