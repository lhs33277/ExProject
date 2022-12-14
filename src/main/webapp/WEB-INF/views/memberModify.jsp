<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		fnModify();
		fnPhoneCheck();
		fnEmailCheck();
		fnPwConfirm();
		fnLeave();
	})
	
	// ??????
	function fnModify(){
		$('#f').on('submit', function(event){
			if( $('#boardWriterName').val() == '' || $('#boardWriterPw').val() == '' || $('#boardWriterPhone').val() == '' || $('#boardWriterEmail').val() == '' || $('#pwConfirm').val() == ''){
				alert('??????????????? ???????????? ????????? ????????? ????????????.');
				event.preventDefault();
				return false;
			}
			else if(phonePass == false){
				alert('???????????? ????????? ?????? ?????????????????? ????????????.');
				event.preventDefault();
				return false;
			}
			else if(emailPass == false) {
				alert('????????? ????????? ?????? ????????? ????????? ????????????.');
				event.preventDefault();
				return false;
			}
			else if(rePwPass == false){
				alert('????????? ?????? ????????????. ????????? ?????? ???????????? ????????? ????????????.');
				event.preventDefault();
				return false;
			}
			else if(confirm('????????? ???????????? ????????? ???????????????. ?????????????????????????')){
				return true;
			}
			else {
				return false;
			}
				
			
		})
	}
	
	// ????????? ?????????
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
	
	// ???????????? ??????
	let rePwPass = false;
	function fnPwConfirm(){
		$('#pwConfirm').on('keyup', function(){
			if($('#pwConfirm').val() != '' && $('#boardWriterPw').val() != $('#pwConfirm').val()){
				rePwPass = false;
			} else {
				rePwPass = true;
			}
		})
	}
	
	// ????????? ?????????
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
	
	function fnLeave(){
		$('#btnLeave').on('click', function(){
			if(confirm('?????? ????????? ??????????????????. ?????????????????????????')){
				location.href='${contextPath}/leave.do';
			}
		})
	}
	
	
</script>
</head>
<body>
	<form id="f" action="${contextPath}/memberModify.do" method="post" enctype="multipart/form-data">
		<div class="limiter animsition">
			<div class="container-login100">
				<div class="wrap-login100">
					<div class="login100-form validate-form">
						<span class="login100-form-title p-b-27 p-t-15">????????????</span>
						<div class="row text-center">
							<div class="col-sm-12">
								<img src="resources/images/noImage.png" class="img-circle" style="width: 180px; height: 180px; border-radius: 100%;">
							</div>
						</div>
						<div class="form-group" style="margin-bottom: 50px; margin-top: 10px;">
							<div class="input-group">
								<input type="text" class="form-control" readonly>
								<div class="input-group-btn">
									<span class="fileUpload btn login100-form-btn"> <span class="upl" id="upload">?????????</span> <input type="file" class="upload up" name="up" id="up" onchange="readURL(this);" />
									</span>
									<!-- btn-orange -->
								</div>
								<!-- btn -->
							</div>
							<!-- group -->
						</div>
						<!-- form-group -->
	
						<div class="row">
							<div class="col-sm-12">
								<div class="wrap-input100 validate-input" data-validate="Enter username">
									<div class="input100" >${loginMember.boardWriter}</div>
									<span class="focus-input100" data-placeholder="&#xf207;"></span>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-6">
								<div class="wrap-input100 validate-input" data-validate="Enter username">
									<input class="input100" type="text" name="boardWriterName" placeholder="?????? ?????????">
									<span class="focus-input100" data-placeholder="&#xf205;"></span>
								</div>
							</div>
							<div class="col-sm-6">
								<div class="wrap-input100 validate-input" data-validate="Enter username">
									<input class="input100" type="text" name="boardWriterPhone" id="boardWriterPhone" placeholder="???????????? ?????????">
									<span class="focus-input100" data-placeholder="&#xf2be;"></span>
								</div>
							</div>
							<div class="col-sm-12">
								<div class="wrap-input100 validate-input" data-validate="Enter username">
									<input class="input100" type="text" name="boardWriterEmail" id="boardWriterEmail" placeholder="?????????">
									<span class="focus-input100" data-placeholder="&#xf159;"></span>
								</div>
							</div>
						</div>
						<div class="wrap-input100 validate-input" data-validate="Enter username">
							<input class="input100" type="password" name="boardWriterPw" id="boardWriterPw" placeholder="????????? ??????????????????.">
							<span class="focus-input100" data-placeholder="&#xf191;"></span>
						</div>
						<div class="wrap-input100 validate-input" data-validate="Enter username">
							<input class="input100" type="password" id="pwConfirm" placeholder="?????? ??????.">
							<span class="focus-input100" data-placeholder="&#xf191;"></span>
						</div>
						<div class="container-login100-form-btn">
							<button class="login100-form-btn">??????</button> <input type="button" class="login100-form-btn" value="??????" id="btnLeave"> <a href="${contextPath}/list.do" class="login100-form-btn">??????</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="dropDownSelect1"></div>
	</form>
</body>
</html>