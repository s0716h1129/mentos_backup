package com.study.android.mentos_project;

import android.content.ContentValues;
import android.content.Intent;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class MyPageMainActivity extends AppCompatActivity {
    private static final String TAG = "lecture";

    private final long FINISH_INTERVAL_TIME = 2000;
    private long   backPressedTime = 0;

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
    TextView tvInfoNum;
    TextView tvInfoArea;
    TextView tvInfoGroup;
    TextView tvInfoMajor;
    Button infoModifyBtn;
    Button infoReturnMainBtn;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_my_page_main);

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
        tvInfoNum = findViewById(R.id.TvMNumInfo);
        tvInfoArea = findViewById(R.id.TvMAreaInfo);
        tvInfoGroup = findViewById(R.id.TvMGroupInfo);
        tvInfoMajor = findViewById(R.id.TvMMajorInfo);
        infoModifyBtn = findViewById(R.id.InfoModifyBtn);
        infoReturnMainBtn = findViewById(R.id.InfoReturnMainBtn);

    }

    // 회원 정보 화면으로 이동
    public void MemberIfoBtnClicked(View v) {
        mainLayout.setVisibility(View.GONE);
        mInfoLayout.setVisibility(View.VISIBLE);

        String url = "http://192.168.219.110:8081/mypage/aMemberInfo?email=test@email.com";

        NetworkTask networkTask = new NetworkTask(url, null);
        networkTask.execute();
    }

    // 회원 정보 수정 화면으로 이동
    public void MInfoModifyClicked(View v) {
        Intent intent = new Intent(this, MyPageModifyActivity.class);
        startActivity(intent);

        this.finish();
    }

    // 회원 강좌 리스트 화면으로 이동
    public void MemberClassClicked(View v) {
        Intent intent = new Intent(this, MyPageClassActivity.class);
        startActivity(intent);

        this.finish();
    }

    // 회원 결제 내역 화면으로 이동
    public void MemberPayClicked(View v) {

    }

    // 회원 출결 확인 화면으로 이동
    public void MemberAttendanceClicked(View v) {


    }

    // 회원 탈퇴 화면으로 이동
    public void MemberLeaveClicked(View v) {

    }

    // 메인으로 돌아가기
    public void InfoReturnMainBtnClicked(View view) {
        mainLayout.setVisibility(View.VISIBLE);
        mInfoLayout.setVisibility(View.GONE);
    }

    // 회원 정보 수정 페이지로 이동
    public void InfoModifyBtnClicked(View view) {
        Intent intent = new Intent(this, MyPageModifyActivity.class);
        startActivity(intent);

        this.finish();

    }

    public class NetworkTask extends AsyncTask<Void, Void, String> {
        private String url;
        private ContentValues values;

        public NetworkTask(String url, ContentValues values) {
            this.url = url;
            this.values = values;
        }

        @Override
        protected String doInBackground(Void... params) {
            String result;
            RequestHttpConnection requestHttpConnection = new RequestHttpConnection();
            result = requestHttpConnection.request(url, values);

            return result;
        }

        @Override
        protected void onPostExecute(String json) {
            super.onPostExecute(json);

            try {
                JSONObject jsonObject = new JSONObject(json);
                JSONArray ListArray = jsonObject.getJSONArray("MemberList");
                JSONObject ListObject = ListArray.getJSONObject(0);

                // 이미지 넣기 추가하기
                tvInfoIntro.setText(ListObject.getString("member_intro"));
                tvInfoId.setText(ListObject.getString("email"));
                tvInfoName.setText(ListObject.getString("nickname"));
                tvInfoNum.setText(ListObject.getString("phonenumber"));
                tvInfoMajor.setText(ListObject.getString("interest_major"));
                tvInfoGroup.setText(ListObject.getString("interest_group"));
                tvInfoArea.setText(ListObject.getString("interest_area"));

            } catch (JSONException e) {
                e.printStackTrace();
            }

        }
    }

    // 뒤로 가기 이벤트
    @Override
    public void onBackPressed() {
        long tempTime = System.currentTimeMillis();
        long intervalTime = tempTime - backPressedTime;

        if (0 <= intervalTime && FINISH_INTERVAL_TIME >= intervalTime) {
            super.onBackPressed();
        } else {
            backPressedTime = tempTime;
            Toast.makeText(getApplicationContext(), "뒤로가기를 한번 더 누르면 종료됩니다.", Toast.LENGTH_SHORT).show();
        }
    }
}
