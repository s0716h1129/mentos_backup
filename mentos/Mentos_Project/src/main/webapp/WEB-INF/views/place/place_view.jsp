<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
<body>

<div class="container">
	<div style="float:left;" class="col-md-12">
		<h2>${dto.place_name}</h2>
	</div>
	
	<div style="float:left;" class="col-md-12">
		<img src=/upload/${dto.place_image}  width="950" height="440"> 
	</div>
	
	<div style="float:left;" class="col-md-12">
		<h4>상세주소 &nbsp;&nbsp; ${dto.place}, ${dto.place_place }</h4>
		<h4>수용인원 &nbsp;&nbsp; ${dto.place_people_num}명 </h4>
		<h4>연락처 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${dto.place_phone}</h4> 
		<h4>공간유형 &nbsp;&nbsp; ${dto.place_space }</h4>
		<button onclick="location.href='place_reservation?place_number=${dto.place_number}'">예약문의</button> 
		<button onclick="location.href='place_modify?place_number=${dto.place_number}'">수정</button> 
		<button onclick="location.href='place_delete?place_number=${dto.place_number}'">삭제</button> 
	</div>
	<br>
	<div style="float:left;" class="col-md-12">
		<h2>플레이스 정보</h2>
		<br><br>
		<h5>${dto.place_content}</h5>
		<br>
	</div>
	
	<div style="float:left;" class="col-md-12">
		<h1>위치</h1>
		<br>
		<h3>${dto.place}</h3> 
		<br><br>
		<div id="map" style="width:950px; height:440px;"></div>
	</div>

</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ea9f4a6ee158dc6b3bf6c48f1c63afe7&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = { 
    center: new kakao.maps.LatLng(37.478933,126.8789448,21), // 지도의 중심좌표
    level: 3 // 지도의 확대 레벨
};

//지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption);

//주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

// 주소로 좌표를 검색합니다
geocoder.addressSearch('${dto.place}', function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">${dto.place}</div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } 
});   
</script>
</body>
</html>