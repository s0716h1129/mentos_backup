package com.study.android.mentos_project;

import android.content.ContentValues;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.AsyncTask;
import android.support.annotation.NonNull;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.Gravity;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;

import java.util.ArrayList;


// 회원가입

public class RegisterActivity extends AppCompatActivity {


    private static final String TAG ="lecture";

    Button registerBtn;
    EditText pwet,emailet,nameet,pnumet;
    TextView Select_field;


    FirebaseAuth firebaseAuth;

    ArrayAdapter<CharSequence> adspin1, adspin2; //어댑터를 선언했습니다. adspint1(서울,인천..) adspin2(강남구,강서구..)
    String choice_do="";
    String choice_se="";

    final int DIALOG_MULTICHOICE = 4; // 다이얼로그용 ID

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_register);

        android.support.v7.widget.Toolbar toolbar = (android.support.v7.widget.Toolbar)findViewById(R.id.nav_action);
        setSupportActionBar(toolbar);
        getSupportActionBar().setDisplayShowHomeEnabled(true);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        getSupportActionBar().setDisplayShowTitleEnabled(false);

        firebaseAuth = FirebaseAuth.getInstance();

        setTitle("ORACLE");

        emailet = (EditText)findViewById(R.id.register_email);
        registerBtn = (Button)findViewById(R.id.register_btn);
        pwet = (EditText)findViewById(R.id.register_pw);
        nameet = (EditText)findViewById(R.id.register_name);
        pnumet = (EditText)findViewById(R.id.register_phonenumber);

//        final Spinner spin1 = (Spinner)findViewById(R.id.spinner1);
//        final Spinner spin2 = (Spinner)findViewById(R.id.spinner2);
//        Button btn_refresh = (Button)findViewById(R.id.btn_refresh);


        registerBtn.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {

                firebaseAuth.createUserWithEmailAndPassword(emailet.getText().toString(),pwet.getText().toString())
                        .addOnCompleteListener(new OnCompleteListener<AuthResult>() {
                            @Override
                            public void onComplete(@NonNull Task<AuthResult> task) {

                                if(task.isSuccessful()){

                                    firebaseAuth.getCurrentUser().sendEmailVerification().addOnCompleteListener(new OnCompleteListener<Void>() {
                                        @Override
                                        public void onComplete(@NonNull Task<Void> task) {

                                            if(task.isSuccessful()){

                                                Toast.makeText(RegisterActivity.this,"회원가입 성공",Toast.LENGTH_LONG).show();
                                                Intent intent = new Intent(RegisterActivity.this,LoginActivity.class);
                                                startActivity(intent);

                                                    // URL 설정.
                                                    String url = "http://192.168.219.135:8081/main/Andjoin";
                                                    String email = emailet.getText().toString();
                                                    String pw = pwet.getText().toString();
                                                    String name = nameet.getText().toString();
                                                    String pnumber = pnumet.getText().toString();
//                                                    choice_do = spin1.getSelectedItem().toString();
//                                                    choice_se = spin2.getSelectedItem().toString();
//                                                    String field = Select_field.getText().toString();

                                                    url = url + "?"
                                                              + "email=" + email
                                                              + "&password=" + pw
                                                              + "&nickname=" + name
                                                              + "&phonenumber=" + pnumber
                                                              + "&MEMBER_IMAGE=aaaaaa";


                                                       Log.d(TAG,email+"/"+pw+"/"+name+"/"+pnumber);
                                                       Log.d(TAG,url);

                                                    // AsyncTask를 통해 HttpURLConnection 수행.
                                                    NetworkTask networkTask = new NetworkTask(url, null);
                                                    networkTask.execute();


                                            } else{
                                                Toast.makeText(RegisterActivity.this,task.getException().getMessage(),Toast.LENGTH_LONG).show();
                                            }

                                        }

                                    });

                                }else{
                                    Toast.makeText(RegisterActivity.this,task.getException().getMessage(),
                                            Toast.LENGTH_LONG).show();
                                }
                            }
                        });

            }
        });





