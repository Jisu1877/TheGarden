<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 취소 요청</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <style>
    	th {
    		width:30%;
    	}
	    .error_msg {
	    	display: block;
	    	color: red;
	    	font-size: 13px;
        }
    </style>
    <script>
	    $(function() {
	    	$("#item_qna_content").keyup(function(e) {
	    		var content = $(this).val();
	    		$("#textLengthCheck").text("(" + content.length + " / 500)"); //실시간 글자수 카운팅
	    		if (content.length > 500) {
	    			alert("최대 500자까지 입력 가능합니다.");
	    			$(this).val(content.substring(0, 500));
	    			$('#textLengthCheck').text("(500 / 500)");
	    		}
	    	});
	    	
	    	$("input[name='view_yn']").change(function(){
	    		let view_yn = $("input[name='view_yn']:checked").val();
	    		if(view_yn == 'n') {
	    			$("#pwd").attr("style","display:block;");
	    			$("input[name=item_qna_pwd]").attr("disabled", false);
	    		}
	    		else {
	    			$("#pwd").attr("style","display:none;");
	    			$("input[name=item_qna_pwd]").attr("disabled", true);
	    		}
	    	});
	    });
		
	    function qnaInsert() {
	    	let view_yn = $("input[name='view_yn']:checked").val();
	    	if(view_yn == 'y') {
		    	$("#item_qna_pwd").val("00000000");
	    	}
	    	
	    	qnaInsertForm.submit();
		}
	    
	    function itemQnaMypage() {
	    	opener.location.href="${ctp}/user/itemQnaList";
			window.close();
		}
    </script>
</head>
<body>
<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px">
   	<div class="w3-bar w3-border w3-2021-inkwell">
	  <span class="w3-bar-item w3-padding-16" style="font-size:18px;">상품 Q&A 작성하기</span>
	</div>
	<div style="">
		<div class="w3-row-padding w3-padding-16">
			<div class="w3-col m1 w3-margin-bottom"></div>
			<div class="w3-col m10 w3-margin-bottom">
				<form:form commandName="qnaInsert" name="qnaInsertForm" method="post">
					<div style="font-size:14px; margin-bottom:15px;">
						<form:textarea path="item_qna_content" cols="50" rows="5" cssClass="w3-input w3-border" placeholder="문의하실 내용을 입력하세요." />
						<form:errors path="item_qna_content" cssClass="error_msg" />
						<div id="textLengthCheck" style="text-align:right"></div>		
					</div>
					<div style="margin-bottom: 20px;">
						<label for="view_yn">공개 여부 : </label>
					      <div class="form-check-inline">
				        	<div class="form-check">
							    <form:radiobutton class="view_yn" path="view_yn" value="y" />&nbsp;&nbsp;공개&nbsp;&nbsp;&nbsp;
							    <form:radiobutton class="view_yn" path="view_yn" value="n" checked="checked" />&nbsp;&nbsp;비공개&nbsp;&nbsp;&nbsp;
							</div>
						</div><br>
						<div id="pwd">
							<div>
								<label for="item_qna_pwd">비밀번호 : </label>
								<form:input type="password" path="item_qna_pwd" />
								<span style="font-size:11px"><i class="fa-solid fa-circle-info"></i> 8자~30자 이내로 작성</span>
								<form:errors path="item_qna_pwd" cssClass="error_msg" />
							</div>
						</div>				
					</div>
					<hr>
					<div style="font-size:12px;color:gray">
						<i class="fa-solid fa-circle-exclamation"></i>&nbsp;
						문의하신 내용에 대한 답변은 해당 상품의 상세페이지 또는 
						<a href="javascript:itemQnaMypage()" style="text-decoration:underline;">'마이페이지 > 내가 쓴 게시물'</a>에서 확인하실 수 있습니다.
					</div>
					<div class="text-center">
						<a class="w3-btn w3-2021-inkwell" onclick="qnaInsert()">등록</a>&nbsp;
						<a class="w3-btn w3-2021-illuminating" onclick="window.close();">닫기</a>
					</div><br>
					<hr>
					<div style="font-size:13px;">
						<b>상품 Q&A 작성 유의사항</b>
						<hr>
						<div>
							▪️ 상품 Q&A는 상품 및 상품 구매 과정(배송, 반품/취소, 교환/변경)에 대해 판매자에게 문의하는 게시판입니다.<br>
							▪️ 상품 및 상품 구매 과정과 관련 없는 비방/욕설/명예훼손성 게시글 및 상품과 관련 없는 광고글 등 부적절한 게시글 등록 시 글쓰기 제한 및 게시글이 삭제 조치 될 수 있습니다.<br>
							▪️ 전화번호, 이메일 등 개인 정보가 포함된 글 작성이 필요한 경우 판매자만 볼 수 있도록 비밀글로 문의해 주시기 바랍니다.<br>
							▪️ 상품에 대한 이용 후기는 리뷰에 남겨 주세요.<br>
						</div>
					</div>
					<form:hidden path="item_idx" value="${vo.item_idx}"/>
					<form:hidden path="user_idx" value="${vo.user_idx}"/>
				</form:form>
		    </div>
		    <div class="w3-col m1 w3-margin-bottom">
		    </div>
	    </div>
	</div>
</div>
</body>
</html>