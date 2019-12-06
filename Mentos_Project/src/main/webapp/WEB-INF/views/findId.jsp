<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="findId" method="post">
			<h3>아이디 찾기</h3>
			<p>
				<label>Email</label>
				<input type="text" id="email" name="email">
			</p>
			<p>
				<button type="submit" id=findBtn >find</button>
				<button type="button" onclick="history.go(-1);">Cancel</button>
			</p>
	</form>
	<c:if test="${id != null}">
			<h5>
				${ id }
			</h5>
	</c:if>
<a href="joinForm">join</a> &nbsp;&nbsp;&nbsp;
<a href="main">main</a> &nbsp;&nbsp;&nbsp;
</body>
</html>