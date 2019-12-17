package com.study.springboot.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ClassDto {
	private int class_number;				// 강좌 번호
	private String class_name;				// 강좌 이름
	private String class_mento;				// 강좌 아이디
	private int class_maxNumber;			// 강좌 수강 최대 인원
	private int class_menteeNumber;			// 참가 인원
	private String class_content;			// 강좌 내용
	private String class_payment;			// 강좌 가격
	private String class_place;				// 강좌 장소
	private Timestamp class_date;			// 강좌 시작 날짜?
	private String class_image;				// 강좌 대표 이미지
	private String class_mento_infomation;	// 강사 정보
	private String class_like;				// 종아요
	private String class_startDate;			// 수강 날짜
	private String class_endDate;			// 종료 날짜
	private String class_startTime;			// 수강 시작 시간
	private String class_endTime;			// 수강 종료 시간
	private String class_receiveStartDate;	// 접수 시작 날짜
	private String class_receiveEndDate;	// 접수 종료 날짜
	private String class_receiveStartTime;	// 접수 시작 날짜
	private String class_receiveEndTime;	// 접수 종료 날짜
	private String class_location;			// 장소 구분
	private String class_location_y;			// y 좌표
	private String class_location_x;			// x 좌표
	private String class_category;			// 카테고리 구분
	private String class_state;				// 강좌 개설 상태
}
