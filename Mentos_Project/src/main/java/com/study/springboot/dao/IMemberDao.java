package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.ClassDto;
import com.study.springboot.dto.MemberDto;
import com.study.springboot.dto.PlaceDto;

@Mapper
public interface IMemberDao {
	// 일반
	public int insertMember(String email,String pw,String nickname,String phoneNumber,String image); 
	// 회원가입
	public String snsCheck( String email);	// sns 가입 여부 
	public int check_id(String id);	// 아이디 중복 검사
	public String userCheck( String id, String pw);	// 비밀번호 체크
	public String find_id(String name , String phoneNumber);	// 아이디 찾기
	// 마이페이지 
	public MemberDto InformationDao(String mId);	// 회원 DB에서 정보 전체를 가져온다.
	public int InfoModifyDao(String intro, String email, String area, String major, String group, String id);
	// 회원정보 수정
	public int ModifyPw(String pw, String id);	// 비밀번호 변경
	public int IdCountDao (String id);	// DB에서 아이디 유무를 판단해서 있을 경우 1, 없을 경우 0 출력
	public int LeaveDao(String id);		// 회원 탈퇴 시 탈퇴 처리 
	public String QnA(String id, String QnA_content);
	// 관리자?
	public int MemberStop(String mId);	// 계정 영구 정지
	public int MemberBlackList(String mId);		// 계정 블랙리스트
	public int MemberMember(String mId);		// 계정 일반 회원 처리

	public List<ClassDto> ClassNumInfo(String cId);		// 강좌 번호로 클래스 DB에서 정보를 가져온다.
	public List<ClassDto> ClassNameInfo(String cId);	// 강좌 이름으로 클래스 DB에서 정보를 가져온다.
	public List<ClassDto> ClassMentoInfo(String cId);	// 강좌 멘토로 클래스 DB에서 정보를 가져온다.

	public int DeleteClass(String cId);		// 강좌 삭제
	
	public List<PlaceDto> PlaceNumInfo(String pId);		// 장소 번호로 장소 DB에서 정보를 가져옴
	public List<PlaceDto> PlaceNameInfo(String pId);	// 장소 이름으로 장소 DB에서 정보를 가져옴
}
