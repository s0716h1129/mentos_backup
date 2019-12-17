package com.study.android.mentos_project;

public class MemberDto {
    private String email;			// 이메일
    private String password;		// 비밀번호
    private String nickname;		// 닉네임
    private String member_score;		// 회원점수 등급으로 반영
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
    private String stop_day;	// 계정 일시 정지 풀리는 날짜

    public MemberDto( String member_image, String email, String nickname, String phonenumber, String interest_major, String interest_group, String interest_area, String member_intro) {
        this.email = email;
        this.nickname = nickname;
        this.phonenumber = phonenumber;
        this.interest_major = interest_major;
        this.interest_group = interest_group;
        this.interest_area = interest_area;
        this.member_image = member_image;
        this.member_intro = member_intro;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public String getNickname() {
        return nickname;
    }

    public String getMember_score() {
        return member_score;
    }

    public String getPayment() {
        return payment;
    }

    public String getPoint() {
        return point;
    }

    public String getSns_check() {
        return sns_check;
    }

    public String getPhonenumber() {
        return phonenumber;
    }

    public String getInterest_class() {
        return interest_class;
    }

    public String getInterest_major() {
        return interest_major;
    }

    public String getInterest_group() {
        return interest_group;
    }

    public String getInterest_area() {
        return interest_area;
    }

    public String getMember_state() {
        return member_state;
    }

    public String getMember_image() {
        return member_image;
    }

    public String getMember_intro() {
        return member_intro;
    }

    public String getAuthority() {
        return authority;
    }

    public String getStop_day() {
        return stop_day;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public void setMember_score(String member_score) {
        this.member_score = member_score;
    }

    public void setPayment(String payment) {
        this.payment = payment;
    }

    public void setPoint(String point) {
        this.point = point;
    }

    public void setSns_check(String sns_check) {
        this.sns_check = sns_check;
    }

    public void setPhonenumber(String phonenumber) {
        this.phonenumber = phonenumber;
    }

    public void setInterest_class(String interest_class) {
        this.interest_class = interest_class;
    }

    public void setInterest_major(String interest_major) {
        this.interest_major = interest_major;
    }

    public void setInterest_group(String interest_group) {
        this.interest_group = interest_group;
    }

    public void setInterest_area(String interest_area) {
        this.interest_area = interest_area;
    }

    public void setMember_state(String member_state) {
        this.member_state = member_state;
    }

    public void setMember_image(String member_image) {
        this.member_image = member_image;
    }

    public void setMember_intro(String member_intro) {
        this.member_intro = member_intro;
    }

    public void setAuthority(String authority) {
        this.authority = authority;
    }

    public void setStop_day(String stop_day) {
        this.stop_day = stop_day;
    }
}
