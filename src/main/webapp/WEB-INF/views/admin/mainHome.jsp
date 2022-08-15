<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<title>관리자 HOME</title>
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
   		/* box-shadow: 0 13px 10px -18px rgba(0, 0, 0, 1); */
	}
	.tableStyle {
 		width:100%;
 		white-space:nowrap;
 		border-radius: 15px;
 		background-color: white;
 	}
</style>
<script src="${ctp}/js/main.js"></script>
</head>
<body class="w3-light-grey">

<!-- Top container -->
<jsp:include page="/WEB-INF/views/include/admin_nav.jsp" />
<jsp:include page="/WEB-INF/views/include/admin_sidebarMenu.jsp" />

<!-- !PAGE CONTENT! -->
<div class="w3-main w3-collapse" style="margin-left:250px;margin-top:43px;">

  <!-- Header -->
  <header class="w3-container" style="padding-top:22px">
  </header>
<%-- <div class="w3-row-padding w3-margin-bottom">
  	<c:forEach var="count" items="${orderCountList}" end="3">
  	<div class="w3-quarter">
  		<c:if test="${count.status == '신규주문'}">
	    	<a href="${ctp}/admin/order/orderList?part=1">
  		</c:if>
  		<c:if test="${count.status == '배송준비'}">
	    	<a href="${ctp}/admin/order/orderDelivery">
  		</c:if>
  		<c:if test="${count.status == '배송중'}">
	    	<a href="${ctp}/admin/order/orderList?part=4">
  		</c:if>
  		<c:if test="${count.status == '구매확정'}">
	    	<a href="${ctp}/admin/order/orderList">
  		</c:if>
	      <div style="border:16px solid white" class="w3-container w3-border w3-padding-16 w3-round w3-2020-navy-blazer box mt-3">
	        <div class="w3-left"><span style="font-size:25px;">${count.count}</span></div>
	        <div class="w3-right">
	          <h4 class="mr-3">${count.status}</h4>
	        </div>
	      </div>
	    </a>
    </div>
  	</c:forEach>
  </div> --%>
  <div class="w3-row-padding w3-margin-bottom">
    <div class="w3-third">
    	<a href="${ctp}/admin/order/orderList?part=15">
	      <div style="border:16px solid white" class="w3-container w3-border w3-padding-16 w3-round w3-2021-french-blue box mt-3">
	        <div class="w3-left"><span style="font-size:25px;">${cancelRequestCount}</span></div>
	        <div class="w3-right">
	          <h4 class="mr-3">취소요청</h4>
	        </div>
	      </div>
	    </a>
    </div>
    <div class="w3-third">
    	<a href="${ctp}/admin/order/orderList?part=7">
	      <div style="border:16px solid white" class="w3-container w3-border w3-padding-16 w3-round w3-2021-french-blue box mt-3">
	        <div class="w3-left"><span style="font-size:25px;">${exchangeCount}</span></div>
	        <div class="w3-right">
	          <h4 class="mr-3">교환요청</h4>
	        </div>
	      </div>
	    </a>
    </div>
    <div class="w3-third">
    	<a href="${ctp}/admin/order/orderList?part=11">
	      <div style="border:16px solid white" class="w3-container w3-border w3-padding-16 w3-round w3-2021-french-blue box mt-3">
	        <div class="w3-left"><span style="font-size:25px;">${returnCount}</span></div>
	        <div class="w3-right">
	          <h4 class="mr-3">반품요청</h4>
	        </div>
	      </div>
	    </a>
    </div>
  </div>
  <div class="w3-row-padding w3-margin-bottom">
    <div class="w3-third">
    	<a href="${ctp}/itemQna/itemQnaList?part=n">
	      <div style="border:16px solid white" class="w3-container w3-border w3-padding-16 w3-round w3-2021-illuminating box mt-3">
	        <div class="w3-left"><span style="font-size:25px;">${itemQnaNoAnswerCount}</span></div>
	        <div class="w3-right">
	          <h4 class="mr-3">상품문의 미답변</h4>
	        </div>
	      </div>
	    </a>
    </div>
    <div class="w3-third">
    	<a href="${ctp}/inquiry/inquiryList?part=n">
	      <div style="border:16px solid white" class="w3-container w3-border w3-padding-16 w3-round w3-2021-illuminating box mt-3">
	        <div class="w3-left"><span style="font-size:25px;">${inquiryNoAnswerCount}</span></div>
	        <div class="w3-right">
	          <h4 class="mr-3">1:1문의 미답변</h4>
	        </div>
	      </div>
	    </a>
    </div>
    <div class="w3-third">
    	<a href="${ctp}/admin/plant/boardList?part=n">
	      <div style="border:16px solid white" class="w3-container w3-border w3-padding-16 w3-round w3-2021-illuminating box mt-3">
	        <div class="w3-left"><span style="font-size:25px;">${plantBoardNoAnswerCount}</span></div>
	        <div class="w3-right">
	          <h4 class="mr-3">식물상담 미답변</h4>
	        </div>
	      </div>
	    </a>
    </div>
  </div>
  <div>
  <br><br>
    <div class="w3-row-padding">
      <div class="w3-half">
        <div class="w3-responsive tableStyle ml-1">
			<table class="w3-table w3-striped" style="border-collapse:separate;">
				<thead>
					 <tr>
			          	<th colspan="4">
			          		최근 상품 문의
			          		<a href="${ctp}/itemQna/itemQnaList" class="w3-btn w3-black w3-round w3-small w3-padding-small w3-right">GO</a>
			          	</th>
			          </tr>
		        	<tr class="w3-2020-ash">
		        		<th class="text-center">상품명</th>
		        		<th class="text-center">내용</th>
		        		<th class="text-center">작성일</th>
		        		<th class="text-center">답변여부</th>
		        	</tr>
				</thead>
				<tbody>
						<c:forEach var="vo" items="${itemQnaList}">
							<tr>
								<td class="text-center">
									${vo.item_name}
								</td>
								<td>${fn:substring(vo.item_qna_content,0,10)}..</td>
								<td class="text-center">${fn:substring(vo.write_date,0,10)}</td>
								<td class="text-center">
			        				<c:if test="${vo.admin_answer_yn == 'y'}">
			        					<i class="fa-solid fa-o"></i>
			        				</c:if>
			        				<c:if test="${vo.admin_answer_yn == 'n'}">
			        					<i class="fa-solid fa-x"></i>
			        				</c:if>
								</td>
							</tr>
					</c:forEach>
					<tr><td colspan="8" class="p-1 m-1"></td></tr>
				</tbody>
			</table>
		</div>
      </div>
      <div class="w3-half">
        <div class="w3-responsive tableStyle ml-1">
			<table class="w3-table w3-striped" style="border-collapse:separate;">
				<thead>
					 <tr>
			          	<th colspan="4">
			          		최근 식물 상담 문의
			          		<a href="${ctp}/admin/plant/boardList" class="w3-btn w3-black w3-round w3-small w3-padding-small w3-right">GO</a>
			          	</th>
			          </tr>
		        	<tr class="w3-2020-ash">
		        		<th class="text-center">제목</th>
		        		<th class="text-center">글쓴이</th>
		        		<th class="text-center">작성일</th>
		        		<th class="text-center">답변여부</th>
		        	</tr>
				</thead>
				<tbody>
						<c:forEach var="vo" items="${plantBoardList}">
							<tr>
								<td class="text-center">
									${fn:substring(vo.title,0,10)}
									<c:if test="${fn:length(vo.title) >= 10}">
										...
									</c:if>
								</td>
								<td class="text-center">${vo.user_id}</td>
								<td class="text-center">${fn:substring(vo.write_date,0,10)}</td>
								<td class="text-center">
			        				<c:if test="${vo.admin_answer_yn == 'y'}">
			        					<i class="fa-solid fa-o"></i>
			        				</c:if>
			        				<c:if test="${vo.admin_answer_yn == 'n'}">
			        					<i class="fa-solid fa-x"></i>
			        				</c:if>
								</td>
							</tr>
					</c:forEach>
					<tr><td colspan="8" class="p-1 m-1"></td></tr>
				</tbody>
			</table>
		</div>
      </div>
    </div>
    <br><br>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script type="text/javascript">
		let weeklyTotalSales = ${weeklyTotalSales};
	    let bestSellingItemList = ${bestSellingItemList};
	    let reasonList = ${reasonList};
	    let logList = ${logList};
	    
	    let weeklyData = new Array();
	    for (let i = 0; i < 5; i++) {
	    	let obj = new Object();
	    	obj.label = weeklyTotalSales[i].start_date + ' ~ ' + weeklyTotalSales[i].end_date;
	    	obj.value = weeklyTotalSales[i].total_sales;
	    	
	    	weeklyData.push(obj)
	    }
	    
	    let bestSellingData = new Array();
	    for (let i = 0; i < 5; i++) {
	    	let obj = new Object();
	    	obj.label = bestSellingItemList[i].item_name;
	    	obj.value = bestSellingItemList[i].sale_quantity;
	    	
	    	bestSellingData.push(obj)
	    }
	    
	    drawChart('weeklyTotalSalesChart', '최근 5주간 판매액 통계', weeklyData);
	    drawChart('bestSellingItemListChart', '판매 TOP5 상품 판매수량', bestSellingData);
	    drawPieChart('reasonListChart', '상품 취소/교환/반품 사유', reasonList);
	    drawScatterChart('logListChart', '회원 접속 횟수(주간)', logList);
    </script>
	<div class="w3-row">
		<div class="w3-half">
			<div id="weeklyTotalSalesChart" style="display: inline; width: 500px; height: 300px;"></div>
		</div>
		<div class="w3-half">
			<div id="bestSellingItemListChart" style="display: inline; width: 500px; height: 300px;"></div>
		</div>
	</div>
	<div class="w3-row">
		<div class="w3-half">
			<div id="logListChart" style="display: inline; width: 700px; height: 500px;"></div>
		</div>
		<div class="w3-half">
			<div id="reasonListChart" style="display: inline; width: 750px; height: 500px;"></div>
		</div>
	</div>
	<!-- End page content -->
</div>
</div>
</body>
</html>
