package com.study.android.mentos_project;

import android.content.ContentValues;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.design.widget.TabLayout;
import android.support.v4.app.Fragment;
import android.support.v4.view.ViewPager;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBarDrawerToggle;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;


// 메인 액티비티
// 위에 프레그먼트 얹혀있음
// 사이드바 목록들은 리스트 말고 버튼으로 만들어놔서
// 사이드바 수정사항 있으시면 서기남한테 말씀해주세용

public class MainActivity extends AppCompatActivity {

    private static final String TAG = "lecture";

    private TabLayout tabLayout;
    private ViewPager viewPager;

    // 사이드
    private Toolbar mToolbar;

    private DrawerLayout mDrawerLayout;
    private ActionBarDrawerToggle mToggle;


    TextView userEmail, name,Loginname;
    Button userLogout;

    FirebaseAuth firebaseAuth;
    FirebaseUser firebaseUser;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);


        // 로그인
        name = findViewById(R.id.userName);
        userLogout = findViewById(R.id.btnLogout);

        Loginname = findViewById(R.id.loginName);

        firebaseAuth = FirebaseAuth.getInstance();
        firebaseUser = firebaseAuth.getCurrentUser();

//        userEmail.setText(firebaseUser.getEmail() + "님");
        name.setText(firebaseUser.getEmail() + "님");

        userLogout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                FirebaseAuth.getInstance().signOut();
                Intent intent = new Intent(MainActivity.this, LoginActivity.class);
                intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK);
                startActivity(intent);
                overridePendingTransition(R.anim.fadein, R.anim.fadeout);
            }
        });

        //툴바
        mToolbar = (Toolbar) findViewById(R.id.nav_action);
        setSupportActionBar(mToolbar);
        getSupportActionBar().setDisplayShowTitleEnabled(false); // 툴바 타이틀


        // 사이드바
        mDrawerLayout = (DrawerLayout) findViewById(R.id.drawerLayout);
        mToggle = new ActionBarDrawerToggle(this, mDrawerLayout, R.string.open, R.string.close);

        mDrawerLayout.addDrawerListener(mToggle);
        mToggle.syncState();
        getSupportActionBar().setDisplayHomeAsUpEnabled(true); // 햄버거 버튼 on/off


        // Initializing the TabLayout
        tabLayout = (TabLayout) findViewById(R.id.tabLayout);
        tabLayout.addTab(tabLayout.newTab().setText("Tab One"));
        tabLayout.addTab(tabLayout.newTab().setText("Tab Two"));
        tabLayout.addTab(tabLayout.newTab().setText("Tab Three"));
        tabLayout.setTabGravity(TabLayout.GRAVITY_FILL);

        // Initializing ViewPager
        viewPager = (ViewPager) findViewById(R.id.pager);

        // Creating TabPagerAdapter adapter
        TabPagerAdapter pagerAdapter = new TabPagerAdapter(getSupportFragmentManager(), tabLayout.getTabCount());
        viewPager.setAdapter(pagerAdapter);
        viewPager.addOnPageChangeListener(new TabLayout.TabLayoutOnPageChangeListener(tabLayout));

        // Set TabSelectedListener
        tabLayout.addOnTabSelectedListener(new TabLayout.OnTabSelectedListener() {

            @Override
            public void onTabSelected(TabLayout.Tab tab) {
                viewPager.setCurrentItem(tab.getPosition());
            }

            @Override
            public void onTabUnselected(TabLayout.Tab tab) {

            }

            @Override
            public void onTabReselected(TabLayout.Tab tab) {

            }
        });

        String url = "http://192.168.219.135:8081/main/Login_name";
        String msg = "?Email=" + firebaseUser.getEmail();
        String url1 = url + msg;

        Log.d(TAG, "main"+url1);

        MainActivity.NetworkTask networkTask = new MainActivity.NetworkTask(url1, null);
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

            String result; // 요청 결과를 저장할 변수.
            RequestHttpConnection requestHttpURLConnection = new RequestHttpConnection();
            result = requestHttpURLConnection.request(url, values); // 해당 URL로 부터 결과물을 얻어온다.

            return result;
        }

        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);

            try {

//                JSONObject jsonObject = new JSONObject(s);
//                JSONArray ListArray = jsonObject.getJSONArray("List");
//                Log.d("lecture", "리스트 갯수  " + String.valueOf(ListArray.length()));
//
//                for (int i = 0; i < ListArray.length(); i++) {
//                    JSONObject ListObject = ListArray.getJSONObject(i);
//                    Log.d("오라클에서 받아 온 name : ",  ListObject.getString("loginName"));
//                   // ListObject.getString("loginName");
//                }


                if (s != null) {
                    Log.d("s : ",s);
                    JSONObject json = new JSONObject(s);

                    Log.d(TAG,"오라클에서 받아 온 name : " + json.getString("loginName"));

                    Loginname.setText(json.getString("loginName"));

                    String loginname = Loginname.getText().toString();

                    Log.d(TAG,"테스트으 " + loginname);



//                    Intent intent = new Intent(MainActivity.this, Create_class.class);
//                    intent.putExtra("userEmail",loginname);


                }
                else{

                    Log.d(TAG , "에라라라라");
                }



            } catch (JSONException e) {
                Log.d("eeeeeeettext", "");
                e.printStackTrace();
            }


            //doInBackground()로 부터 리턴된 값이 onPostExecute()의 매개변수로 넘어오므로 s를 출력한다.
//            tv_outPut.setText(s);
        }
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.sidebar, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {

        if (mToggle.onOptionsItemSelected(item)) {
            return true;
        }

        return super.onOptionsItemSelected(item);

    }

    // 뒤로가기 종료
    @Override
    public void onBackPressed() {

        AlertDialog.Builder alBuilder = new AlertDialog.Builder(this);
        alBuilder.setMessage("어플을 종료하시겠습니까?");

        alBuilder.setNegativeButton("예", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                finishAffinity();
            }
        });

        alBuilder.setPositiveButton("아니오", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                return;
            }
        });
        alBuilder.setTitle("프로그램 종료");
        alBuilder.show();
    }

}
