package com.study.springboot.dto;

import lombok.Data;

@Data
public class BPageInfo {
	private int totalcount;			// 총 게시물의 갯수
	private int listcount;			// 한 페이지당 보여줄 게시물의 갯수
	private int totalpage;			// 총 페이지
	private int curpage;			// 현재 페이지
	private int pagecount;			// 하단에 보여줄 페이지 리스트의 갯수
	private int startpage;			// 시작 페이지
	private int endpage;			// 끝 페이지
}
