<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<table width="500" cellpadding="0" cellspacing="0" border="1">
		<forM action="evaluation_write" method="post">
			<tr>
				<td>제목</td>
				<td> <input type="text" name="title" size="50"></td>
			</tr>
			<tr>
				<td>아이디</td>
				<td> <input type="text" name="name" size="50"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td> <textarea  name="content" rows="5" cols="50"></textarea>				 
			<tr>
				<td colspan="2">
				<input type="submit" value="입력"> &nbsp;&nbsp;
				<a href="evaluation_list">목록보기</a>
				</td>
			</tr>
		</forM>
	
	</table>
</body>
</html>