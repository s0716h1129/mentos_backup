package com.study.springboot.dto;

import lombok.Data;

@Data
public class HistoryDto {
	private int qna_num;		// 문의사항 번호
	private String qna_writer;	// 문의사항 작성자
	private String qna_content;	// 문의사항 내용
}
