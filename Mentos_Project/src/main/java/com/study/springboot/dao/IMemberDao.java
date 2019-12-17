package com.study.springboot.dao;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.AttendanceDto;
import com.study.springboot.dto.ClassDto;
import com.study.springboot.dto.ClassJoinDto;
import com.study.springboot.dto.HistoryDto;
import com.study.springboot.dto.MemberDto;
import com.study.springboot.dto.NoticeDto;
import com.study.springboot.dto.PayDto;
import com.study.springboot.dto.PlaceDto;
import com.study.springboot.dto.ReviewDto;

@Mapper
public interface IMemberDao {
	
   // 일반
   public int insertMember(String email,String pw,String nickname,String phoneNumber,String image, String sns); 
   public int check_alram(String email);
   // 회원가입
   public String snsCheck( String email);   // sns 가입 여부 
   public int check_id(String id);   // 아이디 중복 검사
   public String userCheck( String id, String pw);   // 비밀번호 체크
   public String find_id(String name , String phoneNumber);   // 아이디 찾기
   
   // 마이페이지 
   public MemberDto informationDao(String mId);   // 회원 DB에서 정보 전체를 가져온다.

   public int InfoModifyDao(String intro, String area, String major, String group, String id);
   public int PayMemberCountDao (String mId);   // 해당 회원이 몇 건의 결제를 했는지 조회
   public List<ClassJoinDto> MemberClassInfoDao(String mId);	// 해당 회원이 참여한 강좌를 조회
   public List<ClassJoinDto> MemberLikeClassInfoDao (String mId);	// 해당 회원이 찜한 강좌를 조회
   public List<AttendanceDto> MemberAttendanceDao (String mId);	//해당 회원의 출결 정보

   // 회원정보 수정
   public int ModifyPw(String pw, String id);   // 비밀번호 변경
   public int IdCountDao (String id);   // DB에서 아이디 유무를 판단해서 있을 경우 1, 없을 경우 0 출력
   public int LeaveDao(String id);      // 회원 탈퇴 시 탈퇴 처리 
   
   // 관리자?
   
   public List<PayDto> PayInfoClassDao (String mId);   // 결제 회원 아이디로 강좌 결제 내역 조회
   public List<PayDto> PayInfoPlaceDao (String mId);   // 결제 회원 아이도로 장소 결제 내역 조회
   
   public int MemberGradeChange (String score, String mId);   // 멤버 점수 변경

   public int MemberStopDate (String mId, Timestamp date);   // 기간 정해 계정 정지
   public int MemberStop(String mId);   // 계정 영구 정지
   public int MemberBlackList(String mId);      // 계정 블랙리스트
   public int MemberMember(String mId);      // 계정 일반 회원 처리

   public int ClassNumTotalCount(String cId);		// 강좌 번호로 가져온 목록 갯수
   public List<ClassDto> ClassNumList (String cId, int nStart, int nEnd);	// 페이지 처리시 강좌 이름으로 가져오는 내역
   public List<ClassDto> ClassInfo (String cId);	//페이지 처리없이 정보 가져오기
   
   public int ClassNameTotalCount(String cId);		// 강좌 이름으로 가져온 목록 갯수
   public List<ClassDto> ClassNameList (String cId, int nStart, int nEnd);	// 페이지 처리시 강좌 이름으로 가져오는 내역
   public int ClassMentoTotalCount(String cId);		// 강좌 멘토로 가져온 목록 갯수
   public List<ClassDto> ClassMentoList (String cId, int nStart, int nEnd);	// 페이지 처리시 강좌 이름으로 가져오는 내역
 
   public int ClassPayTotalCount (String cId);	// 강좌 번호로 강좌 결제 내역 갯수 확인
   public List<PayDto> ClassPayList (String cId, int nStart, int nEnd);	// 강좌 결제 내역 페이지 처리로 가져 옴
   public int ClassReviewTotalCount (String cId);	// 강좌 번호로 강좌 리뷰 내역 갯수 확인
   public List<PayDto> ClassReviewList (String cId, int nStart, int nEnd);	// 강좌 리뷰 내역 페이지 처리로 가져 옴
   public List<ReviewDto> ClassReviewDao (String cId);   // 강좌 번호로 강좌 리뷰 내역 조회

   public int DeleteClass(String cId);      // 강좌 삭제
   
   public List<PlaceDto> PlaceInfo(String pId);	//페이징 처리없이 장소 번호로 목록 가져오기
   public int placeNumTotalCount(String pId);	// 장소 번호로 가져온 목록의 갯수
   public List<PlaceDto> PlaceNumList (String pId, int nStart, int nEnd);	// 페이지 처리시 장소 번호로 가져오는 내역
   public int placeNameTotalCount(String pId);	// 장소 이름으로 가져온 목록의 갯수
   public List<PlaceDto> PlaceNameList (String pId, int nStart, int nEnd);	// 페이지 처리시 장소 이름으로 가져오는 내역
   
   public int PlacePayTotalCount (String pId);	// 장소 번호로 장소 결제 내역 갯수 확인
   public List<PayDto> PlacePayList (String pId, int nStart, int nEnd);	// 장소 결제 내역 페이지 처리로 가져 옴
   public int PlaceReviewTotalCount (String pId);	// 장소 번호로 장소 리뷰 내역 갯수 확인
   public List<ReviewDto> PlaceReviewList (String pId, int nStart, int nEnd);	// 장소 결제 내역 페이지 처리로 가져 옴
   public int DeletePlace(String pId);      // 장소 등록 삭제
   
   // 고객센터
   public void QnA(HashMap<String, String> map);
   public void report(HashMap<String, String> map);
   public void notice(HashMap<String, String> map);
   public int totalCount();
   public List<NoticeDto> notice_list(int nStart, int nEnd);
   public List<HistoryDto> history_list(int nStart, int nEnd, String id);
   
   
   //안드로이드
 	public int AndinsertMember(String email,String pw,String nickname,String phoneNumber,String image); 
 	
 	public List<ClassJoinDto> beaconAttClassList(String mId);	// 비콘 강좌 리스트
}
