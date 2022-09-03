<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>dd</title>
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
<link rel="stylesheet" type="text/css" href="resources/vendor/fontawesome-free-5.8.2-web/css/all.min.css">
<style>
	td > a {color: black;}
</style>

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
		fnBoardCount();
		fnMemberCount();
		fnTodayBoardCount();
		fnTodayMemberCount();
		fnWritePage();
		fnLogOut();
		fnSearch();
		
		
		fnCheckAll();
		fnRemoveAll();
		fnRemoveOne();
		fnManageMember();
	})
	
	
	function fnList(){
		location.href='${contextPath}/list.do'
	}
	
	function fnBoardCount(){
		$.ajax({
			url: '${contextPath}/boardCount.do',
			type: 'get',
			dataType: 'json',
			success: function(obj){
				$('#totalCount').text(obj.result);
			}
			
		})
	}
	
	function fnMemberCount(){
		$.ajax({
			url: '${contextPath}/memberCount.do',
			type: 'get',
			dataType: 'json',
			success: function(obj){
				$('#memberCount').text(obj.result);
			}
			
		})
	}
	
	function fnTodayBoardCount(){
		$.ajax({
			url: '${contextPath}/todayBoardCount.do',
			type: 'get',
			dataType: 'json',
			success: function(obj){
				$('#todayBoardCount').text(obj.result);
			}
			
		})
	}
	
	function fnTodayMemberCount(){
		$.ajax({
			url: '${contextPath}/todayMemberCount.do',
			type: 'get',
			dataType: 'json',
			success: function(obj){
				$('#todayMemberCount').text(obj.result);
			}
			
		})
	}
	
	function fnWritePage(){
		$('#writePage').on('click', function(){
			location.href='${contextPath}/writePage.do';
		})
	}
	
	function fnLogOut(){
		$('#btnLogOut').on('click', function(){
			location.href='${contextPath}/logOut.do';
		})
	}
	
	function fnSearch(){
		let page = 1;
		$('#btnSearch').on('click', function(){
			if($('#query').val().length < 2){
				alert('검색어는 2글자 이상 작성하셔야 합니다.');
				return;
			} else {
				location.href='${contextPath}/search.do?column=' + $('#column').val() + '&query=' + $('#query').val() + '&page=' + page;
			}
		})
		
		
	}
	
	// 관리자
	
	function fnCheckAll(){
		$('#checkAll').change(function(){
			if($(this).prop('checked')){
				$('.checkOne').prop('checked', true);
			}
			else{
				$('.checkOne').prop('checked', false);
			}
		})
	}
	
	function fnCheckOne(){
		$('.checkOne').change(function(){
			if($(this).prop('checked', false)){
				$('#checkAll').prop('checked', false);
			}
		})
	}
	
	function fnRemoveAll(){
		$('#btnRemoveAll').on('click', function(){
			for(let i = 0; i < $('.checkOne').length; i++){
				if($($('.checkOne')[i]).is(':checked')){
					$.ajax({
						url: '${contextPath}/boards/' + $('.checkOne')[i].value,
						type: 'put',
						dataType: 'json',
						success: function(obj){
							
						}
					})
				}
				
			}
			alert('삭제되었습니다.');
			fnList();
		})
	}
	
	function fnRemoveOne(){
		$('.btnRemoveOne').on('click', function(){
			location.href='${contextPath}/removeOne.do?boardIdx=' + this.id;
			alert('삭제되었습니다.');
		})
	}
	
	function fnManageMember(){
		$('#btnManageMember').on('click', function(){
			location.href='${contextPath}/manageMember.do';
		})
	}
	
</script>
	
