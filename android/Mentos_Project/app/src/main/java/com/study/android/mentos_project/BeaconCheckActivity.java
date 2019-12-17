package com.study.android.mentos_project;

import android.content.ContentValues;
import android.content.Context;
import android.content.DialogInterface;
import android.net.Network;
import android.os.AsyncTask;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.DefaultItemAnimator;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.estimote.sdk.Beacon;
import com.estimote.sdk.BeaconManager;
import com.estimote.sdk.Region;
import com.estimote.sdk.SystemRequirementsChecker;
import com.kakao.network.NetworkTask;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

public class BeaconCheckActivity extends AppCompatActivity {
    private static final String TAG = "lecture";
    BeaconClassAdapter adapter;

    private BeaconManager beaconManager;
    private Region region;
    private boolean isConnected;
    private String today;
    private String net;

    LinearLayout beaconMainLayout;
    RecyclerView bClassRecycler;
    Button beaconConnectBtn;
    Button attendanceCheckBtn;

    LinearLayout beaconCheckLayout;
    TextView tvToday;
    TextView tvCheck;
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
        tvCheck = findViewById(R.id.TvCheck);
        checkBtn = findViewById(R.id.CheckBtn);
        returnBtn = findViewById(R.id.ReturnBtn);

        Date currentTime = Calendar.getInstance().getTime();
        today = new SimpleDateFormat("yyyy년 MM월 dd일 EE요일",
                Locale.getDefault()).format(currentTime);

        code = "";

        // 강좌 리스트
        adapter = new BeaconClassAdapter(this);

        String url = "http://192.168.219.110:8081/beaconAttendance?email=test@email.com";
        net = "list";

        NetworkTask networkTask = new NetworkTask(url, null);
        networkTask.execute();
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

            if (net.equals("list")) {
                try {
                    JSONObject jsonObject = new JSONObject(json);
                    JSONArray ListArray = jsonObject.getJSONArray("List");
                    ClassJoin [] classItems = new ClassJoin[ListArray.length()];

                    for (int i=0; i<ListArray.length(); i++) {

                        JSONObject ListObject = ListArray.getJSONObject(i);

                        classItems[i] = new ClassJoin(ListObject.getString("join_class_num"), ListObject.getString("class_name"), ListObject.getString("class_mento"),
                                                ListObject.getString("class_place"), ListObject.getString("class_startdate"), ListObject.getString("class_enddate"),
                                                ListObject.getString("class_starttime"), ListObject.getString("class_endtime"));

                        Log.d(TAG,  "확인 " + ListObject.getString("class_mento"));

                        adapter.addItem( classItems[i] );
                        bClassRecycler.setAdapter(adapter);
                        bClassRecycler.setLayoutManager(new LinearLayoutManager(getApplicationContext()));
                        bClassRecycler.setItemAnimator(new DefaultItemAnimator());
                    }

                } catch (JSONException e) {
                    e.printStackTrace();
                }


            } else if (net.equals("con")) {

            }

        }
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

            SimpleDateFormat time = new SimpleDateFormat("HH:mm");
            String timeCheck = time.format(new Date(System.currentTimeMillis()));
            tvCheck.setText("출석 시간 : " + timeCheck);

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
