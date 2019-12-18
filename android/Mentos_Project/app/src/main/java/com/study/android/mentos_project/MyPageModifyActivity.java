package com.study.android.mentos_project;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.Toast;

public class MyPageModifyActivity extends AppCompatActivity {
    private final long FINISH_INTERVAL_TIME = 2000;
    private long backPressedTime = 0;

    // modify
    LinearLayout modifyLayout;
    EditText edMIntro;
    Button modifyBtn;
    Button modifyCancelBtn;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_my_page_modify);

        // modify
        modifyLayout = findViewById(R.id.ModifyLayout);
        modifyBtn = findViewById(R.id.ModifyBtn);
        modifyCancelBtn = findViewById(R.id.ModifyCancelBtn);
    }

    // 수정 완료 버튼
    public void ModifyBtnClicked(View v) {

    }

    // 수정 취소 버튼
    public void ModifyCancelBtnClicked(View v) {
        Intent intent = new Intent(this, MyPageMainActivity.class);
        startActivity(intent);

        this.finish();
    }

    @Override
    public void onBackPressed() {
        long tempTime = System.currentTimeMillis();
        long intervalTime = tempTime - backPressedTime;

        if (0 <= intervalTime && FINISH_INTERVAL_TIME >= intervalTime) {
            Intent intent = new Intent(this, MyPageMainActivity.class);
            startActivity(intent);

            this.finish();
        } else {
            backPressedTime = tempTime;
            Toast.makeText(getApplicationContext(), "뒤로가기를 한번 더 누르면 메인으로 돌아갑니다.", Toast.LENGTH_SHORT).show();
        }
    }
}
