<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Place_list</title>
</head>
<style>
	.ti {
		float:right;
		}
	
	.sss {
   		  display:inline-block;
		}
	.si {
		color:red;
		float:right;
		font-weight:bold;
		font-size: 1.1rem;
		}
	.address {
		border:1px solid #808080;
		padding:15px;
		}
	.num {
		border:1px solid #808080;
		padding:15px;
		}
</style>
<body>
<div>
<table>
		<c:forEach items="${list}" var="dto">
			<tr class="sss">
				<td>
					<div style="border:1px solid #808080;">
					<a href="view?id=${dto.place_number}">
						<img src=/upload/${dto.place_image}  width="380" height="340">
					</a>	
						<div class="address">
						<div style="font-weight:bold;">${dto.place_name}</div>
						${dto.place} <br>
						</div>
						<div class="num">
						수용인원 : ${dto.place_people_num}명 
						<div class="ti">&nbsp;/시간</div> 
						<div class="si">${dto.place_price}</div>
						</div>
					</div>
				</td>
			</tr>
		</c:forEach>
		<tr>
			<td colspan="5"> <a href="rent">등록</a> </td>
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
</div>

<!-- 
totalCount = ${page.totalcount}<br>
listCount = ${page.listcount}<br>
totalPage = ${page.totalpage}<br>
curPage = ${page.curpage}<br>
pageCount = ${page.pagecount}<br>
startPage = ${page.startpage}<br>
endPage = ${page.endpage}<br>
 -->
</body>
</html>