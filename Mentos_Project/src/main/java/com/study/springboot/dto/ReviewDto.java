package com.study.springboot.dto;

import lombok.Data;

@Data
public class ReviewDto {
	private int review_num;
	private int class_num;
	private String class_name;
	private String review_content;
	private int review_score;
	private int review_writer;
}
