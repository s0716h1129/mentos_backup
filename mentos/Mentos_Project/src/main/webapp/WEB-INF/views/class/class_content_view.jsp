<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table width="500" cellpadding="0" cellsapcing="0" border="1">
		<tr>
			<td>번호</td>
			<td>${ content_view.class_number }</td>
		</tr>
		
		<tr>
			<td>이름</td>
			<td>${ content_view.class_mento }</td>
		</tr>
		<tr>
			<td>제목</td>
			<td>${ content_view.class_name }</td>
		</tr>
		<tr>
			<td>내용</td>
			<td>${ content_view.class_content }</td>
		</tr>

		<tr>
			<td colspan="2">
				<a href="class/class_modify_view?class_number=${content_view.class_number}">수정</a> &nbsp;&nbsp;
				<a href="class/joinClass?class_number=${content_view.class_number}">참여</a> &nbsp;&nbsp; 
				<a href="class/class_list?page=<%= session.getAttribute("cpage") %>">목록보기</a> &nbsp;&nbsp; 
				<a href="class/class_delete?class_number=${content_view.class_number}">삭제</a> &nbsp;&nbsp; 
				<a href="class/class_reply_view?class_number=${content_view.class_number}">답변</a>  
				
			</td>
		</tr>
	</table>
</body>
</html>