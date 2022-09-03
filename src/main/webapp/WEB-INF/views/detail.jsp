<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>dd</title>
</head>
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
<script>

	$(document).ready(function(){
		fnChange();
		fnRemove();
		fnPrevBoard();
		fnNextBoard();
	})
	
	
	function fnChange(){
		$('#btnChange').on('click', function(){
			location.href='${contextPath}/changePage.do?boardIdx=' + '${board.boardIdx}' + '&boardWriter=' + '${board.boardWriter}'
		})
	}
	
	function fnRemove(){
		$('#btnRemove').on('click', function(){
			if(confirm('현재 글을 삭제 하시겠습니까? (삭제후 복원이 불가능합니다)')){
				location.href='${contextPath}/remove.do?boardIdx=' + ${board.boardIdx};	
			}
		})
	}
	
	function fnPrevBoard(){
		$('#btnPrevBoard').on('click', function(){
			location.href='${contextPath}/prevBoard.do?rn=' + ${board.rn};
		})
	}
	
	function fnNextBoard(){
		$('#btnNextBoard').on('click', function(){
			location.href='${contextPath}/nextBoard.do?rn=' + ${board.rn};
		})
	}

</script>
<script src="resources/js/main.js"></script>
<body>
	<div class="limiter animsition">
		<div class="container-login100">
			<div class="wrap-login100">
				<div class="login100-form">
					<h4>
						<i class="fa fa-paper-plane" style="color: #b224ef;"></i> 글 상세보기
					</h4>
					<div class="row">
						<div class="col-sm-2 col-header">
							<div class="well well-sm">
								<i class="fas fa-chevron-up"></i> 이전글
							</div>
						</div>
						<div class="col-sm-8 col-mid">
							<div class="well well-sm ">
								<input type="button" class="btn btn-link" value="${prevBoard.boardTitle}" id="btnPrevBoard">
							</div>
						</div>
						<div class="col-sm-2 col-footer">
							<div class="well well-sm">${prevBoard.boardWriteDate}</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<table class="table table-bordered">
								<tbody>
									<tr>
										<th>제목</th>
										<td>${board.boardTitle}</td>
										<th>조회수</th>
										<td>${board.boardViewCount}</td>
									</tr>
									<tr>
										<th>작성자</th>
										<td>${board.boardWriter}</td>
										<th>작성일자</th>
										<td>${board.boardWriteDate}</td>
									</tr>
									<tr>
										<td colspan="4">
											<div class="detail-content">${board.boardContents}</div>
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
								<input type="button" class="btn btn-link" value="${nextBoard.boardTitle}" id="btnNextBoard">
							</div>
						</div>
						<div class="col-sm-2 col-footer">
							<div class="well well-sm">${nextBoard.boardWriteDate}</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-2">
							<input type="button" value="목록으로" class="btn btn-default btn-full" onclick="location.href='${contextPath}/list.do';">
						</div>
						<div class="col-sm-6"></div>
						<div class="col-sm-2">
							<input type="button" value="수정" class="btn btn-default btn-full" id="btnChange">
						</div>
						<div class="col-sm-2">
							<input type="button" value="삭제" class="btn btn-default btn-full" id="btnRemove">
						</div>
					</div>
				</div>
			</div>
			<div id="dropDownSelect1"></div>
		</div>
	</div>
</body>
</html>