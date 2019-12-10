package com.study.springboot.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class EvaluationDto {
	
	private int evaluation_number;			//게시판 번호
	private String evaluation_title;		//게시판 제목
	private String evaluation_name;			//아이디
	private String evaluation_content;		//게시판 내용
	Timestamp evaluation_time;				//게시판 등록일
	private int evaluation_Hit;				//게시판 조회수
	private int evaluation_Group;			//답글
	private int evaluation_Step;			//답글
	private int evaluation_Indent;			//답글

}
