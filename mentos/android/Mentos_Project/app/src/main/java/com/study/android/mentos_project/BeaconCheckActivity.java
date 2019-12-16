package com.study.android.mentos_project;

import android.content.DialogInterface;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.estimote.sdk.Beacon;
import com.estimote.sdk.BeaconManager;
import com.estimote.sdk.Region;
import com.estimote.sdk.SystemRequirementsChecker;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

public class BeaconCheckActivity extends AppCompatActivity {

    private BeaconManager beaconManager;
    private Region region;
    private boolean isConnected;

    LinearLayout beaconMainLayout;
    RecyclerView bClassRecycler;
    Button beaconConnectBtn;
    Button attendanceCheckBtn;

    LinearLayout beaconCheckLayout;
    TextView tvToday;
    Button checkBtn;
    Button returnBtn;

    private String code;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_beacon_check);

        beaconMainLayout = findViewById(R.id.BeaconMainLayout);
        bClassRecycler = findViewById(R.id.BClassRecycler);
        beaconConnectBtn = findViewById(R.id.BeaconConnectBtn);
        attendanceCheckBtn = findViewById(R.id.BeaconCheckBtn);

        beaconCheckLayout = findViewById(R.id.BeaconCheckLayout);
        tvToday = findViewById(R.id.TvTody);
        checkBtn = findViewById(R.id.CheckBtn);
        returnBtn = findViewById(R.id.ReturnBtn);

        code = "";

        // 강좌 리스트에 띄우는거 추가하기

    }

    // 비콘 연결
    public void BeaconConnectBtn(View view) {
        SystemRequirementsChecker.checkWithDefaultDialogs(BeaconCheckActivity.this);

        code = "FDA50693-A4E2-4FB1-AFCF-C6EB07647825";  // 나중에 코드 받는걸로 코드 변경하기

        // 비콘 매니저
        beaconManager = new BeaconManager(getApplicationContext());
        region = new Region("ranged region",
                UUID.fromString(code), null, null);

        beaconManager.connect(new BeaconManager.ServiceReadyCallback() {
            @Override
            public void onServiceReady() {
                startRangingListener();
            }
        });
    }

    // 출석 체크 페이지로
    public void BeaconCheckBtn(View view) {
        beaconMainLayout.setVisibility(View.GONE);
        beaconCheckLayout.setVisibility(View.VISIBLE);

        Date currentTime = Calendar.getInstance().getTime();
        String today = new SimpleDateFormat("yyyy년 MM월 dd일 EE요일",
                Locale.getDefault()).format(currentTime);

        tvToday.setText(today);
    }

    // 출석 체크하기
    public void CheckBtnClicked(View view) {
        if (isConnected == true) {

            // 데베로 출석체크 보내기 추가하기

            AlertDialog.Builder dialog = new AlertDialog.Builder(BeaconCheckActivity.this);
            dialog.setTitle("알림")
                    .setMessage("출석 체크 되었습니다.")
                    .setPositiveButton("확인", new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {

                        }
                    })
                    .create().show();
        } else if (isConnected == false) {
            AlertDialog.Builder dialog = new AlertDialog.Builder(BeaconCheckActivity.this);
            dialog.setTitle("알림")
                    .setMessage("비콘이 연결되있지 않습니다.")
                    .setPositiveButton("확인", new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {

                        }
                    })
                    .create().show();
        }
    }

    // 비콘 연결 화면으로 돌아가기
    public void ReturnBtnClicked(View view) {
        beaconMainLayout.setVisibility(View.VISIBLE);
        beaconCheckLayout.setVisibility(View.GONE);
    }

    @Override
    public void onPause() {
        super.onPause();
        beaconManager.disconnect();
    }


    public void startRangingListener() {

        beaconManager.startRanging(region);

        beaconManager.setRangingListener(new BeaconManager.RangingListener() {
            @Override
            public void onBeaconsDiscovered(final Region region, List list) {
                if (!list.isEmpty()) {
                    Beacon nearestBeacon = (Beacon) list.get(0);
                    double ratio = nearestBeacon.getRssi() * 1.0 / nearestBeacon.getMeasuredPower();
                    // accureacy = 원래 측정 거리
                    double accuracy = (0.89976) * Math.pow(ratio, 7.7095) + 0.111;
                    // metter2 = 텍스트뷰 보이기 위한 용도
                    String metter2 = String.valueOf(accuracy).substring(0, 4);
                    // metter = 수신강도 재기위한 용도
                    int metter = (int) accuracy;


                    //거리가 5미터 이상일때 알림창을 띄운다
                    if (!isConnected && metter < 7) {
                        isConnected = true;

                        AlertDialog.Builder dialog = new AlertDialog.Builder(BeaconCheckActivity.this);
                        dialog.setTitle("알림")
                                .setMessage("비콘이 연결되었습니다")
                                .setPositiveButton("확인", new DialogInterface.OnClickListener() {
                                    @Override
                                    public void onClick(DialogInterface dialog, int which) {

                                    }
                                })
                                .create().show();
                    } else if (isConnected && metter >= 7) {

                        Toast.makeText(getApplicationContext(),
                                "연결이 끊어졌습니다",
                                Toast.LENGTH_SHORT).show();
                        isConnected = false;
                    }
                }
            }
        });
    }
}
