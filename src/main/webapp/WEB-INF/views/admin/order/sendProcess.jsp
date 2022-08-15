<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>엑셀 일괄 발송처리</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="icon" href="${ctp}/images/favicon.png">
    <style>
    	th {
    		width:24%;
    	}
    </style>
    <script type="text/javascript">
    	function sendProcess() {
    		//확장자 체크
    		let file = $("#file").val();
    		
    		if (file.indexOf(" ") != -1) { // 혹시 파일명에 공백이 있으면~~~
				alert("업로드 파일명에 공백을 포함할 수 없습니다.");
				return false;
			}
			else if (file != "") {
				let ext = file.substring(file.lastIndexOf(".") + 1);
				let uExt = ext.toUpperCase();
		
				if (uExt != "XLSX" && uExt != "XLS") {
					alert("업로드 가능한 파일 확장자는 '.xlsx / .xls' 입니다.");
					return false;
				}
			}
    		
    		var form = $('#uploadForm')[0];
    		var formData = new FormData(form);
    		 
   		    $.ajax({
   		        url : '${ctp}/excel/fileUpload',
   		        type : 'POST',
   		        data : formData,
   		        contentType : false,
   		        processData : false,
   				success : function(res) {
   					if(res == "1") {
	   					alert("일괄 발송 처리가 완료되었습니다.");
	   	   				window.opener.location.reload();
	   					window.close();
   					}
   					else if(res == "0") {
   						alert("송장번호를 모두 입력하세요.");
   						location.reload();
   						return false;
   					}
   					else if(res == "2") {
   						alert("발송처리 필요 주문 건과 일치하지 않는 주문번호의 자료가 있습니다.");
   						location.reload();
   						return false;
   					}
				},
				error : function() {
					alert("발송처리 불가. \n예상 원인 1 : 주문 목록 번호, 택배사, 송장번호 입력칸은 빈칸이 허용되지 않습니다.\n예상 원인 2 : 배송처리 필요 주문 건수와 엑셀 파일의 주문 건수가 일치하지 않습니다.\n위 2가지 사항을 확인하세요.");
				}
   		    });
    		
    		//uploadForm.submit();
		}
    	
    </script>
</head>
<body>
<!-- !PAGE CONTENT! -->
<div id="pageContent" class="w3-content" style="max-width:1500px">
	<div class="w3-bar w3-border w3-2019-eden">
	  <span class="w3-bar-item w3-padding-16" style="font-size:18px;">엑셀 일괄 발송처리</span>
	</div>
	<div style="margin-top:20px; padding:10px;">
		<div class="w3-row-padding w3-padding-16">
			<div class="w3-col m1 w3-margin-bottom"></div>
			<div class="w3-col m10 w3-margin-bottom">
				<div class="mb-2">
					<span class="w3-yellow">
					<i class="fa-solid fa-circle-info"></i> '엑셀 다운로드'를 통해 다운받은 ' theGarden_excel_form ' 파일 양식만 정상 처리 가능합니다.
					</span>
				</div>
				<div class="mb-3">
					<span>
					<i class="fa-solid fa-circle-info"></i> 주문 목록 번호, 택배사, 송장번호 입력칸은 빈칸이 허용되지 않습니다.
					</span>
				</div>
				<div class="mb-3">
					<span>
					<i class="fa-solid fa-circle-info"></i> 엑셀 2007 버전 이상을 이용해야 합니다.
					</span>
				</div>
				<div style="border: 0.5px solid;" class="w3-padding">
					<label><b>파일 등록</b></label>
					<form name="uploadForm" id="uploadForm" action="${ctp}/excel/fileUpload" method="POST" enctype="multipart/form-data">
						<input type="file" name="file" id="file" class="w3-file w3-2020-brilliant-white" accept=".xlsx"> 
						<input type="button" value="일괄 발송" onclick="sendProcess()">
					</form>
					<br>
		    </div>
			<div class="text-center mt-3"><a class="w3-btn w3-2019-eden" onclick="window.close();">닫기</a></div>
		    <div class="w3-col m1 w3-margin-bottom">
		    </div>
	    </div>
	</div>
</div>
</body>
</html>