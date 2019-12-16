package com.study.android.mentos_project;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.Button;
import android.widget.CalendarView;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

public class MyPageActivity extends AppCompatActivity {
    private static final String Tag = "lecture";

    // main
    LinearLayout mainLayout;
    Button memberInfoBtn;
    Button mInfoModifyBtn;
    Button memberClassBtn;
    Button memberPayBtn;
    Button memberAttendanceBtn;
    Button memberLeaveBtn;

    // info
    LinearLayout mInfoLayout;
    ImageView memberInfoImage;
    TextView tvInfoIntro;
    TextView tvInfoId;
    TextView tvInfoName;
    TextView tvInfoAdd;
    TextView tvInfoNum;
    TextView tvInfoArea;
    TextView tvInfoGroup;
    TextView tvInfoMajor;
    Button infoModifyBtn;
    Button infoReturnMainBtn;

    // modify
    LinearLayout modifyLayout;
    Button modifyBtn;
    Button modifyCancelBtn;

    // memberClass
    LinearLayout memberClassLayout;
    RecyclerView openClassRecycler;
    RecyclerView attendClassRecycler;
    Button cReturnMainBtn;

    // memberPay
    LinearLayout memberPayLayout;
    RecyclerView memberPayRecycler;
    Button pReturnMainBtn;

    // memberAttendance
    LinearLayout memberAttendanceLayout;
    CalendarView attendanceCalendar;
    RecyclerView attendCheckRecycler;
    Button aReturnMainBrn;
    Button attendancePageBtn;

