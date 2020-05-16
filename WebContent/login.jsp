<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="header.jsp" />
<link rel="stylesheet" href="css/stylesheet_member.css">
<link rel="stylesheet" href="css/bootstrap.css">
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script language="javascript" src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>

<!-- script 태그에서 가져오는 자바스크립트 파일의 순서에 주의해야한다! 순서가 틀릴경우 자바스크립트 오류가 발생한다. -->

<script type="text/javascript" src="<%=request.getContextPath()%>/js/jsbn.js"></script>    
<script type="text/javascript" src="<%=request.getContextPath()%>/js/rsa.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/prng4.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/rng.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/login.js"></script>


<script type="text/javascript">

        jQuery(document).ready(function() {
              /* $('#myModal').onclick(); */
        });
        //팝업 Close 기능
        function close_pop(flag) {
             $('#myModal').fadeOut();
        };
        
     $(function(){
        	$('#button').click(function(){
        		$('#myModal').fadeIn();
        	});
        	
        	$('#img').css('background-image: url("./images/back2.png"), width: 1920px, height: 865px');
        	
        	var popupX = (window.screen.width / 2) - (200 / 2);
        	var popupY= (window.screen.height /2) - (300 / 2);
        	
        	$('.id').click(function(){
        		window.open('idFind.jsp', 'window_name','width=400,height=250,location=no,status=no,scrollbars=yes, left='+popupX+', top='+popupY);
        	});
        	
        	$('.pw').click(function(){
        		window.open('findpw.jsp', 'window_nam','width=400,height=250,location=no ,status=no, scrollbars=yes, left='+popupX+', top='+popupY);
        	});
       });
     
</script>


<style>
/* The Modal (background) */
.modal {
	display: none; /* Hidden by default */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}
/* Modal Content/Box */
.modal-content {
	background-color: #fefefe;
	margin: 15% auto; /* 15% from the top and centered */
	padding: 20px;
	border: 1px solid #888;
	width: 20%; /* Could be more or less, depending on screen size */
	bottom: 20%;
	margin-bottom: -50px;
}


</style>

<script type="text/javascript">

function validateEncryptedForm() {
    var userID = document.getElementById("userID").value;
    var password = document.getElementById("password").value;
    if (!userID) {
        alert("ID를 입력해주세요.");
        return false;
    }
    if(!password){
    	alert("비밀번호를 입력해주세요.");
        return false;
    }

    try {
        var rsaPublicKeyModulus = document.getElementById("rsaPublicKeyModulus").value;
        var rsaPublicKeyExponent = document.getElementById("rsaPublicKeyExponent").value;
        submitEncryptedForm(userID,password, rsaPublicKeyModulus, rsaPublicKeyExponent);
    } catch(err) {
        alert(err);
    }
    return false;
}

function submitEncryptedForm(userID, password, rsaPublicKeyModulus, rsaPublicKeyExponent) {
    var rsa = new RSAKey();
    rsa.setPublic(rsaPublicKeyModulus, rsaPublicKeyExponent);

    // 사용자ID와 비밀번호를 RSA로 암호화한다.
    var securedUserID = rsa.encrypt(userID);
    var securedPassword = rsa.encrypt(password);

    // POST 로그인 폼에 값을 설정하고 발행(submit) 한다.
    var securedLoginForm = document.getElementById("securedLoginForm");
    securedLoginForm.securedUserID.value = securedUserID;
    securedLoginForm.securedPassword.value = securedPassword;
    securedLoginForm.submit();
}
</script>

<!-- 본문 로그인창 시작-->
<div class="row backgroundimg" id="img">
	<!-- <img src="./images/back2.png"> -->

	<div class="container" id="img">
		<div class="col-lg-1"></div>
		<div class="col-lg-10">
			<div class="wrapper">
				<div class="jumbotron">
				<!-- 	<form method="post" action="./loginAction.go">-->
						<img src="images/logo-button_sm.png" id="logo-button" />
						<h2 style="text-align: center;" class="logo">MyCart</h2>
						<h3 style="text-align: center;">지금 담아보세요</h3>
						<div>&nbsp;</div>
						
     				    <div>
				            <label for="userID">사용자ID : <input type="text" id="userID" size="16"/></label>
				            <label for="password">비밀번호 : <input type="password" id="password" size="16" /></label>
				            <input type="hidden" id="rsaPublicKeyModulus" value="<%=request.getAttribute("publicKeyModulus")%>"/>
				            <input type="hidden" id="rsaPublicKeyExponent" value="<%=request.getAttribute("publicKeyExponent")%>"/>
				            <!--<a href="<%=request.getContextPath()%>/loginFailure.jsp" onclick="validateEncryptedForm(); return false;">로그인</a>-->
				            <input class="btn btn-primary form-control bnt-block" value="로그인" onClick="validateEncryptedForm(); return false;">
        				</div>
        				<form id="securedLoginForm" name="securedLoginForm" action="<%=request.getContextPath()%>/decryptAction.go" method="post" style="display: none;">
				            <input type="hidden" name="securedUserID" id="securedUserID" value="" />
				            <input type="hidden" name="securedPassword" id="securedPassword" value="" />
        				</form>
        
						<!--<input type="submit"
							class="btn btn-primary form-control bnt-block" value="로그인"> -->
						<input class="btn btn-success btn-block" value="지금 가입하기"
							id="button">
						<div>&nbsp;</div>
						<div id="info" align="center">
							<a href="#" class="id">아이디 찾기</a>/<a href="#"
								class="pw">비밀번호 찾기</a>
						</div>
					</form>
				</div>
			</div>
		</div>
		<div class="col-lg-1"></div>

