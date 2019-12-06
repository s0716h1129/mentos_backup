package com.study.springboot.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ClassDto {
	private int class_number;				// 강좌 번호
	private String class_name;				// 강좌 이름
	private String class_mento;				// 강좌 아이디
	private String class_mentee;			// 참여 멘티 아이디들
	private String class_content;			// 강좌 내용
	private String class_payment;			// 멘티 결제 내역
	private String class_place;				// 강좌 장소
	private Timestamp class_date;			// 강좌 시작 날짜?
	private String class_image;				// 강좌 대표 이미지
	private String class_mento_infomation;	// 강사 정보
}
