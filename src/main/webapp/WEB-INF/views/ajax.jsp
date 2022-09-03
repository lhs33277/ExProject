<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="icon" type="image/png" href="resources/images/icons/favicon.ico" />
<link rel="stylesheet" type="text/css" href="resources/css/bootstrap.origin.min.css">
<link rel="stylesheet" type="text/css" href="resources/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="resources/fonts/iconic/css/material-design-iconic-font.min.css">
<link rel="stylesheet" type="text/css" href="resources/vendor/css-hamburgers/hamburgers.min.css">
<link rel="stylesheet" type="text/css" href="resources/vendor/animsition/css/animsition.min.css">
<link rel="stylesheet" type="text/css" href="resources/vendor/select2/select2.min.css">
<link rel="stylesheet" type="text/css" href="resources/vendor/daterangepicker/daterangepicker.css">
<link rel="stylesheet" type="text/css" href="resources/css/util.css">
<link rel="stylesheet" type="text/css" href="resources/css/main.css">
<link rel="stylesheet" type="text/css" href="resources/css/table.css">
<link rel="stylesheet" type="text/css" href="resources/css/chat.css">
<link rel="stylesheet" type="text/css" href="resources/css/ajax.main.css">
<link rel="stylesheet" type="text/css" href="resources/vendor/fontawesome-free-5.8.2-web/css/all.min.css">
<style>
	#paging {
		display: flex;
		justify-content: center;
	}
	#paging div {
		width: 32px;
		height: 20px;
		text-align: center;
	}
	.disable_link {
		color: lightgray;
	}
	.enable_link {
		cursor: pointer;
	}
	.now_page {
		border: 1px solid gray;
		color: limegreen;
		font-weight: 900;
	}
