<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script language="javascript" src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
</head>
<script type="text/javascript">
function formSubmit(){
	var re3 = RegExp(/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i);
	
	if($("#userID").val() == "") {
    	alert("아이디를 기입해주세요."); 
    	$("#userID").focus(); 
    	return false;
    } if($("#userEmail").val() == "") {
		alert("이메일을 기입해주세요.");
		$("#userEmail").focus();
		return false;
	} if(!re3.test($("#userEmail").val())){ 
    	alert("이메일 형식을 다시 한번 확인해주세요."); 
    	$("#userEmail").val(""); 
    	$("#userEmail").focus(); 
    	return false; 
    	}
	return true;
}

</script>
<style>
	#button {
	width:90px;
    background-color: #b298e6;
    border: none;
    color:#fff;
    padding: 5px 0;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 15px;
    margin: 4px;
    cursor: pointer;
    border-radius: 10px;
}
</style>
<body>
<table width="500px" height="20px">
	<tr>
		<td><b>비밀번호 찾기</b></td>
	</tr>
</table>
	
<form action="./MemberFindPwAction.go" method="post" name="findpw" onclick="return formSubmit();">
	<table width="300px" border-collapse="collapse" >
		<thead>
			<font size="2">
			아이디와 이메일을 입력하세요
			<br><br>
			</font>
		</thead>
		<tr>
			<td colspan="2" height="1"></td>
		</tr>
		<tr>
			<td height="29" bgcolor="#F3F3F3">
				<font size="2">아이디</font>
			</td>
			<td>
				&nbsp;
				<input type="text" name="userID" id="userID" maxlength="12" size="14">
			</td>
		</tr>
		
		<tr>
			<td colspan="2" height="1"></td>
		</tr>
		<tr>
			<td height="29" bgcolor="#F3F3F3">
				<font size="2">이메일</font>
			</td>
			<td>
				&nbsp;
				<input type="text" name="userEmail" id="userEmail" maxlength="20" size="14">
			</td>
		</tr>
		
		<tr>
			<td colspan="2" style="padding: 10px 0 10px 0" align="center">
				<input type="submit" value="찾기" id="button">
			</td>
		</tr>
	</table>
</form>
</body>
</html>