<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="find_pw" method="post">
<div class="w3-content w3-container w3-margin-top">
	<div class="w3-container w3-card-4">
		<div class="w3-center w3-large w3-margin-top">
			<h3>비밀번호 찾기</h3>
		</div>
		<div>
			<p>
				<label>ID</label>
				<input class="w3-input" type="text" id="id" name="id" required>
			</p>
			<p>
				<label>Email</label>
				<input class="w3-input" type="text" id="email" name="email" required>
			</p>
			<p class="w3-center">
				<button type="submit" id=findBtn >find</button>
				<button type="button" onclick="history.go(-1);" >Cancel</button>
			</p>
		</div>
	</div>
</div>
</form>

<a href="joinForm">join</a> &nbsp;&nbsp;&nbsp;
<a href="main">main</a> &nbsp;&nbsp;&nbsp;
</body>
</html>