<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<script src="http://code.jquery.com/jquery.js"></script>
<title>Insert title here</title>
</head>
<body>
<!-- 처음 -->
				<c:choose>
					<c:when test="${(page.curpage - 1) < 1}">
						[ &lt;&lt; ]
					</c:when>
					<c:otherwise>
						<a href="memberPay&page=1">[ &lt;&lt; ]</a>
					</c:otherwise>
				</c:choose>
				<!-- 이전 -->
				<c:choose>
					<c:when test="${(page.curpage -1) < 1}">
						[ &lt; ]
					</c:when>
					<c:otherwise>
						<a href="memberPay&page=${page.curpage - 1}">[ &lt; ]</a>
					</c:otherwise>
					</c:choose>
						
				<!-- 개별 페이지 -->
				<c:forEach var="fEach" begin="${page.startpage}" end="${page.endpage}" step="1">
					<c:choose>
						<c:when test="${page.curpage == fEach}">
							[${fEach}] &nbsp;
						</c:when>
								
						<c:otherwise>
							<a href="memberPay&page=${fEach}">[${fEach}]</a>&nbsp;
						</c:otherwise>
					</c:choose>
				</c:forEach>
						 
				<!-- 다음 -->
				<c:choose>
					<c:when test="${page.curpage > (page.totalpage-1)}">
						[ &gt; ]
					</c:when>
					<c:otherwise>
						<a href="memberPay&page=${page.curpage + 1}">[ &gt; ]</a>
					</c:otherwise>
				</c:choose>
				<!-- 끝 -->
				<c:choose>
					<c:when test="${page.curpage == page.totalpage}">
						[ &gt;&gt; ]
					</c:when>
					<c:otherwise>
						<a href="memberPay&page=${page.totalpage}">[ &gt;&gt; ]</a>
					</c:otherwise>
				</c:choose>
				<br>
				totalCount = ${page.totalcount}<br>
				listCount = ${page.listcount}<br>
				totalPage = ${page.totalpage}<br>
				curPage = ${page.curpage}<br>
				pageCount = ${page.pagecount}<br>
				startPage = ${page.startpage}<br>
				endPage = ${page.endpage}<br>
</body>
</html>