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
    		<img class="w3-image" src="${ctp}/images/20220727_141251.png" width="180px" id="mainImage">
    	</div>
    	<div style="margin-bottom: 20px; text-align:right">
    		<c:if test="${level == 0}">
    			<a href="${ctp}/plant/boardAdminInsert" class="w3-btn w3-2020-ultramarine-green w3-round-large mr-3">공지등록</a>
    		</c:if>
    		<c:if test="${level != 0}">
    			<a href="${ctp}/plant/boardInsert" class="w3-btn w3-2020-ultramarine-green w3-round-large">글쓰기</a>
    		</c:if>
    	</div>
    	<div class="w3-responsive tableStyle">
			<table class="w3-table w3-striped" style="border-collapse:separate;">
				<thead>
		        	<tr class="w3-2021-mint">
		        		<th class="text-center">번호</th>
		        		<th class="text-center">제목</th>
		        		<th class="text-center">글쓴이</th>
		        		<th class="text-center">등록일</th>
		        		<th class="text-center">조회수</th>
		        		<th class="text-center">답변여부</th>
		        	</tr>
				</thead>
				<tbody>
					<c:set var="i" value="${boardList.size()}"/>
					<c:forEach var="vo" items="${boardList}">
							<tr>
								<td class="text-center">
									<c:if test="${vo.notice_yn == 'y'}">
										<span class="badge badge-secondary">공지</span>
									</c:if>
									<c:if test="${vo.notice_yn == 'n'}">
										${i}
									</c:if>
								</td>
								<td class="text-center">
									<c:if test="${vo.notice_yn == 'y'}">
										<a href="${ctp}/plant/showNoticeContent${searchVO.getParams(searchVO)}&pag=${searchVO.pag}&idx=${vo.plant_board_idx}">
											${vo.title}
										</a>
										<c:if test="${vo.diff_time <= 24}"><img src="${ctp}/images/new.gif"></c:if>
									</c:if>
									<c:if test="${vo.notice_yn == 'n'}">
										<a href="${ctp}/plant/showcontent${searchVO.getParams(searchVO)}&pag=${searchVO.pag}&idx=${vo.plant_board_idx}">
											${vo.title}
											<c:if test="${vo.reply_count != 0}">
												<span class="w3-text-brown">[${vo.reply_count}]</span>
											</c:if>
											<c:if test="${vo.diff_time <= 24}"><img src="${ctp}/images/new.gif"></c:if>
										</a>
									</c:if>
								</td>
								<td class="text-center">${vo.user_id}</td>
								<td class="text-center">
									<c:if test="${vo.diff_time <= 24}">${fn:substring(vo.write_date, 11, 19)}</c:if>
									<c:if test="${vo.diff_time > 24}">${fn:substring(vo.write_date, 0, 10)}</c:if>
								</td>
								<td class="text-center">${vo.views}</td>
								<td class="text-center">
									<c:if test="${vo.admin_answer_yn == 'y'}">
			        					<i class="fa-solid fa-o"></i>
			        				</c:if>
			        				<c:if test="${vo.admin_answer_yn == 'n'}">
			        					<c:if test="${vo.notice_yn == 'n'}">
			        						<i class="fa-solid fa-x"></i>
			        					</c:if>
			        					<c:if test="${vo.notice_yn == 'y'}">
			        						-
			        					</c:if>
			        				</c:if>
								</td>
							</tr>
							<c:set var="i" value="${i - 1}"/>
					</c:forEach>
					<tr><td colspan="6" class="p-1 m-0"></td></tr>
				</tbody>
			</table>
		</div>
		<form name="searchForm" method="get" action="${ctp}/plant/boardList">
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
				   		<a href="${ctp}/plant/boardList" class="w3-button w3-khaki w3-hover-khaki w3-round-large">Reset</a>
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
	  <!-- 블록 페이징 처리 -->
	  <div class="w3-center w3-padding-32">
	 	 <div class="mb-2"><b>${searchVO.pag} Page</b></div>
	    <div class="w3-bar w3-white">
	      <c:if test="${searchVO.curBlock > 0}">
		      <a href="${ctp}/plant/boardList${searchVO.getParams(searchVO)}&pag=1" class="w3-bar-item w3-button w3-hover-black">«</a>
		      <a href="${ctp}/plant/boardList${searchVO.getParams(searchVO)}&pag=${searchVO.curBlockStartPage - 1}" class="w3-bar-item w3-button w3-hover-black">＜</a>
	      </c:if>
	      <c:forEach var="i" begin="${searchVO.curBlockStartPage}" end="${searchVO.curBlockEndPage}">
	      	  <c:if test="${searchVO.pag eq i}"><span style="background:gray; color:white;"></c:if>
		      <a href="${ctp}/plant/boardList${searchVO.getParams(searchVO)}&pag=${i}" class="w3-bar-item w3-button w3-hover-black">${i}</a>
		      <c:if test="${searchVO.pag eq i}"></span></c:if>
	      </c:forEach>
		  <c:if test="${searchVO.curBlock < searchVO.lastBlock}">
		  	<a href="${ctp}/plant/boardList${searchVO.getParams(searchVO)}&pag=${searchVO.curBlockEndPage + 1}" class="w3-bar-item w3-button w3-hover-black">＞</a>
		  	<a href="${ctp}/plant/boardList${searchVO.getParams(searchVO)}&pag=${searchVO.totPage}" class="w3-bar-item w3-button w3-hover-black">»</a>
		  </c:if>
	    </div>
	  </div>	
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>