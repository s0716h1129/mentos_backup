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
		<form action="evaluation_replyOk" method="post">
			<input type="hidden" name="evaluation_number" value="${dto.evaluation_number }">
			<input type="hidden" name="evaluation_Group" value="${dto.evaluation_Group }">
			<input type="hidden" name="evaluation_Step" value="${dto.evaluation_Step }">
			<input type="hidden" name="evaluation_Indent" value="${dto.evaluation_Indent }">
		<tr>
			<td> 번호 </td>
			<td>${dto.evaluation_number }</td>
		</tr>
		<tr>
			<td>조회수</td>
			<td>${dto.evaluation_Hit }</td>
		</tr>
		<tr>
			<td>제목</td>
			<td><input type="text" name="evaluation_title" value="${dto.evaluation_title }"></td>
		</tr>
		<tr>
			<td>아이디</td>
			<td><input type="text" name="evaluation_name" value="${dto.evaluation_name }"></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><textarea name="evaluation_content" rows="10" cols="50">${dto.evaluation_content }</textarea></td>
		</tr>
		<tr>
			<td colspan="2"><input type="submit" value="답변">
			<a href="evaluation_list">목록</a>
			</td>
		</tr>
		</form>
	</table>
</body>
</html>