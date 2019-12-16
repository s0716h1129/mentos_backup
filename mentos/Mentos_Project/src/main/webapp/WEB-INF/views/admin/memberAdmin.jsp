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

<script>
	// 비밀번호 변경
	function changePw() {
		if ($('#pId').val().length == 0) {
			alert("변경 할 아이디를 입력해주세요.");
			$('#pId').focus();
			return;
		}
		
		if ($('#pw').val().length == 0) {
			alert("변경 할 비밀번호를 입력해주세요.");
			$('#pw').focus();
			return;
		}
		
		if ($('#pw').val().length < 8) {
			alert("비밀번호는 8자리 이상 입력해주세요.");
			$('#pw').focus();
			return;
		}
		
		if ($('#checkPw').val().length == 0) {
			alert("변경 할 비밀번호를 입력해주세요.");
			$('#checkPw').focus();
			return;
		}
		
		if ($('#pw').val() != $('#checkPw').val()) {
			alert("비밀번호 확인과 일치하지 않습니다.");
			$('#pw').focus();
			return;
		}
		
		submit_ajax();
	}
	
	function submit_ajax() {
		var queryString = $("#pw-form").serialize();
		$.ajax({
			url: './pwModify',
			type: 'POST',
			data: queryString,
			dataType: 'text',
			success: function(json) {
				var result = JSON.parse(json);
				if (result.code == "success") {
					alert(result.desc)
					window.location.replace("./main?type=member")
				} else {
					alert(result.desc)
				}
				
			}
		});
	}
	
	// 등급 변경
	function changegrade() {
		if ($('#gradeId').val().length == 0) {
			alert("변경 할 아이디를 입력해주세요.");
			$('#gradeId').focus();
			return;
		}
		
		if ($('#score').val().length == 0) {
			alert("점수를 입력해주세요.");
			$('#score').focus();
			return;
		}
		
		submit_gradeAjax();
	}
	
	function submit_gradeAjax() {
		var queryString = $("#grade-form").serialize();
		$.ajax({
			url: './changeGrade',
			type: 'POST',
			data: queryString,
			dataType: 'text',
			success: function(json) {
				var result = JSON.parse(json);
				if (result.code == "success") {
					alert(result.desc)
					window.location.replace("./memberSerch?type=member&menu=&mId="+$('#gradeId').val())
				} else {
					alert(result.desc)
				}
				
			}
		});
	}
	
	
	// 계정 정지, 삭제, 블랙 리스트
	function mState() {
		if ($('#sId').val().length == 0) {
			alert("변경 할 아이디를 입력해주세요.");
			$('#sId').focus();
			return;
		}
		
		submit_mState();
		
	}
	
	function submit_mState() {
		var queryString = $("#state-form").serialize();
		$.ajax({
			url: './stateAjax',
			type: 'POST',
			data: queryString,
			dataType: 'text',
			success: function(json) {
				var result = JSON.parse(json);
				
				
				if (result.code == "success") {
					if ($('#sState').val() == 'stop') {
						var con = confirm("일정 기간 동안 계정을 정지 하겠습니까");
						if (con == true) {
							var date = prompt("정지 기간을 정해주세요.", "7");
							window.location.replace("./memberState?type=member&sType=stop&mId="+$('#sId').val()+"&date="+date)
						} else if (con == false) {
							alert("취소되었습니다.")
							return;
						}
						
					}else if ($('#sState').val() == 'allStop') {
						var con = confirm("계정을 영구 정지 하겠습니까");
						if (con == true) {
							window.location.replace("./memberState?type=member&sType=allStop&mId="+$('#sId').val())
						} else if (con == false) {
							alert("취소되었습니다.")
							return;
						}
						
					} else if ($('#sState').val() == 'delete') {
						var con = confirm("계정을 탈퇴 시키겠습니까");	
						if (con == true) {
							window.location.replace("./memberState?type=member&sType=delete&mId="+$('#sId').val())
						} else if (con == false) {
							alert("취소되었습니다.")
							return;
						}
						
					} else if ($('#sState').val() == 'blackList') {
						var con = confirm("블랙리스트 처리하시겠습니까");	
						if (con == true) {
							window.location.replace("./memberState?type=member&sType=blackList&mId="+$('#sId').val())
						} else if (con == false) {
							alert("취소되었습니다.")
							return;
						}	
						
					} else if ($('#sState').val() == 'member') {
						var con = confirm("일반 회원으로 전환시키겠습니까");	
						if (con == true) {
							window.location.replace("./memberState?type=member&sType=member&mId="+$('#sId').val())
						} else if (con == false) {
							alert("취소되었습니다.")
							return;
						}	
					}
				} else {
					alert(result.desc)
				}
				
			}
		});
	}
	
