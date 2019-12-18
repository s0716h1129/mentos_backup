package com.study.android.mentos_project;

import android.content.ContentValues;
import android.content.Intent;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.DefaultItemAnimator;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class MyPageClassActivity extends AppCompatActivity {
    private static final String TAG = "lecture";
    BeaconClassAdapter adapter1;
    BeaconClassAdapter adapter2;

    // memberClass
    LinearLayout memberClassLayout;
    RecyclerView likeClassRecycler;
    RecyclerView attendClassRecycler;
    Button cReturnMainBtn;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_my_page_class);

        // memberClass
        memberClassLayout = findViewById(R.id.MemberClassLayout);
        likeClassRecycler = findViewById(R.id.LikeClassRecycler);
        attendClassRecycler = findViewById(R.id.AttendClassRecycler);
        cReturnMainBtn = findViewById(R.id.CReturnMainBtn);

        adapter1 = new BeaconClassAdapter(this);
        adapter2 = new BeaconClassAdapter(this);

        String url = "http://192.168.219.110:8081/mypage/aMemberClass?email=test@email.com";

        NetworkTask networkTask = new NetworkTask(url, null);
        networkTask.execute();
    }

    // 메인으로 돌아가기
    public void CReturnMainBtnClicked(View v) {
        Intent intent = new Intent(this, MyPageMainActivity.class);
        startActivity(intent);

        this.finish();
    }

    @Override
    public void onBackPressed() {
        Intent intent = new Intent(this, MyPageMainActivity.class);
        startActivity(intent);
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
                JSONObject jsonObject1 = new JSONObject(json);
                JSONArray ListArray1 = jsonObject1.getJSONArray("attendList");

                ClassJoin [] attendItems = new ClassJoin[ListArray1.length()];
                ClassJoin [] likeItems = new ClassJoin[ListArray1.length()];

                for (int i=0; i<ListArray1.length(); i++) {
                    JSONObject ListObject1 = jsonObject1.getJSONArray("attendList").getJSONObject(i);

                    if (ListObject1.getString("join_type").equals("like")) {
                        likeItems[i] = new ClassJoin(ListObject1.getString("join_class_num"), ListObject1.getString("class_name"), ListObject1.getString("class_mento"),
                                ListObject1.getString("class_place"), ListObject1.getString("class_startdate"), ListObject1.getString("class_enddate"),
                                ListObject1.getString("class_starttime"), ListObject1.getString("class_endtime"));

                        Log.d(TAG, "1");
                        adapter2.addItem( likeItems[i] );
                        likeClassRecycler.setAdapter(adapter2);
                        likeClassRecycler.setLayoutManager(new LinearLayoutManager(getApplicationContext()));
                        likeClassRecycler.setItemAnimator(new DefaultItemAnimator());
                    } else {
                        attendItems[i] = new ClassJoin(ListObject1.getString("join_class_num"), ListObject1.getString("class_name"), ListObject1.getString("class_mento"),
                                ListObject1.getString("class_place"), ListObject1.getString("class_startdate"), ListObject1.getString("class_enddate"),
                                ListObject1.getString("class_starttime"), ListObject1.getString("class_endtime"));

                        Log.d(TAG, "2");
                        adapter1.addItem( attendItems[i] );
                        attendClassRecycler.setAdapter(adapter1);
                        attendClassRecycler.setLayoutManager(new LinearLayoutManager(getApplicationContext()));
                        attendClassRecycler.setItemAnimator(new DefaultItemAnimator());
                    }

                }

            } catch (JSONException e) {
                e.printStackTrace();
            }

        }
    }
}
