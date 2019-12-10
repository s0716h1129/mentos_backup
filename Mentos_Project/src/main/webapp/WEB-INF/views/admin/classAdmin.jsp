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
<title>MembeAdmin</title>

<!-- Bootstrap core CSS -->
<link href="../resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="../resources/css/sb-admin.css" rel="stylesheet">

<style>
	#container {
	}
	#left {
		border-style: solid;
		border-width: 1px;
		width:80%;
	}
	#right {
		border-style: solid;
		border-width: 1px;
		text-align: right;
		width:20%;
	}
</style>

<script>
	function classDelete() {
		var con = confirm("강좌를 삭제하시겠습니까?");
		
		if (con == true) {
			window.location.replace("./classDelete?type=class&menu=delete&cId="+$('#cNum').val())
		} else if (con == false) {
			alert("강좌 삭제를 취소합니다.");
		}	
	}

</script>

</head>
<body>
	<div class="card mb-3">
    	<div class="card-header">
    		<i class="fas fa-table"></i>
    		<form action="classSerch" class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
    			<div class="input-group">
	    			<select id="serType" name="serType" class="custom-select mr-sm-2" id="inlineFormCustomSelect">
						<option value="s1" selected=selected> 강좌 번호</option>
						<option value="s2"> 강좌 이름 </option>
						<option value="s3"> 개최 멘토 </option>
					</select>
    				<input type="text" class="form-control" placeholder="" aria-label="Search" aria-describedby="basic-addon2" id="cId" name="cId">
    				<button class="btn btn-dark" type="submit"> 검색 <!-- 나중에 돋보기 모양 아이콘 추가하기 --> </button>	
    				<input type="hidden" id="type" name="type" value="class">
					<input type="hidden" id="menu" name="menu" value="">
    			</div>
    		</form></div>
    	<div class="card-body">
            <div class="table-responsive">
            	<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
            		<thead>
            			<tr>
	            			<th> 강좌 번호 </th>
				    		<th> 강좌 이름 </th>
				    		<th> 개최 멘토 </th>
				    		<th> 진행 장소 </th>
				    		<th> 진행 기간 </th>
				    		<th> 결제 내역 </th>
				    		<th> 리뷰 내역 </th>
				    		<th> 강좌 삭제</th>
			    		</tr>
            		</thead>
            		
            		<c:forEach items="${serList}" var="dto">
	            		<tr>
	            			<td> ${dto.class_number} </td>
						   	<td> ${dto.class_name} </td>
						   	<td> ${dto.class_mento} </td>
					   		<td> ${dto.class_place} </td>
					   		<td> ${dto.class_date} </td>
					   		<td> <a href="./classPay?type=class&menu=pay&serType=${param.serType}&cId=${dto.class_number}" > 결제 확인 </a> </td>
					   		<td> <a href="./classReview?type=class&menu=review&serType=${param.serType}&cId=${dto.class_number}" > 리뷰 확인 </a> </td>
					   		<td> 
					   		<form>
					   			<input type="button" value="X" onclick=classDelete()>
					   			<input type="hidden" value="${dto.class_number}" id="cNum" name="cNum">
					   		</form>				   		
					   		</td>
					   	
	            		</tr>
            		</c:forEach>
            	</table>
            </div>
        </div>
    </div>
    
    <c:if test="${param.menu eq 'pay'}">
    <div class="card mb-3">
    	<div class="card-header">
    		<i class="fas fa-table"></i>
    		결제 내역
    	</div>
    	<div class="card-body">
            <div class="table-responsive">
            	<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
            		<thead>
	            		<tr>
			    			<th> 결제 멘티 </th>
			    			<th> 금액 </th>
			    			<th> 결제일 </th>
			    			<th> 환불 / 결제 상황 </th>
			    		</tr>
            		</thead>
            		
            		<c:forEach items="${cPay}" var="pdto">
			    		<tr>
			    			<td> ${pdto.pay_member} </td>
			    			<td> ${pdto.pay_price} </td>
			    			<td> ${pdto.pay_date} </td>
			    			<td> ${pdto.refund} </td>
			    		</tr>
		    		</c:forEach>
            	</table>
            </div>
        </div>
    </div>
    </c:if>
    
    <c:if test="${param.menu eq 'review'}">
    <div class="card mb-3">
    	<div class="card-header">
    		<i class="fas fa-table"></i>
    		리뷰 내역
    	</div>
    	<div class="card-body">
            <div class="table-responsive">
            	<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
            		<thead>
            			<tr>
			    			<th> 작성자 </th>
			    			<th> 별점 </th>
			    			<th> 내용 </th>
			    		</tr>
			    		
			    		<c:forEach items="${cReview}" var="rdto">
			    		<tr>
			    			<td> ${rdto.review_writer} </td>
			    			<td> ${rdto.review_score} </td>
			    			<td> ${rdto.review_content} </td>
			    		</tr>
			    		</c:forEach>
            		</thead>
            	</table>
            </div>
        </div>
    </div>
    </c:if>

		<button type="button" onclick=""> 강좌 상세 내용 </button> <br><br>
		<button type="button" onclick=""> 강좌 정보 수정하기 </button> <br><br>	
<!-- Bootstrap core JavaScript -->
<script src="../resources/vendor/jquery/jquery.min.js"></script>
<script src="../resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Plugin JavaScript -->
<script src="../resources/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Bootstrap core JavaScript -->
<script src="../resources/vendor/jquery/jquery.min.js"></script>
<script src="../resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Plugin JavaScript -->
<script src="../resources/vendor/jquery-easing/jquery.easing.min.js"></script>
</body>
</html>