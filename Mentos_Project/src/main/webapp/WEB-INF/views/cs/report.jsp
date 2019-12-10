<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@include file ="../header.jsp" %>
 <!-- Page Content -->
  <div class="container">
    <div class="row">
      <div  style='text-align: center;'>
        <div style='display: inline-block;'>
          <a href="/cs/QnA">QnA</a>
          <a href="/cs/report">신고하기</a>
          <a href="/cs/notice">공지사항</a>
          <a href="/cs/history">나의 문의내역</a>
        </div>
      </div>
	</div>
</div>
<div style='text-align: center;'>
<div style='display: inline-block;'>
<form action="QnA" method="post">	
<%@include file ="write_view.jsp" %>
report
<input type="submit" value="입력"> &nbsp;&nbsp;
					<a href="list">목록보기</a>
</form>
</div>
</div>
<%@include file ="../footer.jsp" %>
</body>
</html>