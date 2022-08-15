<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>식물 상담실 관리</title>
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
		
	  	function boardDelete(idx) {
			let ans = confirm("해당 상담글을 삭제하시겠습니까?");
			if(!ans) return false;
			
			location.href="${ctp}/admin/plant/boardDelete?idx=" + idx;
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
		    	<span style="font-size:23px;">식물 상담실 관리</span>
		    </div>
		</header>
		<form name="searchForm" method="get" action="${ctp}/admin/plant/boardList">
			<div class="w3-row">
				<div class="w3-half">
				   	<div class="input-group mt-2 mb-4">
						<select name="search" class="w3-select w3-round-large mr-2 w3-border" style="width:15%">
				   			<option value="title" ${searchVO.search == 'title' ? 'selected' : ''}>제목</option>
				   			<option value="content" ${searchVO.search == 'content' ? 'selected' : ''}>내용</option>
			 				<option value="user_id" ${searchVO.search == 'user_id' ? 'selected' : ''}>아이디</option>
				   		</select>
				   		<input type="text" name="searchValue" id="searchValue" value="${searchVO.searchValue}" class="w3-input w3-border w3-round-large mr-2" style="width:30%">
				   		<a href="javascript:search()" class="w3-button w3-khaki w3-hover-khaki w3-round-large mr-3" style="width:13%;">검색</a>
	   					<a href="${ctp}/admin/plant/boardList" class="w3-button w3-white w3-hover-white w3-round-large">Reset</a>
			   		</div>
		   		</div>
		   		<div class="w3-half">
		   			<div class="w3-quarter">&nbsp;</div>
		   			<div class="w3-quarter">&nbsp;</div>
		   			<div class="w3-quarter">
				   		<div class="input-group mt-2 mb-4">
				   			<select name="part"  id="part" onchange="searchCheck()" class="w3-select w3-round-large mr-2 w3-border" style="width:100%">
								<option value="">전체</option>
								<option value="n" ${searchVO.part == 'n' ? 'selected' : '' }>미답변</option>
								<option value="y" ${searchVO.part == 'y' ? 'selected' : '' }>답변완료</option>
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
		        	<tr class="w3-2021-mint">
		        		<th class="text-center">고유번호</th>
		        		<th class="text-center">제목</th>
		        		<th class="text-center">글쓴이</th>
		        		<th class="text-center">등록일</th>
		        		<th class="text-center">조회수</th>
		        		<th class="text-center">답변여부</th>
		        		<th class="text-center">답변등록</th>
		        		<th class="text-center">삭제</th>
		        	</tr>
				</thead>
				<tbody>
					<c:forEach var="vo" items="${boardList}">
							<tr>
								<td class="text-center">
									<c:if test="${vo.notice_yn == 'y'}">
										<span class="badge badge-secondary">공지</span>
									</c:if>
									<c:if test="${vo.notice_yn == 'n'}">
										${vo.plant_board_idx}
									</c:if>
								</td>
								<td class="text-center">${vo.title}</td>
								<td class="text-center">${vo.user_id}</td>
								<td class="text-center">${vo.write_date}</td>
								<td class="text-center">${vo.views}</td>
								<td class="text-center">
									<c:if test="${vo.notice_yn == 'y'}">
										-
									</c:if>
									<c:if test="${vo.notice_yn == 'n'}">
				        				<c:if test="${vo.admin_answer_yn == 'y'}">
				        					<i class="fa-solid fa-o"></i>
				        				</c:if>
				        				<c:if test="${vo.admin_answer_yn == 'n'}">
				        					<i class="fa-solid fa-x"></i>
				        				</c:if>
									</c:if>
								</td>
								<td class="text-center">
									<c:if test="${vo.notice_yn == 'y'}">
										-
									</c:if>
									<c:if test="${vo.notice_yn == 'n'}">
										<c:if test="${vo.admin_answer_yn == 'n'}">
											<a href="${ctp}/admin/plant/adminAnswer${searchVO.getParams(searchVO)}&pag=${param.pag}&idx=${vo.plant_board_idx}" class="w3-button w3-teal w3-hover-teal w3-round-large w3-padding-small w3-small">등록</a>
										</c:if>
										<c:if test="${vo.admin_answer_yn == 'y'}">
											<a href="${ctp}/admin/plant/adminAnswerUpdate${searchVO.getParams(searchVO)}&pag=${param.pag}&idx=${vo.plant_board_idx}" class="w3-button w3-lime w3-hover-lime w3-round-large w3-padding-small w3-small">수정</a>
										</c:if>
									</c:if>
								</td>
								<td class="text-center" style="width:10%">
									<a href="javascript:boardDelete(${vo.plant_board_idx})" class="w3-button w3-brown w3-hover-brown w3-round-large w3-padding-small w3-small">삭제</a>
								</td>
							</tr>
					</c:forEach>
					<tr>
						<td colspan="8" class="p-1 m-1 text-center">
							<c:if test="${fn:length(boardList) < 1}">
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
		      <a href="${ctp}/admin/plant/boardList${searchVO.getParams(searchVO)}&pag=1" class="w3-bar-item w3-button w3-hover-black">«</a>
		      <a href="${ctp}/admin/plant/boardList${searchVO.getParams(searchVO)}&pag=${searchVO.curBlockStartPage - 1}" class="w3-bar-item w3-button w3-hover-black">＜</a>
	      </c:if>
	      <c:forEach var="i" begin="${searchVO.curBlockStartPage}" end="${searchVO.curBlockEndPage}">
	      	<c:if test="${searchVO.pag eq i}"><span style="background:gray; color:white;"></c:if>
		      <a href="${ctp}/admin/plant/boardList${searchVO.getParams(searchVO)}&pag=${i}" class="w3-bar-item w3-button w3-hover-black">${i}</a>
		    <c:if test="${searchVO.pag eq i}"></span></c:if>
	      </c:forEach>
		  <c:if test="${searchVO.curBlock < searchVO.lastBlock}">
		  	<a href="${ctp}/admin/plant/boardList${searchVO.getParams(searchVO)}&pag=${searchVO.curBlockEndPage + 1}" class="w3-bar-item w3-button w3-hover-black">＞</a>
		  	<a href="${ctp}/admin/plant/boardList${searchVO.getParams(searchVO)}&pag=${searchVO.totPage}" class="w3-bar-item w3-button w3-hover-black">»</a>
		  </c:if>
	    </div>
	  </div>	
	</div>
</div>
</body>
</html>