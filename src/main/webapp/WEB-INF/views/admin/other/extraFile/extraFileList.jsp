<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>임시 파일 관리</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="stylesheet" href="${ctp}/css/admin.css"></style>
    <link rel="icon" href="${ctp}/images/favicon.png">
    <script>
    	function showContent(idx) {
			$(".content").hide();
			$("#content"+idx).show();
		}
    	
    	function hideContent(idx) {
    		$("#content"+idx).hide();
		}
    	
    	function imageDelete(image_name) {
			location.href="${ctp}/extraFile/extarFileDelete?image_name=" + image_name;
		}
    	
    	function imageDeleteAll() {
			let ans = confirm("정말로 임시 파일 전체 삭제를 진행하시겠습니까?");
			if(!ans) {
				return false;
			}
			
			location.href="${ctp}/extraFile/extarFileDeleteAll";
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
		    	<span style="font-size:23px;">임시 파일 관리</span>
		    </div>
		</header>
		<div><i class="fa-solid fa-circle-info"></i> &nbsp;효율적인 메모리 관리를 위해 주기적으로 정리해야 합니다.</div>
		<div class="mb-2 w3-right">
			<a href="javascript:imageDeleteAll()" class="w3-btn w3-2020-flame-scarlet w3-round-large w3-padding-small w3-small" style="margin-right:35px;">전체 삭제</a>
		</div>
    	<div class="w3-responsive tableStyle">
			<table class="w3-table w3-striped" style="border-collapse:separate;">
				<thead>
		        	<tr class="w3-2020-classic-blue">
		        		<th class="text-center" width="10%">번호</th>
		        		<th class="text-center" width="30%">폴더명</th>
		        		<th class="text-center" width="30%">이미지 이름</th>
		        		<th class="text-center" width="15%">조회</th>
		        		<th class="text-center" width="15%">삭제</th>
		        	</tr>
				</thead>
				<tbody>
					<c:forEach var="vo" items="${extraFileList}" varStatus="st">
							<tr>
								<td class="text-center">${st.count}</td>
								<td class="text-center">ckeditor</td>
								<td class="text-center">${extraFileList[st.index]}</td>
								<td class="text-center" style="width:10%">
									<a href="javascript:showContent(${st.count})" class="w3-btn w3-lime w3-round-large w3-padding-small w3-small">조회</a>
								</td>
								<td class="text-center" style="width:10%">
									<a href="javascript:imageDelete('${extraFileList[st.index]}')" class="w3-btn w3-black w3-round-large w3-padding-small w3-small">삭제</a>
								</td>
							</tr>
							<tr><td colspan="5" class="p-0 m-0" style="display:none"></td></tr>
							<tr style="display:none" id="content${st.count}" class="content">
								<td colspan="4">
									<img src="${ctp}/data/ckeditor/${extraFileList[st.index]}" alt="${extraFileList[st.index]}" style="width:20%; margin-top:20px;">
								</td>
								<td class="text-center" style="width:10%">
									<a href="javascript:hideContent(${st.count})" class="w3-btn w3-yellow w3-round-large w3-padding-small w3-small">닫기</a>
								</td>
							</tr>
					</c:forEach>
					<tr>
						<td colspan="5" class="p-1 m-1 text-center">
							<c:if test="${fn:length(extraFileList) < 1}">
		        				조회된 내역이 없습니다.
		        			</c:if>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>
</body>
</html>