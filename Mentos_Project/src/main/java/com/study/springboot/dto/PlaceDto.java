package com.study.springboot.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class PlaceDto {
	private int place_number;		// 장소 번호
	private String place_name;		// 장소 이름
	private String place;			// 주소
	Timestamp place_time;			// 대여(시간) 기간
	private int place_people_num;	// 수용 가능 인원
	private String place_price;		// 대여료
	private String place_phone;		// 장소 제공자 전화 번호
	private String place_email;		// 장소 제공자 이메일
	private String place_content;	// 장소 정보
	private String place_image;		// 장소 상세 이미지..이름
}
