package com.study.springboot.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ClassJoinDto {
	private int join_num;
	private int join_class_num;
	private String join_mentee;
	private String join_type;
	
	private String class_name;
	private String class_mento;
	private String class_place;
	private String class_startdate;			// 수강 날짜
	private String class_enddate;			// 종료 날짜
	private String class_starttime;			// 수강 시작 시간
	private String class_endtime;			// 수강 종료 시간
}
