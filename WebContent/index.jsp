<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<link rel="stylesheet" href="css/s tylesheet_member.css">

<%
		String securedUsername = null;
		if (session.getAttribute("userID") != null) {
			securedUsername = (String) session.getAttribute("userID");
		} 
		if (securedUsername != null) {
	%>
	<jsp:include page="boardWrite.jsp" />
<%
		} else{
	%>
		<a href="/04_MyCartFinal/encryptAction.go">로그인 페이지 가기</a>
<%
		}
%>