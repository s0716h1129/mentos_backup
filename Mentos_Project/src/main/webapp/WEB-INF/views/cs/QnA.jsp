<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
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
           <%if(id != null) {%>
          <a href="/cs/history">나의 문의내역</a>
          <%} %>
        </div>
      </div>
	</div>
</div>
<div style='text-align: center;'>
<div style='display: inline-block;'>
<form action="QnA_write" method="post">	
<div width="500" cellpadding="0" cellsapcing="0" border="1">
			<div>
				<div> 이름 </div>
				<div> <input name="writer" value="<%= id %>"></div>
			</div>
			<div>
				<div> 내용 </div>
				<div><textarea id="summernote" name="content" placeholder="content"></textarea> 
				
				</div>
			</div>	
	</div>
<input type="submit" value="문의하기"> &nbsp;&nbsp;
</form>
</div>
</div>
<%@include file ="../footer.jsp" %>
</body>
</html>