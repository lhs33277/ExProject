<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="icon" type="image/png" href="resources/images/icons/favicon.ico" />
<link rel="stylesheet" type="text/css" href="resources/vendor/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="resources/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="resources/fonts/iconic/css/material-design-iconic-font.min.css">
<link rel="stylesheet" type="text/css" href="resources/vendor/animate/animate.css">
<link rel="stylesheet" type="text/css" href="resources/vendor/css-hamburgers/hamburgers.min.css">
<link rel="stylesheet" type="text/css" href="resources/vendor/animsition/css/animsition.min.css">
<link rel="stylesheet" type="text/css" href="resources/vendor/select2/select2.min.css">
<link rel="stylesheet" type="text/css" href="resources/vendor/daterangepicker/daterangepicker.css">
<link rel="stylesheet" type="text/css" href="resources/css/util.css">
<link rel="stylesheet" type="text/css" href="resources/css/main.css">

<script src="resources/vendor/jquery/jquery-3.2.1.min.js"></script>
<script src="resources/vendor/animsition/js/animsition.min.js"></script>
<script src="resources/vendor/bootstrap/js/popper.js"></script>
<script src="resources/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="resources/vendor/select2/select2.min.js"></script>
<script src="resources/vendor/daterangepicker/moment.min.js"></script>
<script src="resources/vendor/daterangepicker/daterangepicker.js"></script>
<script src="resources/vendor/countdowntime/countdowntime.js"></script>
<script src="resources/js/main.js"></script>
<script>

	$(document).ready(function(){
		fnLogin();

	})
	
	function fnLogin(){
		$('#f').on('submit', function(event){
			if($('#boardWriter').val() == '' || $('#boardWriterPw').val() == ''){
				alert('아이디와 비밀번호를 모두 입력해주세요.');
				event.preventDefault();
				return false;
			}
			
		return true;
		})
	}
	
	


	
</script>
</head>

<body>
	<form id="f" action="${contextPath}/login.do" method="post">
		<div class="limiter animsition">
			<div class="container-login100">
				<div class="wrap-login100">
					<div class="login100-form">
						<div class="text-center" style="width: 100%">
							<img src="resources/images/logo.png" width="50%">
						</div>
	
						<span class="login100-form-title p-b-34 p-t-27"> ITKey Edu<br>Project Login</span>
						
							<div class="wrap-input100 validate-input" data-validate="Enter username">
								<input class="input100" type="text" name="boardWriter" placeholder="ID" id="boardWriter">
								<span class="focus-input100" data-placeholder="&#xf207;"></span>
							</div>
		
							<div class="wrap-input100 validate-input" data-validate="Enter password">
								<input class="input100" type="password" name="boardWriterPw" placeholder="비밀번호" id="boardWriterPw">
								<span class="focus-input100" data-placeholder="&#xf191;"></span>
							</div>
		
							<div class="contact100-form-checkbox">
								<input class="input-checkbox100" id="ckb1" type="checkbox" name="rememberId">
								<label class="label-checkbox100" for="ckb1"> ID 저장 </label>
							</div>
		
							<div class="container-login100-form-btn">
								<button class="login100-form-btn">로그인</button> <a href="registerPage.do" class="login100-form-btn">회원가입</a>
							</div>
					</div>
				</div>
			</div>
		</div>
		<div id="dropDownSelect1"></div>
	</form>
</body>
</html>