</head>
<body>

	<div class="limiter animsition">
		<div class="container-login100">
			<div class="wrap-login100">
				<div class="login100-form">
					<div class="row panel-row">
						<div>
							<h3 style="float: left">
								[안녕하세요. <b>${loginMember.boardWriterName}</b>님]
							</h3>
							<div align="right">
								<input type="button" class="btn btn-default" value= "로그아웃" id="btnLogOut">
							</div>
						</div> 
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">총 게시글 수</h5>
								<h1 class="overview-content" id="totalCount"></h1>
								<i class="far fa-file-alt"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">총 가입자 수</h5>
								<h1 class="overview-content" id="memberCount"></h1>
								<i class="fas fa-users"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">오늘 게시글 수</h5>
								<h1 class="overview-content" id="todayBoardCount"></h1>
								<i class="fas fa-file-alt"></i>
								
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">오늘 가입자 수</h5>
								<h1 class="overview-content" id="todayMemberCount"></h1>
								<i class="fas fa-user-circle"></i>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4">
							<c:if test="${loginMember.boardWriter != 'dlgudtlr'}">
								<button type="button" class="btn btn-default" id="writePage">
									<i class="fas fa-plus"></i> 새글 추가
								</button>
								<button type="button" class="btn btn-default" onclick="' ">채팅하기</button>
								<button type="button" class="btn btn-default" onclick="location.href='${contextPath}/memberModifyPage.do'">정보수정</button>
							</c:if>
							
							<c:if test="${loginMember.boardWriter == 'dlgudtlr'}">
								<input type="button" class="btn btn-default" value="선택삭제" id="btnRemoveAll">
								<input type="button" class="btn btn-default" value="회원관리" id="btnManageMember">
							</c:if>
							
						</div>
						<div class="col-sm-2"></div>
							<div class="col-sm-2">
								<select name="column" class="form-control" id="column">
									<option value="all">전체</option>
									<option value="BOARD_WRITER">작성자</option>
									<option value="BOARD_CONTENTS">글내용</option>
								</select>
							</div>
							<div class="col-sm-3">
								<input type="text" name="query" class="form-control" id="query" placeholder="문자열을 입력해주세요.">
							</div>
							<div class="col-sm-1 text-right">
								<input type="button" id="btnSearch" class="btn btn-default btn-full" value="검색">
							</div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<table class="table table-hover">
								<thead>
									<tr>
										<c:if test="${loginMember.boardWriter == 'dlgudtlr'}">
											<th style="width: 7%;"><input type="checkbox" id="checkAll" class="checkAll"></th>
										</c:if>
										<th style="width: 7%;">순번</th>
										<th style="width: 9%;">작성자</th>
										<th style="width: 5%;">공개</th>
										<th>제목</th>
										<th style="width: 10%;">작성일자</th>
										<th style="width: 8%;">조회수</th>
										<c:if test="${loginMember.boardWriter == 'dlgudtlr'}">
											<th style="width: 7%;">삭제</th>
										</c:if>
									</tr>
								</thead>
								<tbody>
								
									<c:forEach items="${boards}" var="list">
										<tr>
											<c:if test="${loginMember.boardWriter == 'dlgudtlr'}">
												<th style="width: 7%;"><input type="checkbox" class="checkOne" value="${list.boardIdx}"></th>
											</c:if>
											<td>${list.rn}</td>
											<td>${list.boardWriter}</td>
											<td><i class="fas fa-lock"></i>${list.boardPublicFl}</td>
											<!-- 관리자인 경우 -->
											<c:if test="${loginMember.boardWriter == 'dlgudtlr'}">
												<td><a href="${contextPath}/detail.do?boardIdx=${list.boardIdx}&rn=${list.rn}">${list.boardTitle}</a></td>
											</c:if>
											<!-- 비공개 + 관리자x + 본인글 아닌경우 -->
											<c:if test="${list.boardPublicFl == 'N' && loginMember.boardWriter != 'dlgudtlr' && loginMember.boardWriter != list.boardWriter}">
												<td>${list.boardTitle}</td>
											</c:if>
											<!-- 공개 + 관리자x + 본인글 아닌경우 -->
											<c:if test="${list.boardPublicFl == 'Y' && loginMember.boardWriter != 'dlgudtlr' && loginMember.boardWriter != list.boardWriter}">
												<td><a href="${contextPath}/detail.do?boardIdx=${list.boardIdx}&rn=${list.rn}">${list.boardTitle}</a></td>
											</c:if>
											<!-- 비공개 + 관리자x + 본인글인경우 -->
											<c:if test="${list.boardPublicFl == 'N' && loginMember.boardWriter != 'dlgudtlr' && loginMember.boardWriter == list.boardWriter}">
												<td><a href="${contextPath}/detail.do?boardIdx=${list.boardIdx}&rn=${list.rn}">${list.boardTitle}</a></td>
											</c:if>
											<!-- 공개 + 관리자x + 본인글인경우 -->
											<c:if test="${list.boardPublicFl == 'Y' && loginMember.boardWriter != 'dlgudtlr' && loginMember.boardWriter == list.boardWriter}">
												<td><a href="${contextPath}/detail.do?boardIdx=${list.boardIdx}&rn=${list.rn}">${list.boardTitle}</a></td>
											</c:if>
											
											<td>${list.boardWriteDate}</td>
											<td>${list.boardViewCount}</td>
											<c:if test="${loginMember.boardWriter == 'dlgudtlr'}">
												<c:if test="${list.boardDelYn == 'Y'}">
													<td>삭제완료</td>
												</c:if>
												<c:if test="${list.boardDelYn == 'N'}">
													<th style="width: 7%;"><input type="button" value="삭제" class="btnRemoveOne" id="${list.boardIdx}"></th>
												</c:if>
												
											</c:if>
										</tr>
									</c:forEach>
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
	<div id="dropDownSelect1"></div>
</body>
</html>