//        // 시,군,구 정하는
//
//        adspin1 = ArrayAdapter.createFromResource(this, R.array.spinner_do, android.R.layout.simple_spinner_dropdown_item);
//        adspin1.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
//        spin1.setAdapter(adspin1);
//        spin1.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
//
//            @Override
//            public void onItemSelected(AdapterView<?> adapterView, View view, int i, long l) {
//
//                if (adspin1.getItem(i).equals("서울")) {
//
//                    choice_do = "서울";//버튼 클릭시 출력을 위해 값을 넣었습니다.
//
//                    adspin2 = ArrayAdapter.createFromResource(RegisterActivity.this, R.array.spinner_do_seoul, android.R.layout.simple_spinner_dropdown_item);
//
//                    adspin2.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
//
//                    spin2.setAdapter(adspin2);
//                    spin2.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
//
//                        @Override
//                        public void onItemSelected(AdapterView<?> adapterView, View view, int i, long l) {
//                            choice_se = adspin2.getItem(i).toString();
//                        }
//
//                        @Override
//                        public void onNothingSelected(AdapterView<?> adapterView) {
//                        }
//                    });
//                } else if (adspin1.getItem(i).equals("인천")) {
//                    choice_do = "인천";
//                    adspin2 = ArrayAdapter.createFromResource(RegisterActivity.this, R.array.spinner_do_incheon, android.R.layout.simple_spinner_dropdown_item);
//                    adspin2.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
//                    spin2.setAdapter(adspin2);
//                    spin2.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
//                        @Override
//                        public void onItemSelected(AdapterView<?> adapterView, View view, int i, long l) {
//                            choice_se = adspin2.getItem(i).toString();
//                        }
//
//                        @Override
//                        public void onNothingSelected(AdapterView<?> adapterView) {
//                        }
//                    });
//                }
//            }
//
//            @Override
//            public void onNothingSelected(AdapterView<?> adapterView) {
//
//            }
//        });
//
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


            Log.d(TAG,"웹에서 받기 테스트 " + result);

            return result;
        }

        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);





            //doInBackground()로 부터 리턴된 값이 onPostExecute()의 매개변수로 넘어오므로 s를 출력한다.
//            tv_outPut.setText(s);
        }
    }



//    public void OnClickHandler(View view)
//    {
//        AlertDialog.Builder builder = new AlertDialog.Builder(this);
//        final ArrayList<String> selectedItems = new ArrayList<String>();
//        final String[] items = getResources().getStringArray(R.array.LAN);
//
//        builder.setTitle("리스트 추가 예제");
//
//        builder.setMultiChoiceItems(R.array.LAN, null, new DialogInterface.OnMultiChoiceClickListener(){
//            @Override
//            public void onClick(DialogInterface dialog, int pos, boolean isChecked)
//            {
//                if(isChecked == true) // Checked 상태일 때 추가
//                {
//                    selectedItems.add(items[pos]);
//                }
//                else				  // Check 해제 되었을 때 제거
//                {
//                    selectedItems.remove(pos);
//                }
//            }
//        });
//
//        builder.setPositiveButton("OK", new DialogInterface.OnClickListener(){
//            @Override
//            public void onClick(DialogInterface dialog, int pos)
//            {
//                String SeletedItemsString = "";
//
//                for(int i =0; i<selectedItems.size();i++)
//                {
//                    SeletedItemsString = SeletedItemsString + "," + selectedItems.get(i);
//                }
//
//                Select_field = (TextView)findViewById(R.id.select_field);
//                Select_field.setText(SeletedItemsString);
//
//                Toast toast = Toast.makeText(getApplicationContext(), "선택 된 항목은 : " + SeletedItemsString,Toast.LENGTH_LONG);
//                toast.setGravity(Gravity.CENTER, 0, 0);
//                toast.show();
//            }
//        });
//
//        AlertDialog alertDialog = builder.create();
//        alertDialog.show();
//    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {


        if(item.getItemId()==android.R.id.home){
            finish();
        }

        return super.onOptionsItemSelected(item);
    }

}
