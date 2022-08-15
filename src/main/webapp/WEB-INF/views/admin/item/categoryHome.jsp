<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<title>카테고리 관리</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<link rel="icon" href="${ctp}/images/favicon.png">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
	body,h1 {font-family: "Montserrat", sans-serif}
	a {
		text-decoration: none;	
	}
	a:hover {
		color : black;
		text-decoration: none;	
	}
	.box {
   		box-shadow: 0 16px 18px -20px rgba(0, 0, 0, 0.7);
	}
</style>
<script>
	'use strict';
	let MaxLevel;
	let IntLevel;
	$(function(){
		/* 중분류 숨기기 */
		/* $(".subCategory").hide(); */
		
		/* 최대 노출 레벨 알아오기 */
		$.ajax({
			type : "post",
			url : "${ctp}/admin/category/category_group_MaxLevel",
			async : false, // 비동기 처리를 하지 않겠다 (이거 끝나야 다음 코드 실행)
			success : function(data) {
				if(data != null) {
					MaxLevel = data;
					IntLevel = Number(MaxLevel);
					
					if(IntLevel == 10) {
						document.getElementById("inputTr").style.display = "none";
					}
					let NextLevel = IntLevel + 1;
					$("#groupLevel").html("<span>"+NextLevel+"</span>");
				}
				else {
					alert("수정 처리 오류.");
				}
			},
			error : function() {
				alert("전송오류.");
			}
		});
	});
	
	/* 대분류 등록 */
	function category_group_input() {
		let name = myForm.name.value;
		
		if(name == "") {
			alert("대분류명을 입력하세요.");
			myForm.name.focus();
			return false;
		}
		else if(name.length > 10) {
			alert("대분류명은 10자 이내로 입력하세요.");
			myForm.name.focus();
			return false;
		}
		
		$.ajax({
			type : "post",
			url : "${ctp}/admin/category/category_group_input",
			data : {category_group_name : name},
			success : function(data) {
				if(data == 1) {
					location.reload();
				}
				else {
					alert("대분류 등록에 실패했습니다. 다시 시도해주세요.");
				}
			},
			error : function() {
				alert("전송오류.");
			}
		});
	}
	
	/* 사용안함 처리 */
	function category_group_useNot(idx,code) {
		let level = document.getElementById("inputLevel"+idx).value;
		
		let ans = confirm("해당 카테고리를 '사용중지' 처리하시겠습니까?");
		if(ans) {
			$.ajax({
				type : "post",
				url : "${ctp}/admin/category/category_group_useNot",
				data : {category_group_idx : idx,
						category_group_level : level,
						category_group_code : code
				},
				success : function(data) {
					if(data == 1) {
						location.reload();
					}
					else {
						alert("해당 카테고리로 등록된 판매중인 상품이 존재합니다. 해당 상품을 전시중지 처리 후 진행하세요.");
					}
				},
				error : function() {
					alert("전송오류.");
				}
			});
		}
	}
	
	/* 사용 처리 */
	function category_group_use(idx) {
		let ans = confirm("해당 카테고리를 사용하시겠습니까?");
		if(ans) {
			$.ajax({
				type : "post",
				url : "${ctp}/admin/category/category_group_use",
				data : {category_group_idx : idx},
				success : function(data) {
					if(data == 1) {
						location.reload();
					}
					else {
						alert("사용 처리 실패. 다시 시도해주세요.");
					}
				},
				error : function() {
					alert("전송오류.");
				}
			});
		}
		
	}
	
	//수정창 열기
	function category_group_update(idx) {
		document.getElementById("spanLevel"+idx).style.display = "none";
		document.getElementById("inputLevel"+idx).style.display = "block";
		document.getElementById("spanName"+idx).style.display = "none";
		document.getElementById("inputName"+idx).style.display = "block";
		
		document.getElementById("updateBtn"+idx).style.display = "none";
		document.getElementById("updateOkBtn"+idx).style.display = "block";
		document.getElementById("deleteBtn"+idx).style.display = "none";
	}
	
	//수정처리
	function category_group_updateOk(idx, level) {
		let inputLevel = document.getElementById("inputLevel"+idx).value;
		let inputName = document.getElementById("inputName"+idx).value;
		
		if(inputLevel > (IntLevel + 1)) {
			alert("변경할 수 있는 최하위 노출 순위는 "+(IntLevel)+"위 입니다.");
			document.getElementById("inputLevel"+idx).value = (IntLevel);
			document.getElementById("inputLevel"+idx).focus();
			return false;
		}
		
		$.ajax({
			type : "post",
			url : "${ctp}/admin/category/category_group_update",
			data : { category_group_idx : idx,
				     category_group_level : inputLevel,
				     category_group_name : inputName,
				     original_level : level
			},
			success : function(data) {
				if(data == 1) {
					alert("수정처리가 완료되었습니다.");
					location.reload();
				}
				else {
					alert("수정 처리 실패. 다시 시도해주세요.");
				}
			},
			error : function() {
				alert("전송오류.");
			}
		});
	}
	
	/* 삭제처리 */
	function category_group_delete(idx, level, code) {
		let ans = confirm("해당 카테고리를 삭제하시겠습니까?");
		if(ans) {
			$.ajax({
				type : "post",
				url : "${ctp}/admin/category/category_group_delete",
				data : { category_group_idx : idx,
				     	 category_group_level : level,
				     	category_group_code : code
				},
				success : function(data) {
					if(data == 1) {
						alert("대분류 삭제처리가 완료되었습니다.");
						location.reload();
					}
					else {
						alert("해당 카테고리로 등록된 판매중인 상품이 존재합니다. 해당 상품을 삭제처리한 후 진행하세요.");
					}
				},
				error : function() {
					alert("전송오류.");
				}
			});
		}
	}
	
	function categoryAdd(idx) {
		$("#subCategoryInput"+idx).slideDown(300);
	}
	
	function categoryAddNo(idx) {
		$("#subCategoryInput"+idx).slideUp(300);
	}
	
	/* 중분류 추가 */
	function category_input(idx) {
		let category_name = document.getElementById("category_name"+idx).value;
		
		if(category_name == "") {
			alert("중분류명을 입력하세요.");
			document.getElementById("category_name").focus();
			return false;
		}
		else if(category_name.length > 10) {
			alert("중분류명은 10자 이내로 입력하세요.");
			document.getElementById("category_name").focus();
			return false;
		}
		
		$.ajax({
			type : "post",
			url : "${ctp}/admin/category/category_input",
			data : {category_name : category_name,
					category_group_idx : idx
			},
			success : function(data) {
				if(data == 1) {
					alert("중분류가 등록되었습니다.");
					location.reload();
				}
				else {
					alert("중분류 등록에 실패했습니다. 다시 시도해주세요.");
				}
			},
			error : function() {
				alert("전송오류.");
			}
		});
	}
	
	/* 중분류 보기 */
	function showCategory(idx) {
		$(".subCategory"+idx).show();
		document.getElementById("hideCategoryBtn"+idx).style.display = "block";
		document.getElementById("showCategoryBtn"+idx).style.display = "none";
	}
	
	/* 중분류 가리기 */
	function hideCategory(idx) {
		$(".subCategory"+idx).hide();
		document.getElementById("hideCategoryBtn"+idx).style.display = "none";
		document.getElementById("showCategoryBtn"+idx).style.display = "block";
	}
	
	/* 중분류 사용중지 */
	function category_useNot(idx) {
		let ans = confirm("해당 중분류 카테고리를 '사용중지' 처리하시겠습니까?");
		if(ans) {
			$.ajax({
				type : "post",
				url : "${ctp}/admin/category/category_useNot",
				data : {category_idx : idx},
				success : function(data) {
					if(data == "1") {
						location.reload();
					}
					else {
						alert("해당 카테고리로 등록된 판매중인 상품이 존재합니다. 해당 상품을 전시중지 처리 후 진행하세요.");
					}
				},
				error : function() {
					alert("전송오류.");
				}
			});
		}
	}
	
	/* 중분류 사용 처리 */
	function category_use(idx) {
		let ans = confirm("해당 중분류 카테고리를 사용하시겠습니까?");
		if(ans) {
			$.ajax({
				type : "post",
				url : "${ctp}/admin/category/category_use",
				data : {category_idx : idx},
				success : function(data) {
					if(data == "1") {
						location.reload();
					}
					else {
						alert("다시 시도해주세요.");
					}
				},
				error : function() {
					alert("전송오류.");
				}
			});
		}
	}
	
	/* 중분류 삭제 */
	function category_delete(idx) {
		let ans = confirm("해당 중분류 카테고리를 삭제하시겠습니까?");
		if(ans) {
			$.ajax({
				type : "post",
				url : "${ctp}/admin/category/category_delete",
				data : {category_idx : idx},
				success : function(data) {
					if(data == 1) {
						alert("중분류 삭제처리가 완료되었습니다.");
						location.reload();
					}
					else {
						alert("해당 카테고리로 등록된 판매중인 상품이 존재합니다. 해당 상품을 삭제처리한 후 진행하세요.");
					}
				},
				error : function() {
					alert("전송오류.");
				}
			});
		}
	}
	
	function category_update(idx) {
		document.getElementById("spanCName"+idx).style.display = "none";
		document.getElementById("inputCName"+idx).style.display = "block";
		
		document.getElementById("updateCBtn"+idx).style.display = "none";
		document.getElementById("updateOkCBtn"+idx).style.display = "block";
		document.getElementById("deleteCBtn"+idx).style.display = "none";
	}
	
	function category_updateOk(idx) {
		let category_name = $("#inputCName"+idx).val();
		$.ajax({
			type : "post",
			url : "${ctp}/admin/category/category_updateOk",
			data : { category_idx : idx,
					 category_name : category_name
			},
			success : function(data) {
				if(data == 1) {
					alert("수정처리가 완료되었습니다.");
					location.reload();
				}
				else {
					alert("수정 처리 실패. 다시 시도해주세요.");
				}
			},
			error : function() {
				alert("전송오류.");
			}
		});
	}
