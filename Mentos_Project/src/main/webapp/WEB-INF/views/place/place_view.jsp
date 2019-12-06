<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<table width="950" height="440">
	<tr style=" display:inline-block;">
		<td>
			<h1>${dto.place_name}</h1>
			<img src=/img/${dto.place_image}  width="950" height="440"> 
			<br>
			<div style="border:1px solid #808080; padding:15px;">
				상세주소 &nbsp;&nbsp; ${dto.place} <br>
				수용인원 &nbsp;&nbsp; ${dto.place_people_num}명 <br>
				연락처 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${dto.place_phone} <br><br>
				<button onclick="location.href='list'">예약문의</button>
			</div>
			<br>
			<h2>플레이스 정보</h2>
			${dto.place_content}
			<br><br><br>
			<h1>위치</h1>
			${dto.place} <br><br>
			<div id="map" style="width:950px; height:440px;"></div>
		</td>
	</tr>
</table>

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