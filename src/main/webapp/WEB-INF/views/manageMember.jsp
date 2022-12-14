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
		fnBoardPage();
	})
	
	
	function fnList(){
		location.href='${contextPath}/manageMember.do'
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
				alert('???????????? 2?????? ?????? ??????????????? ?????????.');
				return;
			} else {
				location.href='${contextPath}/manageSearch.do?column=' + $('#column').val() + '&query=' + $('#query').val() + '&page=' + page;
			}
		})
		
		
	}
	
	// ?????????
	
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
			if(confirm('????????? ????????? ?????? ?????????????????????????')){
				for(let i = 0; i < $('.checkOne').length; i++){
					if($($('.checkOne')[i]).is(':checked')){
						$.ajax({
							url: '${contextPath}/members/' + $('.checkOne')[i].value,
							type: 'put',
							dataType: 'json',
							success: function(obj){
								
							}
						})
					}
					
				}
				alert('?????????????????????.');
			}
			
			fnList();
		})
	}
	
	function fnRemoveOne(){
		$('.btnRemoveOne').on('click', function(){
			location.href='${contextPath}/removeMemberOne.do?boardWriterIdx=' + this.id;
			alert('?????????????????????.');
			fnList();
		})
	}
	
	function fnBoardPage(){
		$('#btnBoardPage').on('click', function(){
			location.href='${contextPath}/list.do';
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
								[???????????????. <b>${loginMember.boardWriterName}</b>???]
							</h3>
							<div align="right">
								<input type="button" class="btn btn-default" value= "????????????" id="btnLogOut">
							</div>
						</div> 
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">??? ????????? ???</h5>
								<h1 class="overview-content" id="totalCount"></h1>
								<i class="far fa-file-alt"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">??? ????????? ???</h5>
								<h1 class="overview-content" id="memberCount"></h1>
								<i class="fas fa-users"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">?????? ????????? ???</h5>
								<h1 class="overview-content" id="todayBoardCount"></h1>
								<i class="fas fa-file-alt"></i>
								
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">?????? ????????? ???</h5>
								<h1 class="overview-content" id="todayMemberCount"></h1>
								<i class="fas fa-user-circle"></i>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4">
							
							
							
								<input type="button" class="btn btn-default" value="????????????" id="btnRemoveAll">
								<input type="button" class="btn btn-default" value="???????????????" id="btnBoardPage">

							
						</div>
						<div class="col-sm-2"></div>
							<div class="col-sm-2">
								<select name="column" class="form-control" id="column">
									<option value="all">??????</option>
									<option value="BOARD_WRITER">?????????</option>
									<option value="BOARD_WRITER_NAME">??????</option>
									<option value="BOARD_WRITER_PHONE">????????????</option>
									<option value="BOARD_WRITER_EMAIL">?????????</option>
								</select>
							</div>
							<div class="col-sm-3">
								<input type="text" name="query" class="form-control" id="query" placeholder="???????????? ??????????????????.">
							</div>
							<div class="col-sm-1 text-right">
								<input type="button" id="btnSearch" class="btn btn-default btn-full" value="??????">
							</div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<table class="table table-hover">
								<thead>
									<tr>
										
										<th style="width: 7%;"><input type="checkbox" id="checkAll" class="checkAll"></th>

										<th style="width: 7%;">?????????</th>
										<th style="width: 9%;">??????</th>
										<th style="width: 5%;">????????????</th>
										<th style="width: 10%;">?????????</th>
										<th style="width: 8%;">??????</th>


									</tr>
								</thead>
								<tbody>
								
									<c:forEach items="${members}" var="member">
										<tr>

											<th style="width: 7%;"><input type="checkbox" class="checkOne" value="${member.boardWriterIdx}"></th>

											<td>${member.boardWriter}</td>
											<td>${member.boardWriterName}</td>
											<td>${member.boardWriterPhone}</td>
											<td>${member.boardWriterEmail}</td>
											<c:if test="${member.delYn == 'Y'}">
												<td>????????????</td>
											</c:if>
											<c:if test="${member.delYn == 'N'}">
												<th style="width: 7%;"><input type="button" value="??????" class="btnRemoveOne" id="${member.boardWriterIdx}"></th>
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
