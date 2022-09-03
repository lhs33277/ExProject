<%@ page language="java" contentType="text/html; charset=UTF8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
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
		fnSignUp();
		fnIdcheck();
		fnPhoneCheck();
		fnEmailCheck();
		fnEmailConfirm();
		fnFileCheck();
		
	})
	
	// 회원가입 서브밋
	function fnSignUp(){
		$('#f').on('submit', function(event){
			if( $('#boardWriter').val() == '' || $('#boardWriterName').val() == '' || $('#boardWriterPw').val() == '' || $('#boardWriterPhone').val() == '' || $('#boardWriterEmail').val() == '' || $('#emailConfirm').val() == ''){
				alert('모든항목을 빈칸없이 작성해 주시기 바랍니다.');
				event.preventDefault();
				return false;
			}
			else if(idPass == false){
				alert('중복된 아이디입니다.');
				event.preventDefault();
				return false;
			}
			else if(emailPass == false) {
				alert('이메일 양식에 맞춰 작성해 주시기 바랍니다.');
				event.preventDefault();
				return false;
			}
			else if(reEmailPass == false){
				alert('작성된 이메일이 다릅니다. 이메일을 다시 확인하여 주시기 바랍니다.');
				event.preventDefault();
				return false;
			}
			else if(phonePass == false){
				alert('전화번호 양식에 맞춰 작성해주시기 바랍니다.');
				event.preventDefault();
				return false;
			}
			
			
			return true;
		})
	}
	
	
	// 아이디 중복체크
	let idPass = false;
	function fnIdcheck(){
		$('#boardWriter').on('keyup',function(){
			$.ajax({
				url: '${contextPath}/idCheck.do',
				type: 'get',
				data: 'boardWriter=' + $('#boardWriter').val(),
				dataType: 'json',
				success: function(obj){
					if(obj.res == null){
						idPass = true;
					} else {
						idPass = false;
					}
				},
				error: function(jqXHR){
					idPass = false;
				}
			})
		})
	}
	
	// 휴대폰 정규식
	let phonePass = false;
	function fnPhoneCheck(){
		$('#boardWriterPhone').on('keyup', function(){
			let regPhone = /^01[0169]-[0-9]{4}-[0-9]{4}$/;
			if(regPhone.test($('#boardWriterPhone').val()) == false){
				phonePass = false;
				return;
			} else {
				phonePass = true;
			}
		})
	}
	
	
	// 이메일 정규식
	let emailPass = false;
	function fnEmailCheck(){
		$('#boardWriterEmail').on('keyup',function(){
			let regEmail = /^[a-zA-Z0-9-_]+@[a-zA-Z0-9]+(\.[a-zA-Z]{2,}){1,2}$/;
			if(regEmail.test($('#boardWriterEmail').val()) == false){
				emailPass = false;
				return;
			} else {
				emailPass = true;
			}
		})
	}
	
	
	// 이메일 확인
	let reEmailPass = false;
	function fnEmailConfirm(){
		$('#emailConfirm').on('keyup', function(){
			if($('#emailConfirm').val() != '' && $('#boardWriterEmail').val() != $('#emailConfirm').val()){
				reEmailPass = false;
			} else {
				reEmailPass = true;
			}
		})
	}
	
	// 파일체크
	function fnFileCheck(){
		$('#up').on('change', function(){
			let regExt = /(.*)\.(jpg|png)$/;
			let files = $(this)[0].files;
			if(regExt.test(files[0].name) == false){
				alert('PNG JPG만 가능합니다.');
				$(this).val('');
				return;
			}
		})
	}
	

</script>
</head>

<body>
	<form id="f" action="${contextPath}/signUp.do" method="post" enctype="multipart/form-data">
		<div class="limiter animsition">
			<div class="container-login100">
				<div class="wrap-login100">
					<div class="login100-form validate-form">
						<span class="login100-form-title p-b-27 p-t-15">회원가입</span>
						<div class="row text-center">
							<div class="col-sm-12">
								<img src="resources/images/noImage.png" class="img-circle" style="width: 180px; height: 180px; border-radius: 100%;">
							</div>
						</div>
						<div class="form-group" style="margin-bottom: 50px; margin-top: 10px;">
							<div class="input-group">
								<input type="text" class="form-control" readonly>
								<div class="input-group-btn">
									<span class="fileUpload btn login100-form-btn"> <span class="upl" id="upload">업로드</span> <input type="file" class="upload up" id="up" name="up" onchange="readURL(this);" />
									</span>
									<!-- btn-orange -->
								</div>
								<!-- btn -->
							</div>
							<!-- group -->
						</div>
						<!-- form-group -->
	
						<div class="row">
							<div class="col-sm-6">
								<div class="wrap-input100 validate-input" data-validate="Enter username">
									<input class="input100" type="text" name="boardWriter" placeholder="ID" id="boardWriter">
									<span class="focus-input100" data-placeholder="&#xf207;"></span>
								</div>
							</div>
							<div class="col-sm-6">
								<div class="wrap-input100 validate-input" data-validate="Enter password">
									<input class="input100" type="password" name="boardWriterPw" placeholder="Password" id="boardWriterPw">
									<span class="focus-input100" data-placeholder="&#xf191;"></span>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-6">
								<div class="wrap-input100 validate-input" data-validate="Enter username">
									<input class="input100" type="text" name="boardWriterName" placeholder="이름 입력란" id="boardWriterName">
									<span class="focus-input100" data-placeholder="&#xf205;"></span>
								</div>
							</div>
							<div class="col-sm-6">
								<div class="wrap-input100 validate-input" data-validate="Enter username">
									<input class="input100" type="text" name="boardWriterPhone" placeholder="전화번호 입력란" id="boardWriterPhone">
									<span class="focus-input100" data-placeholder="&#xf2be;"></span>
								</div>
							</div>
						</div>
						<div class="wrap-input100 validate-input" data-validate="Enter username">
							<input class="input100" type="text" name="boardWriterEmail" placeholder="이메일을 입력해주세요." id="boardWriterEmail">
							<span class="focus-input100" data-placeholder="&#xf15a;"></span>
						</div>
	
						<div class="wrap-input100 validate-input" data-validate="Enter username">
							<input class="input100" type="text" placeholder="이메일을 다시한번 입력해주세요." id="emailConfirm">
							<span class="focus-input100" data-placeholder="&#xf159;"></span>
						</div>
	
						<div class="container-login100-form-btn">
							<button class="login100-form-btn">가입</button>  <a href="loginPage.do" class="login100-form-btn">취소</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="dropDownSelect1"></div>
	</form>
</body>
</html>