</script>

</head>
<body>
	<div class="card mb-3">
    	<div class="card-header">
    		<i class="fas fa-table"></i>
    		<form action="memberSerch" class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
    			<div class="input-group">
    				<input type="text" class="form-control" placeholder="회원 ID 입력" aria-label="Search" aria-describedby="basic-addon2" id="mId" name="mId" value="${param.mId}">
    				<button class="btn btn-dark" type="submit"> 검색 <!-- 나중에 돋보기 모양 아이콘 추가하기 --> </button>	
    				<input type="hidden" id="type" name="type" value="member">
					<input type="hidden" id="menu" name="menu" value="">
    			</div>
    		</form></div>
    	<div class="card-body">
            <div class="table-responsive">
            	<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
            		<thead>
            		 	<tr>
					    	<th> 아이디 </th>
					    	<th> 이름 </th>
					    	<th> 전화번호 </th>
					    	<th> 포인트 </th>
					    	<th> 등급 </th>
					    	<th> 결제 내역 </th>
					    	<th> 계정 상태 </th>
					    		<c:if test ="${serList.member_state eq 'ROLE_DATE_STOP'}">
					    	<th> 일시 정지 풀리는 날짜 </th>
					    	</c:if>
					    </tr>
            		 </thead>
            		 	
            		 <tr>
						<td> ${serList.email} </td>
						<td> ${serList.nickname} </td>	
						<td> ${serList.phonenumber} </td>
					    <td> ${serList.point} </td>
					   	<td> ${grade} (${serList.member_score} 점) </td>
					   	<td> <a href="./memberSerch?type=member&menu=pay&mId=${param.mId}"> ${payCount} </a> </td>
					  	<td> 
						  	<c:if test= "${serList.member_state eq 'ROLE_MEMBER'}">
						  		일반 회원
						  	</c:if>
						  	<c:if test= "${serList.member_state eq 'ROLE_ADMIN'}">
						  		관리자
						  	</c:if>
						  	<c:if test= "${serList.member_state eq 'ROLE_STOP'}">
						  		계정 영구 정지
						  	</c:if>
						  	<c:if test= "${serList.member_state eq 'ROLE_DATE_STOP'}">
						  		계정 일시 정지
						  	</c:if>
						  	<c:if test= "${serList.member_state eq 'ROLE_LEAVE'}">
						  		탈퇴
						  	</c:if>
						  	<c:if test= "${serList.member_state eq 'ROLE_BLACKLIST'}">
						  		블랙리스트
						  	</c:if>
					  	</td>
					  	<c:if test ="${serList.member_state eq 'ROLE_DATE_STOP'}">
				    		<td> ${serList.stop_day} </td>
				    	</c:if>
					</tr>		
            	</table>
            </div>
        </div>
    </div>
	   	
	   	<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
  Launch demo modal
