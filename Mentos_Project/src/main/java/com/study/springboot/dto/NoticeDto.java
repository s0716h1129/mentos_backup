package com.study.springboot.dto;

import lombok.Data;

@Data
public class NoticeDto {
	private int notice_num;
	private String notice_writer;
	private String notice_title;
	private String notice_content;
}
