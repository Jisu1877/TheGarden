<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<% pageContext.setAttribute("newLine", "\n");%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상담 글 조회</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <style>
      	#pageContent {
			font-family: 'MaruBuriExtraLight' !important;
			font-family: 'MaruBuriLight' !important;
			font-family: 'MaruBuri' !important;
			font-family: 'MaruBuriBold' !important;
			font-family: 'MaruBuriSemiBold' !important;
		}
		div, ul, li {-webkit-box-sizing: border-box;-moz-box-sizing: border-box;box-sizing: border-box;padding:0;margin:0}
		a {text-decoration:none;}
		
		.quickmenu {position:absolute;width:90px;top:50%;margin-top:-50px;right:10px;background:#fff;}
		.quickmenu ul {position:relative;float:left;width:100%;display:inline-block;*display:inline;border:1px solid #ddd;}
		.quickmenu ul li {float:left;width:100%;border-bottom:1px solid #ddd;text-align:center;display:inline-block;*display:inline;}
		.quickmenu ul li a {position:relative;float:left;width:100%;height:30px;line-height:30px;text-align:center;color:#000;font-size:9.5pt;}
		.quickmenu ul li a:hover {}
		.quickmenu ul li:last-child {border-bottom:0;}
		
		.content {position:relative;min-height:1000px;}
 		.tableStyle {
	  		width:100%;
	  		overflow-x : auto;
	  		white-space:nowrap;
	  		border-radius: 15px;
	  		background-color: white;
	  	}
    </style>
    <script>
   		$(document).ready(function(){
    	  var currentPosition = parseInt($(".quickmenu").css("top"));
    	  $(window).scroll(function() {
    	    var position = $(window).scrollTop(); 
    	    $(".quickmenu").stop().animate({"top":position+currentPosition+"px"},800);
    	  });
    	});
   		
	  	function boardDelete(idx) {
			let ans = confirm("해당 상담글을 삭제하시겠습니까?");
			if(!ans) return false;
			
			location.href="${ctp}/plant/boardDelete?idx=" + idx;
		}
	  	
	  	function boardUpdate(idx,flag) {
			if(flag == 'y') {
				alert("관리자 답변 후엔 수정이 어렵습니다.");
				return false;
			}
			
			location.href="${ctp}/plant/boardUpdate?idx="+idx;
		}
	  	
	  	function boardReplyInsert(plant_board_idx,user_id) {
			let content = $("#content").val();
			
			if(content == "") {
				alert("댓글 내용을 입력하세요.");
				return false;
			}
			
			$.ajax({
				type : "post",
				url : "${ctp}/plant/boardReplyInsert",
				data : {plant_board_idx : plant_board_idx,
						user_id : user_id,
						content : content
				},
				success : function(res) {
					if(res == "1") {
						location.reload();
					}
					else {
						alert("댓글 등록 실패.");
					}
				},
				error : function() {
					alert("전송오류");					
				}
				
			});
		}
	  	
	  	function replyAnswer(idx) {
			$("#reply"+idx).attr("data-idx", idx);	  		
			$("#reply"+idx).show();
		}
	  	
	  	function replyAnswerHide(idx) {
	  		$("#reply"+idx).hide();
		}
	  	
	  	function boardReplyAnswerInsert(plant_board_idx, user_id, plant_board_reply_idx, levelOrder, level) {
			let content = $("#content"+plant_board_reply_idx).val();
			
			if(content == "") {
				alert("댓글 내용을 입력하세요.");
				return false;
			}
			
			let parents = $("#reply"+plant_board_reply_idx).data('idx');
			
			$.ajax({
				type : "post",
				url : "${ctp}/plant/boardReplyAnswerInsert",
				data : {plant_board_idx : plant_board_idx,
						user_id : user_id,
						content : content,
						levelOrder : levelOrder,
						level : level,
						parents : parents
				},
				success : function(res) {
					if(res == "1") {
						location.reload();
					}
					else {
						alert("댓글 등록 실패.");
					}
				},
				error : function() {
					alert("전송오류");					
				}
				
			}); 
		}
	  	
	  	function replyDelete(plant_board_reply_idx) {
	  		$.ajax({
				type : "post",
				url : "${ctp}/plant/replyDelete",
				data : {plant_board_reply_idx : plant_board_reply_idx},
				success : function(res) {
					if(res == "1") {
						alert("삭제되었습니다.");
						location.reload();
					}
					else {
						alert("댓글 삭제 실패.");
					}
				},
				error : function() {
					alert("전송오류");					
				}
				
			}); 
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
    	<div>
    		<div class="w3-row-padding">
    			<div class="w3-col l2 m2">&nbsp;</div>
	    		<div class="w3-col l8 m8">
	    			<div style="font-family:Montserrat,sans-serif">
	    				<c:if test="${user_idx == vo.user_idx}">
	    					<a href="javascript:boardDelete(${vo.plant_board_idx})" class="w3-button w3-khaki w3-hover-khaki w3-round-large w3-right w3-padding-small w3-samll mb-3">삭제</a>
	    					<c:if test="${vo.admin_answer_yn == 'n'}">
	    						<a href="javascript:boardUpdate('${vo.plant_board_idx}','${vo.admin_answer_yn}')" class="w3-button w3-khaki w3-hover-khaki w3-round-large w3-right w3-padding-small w3-samll mb-3 mr-2">수정</a>
	    					</c:if>
	    				</c:if>
	    			</div>
		    		<table class="w3-table w3-bordered" style="margin-top:30px;">
		    			<tr>
		    				<td>ID</td>
		    				<td width="30%">${vo.user_id}</td>
		    				<td>Email</td>
		    				<td width="30%">
		    					<c:if test="${vo.email_yn == 'y'}">
				    				${vo.email}
		    					</c:if>
		    					<c:if test="${vo.email_yn == 'n'}">
		    						비공개
		    					</c:if>
		    				</td>
		    			</tr>
		    			<tr style="font-family: 'MaruBuriLight'">
		    				<th>상담분류</th>
		    				<td>${vo.choice1}</td>
		    				<th>작성일</th>
		    				<td>${fn:substring(vo.write_date,0,10)}</td>
		    			</tr>
		    			<tr style="font-family: 'MaruBuriLight'">
		    				<th>키우는 장소</th>
		    				<td>${vo.choice3}</td>
		    				<th>식물분류</th>
		    				<td>${vo.choice2}</td>
		    			</tr>
		    			<tr style="font-family: 'MaruBuriLight'">
		    				<th>물주는 방법</th>
		    				<td>${vo.choice5}</td>
		    				<th>한달동안 물주는 주기</th>
		    				<td>${vo.choice4}</td>
		    			</tr>
		    			<tr>
							<td colspan="4" class="text-center w3-lime">		    			
				    			<span style="font-size:18px;">${vo.title}</span>
				    		</td>
		    			</tr>
		    			<tr>
		    				<td colspan="4" style="padding-top: 10px;">
		    					${vo.content}
		    				</td>
		    			</tr>
		    			<c:if test="${vo.admin_answer_yn == 'y'}">
		    				<tr class="w3-lime" id="admin">
			    				<td colspan="3" style="padding-top: 10px;">
			    					<span style="font-size:18px;">관리자 답변</span>
			    				</td>
			    				<td class="text-center">
			    					${vo.admin_write_date}
			    				</td>
			    			</tr>
		    				<tr>
			    				<td colspan="4" style="padding-top: 10px;">
			    					${vo.admin_content}
			    				</td>
			    			</tr>
		    			</c:if>
				    </table>
					<div class="w3-responsive tableStyle" style="margin-top: 30px;">
						<table class="w3-table w3-striped"
							style="border-collapse: separate; margin-bottom: 20px;">
							<tr class="w3-2021-inkwell" style="display: none">
								<th></th><th></th><th></th><th></th>
							</tr>
							<tr style="display: none">
								<td colspan="4"></td>
							</tr>
							<tr>
								<td colspan="3">
									<div class="mb-2">댓글 작성 :</div> <textarea rows="3" class="w3-input w3-border" id="content"></textarea>
								</td>
								<td style="vertical-align: middle;">
									<a href="javascript:boardReplyInsert('${vo.plant_board_idx}','${user_id}')" class="w3-btn w3-black w3-small w3-padding-small w3-round-large">등록</a>
								</td>
							</tr>
						</table>
					</div>
				<div class="w3-col l2 m2">&nbsp;</div>
    		</div>
    	</div>
    	<div class="quickmenu" style="font-family:Montserrat,sans-serif">
		  <ul>
		  	<c:if test="${!empty nextVO}">
		    	<li><a  href="${ctp}/plant/showcontent${searchVO.getParams(searchVO)}&pag=${param.pag}&idx=${nextVO.plant_board_idx}">▲ 다음 글</a></li>
		    </c:if>
		    <c:if test="${!empty preVO}">
		    	<li><a href="${ctp}/plant/showcontent${searchVO.getParams(searchVO)}&pag=${param.pag}&idx=${preVO.plant_board_idx}">▼ 이전 글</a></li>
		    </c:if>
		    <c:if test="${vo.admin_answer_yn == 'y'}">
		    	<li><a href="#admin">답변보기</a></li>
		    </c:if>
		    <li><a href="${ctp}/plant/boardList${searchVO.getParams(searchVO)}&pag=${param.pag}">목록으로</a></li>
		    <li><a href="#header" class="w3-black">TOP&nbsp; <i class="fa-solid fa-angles-up"></i></a></li>
		  </ul>
		</div>
		<div class="w3-row-padding">
   			<div class="w3-col l1 m1">&nbsp;</div>
   			<div class="w3-col l10 m10">
				<div><h4>댓글</h4></div>
				<div class="w3-responsive" style="font-family:Montserrat,sans-serif">
					<table class="w3-table w3-bordered">
						<thead>
							<tr class="w3-2021-inkwell">
								<th class="text-left">작성자</th>
								<th class="text-left">댓글내용</th>
								<th class="text-center">작성일자</th>
								<th class="text-center">답글</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="vo" items="${boardReplyList}">
								<c:if test="${vo.delete_yn == 'n'}">
								<tr ${vo.level > 0 ? 'class="w3-light-gray"' : ''}>
									<td class="text-left">
										<c:if test="${vo.level <= 0}">
											${vo.user_id}
										</c:if>
										<c:if test="${vo.level > 0}">
											<c:if test="${vo.level > 1}">&nbsp;&nbsp;</c:if>
											<c:if test="${vo.level > 2}">&nbsp;&nbsp;</c:if>
										 	&nbsp;&nbsp;<span class="iconify mb-3" data-icon="bi:arrow-return-right"></span>
										 	&nbsp;${vo.user_id}
										</c:if>
										<c:if test="${user_id == vo.user_id || sLevel == 0}">
											(<a href="javascript:replyDelete(${vo.plant_board_reply_idx})"><i class="fa-solid fa-xmark"></i></a>)
										</c:if>
									</td>
									<td class="text-left">
										${fn:replace(vo.content, newLine, "<br/>")}
									</td>
									<td class="text-center">
										${fn:substring(vo.write_date, 0, 10)}
									</td>
									<td class="text-center">
										<c:if test="${vo.level < 3}">
											<a onclick="replyAnswer(${vo.plant_board_reply_idx})" class="w3-btn w3-lime w3-padding-small w3-small w3-round-large">답글</a>
										</c:if>
									</td>
								</tr>
								<tr style="display:none" id="reply${vo.plant_board_reply_idx}" data-idx="0">
									<td colspan="3">
										<span class="iconify mb-3 ml-4" data-icon="bi:arrow-return-right"></span> &nbsp; <span class="mb-3">답글 작성 :</span>
										<textarea rows="3" class="w3-input w3-border" id="content${vo.plant_board_reply_idx}"></textarea>
										<div class="text-left mt-2">
											<a href="javascript:replyAnswerHide(${vo.plant_board_reply_idx})" class="w3-btn w3-lime w3-padding-small w3-small w3-round-large mt-2">닫기</a><br>
										</div>
									</td>
									<td style="vertical-align: middle;">
										<a href="javascript:boardReplyAnswerInsert('${vo.plant_board_idx}','${user_id}','${vo.plant_board_reply_idx}','${vo.levelOrder}','${vo.level}')" class="w3-btn w3-black w3-small w3-padding-small w3-round-large mb-4">등록</a><br>
									</td>
								</tr>
								</c:if>
								<c:if test="${vo.delete_yn == 'y'}">
									<tr ${vo.level > 0 ? 'class="w3-light-gray"' : ''}>
										<td colspan="4" class="w3-text-gray">
											삭제된 댓글입니다.
										</td>
									</tr>
								</c:if>
							</c:forEach>
							<c:if test="${boardReplyList.size() == 0}">
								<tr>
									<td colspan="4" class="text-center">
										댓글이 없습니다.
									</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>
		 	<div class="w3-col l1 m1">&nbsp;</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>