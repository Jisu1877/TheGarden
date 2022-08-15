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
    <title>1:1 문의</title>
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
	    	qnaInsertForm.submit();
		}
	    
	    /* 마이페이지로 이동 */
	    function myPageOpen() {
			opener.location.href="${ctp}/user/inquiryList";
			window.close();
		}
    </script>
</head>
<body>
<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px">
   	<div class="w3-bar w3-border w3-2021-inkwell">
	  <span class="w3-bar-item w3-padding-16" style="font-size:18px;">1:1 문의</span>
	</div>
	<div>
		<div class="w3-row-padding w3-padding-16">
			<div class="w3-col m1 w3-margin-bottom"></div>
			<div class="w3-col m10 w3-margin-bottom">
				<form name="qnaInsertForm" method="post" action="${ctp}/main/qnaInsert">
					<div style="font-size:14px; margin-bottom:15px;">
						<textarea name="inquiry_content" cols="50" rows="5" Class="w3-input w3-border" id="item_qna_content" placeholder="문의하실 내용을 입력하세요."></textarea>
						<div id="textLengthCheck" style="text-align:right"></div>		
					</div>
					<hr>
					<div style="font-size:12px;color:gray">
						<i class="fa-solid fa-circle-exclamation"></i>&nbsp;
						문의하신 내용에 대한 답변은 해당 상품의 상세페이지 또는 
						<a href="javascript:myPageOpen()" style="text-decoration:underline;">'마이페이지 > 내가 쓴 게시물'</a>에서 확인하실 수 있습니다.
					</div>
					<div class="text-center">
						<a class="w3-btn w3-2021-inkwell" onclick="qnaInsert()">문의하기</a>&nbsp;
						<a class="w3-btn w3-2021-illuminating" onclick="window.close();">닫기</a>
					</div><br>
					<div class="w3-panel w3-light-grey">
					  <p>
					  	<i class="fa fa-quote-right w3-xxlarge"></i><br>
					  	카카오톡 상담을 통해 문의하시면 빠르게 응답받으실 수 있습니다.<br>
					  	운영시간 : 09:00 - 18:00 (평일)
				        <script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
					  	<div id="kakao-talk-channel-chat-button"></div>
					  </p>
					</div>
			        <script type="text/javascript">
				      // 사용할 앱의 JavaScript 키를 설정해 주세요.
				      Kakao.init('519384171cff5916d36308792f665979');
				  	
				      // 채널 1:1 채팅 버튼을 생성합니다.
				      Kakao.Channel.createChatButton({
				        container: '#kakao-talk-channel-chat-button',
				        channelPublicId: '_WgLIxj',
				        title: 'consult',
				        size: 'small',
				        color: 'yellow',
				        shape: 'pc',
				        supportMultipleDensities: true,
				      });
				     </script>
					<hr>
					<div style="font-size:13px;">
						<b>1:1문의 작성 유의사항</b>
						<hr>
						<div>
							▪️ 1:1 문의는 관리자에게 직접 문의할 내용이 있을 시 작성하는 게시판입니다.<br>
							▪️ 비방/욕설/명예훼손성 게시글 및 광고글 등 부적절한 문의 등록 시 문의 답변 없이 삭제 조치 될 수 있습니다.<br>
							▪️ 상품 및 상품 구매 과정(배송, 반품/취소, 교환/변경)에 대한 내용은 해당 상품의 상품 문의를 이용하세요.<br>
							▪️ 상품에 대한 이용 후기는 리뷰에 남겨 주세요.<br>
						</div>
					</div>
				</form>
		    </div>
		    <div class="w3-col m1 w3-margin-bottom">
		    </div>
	    </div>
	</div>
</div>
</body>
</html>