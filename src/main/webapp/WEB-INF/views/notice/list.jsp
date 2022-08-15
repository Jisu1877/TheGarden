<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>식물 상담실</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <style>
 		.tableStyle {
	  		width:100%;
	  		overflow-x : auto;
	  		white-space:nowrap;
	  		border-radius: 15px;
	  		background-color: white;
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
		
		//페이지사이즈 검색
	  	function searchCheck() {
	  		searchForm.submit();
		}
		
    </script>
</head>
<body>
<span id="navBar">
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
</span>
<jsp:include page="/WEB-INF/views/include/header2.jsp" />

<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px" onmouseover="hoverMenuClose()">
	<div class="container" style="margin-bottom:100px; margin-top:40px;">
		<div style="text-align:center">
    		<img class="w3-image" src="${ctp}/images/notice.png" width="180px" id="mainImage">
    	</div>
    	<form name="searchForm" method="get" action="${ctp}/notice/list">
			<div class="w3-row">
				<div class="w3-half">
				   	<div class="input-group mt-2 mb-4">
						<select name="search" class="w3-select w3-round-large mr-2 w3-border" style="width:15%">
				   			<option value="notice_title" ${searchVO.search == 'notice_title' ? 'selected' : ''}>제목</option>
				   			<option value="notice_content" ${searchVO.search == 'notice_content' ? 'selected' : ''}>내용</option>
				   		</select>
				   		<input type="text" name="searchValue" id="searchValue" value="${searchVO.searchValue}" class="w3-input w3-border w3-round-large mr-2" style="width:30%">
				   		<a href="javascript:search()" class="w3-button w3-khaki w3-hover-khaki w3-round-large mr-3" style="width:13%;">검색</a>
	   					<a href="${ctp}/notice/list" class="w3-button w3-white w3-hover-white w3-round-large">Reset</a>
			   		</div>
		   		</div>
		   		<div class="w3-half">
		   			<div class="w3-quarter">&nbsp;</div>
		   			<div class="w3-quarter">&nbsp;</div>
		   			<div class="w3-quarter">
				   		<div class="input-group mt-2 mb-4"></div>
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
		        	</tr>
				</thead>
				<tbody>
					<c:forEach var="vo" items="${noticeList}">
							<tr>
								<td class="text-center">${vo.notice_idx}</td>
								<td class="text-center">
									<a href="${ctp}/notice/showcontent?notice_idx=${vo.notice_idx}&pag=${param.pag}">${vo.notice_title}</a>
								</td>
								<td class="text-center">${vo.create_date}</td>
								<td class="text-center">${vo.views}</td>
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
		      <a href="${ctp}/notice/list${searchVO.getParams(searchVO)}&pag=1" class="w3-bar-item w3-button w3-hover-black">«</a>
		      <a href="${ctp}/notice/list${searchVO.getParams(searchVO)}&pag=${searchVO.curBlockStartPage - 1}" class="w3-bar-item w3-button w3-hover-black">＜</a>
	      </c:if>
	      <c:forEach var="i" begin="${searchVO.curBlockStartPage}" end="${searchVO.curBlockEndPage}">
	      	<c:if test="${searchVO.pag eq i}"><span style="background:gray; color:white;"></c:if>
		      <a href="${ctp}/notice/list${searchVO.getParams(searchVO)}&pag=${i}" class="w3-bar-item w3-button w3-hover-black">${i}</a>
		    <c:if test="${searchVO.pag eq i}"></span></c:if>
	      </c:forEach>
		  <c:if test="${searchVO.curBlock < searchVO.lastBlock}">
		  	<a href="${ctp}/notice/list${searchVO.getParams(searchVO)}&pag=${searchVO.curBlockEndPage + 1}" class="w3-bar-item w3-button w3-hover-black">＞</a>
		  	<a href="${ctp}/notice/list${searchVO.getParams(searchVO)}&pag=${searchVO.totPage}" class="w3-bar-item w3-button w3-hover-black">»</a>
		  </c:if>
	    </div>
	  </div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>