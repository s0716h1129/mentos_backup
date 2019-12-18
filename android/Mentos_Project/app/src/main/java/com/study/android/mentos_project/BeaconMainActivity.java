package com.study.android.mentos_project;

import android.content.ContentValues;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.AsyncTask;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.DefaultItemAnimator;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.estimote.sdk.Beacon;
import com.estimote.sdk.BeaconManager;
import com.estimote.sdk.Region;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

public class BeaconMainActivity extends AppCompatActivity {
    private static final String TAG = "lecture";

    private final long FINISH_INTERVAL_TIME = 2000;
    private long   backPressedTime = 0;
    private String code;
    private String type;

    private String class_num;
    private String class_name;
    private String class_start_date;
    private String class_end_date;
    private String class_start_time;
    private String class_end_time;

    BeaconClassAdapter adapter;

    private BeaconManager beaconManager;
    private Region region;
    private boolean isConnected;

    LinearLayout beaconMainLayout;
    RecyclerView bClassRecycler;
    Button attendanceCheckBtn;

    LinearLayout beaconCheckLayout;
    TextView tvClass_name;
    TextView tvClass_date;
    TextView tvTime;
    Button checkBtn;
    Button BReturnMainBtn;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_beacon_main);

        beaconMainLayout = findViewById(R.id.BeaconMainLayout);
        bClassRecycler = findViewById(R.id.BClassRecycler);
        attendanceCheckBtn = findViewById(R.id.BeaconCheckBtn);

        beaconCheckLayout = findViewById(R.id.BeaconCheckLayout);
        tvClass_name = findViewById(R.id.TvClassName);
        tvClass_date = findViewById(R.id.TvTody);
        tvTime = findViewById(R.id.TvTime);
        checkBtn = findViewById(R.id.CheckBtn);
        BReturnMainBtn = findViewById(R.id.ReturnBtn);

        // 강좌 리스트
        adapter = new BeaconClassAdapter(this);

        isConnected = false;
        class_name = "";
        type = "list";

        String url = "http://192.168.219.110:8081/beaconAttendance?email=test@email.com";

        NetworkTask networkTask = new NetworkTask(url, null);
        networkTask.execute();
    }

    // 출석 체크 페이지로
    public void BeaconCheckBtn(View view) {
        if (class_name.equals("")) {
            Toast.makeText(getApplicationContext(), "강좌를 선택해주세요.", Toast.LENGTH_SHORT).show();
        } else {
            beaconMainLayout.setVisibility(View.GONE);
            beaconCheckLayout.setVisibility(View.VISIBLE);

            Date day = Calendar.getInstance().getTime();
            String date = new SimpleDateFormat("yyyy년 MM월 dd일 HH:mm", Locale.getDefault()).format(day);

            tvClass_name.setText("선택한 강좌 : " + class_name);
            tvClass_date.setText("현재 날짜 / 시간 : " + date);
            tvTime.setText("강좌 진행 시간 : " + class_start_time + " ~ " + class_end_time);
        }
    }

    // 출석 체크 하기
    public void CheckBtnClicked(View view) throws ParseException {
        if (isConnected == true) {
            DateFormat dFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date StartDate = dFormat.parse(class_start_date);
            Date EndDate = dFormat.parse(class_end_date);
            Date toDate = new Date();

            long date1 = toDate.getTime() - StartDate.getTime();
            long date2 = EndDate.getTime() - toDate.getTime();
            long sDate = date1 / (24*60*60*1000);
            long eDate = date2 / (24*60*60*1000);

            DateFormat tFormat = new SimpleDateFormat("HH:mm",Locale.KOREA);
            Date startTime = tFormat.parse(class_start_time);
            Date endTime = tFormat.parse(class_end_time);

            Date day = Calendar.getInstance().getTime();
            String nTime = new SimpleDateFormat("HH:mm", Locale.getDefault()).format(day);
            Date nowTime = tFormat.parse(nTime);

            long time1 = nowTime.getTime() - startTime.getTime();
            long time2 = endTime.getTime() - nowTime.getTime();
            long sTime = time1 / (60*1000);
            long eTime = time2 / (60*1000);

            Log.d(TAG, sTime + " " + eTime);

            String url = "http://192.168.219.110:8081/beaconCheck";
            url = url + "?"
                      + "email=test@email.com"
                      + "&class_num=" + class_num;

            if ((sDate >= 0) && (eDate >= 0)) {
                if (sTime < -30) {
                    Toast.makeText(getApplicationContext(), "출석 체크는 강좌 시작 30분 전부터 가능합니다.", Toast.LENGTH_SHORT).show();
                } else if ((sTime < 5) && (eTime >= 30)) {
                    url = url + "&attendance=y";
                    Log.d(TAG, "url : " + url);

                    type = "check";
                    NetworkTask networkTask = new NetworkTask(url, null);
                    networkTask.execute();

                    Toast.makeText(getApplicationContext(), "출석 체크 완료", Toast.LENGTH_SHORT).show();

                } else if ((sTime >= 5) && (eTime >= 30)) {
                    url = url + "&attendance=n";
                    Log.d(TAG, "url : " + url);

                    type = "check";
                    NetworkTask networkTask = new NetworkTask(url, null);
                    networkTask.execute();

                    Toast.makeText(getApplicationContext(), "지각 처리 되었습니다.", Toast.LENGTH_SHORT).show();

                } else if (eTime < 30) {
                    Toast.makeText(getApplicationContext(), "출석 체크 시간이 지났습니다.", Toast.LENGTH_SHORT).show();
                }


            } else {
                Toast.makeText(getApplicationContext(), "강좌 진행 기간이 아닙니다.", Toast.LENGTH_SHORT).show();
            }


        } else {
            Toast.makeText(getApplicationContext(), "비콘이 연결되지 않았습니다.", Toast.LENGTH_SHORT).show();
        }

    }

    // 강좌 선택으로 돌아가기
    public void ReturnBtnClicked(View view) {
        type = "list";

        adapter.notifyDataSetChanged();
        adapter.items.clear();
        Log.d(TAG, String.valueOf(adapter.getItemCount()));

        String url = "http://192.168.219.110:8081/beaconAttendance?email=test@email.com";

        NetworkTask networkTask = new NetworkTask(url, null);
        networkTask.execute();

        beaconMainLayout.setVisibility(View.VISIBLE);
        beaconCheckLayout.setVisibility(View.GONE);
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

            if (type.equals("list")) {
                try {
                    JSONObject jsonObject = new JSONObject(json);
                    JSONArray ListArray = jsonObject.getJSONArray("List");
                    ClassJoin[] classItems = new ClassJoin[ListArray.length()];

                    for (int i = 0; i < ListArray.length(); i++) {

                        JSONObject ListObject = ListArray.getJSONObject(i);

                        if (!(ListObject.getString("join_type").equals("like"))) {
                            classItems[i] = new ClassJoin(ListObject.getString("join_class_num"), ListObject.getString("class_name"), ListObject.getString("class_mento"),
                                    ListObject.getString("class_place"), ListObject.getString("class_startdate"), ListObject.getString("class_enddate"),
                                    ListObject.getString("class_starttime"), ListObject.getString("class_endtime"));
                            Log.d(TAG, "확인 " + ListObject.getString("class_mento"));

                            adapter.addItem(classItems[i]);
                            bClassRecycler.setAdapter(adapter);
                            bClassRecycler.setLayoutManager(new LinearLayoutManager(getApplicationContext()));
                            bClassRecycler.setItemAnimator(new DefaultItemAnimator());
                        }

                        adapter.setItemClick(new BeaconClassAdapter.ItemClick() {
                            @Override
                            public void onClick(View view, int position) {
                                final ClassJoin item = (ClassJoin) adapter.getItem(position);

                                AlertDialog.Builder dialog = new AlertDialog.Builder(BeaconMainActivity.this);
                                dialog.setTitle(item.getClass_name())
                                        .setMessage("해당 강좌의 비콘을 연결합니다.")
                                        .setPositiveButton("연결", new DialogInterface.OnClickListener() {
                                            @Override
                                            public void onClick(DialogInterface dialog, int which) {
                                                BeaconConnect();

                                                class_num = item.getJoin_class_num();
                                                class_name = item.getClass_name();
                                                class_start_date = item.getClass_startdate();
                                                class_end_date = item.getClass_enddate();
                                                class_start_time = item.getClass_starttime();
                                                class_end_time = item.getClass_endtime();

                                                Log.d(TAG, class_end_time + " " + class_start_time);
                                            }
                                        })
                                        .setNegativeButton("취소", new DialogInterface.OnClickListener() {
                                            @Override
                                            public void onClick(DialogInterface dialog, int which) {

                                            }
                                        })
                                        .create().show();
                            }
                        });

                    }

                } catch (JSONException e) {
                    e.printStackTrace();
                }
            } else if (type.equals("check")) {
                try {
                    Log.d(TAG, "type : " + type);

                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

        }
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
                        AlertDialog.Builder dialog = new AlertDialog.Builder(BeaconMainActivity.this);
                        dialog.setTitle("알림")
                                .setMessage("비콘 연결 되었습니다.")
                                .setPositiveButton("확인", new DialogInterface.OnClickListener() {
                                    @Override
                                    public void onClick(DialogInterface dialog, int which) {
                                    }
                                })
                                .create().show();

                    } else if (isConnected && metter >= 7) {
                        isConnected = false;
                    } else {

                    }
                }
            }
        });
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
