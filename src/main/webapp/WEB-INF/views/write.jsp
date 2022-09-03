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
<link rel="stylesheet" type="text/css" href="resources/vendor/fontawesome-free-5.8.2-web/css/all.min.css">
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
		fnList();
		fnCheck();
	})
	
	function fnList(){
		$('#btnList').on('click', function(){
			location.href='${contextPath}/list.do';
		})
	}
	
	function fnCheck(){
		$('#f').on('submit', function(event){
			if($('#boardTitle').val() == '' || $('#boardContents').val() == ''){
				alert('모든 항목을 빈칸 없이 작성해 주세요.');
				event.preventDefault();
			}
		})
	}

</script>
</head>
<body>
	<form id="f" action="${contextPath}/add.do" method="post" enctype="multipart/form-data">
		<div class="limiter animsition">
			<div class="container-login100">
				<div class="wrap-login100">
					<div class="login100-form">
						<h4>
							<i class="fa fa-paper-plane" style="color: #b224ef;"></i> 새글 작성 / 수정
						</h4>
						<div class="row">
							<div class="col-sm-12">
								<table class="table table-bordered">
									<tbody>
										<tr>
											<th class="padding-lg">제 목</th>
											<td colspan="3">
												<input type="text" name="boardTitle" id="boardTitle" class="form-control write-form" id="title" placeholder="제목을 작성해 주세요.">
											</td>
										</tr>
										<tr>
											<th>작성자</th>
											<td colspan="1">${loginMember.boardWriter}</td>
											<th>공개여부</th>
											<td colspan="1">
											<label for="Y">
												<input type="radio" name="boardPublicFi" value="Y" id="Y">공개
											</label>
											<label for="N">
												<input type="radio" name="boardPublicFi" value="N" id="N">비공개
											</label>
											</td>
										</tr>
										<tr>
											<td colspan="4">
												<div class="detail-content">
													<textarea name="boardContents" id="boardContents" class="form-control write-form" rows="14" id="comment" placeholder="내용을 작성해 주세요."></textarea>
												</div>
											</td>
										</tr>
										<tr>
											<th class="padding-lg">첨부파일</th>
											<td colspan="3">
												<input type="file" name="up" class="form-control write-form file-form" id="file">
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
	
						<div class="row">
							<div class="col-sm-2">
								<input type="button" id="btnList" value="목록" class="btn btn-default btn-full">
							</div>
							<div class="col-sm-8"></div>
							<div class="col-sm-2">
								<button class="btn btn-default btn-full">저장</button>
							</div>
						</div>
					</div>
				</div>
				<div id="dropDownSelect1"></div>
			</div>
		</div>
	</form>
</body>
</html>