</style>
<script src="resources/vendor/jquery/jquery-3.2.1.min.js"></script>
<script src="resources/vendor/animsition/js/animsition.min.js"></script>
<script src="resources/vendor/bootstrap/js/popper.js"></script>
<script src="resources/js/bootstrap.min.js"></script>
<script src="resources/vendor/select2/select2.min.js"></script>
<script src="resources/vendor/daterangepicker/moment.min.js"></script>
<script src="resources/vendor/daterangepicker/daterangepicker.js"></script>
<script src="resources/vendor/countdowntime/countdowntime.js"></script>
<script src="resources/js/main.js"></script>
<script>

	$(document).ready(function(){
		fnIdcheck();
		fnPhoneCheck();
		fnEmailCheck();
		fnEmailConfirm();
		fnFileCheck();
		fnLogin();
		fnRegistConfirm();
		fnBoardList();
		fnBoardCount();
		fnMemberCount();
		fnTodayBoardCount();
		fnTodayMemberCount();
		fnPagingLink();
		fnModifyMember();
		fnAddBoard();
	})
	
	// 1. 회원가입
	function fnSignUp(){
		
			if(confirm('작성한 내용으로 가입이 진행됩니다. 계속하시겠습니까?')){
				
				var formData = new FormData();
				
				formData.append('boardWriter', $('#boardWriter').val());
				formData.append('boardWriterPw', $('#boardWriterPw').val());
				formData.append('boardWriterName', $('#boardWriterName').val());
				formData.append('boardWriterPhone', $('#boardWriterPhone').val());
				formData.append('boardWriterEmail', $('#boardWriterEmail').val());
				
				formData.append('up', $('#up')[0].files[0]);	
				
				$.ajax({
					url: '${contextPath}/ajax/signUp.do',
					type: 'POST',
					data: formData,
					contentType: false,
					processData: false,
					dataType: 'json',
					success: function(obj){
						
					}
				})
				
				alert('가입 성공');
				fnMain();
			}
	}
	
	function fnMain(){
		location.href='${contexPath}/';
	}
	
	function fnRegistConfirm(){
		$('#btnSignUp').on('click', function(event){
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
			
			
			fnSignUp();
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
	
	// 3. 로그인
	var page = 1;
	function fnLogin(){
		$('#btnLogIn').on('click', function(){
			var page = 1;
			$.ajax({
				url: '${contextPath}/ajax/logIn.do',
				type: 'post',
				data: $('#f_logIn').serialize(),
				dataType: 'json',
				success: function(obj){
					if(obj.loginMember == null){
						alert('로그인 실패!');
					}
					location.href='${contextPath}/';
				},
				error: function(jqXHR){
					alert('로그인 실패');
				}
			})
			
		})
	}
	
	
	//1-2 페이징 링크 처리
	function fnPagingLink(){
		$(document).on('click', '.enable_link', function(){
			page = $(this).data('page');
			fnBoardList();
		})
	}

	
	// 4. 게시글 가져오기
	
	function fnBoardList(){

		if(${loginMember != null}){
			$.ajax({
				url: '${contextPath}/ajax/list.do',
				data: 'page=' + page,
				type: 'get',
				dataType: 'json',
				success: function(obj){
					$('#tbody').empty();
					$.each(obj.boards, function(i, board){
						var tr = '<tr>';
						tr += '<td>' + board.rn + '</td>';
						tr += '<td>' + board.boardWriter + '</td>';
						tr += '<td>' + board.boardPublicFl + '</td>';
						tr += '<td>' + board.boardTitle + '</td>';
						tr += '<td>' + board.boardWriteDate + '</td>';
						tr += '</tr>';
						$('#tbody').append(tr);
						
						$('#addBoardId').text(obj.boardWriter)
					})
					fnPrintPaging(obj.p);
					
				}
			})
		}
	}
	
function fnPrintPaging(p){
		
		$('#paging').empty();
		
		var paging = '';
		
		// ◀◀ : 이전 블록으로 이동
		if(page <= p.pagePerBlock){
			paging += '<div class="disable_link">이전</div>';
		} else {
			paging += '<div class="enable_link" data-page="' + (p.beginPage - 1) + '">이전</div>';
		}
		
		
		// 1 2 3 4 5 : 페이지 번호
		for(let i = p.beginPage; i <= p.endPage; i++){
			if(i == page){
				paging += '<div class="disable_link now_page">' + i + '</div>';
			} else {
				paging += '<div class="enable_link" data-page="' + i + '">' + i + '</div>';
			}
		}
		

		// ▶▶ : 다음 블록으로 이동
		if(p.endPage == p.totalPage){
			paging += '<div class="disable_link">다음</div>';
		} else {
			paging += '<div class="enable_link" data-page="' + (p.endPage + 1) + '">다음</div>';
		}
		
		$('#paging').append(paging);
		
	}
	
	
	function fnBoardCount(){
		$.ajax({
			url: '${contextPath}/boardCount.do',
			type: 'get',
			dataType: 'json',
			success: function(obj){
				$('.totalCount').text(obj.result);
			}
			
		})
	}
	
	function fnMemberCount(){
		$.ajax({
			url: '${contextPath}/memberCount.do',
			type: 'get',
			dataType: 'json',
			success: function(obj){
				$('.memberCount').text(obj.result);
			}
			
		})
	}
	
	function fnTodayBoardCount(){
		$.ajax({
			url: '${contextPath}/todayBoardCount.do',
			type: 'get',
			dataType: 'json',
			success: function(obj){
				$('.todayBoardCount').text(obj.result);
			}
			
		})
	}
	
	function fnTodayMemberCount(){
		$.ajax({
			url: '${contextPath}/todayMemberCount.do',
			type: 'get',
			dataType: 'json',
			success: function(obj){
				$('.todayMemberCount').text(obj.result);
			}
			
		})
	}
	
	
	
	function fn_chat_toggle() {
		$(".panel-whole-body").slideToggle();
	}
	
	function fnModifyMember(){
		$('#btnModifyMember').on('click', function(){
			if(confirm('작성한 내용으로 가입이 진행됩니다. 계속하시겠습니까?')){
				
				var formData = new FormData();
				
				formData.append('boardWriter', $('#boardWriter2').val());
				formData.append('boardWriterPw', $('#boardWriterPw2').val());
				formData.append('boardWriterName', $('#boardWriterName2').val());
				formData.append('boardWriterPhone', $('#boardWriterPhone2').val());
				formData.append('boardWriterEmail', $('#boardWriterEmail2').val());
				
				formData.append('up', $('#up2')[0].files[0]);
				
				$.ajax({
					url: '${contextPath}/ajax/modify.do',
					type: 'post',
					data: formData,
					contentType: false,
					processData: false,
					dataType: 'json',
					success: function(obj){
					}
					
				})
				alert('수정완료');
				location.href='${contextPath}/';
			}
		})
	}
	
	
	function fnAddBoard(){
		$('.btnAddSave').on('click', function(){
			
			var formData = new FormData();
			var radio = $('input:radio[name=boardPublicFl]:checked').val();
			if(radio == undefined){
				radio = 'Y';
			}
			
			formData.append('boardTitle', $('#boardTitle').val());
			formData.append('boardContents', $('#addBoardContents').val());
			formData.append('boardPublicFl', radio);
			formData.append('up', $('#input-file-now')[0].files[0]);
			
			$.ajax({
				url: '${contextPath}/ajax/add.do',
				type: 'post',
				data: formData,
				contentType: false,
				processData: false,
				dataType: 'json',
				success: function(obj){
					if(obj.res > 0){
						alert('성공');
					} else {
						alert('실패');
					}
					fnBoardList();
					
				},
				error: function(jqXHR){
					alert('모든항목작성');
				}
				
				
			})
			
			
		})
	}
	
	
</script>
</head>
<body>
	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">ITKey Education</a>
			</div>
			<div class="collapse navbar-collapse" id="myNavbar">
				<c:if test="${loginMember != null}">
					<ul class="nav navbar-nav navbar-right navbar-logout">
						<li class="login-img"><img src="resources/images/noImage.png" class="img-circle img-loginer" style="width: 35px; height: 35px;"></li>
						<li>
							<h5 class="h5-nav">
								<u>${loginMember.boardWriterName}</u><font style="color: #cacaca"> 님이 로그인 하셨습니다.</font>
							</h5>
						</li>
						<li><a href="${contextPath}/ajax/logOut.do" id="btnLogOut"><i class="fas fa-sign-out-alt"></i> 로그아웃</a></li>
						
					</ul>
				</c:if>
				
					<form id="f_logIn">
					<ul class="nav navbar-nav navbar-right navbar-login">
						<c:if test="${loginMember == null}">
							<li class="li-login"><input type="text" name="boardWriter" class="form-control nav-login" id="boardWriterLogin" placeholder="로그인 아이디"></li>
							<li class="li-login"><input type="password" name="boardWriterPw" class="form-control nav-login" id="boardWriterPwLogin" placeholder="비밀번호"></li>
							<li><a id="btnLogIn"><i class="fas fa-sign-in-alt"></i> 로그인</a></li>
						
							<li><a href="#" data-toggle="modal" data-target="#joinModal"><i class="fas fa-user-plus"></i> 회원가입</a></li>
						</c:if>
						<c:if test="${loginMember != null}">
							<li><a href="#" data-toggle="modal" data-target="#memModiModal "><i class="fas fa-user"></i> 정보수정</a></li>
						</c:if>
					</ul>
					</form>
				
			</div>
		</div>
	</div>
	<c:if test="${loginMember == null}">
	<div class="limiter iframe-before-login">
		<div class="container-login100">
			<div class="wrap-login100 warp-iframe">
				<div class="login100-form">
					<div class="row">
						<div class="col-sm-12 col-sm-iframe">
							<iframe src="http://itkey.co.kr" width="100%" height="750px"></iframe>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</c:if>

	<div class="limiter table-after-login-user">
		<div class="container-login100">
			<div class="wrap-login100">
				<div class="login100-form">
					<div class="row panel-row">
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">총 게시글 수</h5>
								<h1 id="" class="overview-content totalCount">242</h1>
								<i class="far fa-file-alt"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">총 가입자 수</h5>
								<h1 id="" class="overview-content memberCount">242</h1>
								<i class="fas fa-users"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">오늘 게시글 수</h5>
								<h1 id="" class="overview-content todayBoardCount">242</h1>
								<i class="fas fa-file-alt"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">오늘 가입자 수</h5>
								<h1 id="" class="overview-content todayMemberCount">242</h1>
								<i class="fas fa-user-circle"></i>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4">
							<button type="button" class="btn btn-default" data-toggle="modal" data-target="#writeModal">
								<i class="fas fa-plus"></i> 새글 추가
							</button>

						</div>
						<div class="col-sm-2"></div>
						<div class="col-sm-2">
							<select class="form-control" id="">
								<option>전체</option>
								<option>작성자</option>
								<option>글내용</option>
							</select>
						</div>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="" placeholder="문자열을 입력해주세요.">
						</div>
						<div class="col-sm-1 text-right">
							<button type="button" class="btn btn-default btn-full">
								<i class="fas fa-search"></i> 검색
							</button>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<table class="table table-hover">
								<thead>
									<tr>
										<th style="width: 7%;">순번</th>
										<th style="width: 9%;">작성자</th>
										<th style="width: 5%;">공개</th>
										<th>제목</th>
										<th style="width: 10%;">작성일자</th>
									</tr>
								</thead>
								<tbody id="tbody">
									
								</tbody>
							</table>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 text-center">
							<ul class="pagination">
								<li id="paging"></li>
								<li>zz</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="limiter table-after-login-admin">
		<div class="container-login100">
			<div class="wrap-login100">
				<div class="login100-form">
					<div class="row panel-row">
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">총 게시글 수</h5>
								<h1 class="overview-content totalCount">242</h1>
								<i class="far fa-file-alt"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">총 가입자 수</h5>
								<h1 class="overview-content memberCount">242</h1>
								<i class="fas fa-users"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">오늘 게시글 수</h5>
								<h1 class="overview-content todayBoardCount">242</h1>
								<i class="fas fa-file-alt"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">오늘 가입자 수</h5>
								<h1 class="overview-content todayMemberCount">242</h1>
								<i class="fas fa-user-circle"></i>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4">
							<button type="button" class="btn btn-default">선택삭제</button>
							<button type="button" class="btn btn-default">회원관리</button>
						</div>
						<div class="col-sm-2"></div>
						<div class="col-sm-2">
							<select class="form-control" id="">
								<option>전체</option>
								<option>작성자</option>
								<option>글내용</option>
							</select>
						</div>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="" placeholder="문자열을 입력해주세요.">
						</div>
						<div class="col-sm-1 text-right">
							<button type="button" class="btn btn-default btn-full">
								<i class="fas fa-search"></i> 검색
							</button>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<table class="table table-hover">
								<thead>
									<tr>
										<th style="width: 5%;"><input type="checkbox" /></th>
										<th style="width: 7%;">순번</th>
										<th style="width: 9%;">작성자</th>
										<th style="width: 5%;">공개</th>
										<th>제목</th>
										<th style="width: 10%;">작성일자</th>
										<th style="width: 10%;">삭제</th>

									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
											<input type="checkbox" />
										</td>
										<td>1</td>
										<td>테스트</td>
										<td>
											<i class="fas fa-lock-open"></i>
										</td>
										<td>하이하이</td>
										<td>2019-10-13</td>
										<td>
											<button class="btn btn-default btn-full">삭제</button>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 text-center">
							<ul class="pagination">
								<li>${paging}</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div class="limiter table-after-login-admin">
		<div class="container-login100">
			<div class="wrap-login100">
				<div class="login100-form">
					<div class="row panel-row">
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">총 게시글 수</h5>
								<h1 class="overview-content totalCount">242</h1>
								<i class="far fa-file-alt"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">총 가입자 수</h5>
								<h1 class="overview-content memberCount">242</h1>
								<i class="fas fa-users"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">오늘 게시글 수</h5>
								<h1 class="overview-content todayBoardCount">242</h1>
								<i class="fas fa-file-alt"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">오늘 가입자 수</h5>
								<h1 class="overview-content todayMemberCount">242</h1>
								<i class="fas fa-user-circle"></i>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4">
							<button type="button" class="btn btn-default">선택탈퇴</button>
							<button type="button" class="btn btn-default">게시판관리</button>
						</div>
						<div class="col-sm-2"></div>
						<div class="col-sm-2">
							<select class="form-control" id="">
								<option>전체</option>
								<option>아이디</option>
								<option>이름</option>
							</select>
						</div>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="" placeholder="문자열을 입력해주세요.">
						</div>
						<div class="col-sm-1 text-right">
							<button type="button" class="btn btn-default btn-full">
								<i class="fas fa-search"></i> 검색
							</button>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<table class="table table-hover">
								<thead>
									<tr>
										<th style="width: 5%;"><input type="checkbox" /></th>

										<th style="width: 5%;">아이디</th>
										<th style="width: 5%;">이름</th>
										<th style="width: 10%;">핸드폰</th>
										<th style="width: 10%;">이메일</th>
										<th style="width: 5%;">탈퇴</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
											<input type="checkbox" />
										</td>
										<td>TEST</td>
										<td>테스트</td>
										<td>010-1234-1234</td>
										<td>test@test.com</td>
										<td>탈퇴완료</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 text-center">
							<ul class="pagination">
								<li><a href="#">이전</a></li>
								<li class="active"><a href="#">1</a></li>
								<li><a href="#">2</a></li>
								<li><a href="#">3</a></li>
								<li><a href="#">4</a></li>
								<li><a href="#">5</a></li>
								<li><a href="#">6</a></li>
								<li><a href="#">7</a></li>
								<li><a href="#">8</a></li>
								<li><a href="#">9</a></li>
								<li><a href="#">10</a></li>
								<li><a href="#">다음</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div class="container">
		<div class="row chat-window col-xs-5 col-md-3" id="chat_window_1" style="margin-left: 10px;">
			<div class="col-xs-12 col-md-12">
				<div class="panel panel-default">
					<div class="panel-heading top-bar">
						<div class="col-md-8 col-xs-8">
							<h3 class="panel-title">
								<i class="fas fa-comments"></i> ITKey 전체 채팅
							</h3>
						</div>
						<div class="col-md-4 col-xs-4" style="text-align: right;">
							<a href="javascript:void(0);" onclick="fn_chat_toggle();"><i class="fas fa-window-minimize" style="color: white"></i></a>
						</div>
					</div>
				</div>
				<div class="panel-whole-body" style="display: none;">
					<div class="panel-body msg_container_base">
						<div class="row msg_container base_sent">
							<div class="col-md-10 col-xs-10">
								<div class="messages msg_sent">
									<p>내가 보낸 내용입니다.</p>
									<time datetime="2009-11-13T20:00">2019-06-24 13:22</time>
								</div>
							</div>
							<div class="col-md-2 col-xs-2 avatar">
								<img src="http://www.bitrebels.com/wp-content/uploads/2011/02/Original-Facebook-Geek-Profile-Avatar-1.jpg" class=" img-responsive ">
							</div>
						</div>
						<div class="row msg_container base_receive">
							<div class="col-md-2 col-xs-2 avatar">
								<img src="http://www.bitrebels.com/wp-content/uploads/2011/02/Original-Facebook-Geek-Profile-Avatar-1.jpg" class=" img-responsive ">
							</div>
							<div class="col-md-10 col-xs-10">
								<div class="messages msg_receive">
									<p>다른사람이 보낸 내용입니다.</p>
									<time datetime="2009-11-13T20:00">2019-06-24 13:22</time>
								</div>
							</div>
						</div>

					</div>
					<div class="panel-footer">
						<div class="input-group">
							<input id="btn-input" type="text" class="form-control input-sm chat_input" placeholder="Write your message here..." />
							<span class="input-group-btn">
								<button class="btn btn-default btn-sm" id="btn-chat">보내기</button>
							</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	<!--Join Modal -->
	<div class="modal fade" id="joinModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">회원가입</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-sm-12">
							<img src="" class="img-circle" style="width: 140px; height: 140px; display: block; margin-left: auto; margin-right: auto;">
						</div>
					</div>
					<div class="form-group" style="margin-bottom: 50px; margin-top: 10px;">
						<div class="input-group">
							<input type="text" class="form-control" readonly>
							<div class="input-group-btn">
								<span class="fileUpload btn login100-form-btn login-file-btn"> <span class="upl" id="upload">업로드</span> 
								<input type="file" name="up" class="upload up" id="up" > <!-- onchange="readURL(this);" -->
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
								<input class="input100" type="text" name="boardWriter" id="boardWriter" placeholder="ID">
								<span class="focus-input100" data-placeholder="&#xf207;"></span>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="wrap-input100 validate-input" data-validate="Enter password">
								<input class="input100" type="password" name="boardWriterPw" id="boardWriterPw" placeholder="Password">
								<span class="focus-input100" data-placeholder="&#xf191;"></span>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6">
							<div class="wrap-input100 validate-input" data-validate="Enter username">
								<input class="input100" type="text" name="boardWriterName" id="boardWriterName" placeholder="이름 입력란">
								<span class="focus-input100" data-placeholder="&#xf205;"></span>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="wrap-input100 validate-input" data-validate="Enter username">
								<input class="input100" type="text" name="boardWriterPhone" id="boardWriterPhone" placeholder="전화번호 입력란">
								<span class="focus-input100" data-placeholder="&#xf2be;"></span>
							</div>
						</div>
					</div>
					<div class="wrap-input100 validate-input" data-validate="Enter username">
						<input class="input100" type="text" name="boardWriterEmail" id="boardWriterEmail" placeholder="이메일을 입력해주세요.">
						<span class="focus-input100" data-placeholder="&#xf15a;"></span>
					</div>

					<div class="wrap-input100 validate-input" data-validate="Enter username">
						<input class="input100" type="text" id="emailConfirm" placeholder="이메일을 다시한번 입력해주세요.">
						<span class="focus-input100" data-placeholder="&#xf159;"></span>
					</div>

					<div class="container-login100-form-btn">
						<a class="login100-form-btn" id="btnSignUp">가입</a> <a href="" data-dismiss="modal" class="login100-form-btn">취소</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--//Join Modal -->

	<!--MemberModify Modal -->

	<div class="modal fade" id="memModiModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">정보수정</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-sm-12">
							<img src="" class="img-circle" style="width: 140px; height: 140px; display: block; margin-left: auto; margin-right: auto;">
						</div>
					</div>
					<div class="form-group" style="margin-bottom: 50px; margin-top: 10px;">
						<div class="input-group">
							<input type="text" class="form-control" readonly>
							<div class="input-group-btn">
								<span class="fileUpload btn login100-form-btn login-file-btn"> 
								<span class="upl" id="upload">업로드</span> 
								<input type="file" name="up" class="upload up" id="up2"> <!-- onchange="readURL(this);"--> 
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
								<input class="input100" type="text" placeholder="ID는 수정불가" readonly>
								<span class="focus-input100" data-placeholder="&#xf207;"></span>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6">
							<div class="wrap-input100 validate-input" data-validate="Enter username">
								<input class="input100" type="text" name="boardWriterName" id="boardWriterName2" placeholder="이름 입력란">
								<span class="focus-input100" data-placeholder="&#xf205;"></span>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="wrap-input100 validate-input" data-validate="Enter username">
								<input class="input100" type="text" name="boardWriterPhone" id="boardWriterPhone2" placeholder="전화번호 입력란">
								<span class="focus-input100" data-placeholder="&#xf2be;"></span>
							</div>
						</div>
						<div class="col-sm-12">
							<div class="wrap-input100 validate-input" data-validate="Enter username">
								<input class="input100" type="text" name="boardWriterEmail" id="boardWriterEmail2" placeholder="이메일">
								<span class="focus-input100" data-placeholder="&#xf159;"></span>
							</div>
						</div>
					</div>
					<div class="wrap-input100 validate-input" data-validate="Enter username">
						<input class="input100" type="password" name="boardWriterPw" id="boardWriterPw2" placeholder="암호를 입력해주세요.">
						<span class="focus-input100" data-placeholder="&#xf191;"></span>
					</div>
					<div class="wrap-input100 validate-input" data-validate="Enter username">
						<input class="input100" type="password" id="pwConfirm2" placeholder="암호 확인.">
						<span class="focus-input100" data-placeholder="&#xf191;"></span>
					</div>
					<div class="container-login100-form-btn">
						<a id="btnModifyMember" class="login100-form-btn">수정</a> <a href="" class="login100-form-btn">탈퇴</a> <a href="" class="login100-form-btn">취소</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!--//MemberModify Modal -->

	<!--Write Modal -->
	<div class="modal fade" id="writeModal" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">
						<i class="fa fa-paper-plane" style="color: #b224ef;"></i> 새글 추가/수정
					</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-sm-12">
							<table class="table table-bordered">
								<tbody>
									<tr>
										<th>제목</th>
										<td colspan="3" class="input-td">
											<input type="text" name="boardTitle" id="boardTitle" class="form-control input-sm" placeholder="제목을 입력해 주세요.">
										</td>
									</tr>
									<tr>
										<th>작성자</th>
										<td>${loginMember.boardWriter}</td>
										<th>공개여부</th>
										<td>
											<label for="radioBoardPublicFl1">공개
												<input type="radio" name="boardPublicFl" id="radioBoardPublicFl1" value="Y">
											</label>
											<label for="radioBoardPublicFl2">비공개
												<input type="radio" name="boardPublicFl" id="radioBoardPublicFl2" value="N">
											</label>
										
										</td>
									</tr>
									<tr>
										<td class="input-td" colspan="4">
											<textarea name="boardContents" class="form-control" style="resize: none;" rows="15" id="addBoardContents" placeholder="내용을 입력해 주세요."></textarea>
										</td>
									</tr>
									<tr>
										<th>첨부파일</th>
										<td colspan="3">
											<input type="file" id="input-file-now" name="up" class="file-upload" />
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-2">
							<button class="btn btn-default btn-full btnAddSave">저장</button>
						</div>
						<div class="col-sm-8"></div>
						<div class="col-sm-2">
							<button class="btn btn-default btn-full" data-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
	<!--//Write Modal -->

	<!--modify Modal -->
	<div class="modal fade" id="modiModal" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">
						<i class="fa fa-paper-plane" style="color: #b224ef;"></i> 글 상세 정보
					</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-sm-2 col-header">
							<div class="well well-sm">
								<i class="fas fa-chevron-up"></i> 이전글
							</div>
						</div>
						<div class="col-sm-8 col-mid">
							<div class="well well-sm">
								<button class="btn btn-link">이전 글 제목입니다.</button>
								
							</div>
						</div>
						<div class="col-sm-2 col-footer">
							<div class="well well-sm">2019-10-13</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<table class="table table-bordered">
								<tbody>
									<tr>
										<th>제목</th>
										<td>제목입니다.</td>
										<th>조회수</th>
										<td>1</td>
									</tr>
									<tr>
										<th>작성자</th>
										<td>홍길동</td>
										<th>작성일자</th>
										<td>2021년01월01일</td>
									</tr>
									<tr>
										<td colspan="4">
											<div class="detail-content"></div>
										</td>
									</tr>
									<tr>
										<th>첨부파일</th>
										<td colspan="3"></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-2 col-header">
							<div class="well well-sm">
								<i class="fas fa-chevron-down"></i> 다음글
							</div>
						</div>
						<div class="col-sm-8 col-mid">
							<div class="well well-sm">
								<button class="btn btn-link">다음 글 제목입니다.</button>
								</a>
							</div>
						</div>
						<div class="col-sm-2 col-footer">
							<div class="well well-sm">2019-10-13</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-2">
							<button class="btn btn-default btn-full">수정</button>
						</div>
						<div class="col-sm-2">
							<button class="btn btn-default btn-full">삭제</button>
						</div>
						<div class="col-sm-6"></div>
						<div class="col-sm-2">
							<button class="btn btn-default btn-full" data-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
			</div>
			</div>
			<!--//modify Modal -->
</body>
</html>