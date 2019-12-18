package com.study.android.mentos_project;

import android.content.DialogInterface;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;

import com.estimote.sdk.Beacon;
import com.estimote.sdk.BeaconManager;
import com.estimote.sdk.Region;

import java.util.List;
import java.util.UUID;

public class BeaconCheckActivity extends AppCompatActivity {
    private static final String TAG = "lecture";

    private final long FINISH_INTERVAL_TIME = 2000;
    private long   backPressedTime = 0;

    private BeaconManager beaconManager;
    private Region region;
    private boolean isConnected;

    private String code;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_beacon_check);
    }


    // 비콘 연결
    public void BeaconConnect() {
        code = "FDA50693-A4E2-4FB1-AFCF-C6EB07647821";  // 나중에 코드 받는걸로 코드 변경하기

        Log.d(TAG, "code : " + code);

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

    // 비콘 거리에 따른 연결 상태
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

                    if (!isConnected && metter < 7) {
                        isConnected = true;
                        AlertDialog.Builder dialog = new AlertDialog.Builder(BeaconCheckActivity.this);
                        dialog.setTitle("알림")
                                .setMessage("비콘 연결 되었습니다.")
                                .setPositiveButton("확인", new DialogInterface.OnClickListener() {
                                    @Override
                                    public void onClick(DialogInterface dialog, int which) {
                                    }
                                })
                                .create().show();

                    } else if (isConnected && metter >= 7) {
                        AlertDialog.Builder dialog = new AlertDialog.Builder(BeaconCheckActivity.this);
                        dialog.setTitle("알림")
                                .setMessage("비콘 연결이 끊겼습니다.")
                                .setPositiveButton("확인", new DialogInterface.OnClickListener() {
                                    @Override
                                    public void onClick(DialogInterface dialog, int which) {

                                    }
                                })
                                .create().show();
                        isConnected = false;
                    } else {

                    }
                }
            }
        });
    }
}
