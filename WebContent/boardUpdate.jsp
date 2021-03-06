<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="header.jsp" />
<%-- header 의 session 별도 처리 --%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="board.db.BoardDAO"%>
<%@ page import="board.db.BoardDTO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.*"%>
<script language="javascript" src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<%
	BoardDTO board = (BoardDTO)request.getAttribute("boardDTO");
%>

<script type="text/javascript">
function formSubmit(){
	
	if($("#boardTitle").val() == "") {
    	alert("상품명을 입력해주세요."); 
    	$("#boardTitle").focus(); 
    	return false;
    } if($("#boardPrice").val() == "") {
		alert("상품 가격을 입력해주세요.");
		$("#boardPrice").focus();
		return false;
	} if($("#boardEa").val() == ""){ 
    	alert("원하시는 구매 갯수를 입력해주세요."); 
    	$("#boardEa").focus(); 
    	return false; 
    	}
	return true;
}

	
</script>

<link rel="stylesheet" href="css/stylesheet_board.css">
<!-- 글쓰기 기능 -->
<div class="container" id="main">
	<img src="images/logo-button_tb.png" class="img-responsive"
		id="logo-button" />
	<form action="updateAction.tb" method="post"  name="modifyform">
		<div class="panel panel-default" class="col-md-12"></div>
		<!-- name 값이 곧 파라미터 키값이다..... -->
		<input type="hidden" value=<%=board.getBoardID()%> name="boardID">
		<div>&nbsp;	</div>
		<div class="col-md-12 text-center">
			<input class="btn btn-primary" value="돌아가기" onClick="javascript:history.back()">
			<input type="submit" class="btn	btn-success" value="수정하기" onclick="return formSubmit();">
		</div>
		<div>&nbsp;</div>
		<div>&nbsp;</div>
		<table class="table table striped action"
			style="text-align: center; border: 1px solid #dddddd">
			<thead>
			<tr>
			<th colspan="12" style="text-align: center; background-color: #333333; color: #eeeeee">수정 중</th>
			</tr>
			</thead>
			<tbody>
				<tr colspan="2">
					<td><input type="text" class="form-control" placeholder="<%=board.getBoardTitle() %>"
						name="boardTitle" id="boardTitle" maxlength="50"></td>
					<td><input type="text" class="form-control" placeholder="<%=board.getBoardPrice() %>"
						name="boardPrice" id="boardPrice" maxlength="30"></td>
					<td><input type="text" class="form-control" placeholder="<%=board.getBoardEa() %>"
						name="boardEa" id="boardEa" maxlength="10"></td>
					<td><input type="text" class="form-control" placeholder="<%=board.getBoardSellerLink() %>" name="boardSellerLink" maxlength="50"></td>
					<td><input type="text" class="form-control" placeholder="<%=board.getBoardMemo() %>"
						name="boardMemo" maxlength="50"></td>
					<td><input type="text" class="form-control" placeholder="<%=board.getBoardTag() %>"
						name="boardTag" maxlength="50"></td>
				</tr>
			</tbody>
		</table>
	</form>
</div>
<!-- 본문 끝 -->
<jsp:include page="footer.jsp" />