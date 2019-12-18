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
           <%if(id != null) {%>
          <a href="/cs/history">나의 문의내역</a>
          <%} %>
        </div>
      </div>
	</div>
</div>
<div style='text-align: center;'>
<div style='display: inline-block;'>
<table width="500" cellpadding="0" cellsapcing="0" border="1">
		<tr>
			<td>번호</td>
			<td>제목</td>
			<td>내용</td>
		</tr>
		<c:forEach items="${list}" var="dto">
		<tr>
			<td>${ dto.notice_num }</td>
			<td><a href="class_content_view?class_number=${ dto.notice_num }">${ dto.notice_title }</a></td>
			<td>${ dto.notice_writer }</td>			
		</tr>
		</c:forEach>
		 <%if(id != null) {%>
		<tr>
			<td colspan="5"> <a href="class_write_view">글작성</a> </td>
		</tr>
		 <%} %>
		<tr>
			<td colspan="5">
			<!-- 처음 -->
			<c:choose>
			<c:when test="${(page.curpage - 1) < 1}">
				[ &lt;&lt; ]
			</c:when>
			<c:otherwise>
				<a href="list?page=1">[ &lt;&lt; ]</a>
			</c:otherwise>
			</c:choose>
			<!-- 이전 -->
			<c:choose>
			<c:when test="${(page.curpage -1) < 1}">
				[ &lt; ]
			</c:when>
			<c:otherwise>
				<a href="list?page=${page.curpage - 1}">[ &lt; ]</a>
			</c:otherwise>
			</c:choose>
			
			<!-- 개별 페이지 -->
			<c:forEach var="fEach" begin="${page.startpage}" end="${page.endpage}" step="1">
				<c:choose>
					<c:when test="${page.curpage == fEach}">
						[${fEach}] &nbsp;
					</c:when>
					
					<c:otherwise>
						<a href="list?page=${fEach}">[${fEach}]</a>&nbsp;
					</c:otherwise>
				</c:choose>
			</c:forEach>
			 
			<!-- 다음 -->
			<c:choose>
			<c:when test="${(page.curpage -1) > page.totalpage}">
				[ &gt; ]
			</c:when>
			<c:otherwise>
				<a href="list?page=${page.curpage + 1}">[ &gt; ]</a>
			</c:otherwise>
			</c:choose>
			<!-- 끝 -->
			<c:choose>
			<c:when test="${page.curpage == page.totalpage}">
				[ &gt;&gt; ]
			</c:when>
			<c:otherwise>
				<a href="list?page=${page.totalpage}">[ &gt;&gt; ]</a>
			</c:otherwise>
			</c:choose>
	</table>
</div>
</div>
<%@include file ="../footer.jsp" %>
</body>
</html>