</button>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
	<c:if test="${param.menu eq 'pay'}">
	   	<div class="card mb-3">
	   		<div class="card-header">
    			<i class="fas fa-table"></i>
    			${param.mId}의 강좌 결제 내역
    		</div>
    		<div class="card-body">
            	<div class="table-responsive">
            		<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
            			<thead>
            				<tr>
					   			<th> 결제 내역 </th>
					   			<th> 결제 금액 </th>
					   			<th> 결제일 </th>
					   			<th> 환불 </th>
					   		</tr>
            			</thead>
            				
            			<c:forEach items="${classPay}" var="cdto">
					   		<tr>
					   			<td> ${cdto.class_name} </td>
					   			<td> ${cdto.pay_price} </td>
					   			<td> ${cdto.pay_date} </td>
					   			<td> ${cdto.refund} </td>
					   		</tr>
					   	</c:forEach>
            		</table>
            	</div>
            </div>
    	</div>
    	
    	<div class="card mb-3">
	   		<div class="card-header">
    			<i class="fas fa-table"></i>
    			    ${param.mId}의 장소 결제 내역
    		</div>
    		<div class="card-body">
            	<div class="table-responsive">
            		<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
            			<thead>
            				<tr>
					   			<th> 결제 내역 </th>
					   			<th> 결제 금액 </th>
					   			<th> 결제일 </th>
					   			<th> 환불 </th>
					   		</tr>
            			</thead>
            				
            			<c:forEach items="${placePay}" var="cdto">
					   		<tr>
					   			<td> ${cdto.place_name} </td>
					   			<td> ${cdto.pay_price} </td>
					   			<td> ${cdto.pay_date} </td>
					   			<td> ${cdto.refund} </td>
					   		</tr>
					   	</c:forEach>
            		</table>
            	</div>
            </div>
    	</div>
	</c:if>
	
	<c:if test="${param.menu eq 'cState'}">
		<div class="card mb-3">
		   	<div class="card-header">
	    		<i class="fas fa-table"></i>
	    	    회원 정지/탈퇴/블랙 리스트
	    	</div>
	    	<div class="card-body">
	            <div class="table-responsive">
					<form id="state-form">
			    		<select id="sState" name="sState">
			    			<option value="stop" selected=selected> 단기 정지 </option>
			    			<option value="allStop"> 영구 정지 </option>
			    			<option value="delete"> 계정 탈퇴 </option>
			    			<option value="blackList"> 블랙리스트 </option>
			    			<option value="member"> 일반 회원으로 전환 </option>
			    		</select>	   		
			    		<input type="text" id="sId" name="sId">
			    		<input type="button" onclick="mState()" value="실행"><br>
					</form>
	            </div>
	        </div>
	    </div>
    </c:if>
    
    <c:if test="${param.menu eq 'cPw'}">
	    <div class="card mb-3">
		   	<div class="card-header">
	    		<i class="fas fa-table"></i>
	    	    비밀번호 변경
	    	</div>
	    	<div class="card-body">
	            <div class="table-responsive">
	            	<form id="pw-form">
						아이디 : <input type="text" id="pId" name="pId"><br>
						변경 비밀번호 : <input type="password" id="pw" name="pw"><br>
						변경 비밀번호 확인 : <input type="password" id="checkPw" name="checkPw"><br>
						<input type="button" onclick="changePw()" value="비밀번호 변경"><br>
					</form>
	            </div>
	        </div>
	    </div>
    </c:if>
    
    <c:if test="${param.menu eq 'grade'}">
    	<form id="grade-form">
    		변경 아이디 : <input type="text" id="gradeId" name="gradeId"><br>
    		변경 점수 : <input type="text" id="score" name="score"><br>
    		<input type="button" onclick="changegrade()" value="등급 변경"><br>
    	</form>
    </c:if>

		<!--  
		<button type="button" class="btn btn-primary" onclick="location.href='./memberSerch?type=member&menu=cState&mId=${param.mId}'"> 회원 정지 / 삭제 / 블랙리스트 </button> &nbsp;
		<button type="button" class="btn btn-primary" onclick=""> 회원 등급 변경 </button> &nbsp;
		<button type="button" class="btn btn-primary" onclick="location.href='./memberSerch?type=member&menu=cPw&mId=${param.mId}'"> 회원 비밀번호 변경 </button> &nbsp;
		-->
		
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