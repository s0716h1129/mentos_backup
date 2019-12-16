<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Place_list</title>
<!-- include libraries(jQuery, bootstrap) -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 
<!-- include summernote css/js-->
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.js"></script>
<!-- include summernote-ko-KR -->
<script src="/resources/js/summernote-ko-KR.js"></script>
</head>
<!-- Bootstrap core CSS -->
  <link href="../resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom styles for this template -->
  <link href="../resources/css/scrolling-nav.css" rel="stylesheet">
<style>
	.sss {
   		  display:inline-block;
		}
	.si {
		color:#ff0066;
		float:right;
		}
	.address {
		border:1px solid #808080;
		border-color:#808080;
		padding:15px;
		}
	.num {
		border:1px solid #808080;
		border-color:white #808080 #808080  #808080; 
		padding:15px;
		}
</style>
<body>

<div class="container">
<table class=" container table ">
		<c:forEach items="${list}" var="dto">
			<tr class="sss">
				<td>
					<div style="float:left;" class="col-md-12">
					<a href="view?place_number=${dto.place_number}">
						<img src=/upload/${dto.place_image}  width="500" height="300">
					</a>	
					<div class="address">
						<h2>${dto.place_name}</h2>
						<h3>${dto.place}</h3> <br>
						</div>
						<div class="num">
						<h3>수용인원 : ${dto.place_people_num}명</h3>
						<h3 class="si">${dto.place_price} /시간</h3>
						<br>
						</div>
					</div>
				</td>
			</tr>
		</c:forEach>
		<tr>
		<td colspan="5" style="text-align:right;">
		<button type="button" class="btn btn-" 
			onclick="javascript:window.location='rent'">등록</button>
			
		<div class="container" style='text-align: center;'>
		<form action="/place/place_list" method="post" style='display: inline-block;'>
		    <aside>
		      <select name='type'> <!-- 검색 컬럼 -->
				    <option value="">검색</option>
				    <option value="place">지역</option>
				    <option value="people">인원수</option>
				    <option value="id">작성자</option>
		      </select>
		      <input type='text' name='search' size="50" value='' placeholder="특수문자는 사용할수 없습니다.">
		      <input type='submit' value="검색">    
		     </aside> 
		</form>
		</div>
		<br>
			
		<nav aria-label="Page navigation example" d-flex justify-content-center>
		<div class="d-flex justify-content-center">
		<ul class="pagination" style="text-align:center;">
			
			<!-- 맨처음 -->
			<li class="page-item"><a class="page-link"
				href="place_list?page=1"> 
				<span aria-hidden="true">&lt;&lt;</span>
			</a>
			</li>
			
			<!-- 이전 -->
								
			<c:choose>
			<c:when test="${(page.curpage -1) < 1}">
			<li class="page-item"><a class="page-link" href="#">
			&lt;
			</a>
			</c:when>
			<c:otherwise>
				<li class="page-item"><a class="page-link" href="place_list?page=${page.curpage - 1}">
				<span aria-hidden="true">&lt;</span>
				</a>
			</c:otherwise>
			</c:choose>	
			
			<!-- 개별 페이지 -->
			<li class="page-item"> 
			<c:forEach var="fEach" begin="${page.startpage}" end="${page.endpage}" step="1">
				<c:choose>
					<c:when test="${page.curpage == fEach}">
					<li class="page-item"><a class="page-link" href="place_list?page=${fEach}" >
						${fEach} &nbsp;
					</a>
					</c:when>
					<c:otherwise>
						<li class="page-item"><a class="page-link" href="place_list?page=${fEach}" > ${fEach} </a>&nbsp;
						</li>
						</c:otherwise>
					</c:choose>
			</c:forEach>
			
			<!-- 다음 -->
			<c:choose>
				<c:when test="${(page.curpage -1) > page.totalpage}">
				<li class="page-item"><a class="page-link" href="#">
				&gt;
				</a>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link" href="place_list?page=${page.curpage + 1}"><span
					aria-hidden="true"> &gt; </span>
					</a>&nbsp;
				</c:otherwise>
			</c:choose>
			
			<!-- 마지막 -->
			<c:choose>
			<c:when test="${page.curpage == page.totalpage}">
			<li class="page-item">
			<a class="page-link"
				href="place_list?page=${page.totalpage}"> 
				<span aria-hidden="false">&gt;&gt;</span>
			</a>
			</c:when>
			<c:otherwise>
			<li class="page-item">
				<a class="page-link"
					href="place_list?page=${page.totalpage}"> 
					<span aria-hidden="true">&gt;&gt;</span>
				</a>
			</li>
			</c:otherwise>
			</c:choose>
			
			</ul>
			</div>
			</nav>
			</td>
		</tr>
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