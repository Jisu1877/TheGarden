<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>1:1 문의 관리</title>
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
		
	  	function inquiryDelete(idx) {
			let ans = confirm("해당 문의글을 삭제하시겠습니까?");
			if(!ans) return false;
			
			location.href="${ctp}/inquiry/inquiryDelete?inquiry_idx=" + idx;
		}
	  	
	  	function showContent(idx) {
			$(".content").hide();
			$("#showContent"+idx).slideDown(300);
		}
	  	
	  	function hideContent(idx) {
	  		$("#showContent"+idx).hide();
		}
	  	
	  	function answerInsert(idx) {
	  		let admin_answer = $("#admin_answer"+idx).val();
	  		
	  		location.href="${ctp}/inquiry/inquiryAnswer${searchVO.getParams(searchVO)}&pag=${param.pag}&inquiry_idx="+idx+"&admin_answer="+admin_answer;
		}
	  	
	  	function answerUpdate(idx) {
	  		let admin_answer = $("#admin_answer"+idx).val();
			
	  		location.href="${ctp}/inquiry/inquiryAnswerUpdate${searchVO.getParams(searchVO)}&pag=${param.pag}&inquiry_idx="+idx+"&admin_answer="+admin_answer;
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
		    	<span style="font-size:23px;">1:1 문의 관리</span>
		    </div>
		</header>
    			<form name="searchForm" method="get" action="${ctp}/inquiry/inquiryList">
			<div class="w3-row">
				<div class="w3-half">
				   	<div class="input-group mt-2 mb-4">
						<select name="search" class="w3-select w3-round-large mr-2 w3-border" style="width:15%">
			 				<option value="user_id" ${searchVO.search == 'user_id' ? 'selected' : ''}>아이디</option>
			 				<option value="inquiry_content" ${searchVO.search == 'inquiry_content' ? 'selected' : ''}>문의 내용</option>
			 				<option value="admin_answer" ${searchVO.search == 'admin_answer' ? 'selected' : ''}>답변 내용</option>
				   		</select>
				   		<input type="text" name="searchValue" id="searchValue" value="${searchVO.searchValue}" class="w3-input w3-border w3-round-large mr-2" style="width:30%">
				   		<a href="javascript:search()" class="w3-button w3-khaki w3-hover-khaki w3-round-large mr-3" style="width:13%;">검색</a>
	   					<a href="${ctp}/inquiry/inquiryList" class="w3-button w3-white w3-hover-white w3-round-large">Reset</a>
			   		</div>
		   		</div>
		   		<div class="w3-half">
		   			<div class="w3-quarter">&nbsp;</div>
		   			<div class="w3-quarter">&nbsp;</div>
		   			<div class="w3-quarter">
				   		<div class="input-group mt-2 mb-4">
				   			<select name="part"  id="part" onchange="searchCheck()" class="w3-select w3-round-large mr-2 w3-border" style="width:100%">
								<option value="">전체</option>
								<option value="n" ${searchVO.part == 'n' ? 'selected' : ''}>미답변</option>
								<option value="y" ${searchVO.part == 'y' ? 'selected' : ''}>답변</option>
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
		        	<tr class="w3-2020-classic-blue">
		        		<th class="text-center">고유번호</th>
		        		<th class="text-center">회원ID</th>
		        		<th class="text-center">문의내용</th>
		        		<th class="text-center">등록일</th>
		        		<th class="text-center">답변여부</th>
		        		<th class="text-center">답변등록</th>
		        		<th class="text-center">삭제</th>
		        	</tr>
				</thead>
				<tbody>
					<c:forEach var="vo" items="${inquiryList}">
							<tr>
								<td class="text-center">${vo.inquiry_idx}</td>
								<td class="text-center">${vo.user_id}</td>
								<td class="text-center">
									${fn:substring(vo.inquiry_content,0,10)}
									<c:if test="${fn:length(vo.inquiry_content) > 10}">...</c:if>
								</td>
								<td class="text-center">${vo.write_date}</td>
								<td class="text-center">
			        				<c:if test="${vo.admin_answer_yn == 'y'}">
			        					<i class="fa-solid fa-o"></i>
			        				</c:if>
			        				<c:if test="${vo.admin_answer_yn == 'n'}">
			        					<i class="fa-solid fa-x"></i>
			        				</c:if>
								</td>
								<td class="text-center">
									<c:if test="${vo.admin_answer_yn == 'n'}">
										<a href="javascript:showContent(${vo.inquiry_idx})" class="w3-btn w3-teal w3-hover-teal w3-round-large w3-padding-small w3-small">등록</a>
									</c:if>
									<c:if test="${vo.admin_answer_yn == 'y'}">
										<a href="javascript:showContent(${vo.inquiry_idx})" class="w3-button w3-lime w3-hover-lime w3-round-large w3-padding-small w3-small">수정</a>
									</c:if>
								</td>
								<td class="text-center" style="width:10%">
									<a href="javascript:inquiryDelete(${vo.inquiry_idx})" class="w3-btn w3-2020-flame-scarlet w3-round-large w3-padding-small w3-small">삭제</a>
								</td>
							</tr>
							<tr><td colspan="7" class="p-1 m-1" style="display:none"></td></tr>
							<tr class="w3-2020-brilliant-white content" id="showContent${vo.inquiry_idx}" style="display:none">
								<td colspan="5">
									<div class="mb-2">
										▪️ 문의 내용 :
						    			${vo.inquiry_content}
						    		</div><br>
						    		<div>▪️ 관리자 답변 : </div>
						    		<textarea rows="3" class="form-control" id="admin_answer${vo.inquiry_idx}">${vo.admin_answer}</textarea>
						    		<c:if test="${vo.admin_answer_yn == 'n'}">
						    			<a href="javascript:answerInsert(${vo.inquiry_idx})" class="w3-btn w3-2020-classic-blue w3-round-large w3-padding-small w3-right w3-small mt-2">답변 등록</a>
						    		</c:if>
						    		<c:if test="${vo.admin_answer_yn == 'y'}">
						    			<a href="javascript:answerUpdate(${vo.inquiry_idx})" class="w3-btn w3-lime w3-round-large w3-padding-small w3-right w3-small mt-2">답변 수정</a>
						    		</c:if>
								</td>
								<td class="text-center">
								</td>
								<td class="text-center">
									<a href="javascript:hideContent(${vo.inquiry_idx})" class="w3-btn w3-black w3-round-large w3-padding-small w3-small">닫기</a>
								</td>
							</tr>
					</c:forEach>
					<tr>
						<td colspan="7" class="p-1 m-1 text-center">
							<c:if test="${fn:length(inquiryList) < 1}">
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
		      <a href="${ctp}/inquiry/inquiryList${searchVO.getParams(searchVO)}&pag=1" class="w3-bar-item w3-button w3-hover-black">«</a>
		      <a href="${ctp}/inquiry/inquiryList${searchVO.getParams(searchVO)}&pag=${searchVO.curBlockStartPage - 1}" class="w3-bar-item w3-button w3-hover-black">＜</a>
	      </c:if>
	      <c:forEach var="i" begin="${searchVO.curBlockStartPage}" end="${searchVO.curBlockEndPage}">
	      	<c:if test="${searchVO.pag eq i}"><span style="background:gray; color:white;"></c:if>
		      <a href="${ctp}/inquiry/inquiryList${searchVO.getParams(searchVO)}&pag=${i}" class="w3-bar-item w3-button w3-hover-black">${i}</a>
		    <c:if test="${searchVO.pag eq i}"></span></c:if>
	      </c:forEach>
		  <c:if test="${searchVO.curBlock < searchVO.lastBlock}">
		  	<a href="${ctp}/inquiry/inquiryList${searchVO.getParams(searchVO)}&pag=${searchVO.curBlockEndPage + 1}" class="w3-bar-item w3-button w3-hover-black">＞</a>
		  	<a href="${ctp}/inquiry/inquiryList${searchVO.getParams(searchVO)}&pag=${searchVO.totPage}" class="w3-bar-item w3-button w3-hover-black">»</a>
		  </c:if>
	    </div>
	  </div> 
	</div>
</div>
</body>
</html>