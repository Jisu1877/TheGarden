<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<div class="w3-bar w3-top w3-2019-toffee w3-large" style="z-index:4">
  <span class="w3-bar-item">
  	<a href="${ctp}/main/mainHome">
  		<img src="${ctp}/images/logo.png" alt="logo" style="width:40px;" id="mainImage">
  	</a>
  </span>
  <span class="w3-bar-item" style="font-size:22px; margin-top:4px;">
  	<a href="${ctp}/admin/mainHome">ADMIN CENTER</a>
  </span>
<!--   <span class="w3-button w3-2019-toffee w3-hover-khaki w3-xlarge w3-right" id="SidebarMenu" onclick="sidebarMenuopen()">
	<i class="fa fa-bars"></i>
  </span>  -->
  <span class="w3-bar-item w3-right" style="margin-top:6px;">
  	<a href="${ctp}/user/userLogout">LOGOUT</a>
  </span>
</div>