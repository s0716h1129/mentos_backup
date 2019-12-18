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
	<form action="evaluation_modifyOk" method="post">
		<input type="hidden" name="evaluation_number" value="${dto.evaluation_number }">
	<tr>
		<td>작성자</td>
		<td> <input type="text" name="evaluation_name" readonly value="${dto.evaluation_name }"> </td>
	</tr>
	<tr>
		<td>제목</td>
		<td> <input type="text" name="evaluation_title" value="${dto.evaluation_title }"> </td>
	</tr>
	<tr>
		<td>내용</td>
		<td> <textarea rows="10" cols="" name="evaluation_content" >${dto.evaluation_content }</textarea> </td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="수정"> 
			<a href="evaluation_view?evaluation_number=${dto.evaluation_number}"> 취소</a>	
			<a href="evaluation_list"> 목록보기</a>
		</td>
	</tr>
	</form>
	</table>
</body>
</html>