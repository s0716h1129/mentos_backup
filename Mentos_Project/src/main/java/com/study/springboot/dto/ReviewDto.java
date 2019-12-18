package com.study.springboot.dto;

import lombok.Data;

@Data
public class ReviewDto {
	private int review_num;
	private String review_kind;
	private int review_kind_num;
	private String review_content;
	private int review_score;
	private String review_writer;
	
	private String class_name;
	private String place_name;
}
