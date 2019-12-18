package com.study.springboot.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class AttendanceDto {
	private int attendance_num;		// 출결 번호
	private int class_num;			// 강좌 번호
	private String class_member;	// 참여 멘티 아이디
	private String attendance;		// 출결 여부
	private int attendance_score;	// 출결 누적 점수
	private Date attendance_date;	// 출석 체크 날짜
}