<script type="text/javascript">
	function validate() {
		var re = RegExp(/^(?=.*\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{7,19}$/); // 아이디가 적합한지 검사할 정규식
		var re2 = RegExp(/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/); // 패스워드가 적합한지 검사할 정규식
	    var re3 = RegExp(/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i); // 이메일이 적합한지 검사할 정규식
		
	    if($("#userName").val() == "") {
	    	alert("이름을 입력해주세요."); 
	    	$("#userName").focus(); 
	    	return false;
	    }
	    
	    if($("#ID").val() == "") {
	    	alert("아이디를 입력해주세요."); 
	    	$("#ID").focus(); 
	    	return false;
	    }
	    
	    if(!re.test($("#ID").val())){ 
	    	alert("아이디는 7 ~ 19자의 영문 대소문자와 숫자의 조합으로 입력해주세요."); 
	    	$("#ID").val(""); 
	    	$("#ID").focus(); 
	    	return false; 
	    	}
	    
	    if($("#Password").val() == "") {
	    	alert("비밀번호를 입력해주세요."); 
	    	$("#Password").focus(); 
	    	return false;
	    }
	    
	    if(!re2.test($("#Password").val())){ 
	    	alert("비밀번호는 8 ~ 16자의 영문 대소문자와 숫자의 조합으로 입력해주세요."); 
	    	$("#Password").val(""); 
	    	$("#Password").focus(); 
	    	return false; 
	    	}
	    
	    if($("#PasswordCheck").val() == "") {
	    	alert("비밀번호 확인란을 입력해주세요."); 
	    	$("#PasswordCheck").focus(); 
	    	return false;
	    }
	    
	    if($("#Password").val() != $("#PasswordCheck").val()){ 
	    	alert("비밀번호가 상이합니다"); 
	    	$("#Password").val(""); 
	    	$("#PasswordCheck").val(""); 
	    	$("#Password").focus(); 
	    	return false; 
	    }
	    
	    if($("#userEmail").val() == "") {
	    	alert("이메일을 입력해주세요."); 
	    	$("#userEmail").focus(); 
	    	return false;
	    }
		
	    if(!re3.test($("#userEmail").val())){ 
	    	alert("이메일 형식을 다시 한번 확인해주세요."); 
	    	$("#userEmail").val(""); 
	    	$("#userEmail").focus(); 
	    	return false; 
	    	}
	    
	    alert("회원가입이 완료되었습니다.");
	    return true;
	    
	}
	
</script>

<!-- The Modal -->
		<div id="myModal" class="modal">
			<!-- Modal content -->
			<div class="modal-content" id="modal-content">
				<p style="text-align: center;">
					<span style="font-size: 14pt;"><b><span
							style="font-size: 24pt;">회원가입</span></b></span>
				</p>
				<p style="text-align: center; line-height: 1.5;">
					<br />
				</p>
				<form method="post" action="./joinAction.go" onsubmit ="return validate();">
					<img src="images/logo-button_sm.png" id="logo-button"
						align="middle" />
					<h2 style="text-align: center;" class="logo">MyCart</h2>
					<h3 style="text-align: center;">회원가입</h3>
					<div class="form-group">
						<input type="text" id="userName" class="form-control" placeholder="이름" 
							name="userName" maxlength="20">
					</div>
					<div class="form-group">
						<input type="text" id="ID" class="form-control" placeholder="아이디"
							name="ID" maxlength="20" >
					</div>
					<div class="form-group">
						<input type="password" id="Password" class="form-control" placeholder="비밀번호"
							name="Password" maxlength="20" >
					</div>
					<div class="form-group">
						<input type="password" id="PasswordCheck" class="form-control" placeholder="비밀번호 확인"
							name="PasswordCheck" maxlength="20" >
					</div>
					<div class="form-group">
						<input type="text" id="userEmail" class="form-control" placeholder="이메일"
							name="userEmail" maxlength="20" >
					</div>
					<div class="form-group" style="text-align: center;">
						<div class="btn-group" data-toggle="buttons">
							<label class="btn btn-primary active"> 
								<input type="radio" name="userGender" autoComplete="off" value="남자" checked>남자</label> 
							<label class="btn btn-danger"> 
								<input type="radio" name="userGender" autoComplete="off" value="여자" checked>여자</label>
						</div>
					</div>
					
					<input type="submit" class="btn btn-primary form-control" value="회원가입">
				</form>
					<input type="button" value="닫기" class="btn btn-success form-control" onClick="close_pop();">

			</div>
		</div>
	</div>
	<!--End Modal-->

</div>
<!-- 본문 끝 -->
<jsp:include page="footer.jsp" />
