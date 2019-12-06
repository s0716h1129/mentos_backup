package com.study.springboot.dto;

import lombok.Data;

@Data
public class MemberDto {
	private String email;			// 이메일
	private String password;		// 비밀번호
	private String nickname;		// 닉네임
	private int member_score;		// 회원점수 등급으로 반영
	private String payment;			// 결제내역
	private String point;			// 포인트
	private String sns_check;		// sns 로그인 여부 / sns 종류?
	private String phonenumber;		// 전화번호 
	private String interest_class;	// 관심 모임
	private String interest_major;	// 관심 분야
	private String interest_group;	// 관심 직군
	private String interest_area;	// 관심 지역
	private String member_state;	// 회원 상태 / 정지 탈퇴 등
	private String member_image;	// 회원 프로필 이미지
	private String member_intro;   	// 회원 자기소개
	private String authority;		// 시큐리티 인증여부
}
