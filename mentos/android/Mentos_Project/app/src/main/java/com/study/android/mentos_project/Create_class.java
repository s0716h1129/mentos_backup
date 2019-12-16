package com.study.android.mentos_project;

import android.app.DatePickerDialog;
import android.app.TimePickerDialog;
import android.content.ContentValues;
import android.content.Intent;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.TimePicker;
import android.widget.Toast;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;

import org.w3c.dom.Text;

import java.util.Calendar;
import java.util.Date;


// 강좌개설

public class Create_class extends AppCompatActivity {


    private static final String TAG ="lecture";


    FirebaseAuth firebaseAuth;
    FirebaseUser firebaseUser;


    TextView classname,date1,date2,Loginname;

    Spinner yearSpinner;

    Button btn_create;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_create_class);

        Intent intent = getIntent();
        Loginname = (TextView)findViewById(R.id.LoginName);

        firebaseAuth = FirebaseAuth.getInstance();
        firebaseUser = firebaseAuth.getCurrentUser();

        final Calendar cal = Calendar.getInstance();


                // Spinner 카테고리
                yearSpinner = (Spinner) findViewById(R.id.category);
                ArrayAdapter yearAdapter = ArrayAdapter.createFromResource(this,
                        R.array.category, android.R.layout.simple_spinner_item);
                yearAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
                yearSpinner.setAdapter(yearAdapter);
                String category = yearSpinner.getSelectedItem().toString();


//                Log.d(TAG,category);


        classname = (EditText)findViewById(R.id.class_name);


        Log.d(TAG,"강좌 개설 엑티비티에서 받은 유저 이메일 : " + firebaseUser.getEmail());


        date1 = (TextView) findViewById(R.id.date1);
        date1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                DatePickerDialog dialog = new DatePickerDialog(Create_class.this, new DatePickerDialog.OnDateSetListener() {
                    @Override
                    public void onDateSet(DatePicker datePicker, int year, int month, int date) {

                        String msg = String.format("%d 년 %d 월 %d 일", year, month + 1, date);
                        Toast.makeText(Create_class.this, msg, Toast.LENGTH_SHORT).show();

                        date1.setText(year + "년" + (month + 1) + "월" + date + "일");

                    }
                }, cal.get(Calendar.YEAR), cal.get(Calendar.MONTH), cal.get(Calendar.DATE));

//                dialog.getDatePicker().setMaxDate(new Date().getTime());    //입력한 날짜 이후로 클릭 안되게 옵션
                dialog.show();


            }

        });

        date2 = (TextView) findViewById(R.id.date2);
        date2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                DatePickerDialog dialog = new DatePickerDialog(Create_class.this, new DatePickerDialog.OnDateSetListener() {
                    @Override
                    public void onDateSet(DatePicker datePicker, int year, int month, int date) {

                        String msg = String.format("%d 년 %d 월 %d 일", year, month + 1, date);
//                        Toast.makeText(Create_class.this, msg, Toast.LENGTH_SHORT).show();

                        date2.setText(year + "년" + (month + 1) + "월" + date + "일");

                    }
                }, cal.get(Calendar.YEAR), cal.get(Calendar.MONTH), cal.get(Calendar.DATE));

//                dialog.getDatePicker().setMaxDate(new Date().getTime());    //입력한 날짜 이후로 클릭 안되게 옵션
                dialog.show();


            }

        });

        btn_create = (Button) findViewById(R.id.btn_create);
        btn_create.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                String url = "http://192.168.219.135:8081/class/AndClassCreate";

                String class_mento = firebaseUser.getEmail();
                String class_name = classname.getText().toString();
                String category = yearSpinner.getSelectedItem().toString();
                String opendate = date1.getText().toString();
                String closedate = date2.getText().toString();


                url = url + "?"
                        + "CLASS_NAME=" + class_name
                        + "&CLASS_CATEGORY=" + category
                        + "&CLASS_RECEIVESTARTDATE=" + opendate
                        + "&CLASS_RECEIVEENDDATE=" + closedate
                        + "&CLASS_MENTO=" + class_mento;

                Log.d(TAG,class_name+"/"+category+"/"+opendate+"/"+closedate+"");
                Log.d(TAG,url);

                // AsyncTask를 통해 HttpURLConnection 수행.
                Create_class.NetworkTask networkTask = new Create_class.NetworkTask(url, null);
                networkTask.execute();


                Intent intent = new Intent(Create_class.this,MainActivity.class);
                startActivity(intent);

            }
        });

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

            //doInBackground()로 부터 리턴된 값이 onPostExecute()의 매개변수로 넘어오므로 s를 출력한다.
//            tv_outPut.setText(s);
        }
    }
}
