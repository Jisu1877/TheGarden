<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품문의 비밀번호 확인</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <style>
    	th {
    		width:35%;
    	}
    </style>
    <script>
    	function itemQnaPwdChecks(item_qna_idx) {
    		let item_qna_pwd = $("#item_qna_pwd").val();
    		
    		if(item_qna_pwd == "") {
    			alert("비밀번호를 입력하세요.");
    			return false;
    		}
    		
    		//비밀번호 확인
    		$.ajax({
    			type : "post",
    			url : "${ctp}/itemQna/itemQnaPwdCheck",
    			data : {item_qna_idx : item_qna_idx,
    					item_qna_pwd : item_qna_pwd},
    			success : function(res) {
					if(res == "1") {
						let url = "/javagreenS_ljs/itemQna/itemQnaContent?item_qna_idx="+item_qna_idx;
						let winX = 650;
					    let winY = 650;
					    let x = (window.screen.width/2) - (winX/2);
					    let y = (window.screen.height/2) - (winY/2)
						window.open(url, "nWin", "width="+winX+",height="+winY+", left="+x+", top="+y+", resizable = no, scrollbars = no");
					}
					else {
						alert("비밀번호가 일치하지 않습니다.");
						return false;
					}
				},
				error : function() {
					
				}
    		});
		}
    </script>
</head>
<body>
<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px">
   	<div class="w3-bar w3-border w3-2020-ash">
	  <span class="w3-bar-item w3-padding-16" style="font-size:18px;">상품 문의 비밀번호 확인</span>
	</div>
	<div style="margin-top:10px; padding:10px;">
		<div class="w3-row-padding w3-padding-16">
			<div class="w3-col m1"></div>
			<div class="w3-col m10">
				<label class="mt-3"><b>비밀번호 입력</b></label>
				<div id="pwd">
					<div>
						<label for="item_qna_pwd">비밀번호 : </label>
						<input type="password" id="item_qna_pwd"/>
						<span style="font-size:11px"><i class="fa-solid fa-circle-info"></i> 문의 등록시 입력했던 비밀번호를 입력하세요.</span>
					</div>
				</div>
				<br>
				<div class="text-center">
					<a class="w3-btn w3-black" href="javascript:itemQnaPwdChecks(${item_qna_idx})">입력</a>&nbsp;
					<a class="w3-btn w3-2020-ash" onclick="window.close();">닫기</a>
				</div>
		    </div>
		    <div class="w3-col m1">
		    </div>
	    </div>
	</div>
</div>
</body>
</html>