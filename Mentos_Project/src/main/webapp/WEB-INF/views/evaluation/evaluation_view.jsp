<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<table width="500" cellpadding="0" sellspacing="0" border="1">
	<tr>
		<td>번호</td>
		<td>${dto.evaluation_number }</td>	
	</tr>	
	<tr>
		<td>제목</td>
		<td>${dto.evaluation_title }</td>	
	</tr>	
	<tr>
		<td>작성자</td>
		<td>${dto.evaluation_name }</td>	
	</tr>	
	<tr>
		<td>조회수</td>
		<td>${dto.evaluation_Hit }</td>	
	</tr>	
	<tr>
		<td>내용</td>
		<td>${dto.evaluation_content }</td>	
	</tr>	
	<tr>
		<td colspan="2">
		<a href="evaluation_modify?evaluation_number=${dto.evaluation_number }">수정</a>&nbsp;&nbsp;
		<a href="evaluation_list">목록보기</a> &nbsp;&nbsp;
		<a href="evaluation_delete?evaluation_number=${dto.evaluation_number }">삭제</a>&nbsp;&nbsp;
		<a href="evaluation_reply?evaluation_number=${dto.evaluation_number }">답변</a>
		</td>
	</tr>
	</table>

</body>
</html>