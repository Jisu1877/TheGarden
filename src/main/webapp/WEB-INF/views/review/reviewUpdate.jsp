<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰 수정</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <style>
   		.w3-radius {
			border-radius: 20px;
		}
		th {
			width: 30%;
		}
    </style>
    <script>
    	function reviewInsert() {
    		let rating = $("select[name=rating]").val();
			let file = $("#file").val();
			let maxSize = 1024 * 1024 * 20;
			let review_subject = $("#review_subject").val();
			let review_contents = $("#review_contents").val();
			
			if(rating == "") {
				alert("평점을 선택하세요.");
				return false;
			}
			else if(review_subject == "") {
				alert("리뷰 제목을 입력하세요.");
				return false;
			}
			else if(review_contents == "") {
				alert("리뷰 내용을 입력하세요.");
				return false;
			}
			
			let fileSize = 0;
    		var files= document.getElementById("file").files;
    		
    		let length = files.length;
    		$("#fileLength").val(length);
    		
    		for(let i=0; i< files.length; i++) {
    			
    			let fName = files[i].name;
    			
    			if(fName != "") {
	   				let ext = fName.substring(fName.lastIndexOf(".")+1);
	   	    		let uExt = ext.toUpperCase();
	
	   	    		if (uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "JPEG" && uExt != "JFIF") {
	   	 				alert("업로드 가능한 파일은 'JPG/GIF/PNG/JPEG/JFIF' 입니다.");
	   	    			return false;
	   	    		}
	   	    		else {
		   	    		fileSize += files[i].size;
	   	    		}
    			}
    		}
    		
    		if(fileSize > maxSize) {
    			alert("업로드 가능한 파일의 총 최대 용량은 20MByte 입니다.");
    			return false;
    		}    		
    		else {
    			reivewForm.submit();
    		}
		}
    	
    	function photoDel(review_idx, image_name, photo) {
    		let ans = confirm("'"+image_name + "' 이미지를 삭제하시겠습니까?");
    		if(!ans) return false;
    		
    		$.ajax({
    			type : "post",
    			url : "${ctp}/review/reviewImageDel",
    			data : {review_idx : review_idx,
    					image_name : image_name,
    					photo : photo},
    			success : function(data) {
    				if(data == "1") {
    					alert("이미지가 삭제되었습니다.");
    					location.reload();
    				}
    				else {
    					alert("이미지 삭제 실패. 다시 시도해주세요.");
    				}
    			},
    			error : function() {
    				alert("전송오류.");
    			}
    		});
    	}
    </script>
</head>
<body>
<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px">
   	<div class="w3-bar w3-border w3-black">
	  <span class="w3-bar-item w3-padding-16" style="font-size:18px;">리뷰 수정</span>
	</div>
	<div style="margin-top:10px; padding:10px;">
		<div class="w3-row-padding w3-padding-16">
			<div class="w3-col m1 w3-margin-bottom"></div>
			<div class="w3-col m10 w3-margin-bottom">
				<label class="w3-yellow mt-3"><b>주문 정보</b></label>
				<table class="table w3-bordered">
					<tr>
						<th>주문 번호</th>
						<td>${orderVO.order_number}</td>
					</tr>
					<tr>
						<th>주문 상품</th>
						<td>
							<img src="${ctp}/data/item/${orderVO.item_image}" alt="${orderVO.item_image}" style="width:20%; margin-top:0px;" class="w3-radius mr-3">
							<br>${orderVO.item_name}
						</td>
					</tr>
					<c:if test="${orderVO.item_option_flag == 'y'}">
						<th>옵션</th>
						<td>${orderVO.option_name}</td>
					</c:if>
					<tr>
						<th>수량</th>
						<td>${orderVO.order_quantity}개</td>
					</tr>
				</table>
				<br>
				<form name="reivewForm" method="post" enctype="multipart/form-data">
					<label class="w3-yellow"><b>리뷰 입력</b></label>
					<table class="table w3-bordered">
						<tr>
							<th>평점(만족도)</th>
							<td>
								<select name="rating" id="rating" class="w3-select w3-border">
								    <option value="">평점을 선택하세요</option>
								    <option value="5" ${reviewVO.rating == 5 ? 'selected' : '' }>⭐⭐⭐⭐⭐</option>
								    <option value="4" ${reviewVO.rating == 4 ? 'selected' : '' }>⭐⭐⭐⭐</option>
								    <option value="3" ${reviewVO.rating == 3 ? 'selected' : '' }>⭐⭐⭐</option>
								    <option value="2" ${reviewVO.rating == 2 ? 'selected' : '' }>⭐⭐</option>
								    <option value="1" ${reviewVO.rating == 1 ? 'selected' : '' }>⭐</option>
								</select>
							 </td>
						</tr>
						<tr>
							<th>리뷰 제목</th>
							<td>
								<input placeholder="리뷰 제목을 입력하세요." value="${reviewVO.review_subject}" class="input w3-border form-control" id="review_subject" name="review_subject" type="text"/>
							</td>
						</tr>
						<tr>
							<th>리뷰 내용</th>
							<td>
								<textarea placeholder="리뷰 내용을 입력하세요." rows="4" class="form-control" id="review_contents" name="review_contents">${reviewVO.review_contents}</textarea>
							</td>
						</tr>
						<tr>
							<td>
								<c:if test="${reviewVO.photo != ''}">
		  							<c:set var="images" value="${fn:split(reviewVO.photo, '/')}"/>
						    		<c:forEach var="image" items="${images}" varStatus="st">
						    			<img src="${ctp}/data/review/${image}" alt="${image}" style="width:100%; margin-top:5px;">
						    			${st.count}.${image}
						    			<a href="javascript:photoDel('${reviewVO.review_idx}','${image}','${reviewVO.photo}')"><font color="tomato">삭제</font></a>
						    		</c:forEach>
		  						</c:if>
							</td>
						</tr>
						<tr>
							<th>사진 첨부</th>
							<td>
								<input type="file" class="w3-file" name="file" id="file" multiple="multiple" class="form-control-file border" accept=".png, .jpg, .jpeg, .jfif, .gif">
							</td>
						</tr>
					</table>
					<div class="text-center">
						<a class="w3-btn w3-black" onclick="reviewInsert()">리뷰 수정</a>&nbsp;
						<a class="w3-btn w3-2021-illuminating" onclick="window.close();">닫기</a>
					</div>
					<input type="hidden" name="photo" value="${reviewVO.photo}">
					<input type="hidden" name="fileLength" id="fileLength">
				</form>
		    </div>
		    <div class="w3-col m1 w3-margin-bottom">
		    </div>
	    </div>
	</div>
</div>
</body>
</html>