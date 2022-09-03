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
		fnCheck();
		fnRemove();
	})
	
	function fnCheck(){
		$('#f').on('submit', function(ev){
			if($('#boardTitle').val() == '' || $('#boardContents').val() == ''){
				alert('제목과 내용은 필수입니다.');
				ev.preventDefault();
			}
		})
	}
	
	function fnRemove(){
		$('#btnRemove').on('click', function(){
			if(confirm('현재 글을 삭제 하시겠습니까? (삭제후 복원이 불가능합니다)')){
				location.href='${contextPath}/remove.do?boardIdx=' + ${board.boardIdx};	
			}
		})
	}

</script>
</head>
<body>
	<form id="f" method="post" action="${contextPath}/change.do" enctype="multipart/form-data">
		<div class="limiter animsition">
			<div class="container-login100">
				<div class="wrap-login100">
					<div class="login100-form">
							<div class="row">
								<div class="col-sm-12">
									<table class="table table-bordered">
										<tbody>
											<tr>
												<th colspan="2">제목</th>
												<td colspan="2"><input type="text" name="boardTitle" id="boardTitle"></td>
											</tr>
											<tr>
												<th colspan="2">작성자</th>
												<td colspan="2">${board.boardWriter}</td>
											</tr>
											<tr>
												<td colspan="4">
													<div class="detail-content"><textarea rows="100" cols="100" id="boardContents" name="boardContents"></textarea></div>
												</td>
											</tr>
											<tr>
												<th>첨부파일</th>
												<td colspan="3"><input type="file" name="up" id="up"></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>

						<div class="row">
							<div class="col-sm-2">
								<input type="button" value="목록으로" class="btn btn-default btn-full" onclick="location.href='${contextPath}/list.do'">
							</div>
							<div class="col-sm-6"></div>
							<div class="col-sm-2">
								<input type="button" value="삭제" class="btn btn-default btn-full" id="btnRemove">
							</div>
							<div class="col-sm-2">
								<button class="btn btn-default btn-full">저장</button>
							</div>
						</div>
					</div>
				</div>
				<div id="dropDownSelect1"></div>
			</div>
		</div>
		<input type="hidden" name="boardIdx" value="${board.boardIdx}">
	</form>
</body>
</html>