</script>
</head>
<body class="w3-light-grey">

<!-- Top container -->
<jsp:include page="/WEB-INF/views/include/admin_nav.jsp" />
<jsp:include page="/WEB-INF/views/include/admin_sidebarMenu.jsp" />

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:300px;margin-top:43px;">

 	
 	<!-- content  -->
 	<div class="w3-row-padding w3-margin-bottom">
 		<div class="w3-col s11">
	    <!-- Header -->
		<header style="padding-top:22px;">
			<div class="w3-bottombar w3-light-grey w3-padding" style="margin-bottom: 20px; font-size:23px;">
		    	카테고리 관리
		    </div>
		</header>
 		<form name="myForm">
 			<div class="box w3-border">
				<div class="w3-white w3-padding">
					<div style="padding: 5px;">
						- '대분류'는 최대 10개까지 등록가능합니다.<br>
						- '대분류'를 등록한 뒤에, '중분류' 등록이 가능합니다.<br>
						- 노출순서가 '0'인 경우 현재 사용중이지 않은 카테고리입니다.<br>
						- 카테고리를 '사용중'인 경우에만 수정이 가능합니다.<br>
						- 중분류가 등록된 대분류의 경우,&nbsp; <i class="fa-solid fa-chevron-down"></i> 를 클릭하여 중분류를 조회할 수 있습니다.
					</div>
					<div class="w3-white" style="border: 10px solid lightslategray;">
						<table class="table table-border w3-2020-brilliant-white" style="margin:0px;">
							<tr><td colspan="6">&nbsp;</td></tr>
							<tr>
								<td width="10%">노출 순서</td>
								<td width="30%">분류명</td>
								<td width="13%">카테고리 코드</td>
								<td width="8%" class="text-center">사용 처리</td>
								<td width="20%"class="text-center">수정/삭제</td>
								<td class="w3-center">중분류 추가</td>
								<td></td>
							</tr>
							<c:forEach var="vo" items="${vos}" varStatus="st">
								<tr>
									<td class="w3-center">
										<span id="spanLevel${vo.category_group_idx}">${vo.category_group_level}</span>
										<input id="inputLevel${vo.category_group_idx}" type="text" value="${vo.category_group_level}" name="category_group_level" style="display:none" class="w3-input text-center">
									</td>
									<td>
										<span id="spanName${vo.category_group_idx}">
											${vo.category_group_name}&nbsp;
											<c:if test="${vo.category_group_use_yn == 'y'}">
												<button class="badge badge-primary" disabled>사용중</button>
											</c:if>
										</span>
										<input id="inputName${vo.category_group_idx}" type="text" value="${vo.category_group_name}" name="category_group_name" style="display:none" class="w3-input">
									</td>
									<td>
										${vo.category_group_code}
									</td>
									<td>
										<c:if test="${vo.category_group_use_yn == 'y'}">
											<input type="button" class="w3-button w3-white w3-hover-white w3-small" value="사용 중지" onclick="category_group_useNot('${vo.category_group_idx}','${vo.category_group_code}')">
										</c:if>
										<c:if test="${vo.category_group_use_yn == 'n'}">
											<input type="button" class="w3-button w3-white w3-hover-white w3-small" value="사용" onclick="category_group_use(${vo.category_group_idx})">
										</c:if>
									</td>		
									<td class="w3-center">
										<c:if test="${vo.category_group_use_yn == 'y'}">
											<input type="button" id="updateBtn${vo.category_group_idx}" class="w3-btn w3-2020-classic-blue w3-small" value="수정" onclick="category_group_update(${vo.category_group_idx})">
											<input type="button" id="updateOkBtn${vo.category_group_idx}" class="w3-btn w3-2019-toffee w3-small" value="수정완료" onclick="category_group_updateOk(${vo.category_group_idx}, ${vo.category_group_level})" style="display: none; margin-left: 30px;">
										</c:if>
										<input type="button" id="deleteBtn${vo.category_group_idx}" class="w3-btn w3-2020-classic-blue w3-small" value="삭제" onclick="category_group_delete(${vo.category_group_idx}, ${vo.category_group_level}, '${vo.category_group_code}')">
									</td>
									<td class="w3-center">
										<input type="button" class="w3-btn w3-2020-navy-blazer w3-small" value="추가" onclick="categoryAdd(${vo.category_group_idx})">
									</td>
									<td>
										<c:if test="${vo.categoryList[0] != null}">
											<button onclick="hideCategory(${vo.category_group_idx}); return false;" id="hideCategoryBtn${vo.category_group_idx}" style="display:none"><i class="fa-solid fa-angle-up"></i></button>
											<button onclick="showCategory(${vo.category_group_idx}); return false;" id="showCategoryBtn${vo.category_group_idx}"><i class="fa-solid fa-chevron-down"></i></button>
										</c:if>
									</td>	
								</tr>
								<tr id="subCategoryInput${vo.category_group_idx}" style="display: none" class="w3-white">
									<td class="text-center">중분류<br>추가</td>
									<td colspan="2">
										<input type="text" id="category_name${vo.category_group_idx}" name="category_name" placeholder="중분류명을 입력하세요.(10자 이내)" class="w3-input w3-border w3-light-grey" onKeypress="javascript:if(event.keyCode==13) {category_input()}">
									</td>
									<td class="text-center">
										<input type="button" class="w3-btn w3-2020-amberglow w3-small" value="등록" onclick="category_input(${vo.category_group_idx})">
									</td>
									<td></td>
									<td class="text-center">
										<input type="button" class="w3-btn w3-2020-navy-blazer w3-small" value="취소" onclick="categoryAddNo(${vo.category_group_idx})">
									</td>
									<td></td>
								</tr>
								<!-- 중분류 -->
								<c:set var="i" value="0"/>
								<c:forEach var="cVO" items="${vo.categoryList}">
									<tr class="w3-light-gray subCategory${vo.category_group_idx}" style="display:none">
										<td class="text-right">&nbsp; ${i+1}</td>
										<td>
											<span id="spanCName${cVO.category_idx}">
											${cVO.category_name}&nbsp;
											<c:if test="${cVO.category_use_yn == 'y'}">
												<button class="badge badge-warning" disabled>사용중</button>
											</c:if>
											</span>
											<input id="inputCName${cVO.category_idx}" type="text" value="${cVO.category_name}" style="display:none" class="w3-input">
										</td>
										<td>-</td>
										<td class="text-center">
											<c:if test="${vo.categoryList[i].category_use_yn == 'y'}">
												<input type="button" class="w3-btn w3-2020-amberglow w3-tiny" value="사용 중지" onclick="category_useNot(${vo.categoryList[i].category_idx})">
											</c:if>
											<c:if test="${vo.categoryList[i].category_use_yn == 'n'}">
												<input type="button" class="w3-btn w3-2020-amberglow w3-tiny" value="사용" onclick="category_use(${vo.categoryList[i].category_idx})">
											</c:if>
										</td>
										<td class="text-center">
											<c:if test="${vo.categoryList[i].category_use_yn == 'y'}">
												<input type="button" id="updateCBtn${cVO.category_idx}" class="w3-btn w3-2019-toffee w3-tiny" value="수정" onclick="category_update(${cVO.category_idx})">
												<input type="button" id="updateOkCBtn${cVO.category_idx}" class="w3-btn w3-2019-toffee w3-tiny" value="수정완료" onclick="category_updateOk(${cVO.category_idx})" style="display: none; margin-left: 30px;">
											</c:if>
											<input type="button" id="deleteCBtn${cVO.category_idx}" class="w3-btn w3-2019-toffee w3-tiny" value="삭제" onclick="category_delete(${cVO.category_idx})">
										</td>
										<td></td>
										<td></td>
										<c:set var="i" value="${i + 1}"/>
									</tr>
								 </c:forEach>
							</c:forEach>
							<tr id = "inputTr" class="w3-2020-faded-denim">
								<td class="text-center" id="groupLevel">
								</td>
								<td colspan="2">
									<input type="text" name="name" placeholder="대분류명을 입력하세요.(10자 이내)" class="w3-input" onKeypress="javascript:if(event.keyCode==13) {category_group_input()}">
								</td>
								<td>
									<input type="button" class="w3-btn w3-2020-navy-blazer w3-small" value="등록" onclick="category_group_input()">
								</td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</table>
					</div>
				</div>
				<div class="w3-white w3-padding">
					<div>
						<!-- <input type="button" value="변경사항 저장" class="w3-button w3-dark-grey w3-hover-dark-grey w3-small"> -->
					</div>
				</div>
			</div>
		</form>
		</div>
		<div class="w3-col s1"></div>
	</div>

  <!-- End page content -->
</div>

</body>
</html>
