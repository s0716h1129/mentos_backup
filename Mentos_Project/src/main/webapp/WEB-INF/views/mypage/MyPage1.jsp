<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MyPage</title>
</head>
<body>
	<h1>마이 페이지</h1> <br><br>
	<a href=""> 참여 강좌 </a> &nbsp;
	<a href=""> 등록 강좌 </a> &nbsp;
	<a href=""> 결제 내역 </a> &nbsp;
	<a href=""> 출결 확인 </a> &nbsp;
	
	<hr>
		${Intro}
	<hr>
	
	<button type="button" onclick="location.href='memberLeaveForm'">회원 탈퇴</button> &nbsp;
	<input type="button" onclick="location.href='modifyForm'" value="회원 정보 수정"> &nbsp;
	<button type="button" onclick="location.href='modifyPwForm'">비밀번호 변경</button> &nbsp;
</body>
</html>