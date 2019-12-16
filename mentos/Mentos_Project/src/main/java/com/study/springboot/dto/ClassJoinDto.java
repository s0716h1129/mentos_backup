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
	private Date class_date;
}
