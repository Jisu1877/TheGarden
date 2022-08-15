<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 문의 답변 수정</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="stylesheet" href="${ctp}/css/admin.css"></style>
    <link rel="icon" href="${ctp}/images/favicon.png">
   	<script>
		function adminAnswerUpdate() {
			let admin_answer = $("#admin_answer").val();
			
			if(admin_answer == "") {
				alert("답변 내용을 입력하세요.");
				return false;
			}
			
			answerForm.submit();
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
		    	<span style="font-size:23px;">상품 문의 답변 수정</span>
		    	<a href="${ctp}/itemQna/itemQnaList${searchVO.getParams(searchVO)}&pag=${param.pag}" class="w3-button w3-khaki w3-hover-khaki w3-round-large w3-right">목록으로</a>
		    </div>
		</header>
		<div class="w3-row">
			<div class="w3-half">
				<div class="w3-responsive tableStyle mb-4">
					<table class="w3-table" style="border-collapse:separate;">
						<thead>
				        	<tr class="w3-2021-inkwell">
				        		<th class="text-center">회원 ID</th>
				        		<th class="text-center">상품명</th>
				        		<th class="text-center">공개여부</th>
				        		<th class="text-center">작성일</th>
				        	</tr>
						</thead>
						<tbody>
							<tr>
								<td class="text-center">${vo.user_id}</td>
								<td class="text-center">${vo.item_name}</td>
								<td class="text-center">
									<c:if test="${vo.view_yn == 'y'}">공개</c:if>
									<c:if test="${vo.view_yn == 'n'}">비밀글</c:if>
								</td>
								<td class="text-center">
									${fn:substring(vo.write_date,0,10)}
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="w3-responsive tableStyle">
					<table class="w3-table" style="border-collapse:separate;">
						<thead>
				        	<tr class="w3-2020-lark">
				        		<th class="text-center">문의내용</th>
				        	</tr>
						</thead>
						<tbody>
							<tr>
								<td>${fn:replace(vo.item_qna_content, newLine, '<br>')}</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="w3-half">
				<form name="answerForm" method="post">
					<div class="w3-responsive tableStyle w3-right mr-5" style="width:80%;">
						<table class="w3-table" style="border-collapse:separate;">
							<thead>
					        	<tr class="w3-2020-lark">
					        		<th class="text-center">관리자 답변</th>
					        	</tr>
							</thead>
							<tbody>
								<tr>
									<td>
										<br>
										<textarea rows="12" class="form-control" placeholder="답변내용을 입력하세요." name="admin_answer" id="admin_answer">${vo.admin_answer}</textarea>
									</td>
								</tr>
								<tr>
									<td class="text-center">
										<a href="javascript:adminAnswerUpdate()" class="w3-btn w3-2021-inkwell w3-padding-small w3-round-large m-2">수정</a>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<input type="hidden" name="item_qna_idx" value="${vo.item_qna_idx}">
				</form>
			</div>
		</div>
	</div>
</div>
</body>
</html>