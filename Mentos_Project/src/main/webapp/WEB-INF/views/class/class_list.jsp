<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@include file ="../header.jsp" %>
<div class="container" style='text-align: center;'>
<form action="/class/list" method="post" style='display: inline-block;'>
		    <aside>
		      <select name='type'> <!-- 검색 컬럼 -->
				    <option value="">분류</option>
				    <option value="place">지역</option>
				    <option value="major">분야</option>
				    <option value="mento">작성자</option>
		      </select>
		      <select name='type'> <!-- 검색 컬럼 -->
				    <option value="">지역</option>
				    <option value="place">지역</option>
				    <option value="major">분야</option>
				    <option value="mento">작성자</option>
		      </select>
		      <select name='type'> <!-- 검색 컬럼 -->
				    <option value="">검색</option>
				    <option value="place">지역</option>
				    <option value="major">분야</option>
				    <option value="mento">작성자</option>
		      </select>
		      <input type='text' name='search' size="50" value='' placeholder="특수문자는 사용할수 없습니다.">
		      <input type='submit' value="검색">    
		     </aside> 
</form>
	<hr>	
<div>
<c:forEach items="${list}" var="dto">
<div class="row" style="width: 200px; height: 300px; display:inline-block; margin-right:10px;">
	<div>
		<div class="card h-100">
			<a href="class_content_view?class_number=${ dto.class_number }"><img class="card-img-top" src="${dto.class_image}" alt=""></a>
			<div class="card-body">
				<h4 class="card-title">
					<a href="/class/content_view?class_number=${ dto.class_number }">${ dto.class_name }</a>
				</h4>
				<h5>${ dto.class_mento }</h5>
				<p class="card-text">${ dto.class_content }</p>
				 <div class="date">${ dto.class_date } ~ ${ dto.class_date }</div>
			</div>
			<div class="card-footer">
				<small class="text-muted">&#9733; &#9733; &#9733; &#9733; &#9734;</small>
			</div>
		</div>
	</div>
</div>
</c:forEach>
</div>
<div style='display: inline-block;'>
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
</div>
</div>
<%-- 	<table width="500" cellpadding="0" cellsapcing="0" border="1">
		<tr>
			<td>번호</td>
			<td>멘토</td>
			<td>제목</td>
			<td>내용</td>
			
		</tr>
		<c:forEach items="${list}" var="dto">
		<tr>
			<td>${ dto.class_number }</td>
			<td>${ dto.class_mento }</td>
			<td><a href="class_content_view?class_number=${ dto.class_number }">${ dto.class_name }</a></td>
			<td>${ dto.class_date }</td>
			
		</tr>
		</c:forEach>
		<tr>
			<td colspan="5"> <a href="class_write_view">글작성</a> </td>
		</tr>
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

	totalCount = ${page.totalcount}<br>
	listCount = ${page.listcount}<br>
	totalPage = ${page.totalpage}<br>
	curPage = ${page.curpage}<br>
	pageCount = ${page.pagecount}<br>
	startPage = ${page.startpage}<br>
	endPage = ${page.endpage}<br>
	 --%>
<%@include file ="../footer.jsp" %>
</body>
</html>