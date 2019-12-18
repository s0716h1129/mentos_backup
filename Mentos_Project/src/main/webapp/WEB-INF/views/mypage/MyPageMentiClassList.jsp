<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MyPage Class List</title>
</head>
<body>
	<h1>마이 페이지</h1> <br><br>
	<a href=""> 참여 강좌 </a> &nbsp;
	<a href=""> 등록 강좌 </a> &nbsp;
	<a href=""> 결제 내역 </a> &nbsp;
	<a href=""> 출결 확인 </a> &nbsp;
	
	<h3> 참여 신청 강좌</h3>
	<table>
	
	</table>
	
	
	<h3> 참여 중인 강좌</h3>
	<table>
	
	</table>
	
	<button type="button" onclick="">회원 탈퇴</button> &nbsp;
	<input type="button" onclick="location.href='modifyForm?id=${memberId}'" value="회원 정보 수정"> &nbsp;
	
</body>
</html>