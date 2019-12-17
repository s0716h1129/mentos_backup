package com.study.android.mentos_project;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;

// 메인 프레그먼트
// 하단 탭 왼쪽 페이지


public class Main1Fragment extends Fragment {


    private static final String TAG ="lecture";

    Button create;

    FirebaseAuth firebaseAuth;
    FirebaseUser firebaseUser;




    @Override
    public void onCreate(Bundle savedInstanceState){
        super.onCreate(savedInstanceState);

    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {

        View view = (View) inflater.inflate(R.layout.fragment_main1, null);


        // 로그인

        firebaseAuth = FirebaseAuth.getInstance();
        firebaseUser = firebaseAuth.getCurrentUser();

//        String loginname = getArguments().getString("userName"); // 전달한 key 값
//        Log.d(TAG,"메인 엑티비티에서 받은 유저 이름떠라아아아아 : " + loginname);


        Log.d(TAG,"메인 엑티비티에서 받은 유저 이메일 : " + firebaseUser.getEmail());


        create = view.findViewById(R.id.btn_classCreate);
        create.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {



                Intent intent = new Intent(getActivity(),Create_class.class);
                intent.putExtra("userEmail",firebaseUser.getEmail());
                startActivity(intent);
            }
        });


        return view;


    }
}

