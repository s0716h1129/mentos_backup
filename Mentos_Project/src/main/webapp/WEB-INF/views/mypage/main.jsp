<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<script src="http://code.jquery.com/jquery.js"></script>
<title>MyPage</title>

</head>
<body>
	
	<div class="card mb-3" style="text-align:center">
    	<div class="card-header">
    		<i class="fas fa-table"></i>
			<h1>마이 페이지</h1>
		</div>
    	<div class="card-body">
            <div class="table-responsive">
	            <a href=""> 참여 강좌 </a> &nbsp;
				<a href=""> 등록 강좌 </a> &nbsp;
				<a href=""> 결제 내역 </a> &nbsp;
				<a href=""> 출결 확인 </a> &nbsp;
				<hr>
				${Intro}
				<hr>
					
				<button type="button" class="btn btn-dark" onclick="location.href='memberLeaveForm'">회원 탈퇴</button> &nbsp;
				<input type="button" class="btn btn-dark" onclick="location.href='modifyForm'" value="회원 정보 수정"> &nbsp;
				<button type="button" class="btn btn-dark" onclick="location.href='modifyPwForm'">비밀번호 변경</button> &nbsp;
            </div>
        </div>
    </div>

</body>
</html>