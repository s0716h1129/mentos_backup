<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Place_list</title>
</head>
<!-- Bootstrap core CSS -->
  <link href="../resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom styles for this template -->
  <link href="../resources/css/scrolling-nav.css" rel="stylesheet">
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
		border:1px dashed #808080;
		padding:15px;
		}
	.num {
		border:1px dashed #808080;
		padding:15px;
		}
</style>
<body>

<!-- Navigation -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" id="mainNav">
    <div class="container">
      <a class="navbar-brand js-scroll-trigger" href="#page-top">Mentos Main</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
    </div>
</nav>
<table class=" container table table-bordered table-hover ">
		<c:forEach items="${list}" var="dto">
			<tr class="sss">
				<td>
					<div style="border:1px solid #808080;">
					<a href="view?place_number=${dto.place_number}">
						<img src=/upload/${dto.place_image}  width="500" height="300">
					</a>	
						<div class="address">
						<div><h3>${dto.place_name}</h3></div>
						<h5>${dto.place}</h5> <br>
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
<br> 
<footer class="py-5 bg-dark">
<div class="container">
 <ol class="breadcrumb">
	 <li><a class="btn btn-primary" href="/main/">회사소개</a></li>
	 <li><a class="btn btn-primary" href="/main/">이용하기</a></li>
	 <li><a class="btn btn-primary" href="/main/">문의하기</a></li>
	 <li><a class="btn btn-primary" href="/main/">고객센터</a></li>
</ol>
</div>
</footer>

 <!-- Bootstrap core JavaScript -->
  <script src="../resources/vendor/jquery/jquery.min.js"></script>
  <script src="../resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Plugin JavaScript -->
  <script src="../resources/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom JavaScript for this theme -->
  <script src="../resources/js/scrolling-nav.js"></script>
		
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