<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 관리</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <link rel="stylesheet" href="${ctp}/css/admin.css"></style>
	<script>
      	function submitForm() {
      		$('#searchForm').submit();
      		return false;
      	}
    	
    	function openUserInfo(href) {
    		const win = window.open(href, '회원 관리', 'width:700; height:700; top:50;')
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
		    	<span style="font-size:23px;">회원 관리</span>
		    </div>
		</header>
		
		<form id="searchForm" name="searchForm" method="GET" action="${ctp}/admin/user/userList">
			<div class="w3-row">
				<div class="w3-half mt-2 mb-4">
				   	<div class="input-group">
				   		<select name="search" class="w3-select w3-round-large mr-2 w3-border" style="width:15%">
			   				<option value="user_id" ${searchVO.search == 'user_id' ? 'selected' : '' }>아이디</option>
			   				<option value="name" ${searchVO.search == 'name' ? 'selected' : '' }>성명</option>
			   				<option value="email" ${searchVO.search == 'email' ? 'selected' : '' }>이메일</option>
			   				<option value="tel" ${searchVO.search == 'tel' ? 'selected' : '' }>전화번호</option>
			   			</select>
				   		<input type="text" name="searchValue" id="searchValue" value="${searchVO.searchValue}" class="w3-input w3-border w3-round-large mr-2" style="width:30%">
				   		<a href="javascript:submitForm()" class="w3-button w3-khaki w3-hover-khaki w3-round-large mr-3" style="width:13%;">검색</a>
	   					<a href="${ctp}/admin/user/userList" class="w3-button w3-white w3-hover-white w3-round-large">Reset</a>
			   		</div>
		   		</div>
		   		<div class="w3-half mt-2 mb-4">
		   			<select name="pageSize" id="pageSize" onchange="submitForm()" class="w3-select w3-round-large mr-2 w3-border w3-right" style="width:15%">
						<option value="5" ${searchVO.pageSize == 5 ? 'selected' : '' }>5건</option>
						<option value="10" ${searchVO.pageSize == 10 ? 'selected' : '' }>10건</option>
						<option value="15" ${searchVO.pageSize == 15 ? 'selected' : '' }>15건</option>
						<option value="20" ${searchVO.pageSize == 20 ? 'selected' : '' }>20건</option>
					</select>
					<select name="status_code" id="status_code" onchange="submitForm()" class="w3-select w3-round-large mr-2 w3-border w3-right" style="width:20%">
						<option value="" ${searchVO.status_code == '' ? 'selected' : ''}>전체</option>
						<option value="9" ${searchVO.status_code == '9' ? 'selected' : ''}>활동중</option>
						<option value="0" ${searchVO.status_code == '0' ? 'selected' : ''}>탈퇴</option>
					</select>
					<select name="level" id="level" class="w3-select w3-round-large mr-2 w3-border w3-right" onchange="submitForm()" style="width:20%">
						<option value="" ${searchVO.level == '' ? 'selected' : ''}>전체</option>
						<option value="1" ${searchVO.level == '1' ? 'selected' : ''}>골드레벨</option>
						<option value="2" ${searchVO.level == '2' ? 'selected' : ''}>실버레벨</option>
					</select>
	   			</div>
	   		</div>	
			
			<div class="w3-responsive tableStyle">
			<table class="w3-table w3-striped" style="border-collapse:separate;">
				<colgroup>
					<col style="width:5%;">
					<col style="width:13.5%;">
					<col style="width:13.5%;">
					<col style="width:13.5%;">
					<col style="width:13.5%;">
					<col style="width:13.5%;">
					<col style="width:13.5%;">
				</colgroup>
	        	<tr class="w3-2021-inkwell">
	        		<th class="text-center">아이디</th>
	        		<th class="text-center">성명</th>
	        		<th class="text-center" width="15%">이메일</th>
	        		<th class="text-center" width="15%">전화번호</th>
	        		<th class="text-center">상태</th>
	        		<th class="text-center">레벨</th>
	        		<th class="text-center">가입일</th>
	        	</tr>
	        	<c:forEach var="user" items="${userList}">
	        		<tr>
	        			<td class="text-center">
	        				<a href="${ctp}/admin/user/userInforUpdate${searchVO.getParams(searchVO)}&user_id=${user.user_id}" alt="${searchVO.name} 회원 정보 수정" onclick="openUserInfo(this.href); return false;">${user.user_id}</a>
	        			</td>
	        			<td>${user.name}</td>
	        			<td class="text-center">${user.email}</td>
	        			<td class="text-center">${user.tel}</td>
	        			<td class="text-center">
	        				<c:if test="${user.status_code == 9}">
		        				활동중
	        				</c:if>
	        				<c:if test="${user.status_code == 0}">
		        				<font color="red">탈퇴</font>
	        				</c:if>
	        			</td>
	        			<td class="text-center">
	        				<c:if test="${user.level == 0}">
	        					관리자
	        				</c:if>
	        				<c:if test="${user.level == 1}">
	        					골드
	        				</c:if>
	        				<c:if test="${user.level == 2}">
	        					실버
	        				</c:if>
	        			</td>
	        			<td class="text-center">${user.created_date}</td>
	        		</tr>
	        	</c:forEach>
        		<tr>
        			<td class="p-1 m-1 text-center" colspan="7">
			        	<c:if test="${fn:length(userList) == 0}">
			        		조회된 내역이 없습니다.
			        	</c:if>
        			</td>
        		</tr>
	        </table>
	     </div>
	    </form>
	     <!-- 블록 페이징 처리 -->
	  <div class="w3-center w3-padding-32">
	 	 <div class="mb-2"><b>${searchVO.pag} Page</b></div>
	    <div class="w3-bar w3-white">
	      <c:if test="${searchVO.curBlock > 0}">
		      <a href="${ctp}/admin/user/userList${searchVO.getParams(searchVO)}&pag=1" class="w3-bar-item w3-button w3-hover-black">«</a>
		      <a href="${ctp}/admin/user/userList${searchVO.getParams(searchVO)}&pag=${searchVO.curBlockStartPage - 1}" class="w3-bar-item w3-button w3-hover-black">＜</a>
	      </c:if>
	      <c:forEach var="i" begin="${searchVO.curBlockStartPage}" end="${searchVO.curBlockEndPage}">
	      	<c:if test="${searchVO.pag eq i}"><span style="background:gray; color:white;"></c:if>
	      	<a href="${ctp}/admin/user/userList${searchVO.getParams(searchVO)}&pag=${i}" class="w3-bar-item w3-button w3-hover-gray">${i}</a>
	      	<c:if test="${searchVO.pag eq i}"></span></c:if>
	      </c:forEach>
	      <c:if test="${searchVO.curBlock < searchVO.lastBlock}">
	      	<a href="${ctp}/admin/user/userList${searchVO.getParams(searchVO)}&pag=${searchVO.curBlockEndPage + 1}" class="w3-bar-item w3-button w3-hover-black">＞</a>
		  	<a href="${ctp}/admin/user/userList${searchVO.getParams(searchVO)}&pag=${searchVO.totPage}" class="w3-bar-item w3-button w3-hover-black">»</a>
	      </c:if>
	    </div>
	  </div>	
 	</div>
</div>
</body>
</html>