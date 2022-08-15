<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 답변 등록</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="${ctp}/ckeditor/ckeditor.js"></script>
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
		function answerInsert() {
			let text = CKEDITOR.instances['CKEDITOR'].getData();
			
			if(text == "") {
			 	alert("관리자 답변을 작성하세요");
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
		    	<span style="font-size:23px;">식물 상담 답변 등록</span>
		    	<a href="${ctp}/admin/plant/boardList${searchVO.getParams(searchVO)}&pag=${param.pag}" class="w3-button w3-khaki w3-hover-khaki w3-round-large w3-right">목록으로</a>
		    </div>
		</header>
    	<div>
    		<div class="w3-row-padding">
    			<div class="w3-col l6 m6">
    				<table class="w3-table w3-white w3-round-large" style="margin-top:30px;">
		    			<tr>
		    				<td>▪️ 상담분류</td>
		    				<td>${vo.choice1}</td>
		    			</tr>
		    			<tr>
		    				<td>▪️ 식물분류</td>
		    				<td>${vo.choice2}</td>
		    			</tr>
		    			<tr>
		    				<td>▪️ 키우는 장소</td>
		    				<td>${vo.choice3}</td>
		    			</tr>
		    			<tr>
		    				<td>▪️ 한달동안 물주는 주기</td>
		    				<td>${vo.choice4}</td>
		    			</tr>
		    			<tr>
		    				<td>▪️ 물주는 방법</td>
		    				<td>${vo.choice5}</td>
		    			</tr>
		    		</table>
		    		<br>
		    		<form name="answerForm" method="post">
			    		<div>
			    			<div class="mb-3">
			    				<span style="font-size:19px;" class="w3-lime">관리자 답변</span>
			    				<a href="javascript:answerInsert()" class="w3-button w3-black w3-hover-black w3-round-large w3-padding-small w3-small w3-right">답변 등록</a>
			    			</div>
						   <textarea rows="10" id="CKEDITOR" name="admin_content" class="form-control"></textarea> 				
			    		</div>
			    		<input type="hidden" name="plant_board_idx" value="${vo.plant_board_idx}">
			    		<%-- <input type="hidden" name="pag" value="${param.pag}">
			    		<input type="hidden" name="pageSize" value="${searchVO.pageSize}">
			    		<input type="hidden" name="search" value="${searchVO.search}">
			    		<input type="hidden" name="searchValue" value="${searchVO.searchValue}"> --%>
		      	    </form>
		    		<script>
			      	  CKEDITOR.replace("admin_content",{
			      		  height:500,
			      		  filebrowserUploadUrl :"${ctp}/imageUpload",
			      		  uploadUrl : "${ctp}/imageUpload"
			      	  });
		      	    </script>
    			</div>
	    		<div class="w3-col l6 m6">
		    		<table class="w3-table w3-white w3-round-large" style="margin-top:30px;">
		    			<tr>
		    				<td>회원 아이디 :</td>
		    				<td width="30%">${vo.user_id}</td>
		    				<td>이메일 :</td>
		    				<td width="30%">
			    				${vo.email}
		    				</td>
		    			</tr>
		    			<tr>
							<td colspan="4" class="w3-lime">		    			
				    			<span style="font-size:18px;">제목 : ${vo.title}</span>
				    		</td>
		    			</tr>
		    			<tr>
		    				<td colspan="4" style="padding-top: 10px;">
		    					${vo.content}
		    				</td>
		    			</tr>
				    </table>
	    		</div>
    		</div>
    	</div>
	</div>
</div>
</body>
</html>