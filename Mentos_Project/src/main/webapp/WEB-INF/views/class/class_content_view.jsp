<%@include file ="../header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
#container {
	
}
</style>
</head>
<body>
	<div class="container">
		<div>
			<div class="form-row col-md-12" style="display: flex;">
				<div class="form-group col-md-8">
					<div id="img" class="image-container">
					<img id="img_source" src="${content_view.class_image }" style="width: 700px; height: 400px;">
				</div>
				</div>
				<div class="form-group col-md-4" style="position:relative;">
					<div style="position:absolute; left:0px; text-align : left;">
						<label>강좌 이름</label>
						<p>${content_view.class_name }</p>					
					</div>
				</div>
			</div>
		</div>
		<div>
		</div>
		
		<div>
		<label>강사 이름</label>
		<p>${content_view.class_mento }</p>
		</div>
		<div>
			<label>모임 장소</label>
			${content_view.class_place }
		</div>
		<div>
			<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
			<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3e3bd2cc527b7ea57ecfc6e10dbcf2c5&libraries=services"></script>
				<div id="map" style="width:500px;height:400px;"></div>

				<script>
					var container = document.getElementById('map');
					var position = new kakao.maps.LatLng(${content_view.class_location_y}, ${content_view.class_location_x});
					
					var options = {
						center: position,
						level: 3
					};
			
					var map = new kakao.maps.Map(container, options);
					
                    var marker = new kakao.maps.Marker({
				        position: position,
				        clickable: true
				    });
                    
                 // 마커를 지도에 표시합니다.
                    marker.setMap(map);
                    
                	// 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
                    var iwContent = '<div style="padding:5px;">' + "${content_view.class_place}" + '</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
                        iwPosition = new daum.maps.LatLng(${content_view.class_location_y}, ${content_view.class_location_x}), //인포윈도우 표시 위치입니다
                        iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다
                    
                    // 인포윈도우를 생성합니다
                    var infowindow = new daum.maps.InfoWindow({
                        position : iwPosition,
                        content : iwContent,
                        removable : iwRemoveable
                    });
                        
                 // 마커에 클릭이벤트를 등록합니다
                    kakao.maps.event.addListener(marker, 'click', function() {
                          // 마커 위에 인포윈도우를 표시합니다
                          infowindow.open(map, marker);  
                    });
                        
				</script>
			</div>
			
		
		
		<div>
			${content_view.class_content }
		</div>
		<div>
			참가 인원/ 정원
		</div>
	</div>
	<table width="500" cellpadding="0" cellsapcing="0" border="1">
		<tr>
			<td>번호</td>
			<td>${ content_view.class_number }</td>
		</tr>
		
		<tr>
			<td>이름</td>
			<td>${ content_view.class_mento }</td>
		</tr>
		<tr>
			<td>제목</td>
			<td>${ content_view.class_name }</td>
		</tr>
		<tr>
			<td>내용</td>
			<td>${ content_view.class_content }</td>
		</tr>

		<tr>
			<td colspan="2">
				<a href="class/class_modify_view?class_number=${content_view.class_number}">수정</a> &nbsp;&nbsp;
				<a href="class/joinClass?class_number=${content_view.class_number}">참여</a> &nbsp;&nbsp; 
				<a href="class/class_list?page=<%= session.getAttribute("cpage") %>">목록보기</a> &nbsp;&nbsp; 
				<a href="class/class_delete?class_number=${content_view.class_number}">삭제</a> &nbsp;&nbsp; 
				<a href="class/class_reply_view?class_number=${content_view.class_number}">답변</a>  
				
			</td>
		</tr>
	</table>
</body>
</html>