    // memberLeave
    LinearLayout memberLeaveLayout;
    EditText edLeaveId;
    EditText edLeavePw;
    EditText edLeavePwCheck;
    Button leaveBtn;
    Button leaveReturnMainBtn;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_my_page);

        //main
        mainLayout = findViewById(R.id.MainLayout);
        memberInfoBtn = findViewById(R.id.MemberInfoBtn);
        mInfoModifyBtn = findViewById(R.id.MInfoModifyBtn);
        memberClassBtn = findViewById(R.id.MemberClassBtn);
        memberPayBtn = findViewById(R.id.MemberPayBtn);
        memberAttendanceBtn = findViewById(R.id.MemberAttendanceBtn);
        memberLeaveBtn = findViewById(R.id.MemberLeaveBtn);

        //info
        mInfoLayout = findViewById(R.id.MInfoLayout);
        memberInfoImage = findViewById(R.id.MemberInfoImage);
        tvInfoIntro = findViewById(R.id.TvMIdInfo);
        tvInfoId = findViewById(R.id.TvMIdInfo);
        tvInfoName = findViewById(R.id.TvMNameInfo);
        tvInfoAdd = findViewById(R.id.TvMAddInfo);
        tvInfoNum = findViewById(R.id.TvMNumInfo);
        tvInfoArea = findViewById(R.id.TvMAreaInfo);
        tvInfoGroup = findViewById(R.id.TvMGroupInfo);
        tvInfoMajor = findViewById(R.id.TvMMajorInfo);
        infoModifyBtn = findViewById(R.id.InfoModifyBtn);
        infoReturnMainBtn = findViewById(R.id.InfoReturnMainBtn);

        // modify
        modifyLayout = findViewById(R.id.ModifyLayout);
        modifyBtn = findViewById(R.id.ModifyBtn);
        modifyCancelBtn = findViewById(R.id.ModifyCancelBtn);

        // memberClass
        memberClassLayout = findViewById(R.id.MemberClassLayout);
        openClassRecycler = findViewById(R.id.OpenClassRecycler);
        attendClassRecycler = findViewById(R.id.AttendClassRecycler);
        cReturnMainBtn = findViewById(R.id.CReturnMainBtn);

        // memberPay
        memberPayLayout = findViewById(R.id.MemberPayLayout);
        memberPayRecycler = findViewById(R.id.MemberPayRecycler);
        pReturnMainBtn = findViewById(R.id.PReturnMainBtn);

        // memberAttendance
        memberAttendanceLayout = findViewById(R.id.MemberAttendanceLayout);
        attendanceCalendar = findViewById(R.id.AttendanceCalendar);
        attendCheckRecycler = findViewById(R.id.AttendanceCheckRecycler);
        aReturnMainBrn = findViewById(R.id.AReturnMainBtn);
        attendancePageBtn = findViewById(R.id.AttendancePageBtn);

        // memberLeave
        memberLeaveLayout = findViewById(R.id.MemberLeaveLayout);
        edLeaveId = findViewById(R.id.EdLeaveId);
        edLeavePw = findViewById(R.id.EdLeavePw);
        edLeavePwCheck = findViewById(R.id.EdLeavePwCheck);
        leaveBtn = findViewById(R.id.LeaveBtn);
        leaveReturnMainBtn = findViewById(R.id.LeaveReturnMainBtn);
    }

    // main 버튼
    // 회원 정보 화면으로 이동
    public void MemberIfoBtnClicked(View v) {
        mainLayout.setVisibility(View.GONE);
        mInfoLayout.setVisibility(View.VISIBLE);

    }

    // 회원 정보 수정 화면으로 이동
    public void MInfoModifyClicked(View v) {
        mainLayout.setVisibility(View.GONE);
        modifyLayout.setVisibility(View.VISIBLE);
    }

    // 회원 강좌 리스트 화면으로 이동
    public void MemberClassClicked(View v) {
        mainLayout.setVisibility(View.GONE);
        memberClassLayout.setVisibility(View.VISIBLE);
    }

    // 회원 결제 내역 화면으로 이동
    public void MemberPayClicked(View v) {
        mainLayout.setVisibility(View.GONE);
        memberPayLayout.setVisibility(View.VISIBLE);
    }

    // 회원 출결 확인 화면으로 이동
    public void MemberAttendanceClicked(View v) {
        mainLayout.setVisibility(View.GONE);
        memberAttendanceLayout.setVisibility(View.VISIBLE);

    }

    // 회원 탈퇴 화면으로 이동
    public void MemberLeaveClicked(View v) {
        mainLayout.setVisibility(View.GONE);
        memberLeaveLayout.setVisibility(View.VISIBLE);
    }

    // modify 버튼
    // 수정 완료 버튼
    public void ModifyBtnClicked(View v) {


        mainLayout.setVisibility(View.GONE);
        modifyLayout.setVisibility(View.GONE);
    }

    // 수정 취소 버튼
    public void ModifyCancelBtnClicked(View v) {
        mainLayout.setVisibility(View.VISIBLE);
        modifyLayout.setVisibility(View.GONE);
    }

    // memberClass 버튼
    // 메인으로 돌아가기
    public void CReturnMainBtnClicked(View v) {
        mainLayout.setVisibility(View.VISIBLE);
        memberClassLayout.setVisibility(View.GONE);
    }

    // memberPay 버튼
    // 메인으로 돌아가기
    public void PReturnMainBtnClicked(View v) {
        mainLayout.setVisibility(View.VISIBLE);
        memberPayLayout.setVisibility(View.GONE);
    }

    // memberAttendance 버튼
    // 메인으로 돌아가기
    public void AReturnMainBtnClicked(View v) {
        mainLayout.setVisibility(View.VISIBLE);
        memberAttendanceLayout.setVisibility(View.GONE);
    }

    // 출석 체크 페이지로 이동
    public void AttendancePageBtnClicked(View v) {

    }

    // memberInfo 버튼
    // 메인으로 돌아가기
    public void InfoReturnMainBtnClicked(View view) {
        mainLayout.setVisibility(View.VISIBLE);
        mInfoLayout.setVisibility(View.GONE);
    }

    // 회원 정보 수정 페이지로 이동
    public void InfoModifyBtnClicked(View view) {
        mInfoLayout.setVisibility(View.GONE);
        modifyLayout.setVisibility(View.VISIBLE);
    }

    // memberLeave 버튼
    // 회원 탈퇴
    public void LeaveBtnClicked(View view) {

    }

    // 메인으로 돌아가기
    public void LeaveReturnMainBtn(View view) {
        mainLayout.setVisibility(View.VISIBLE);
        memberLeaveLayout.setVisibility(View.GONE);
    }
}