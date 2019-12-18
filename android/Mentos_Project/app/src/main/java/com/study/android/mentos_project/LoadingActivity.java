package com.study.android.mentos_project;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;
import android.widget.ImageView;

import com.bumptech.glide.Glide;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.firestore.FirebaseFirestore;
import com.google.firebase.firestore.FirebaseFirestoreSettings;
import com.study.android.mentos_project.LoginActivity;
import com.study.android.mentos_project.MainActivity;
import com.study.android.mentos_project.R;

public class LoadingActivity extends Activity {
    @Override
    public void onCreate(Bundle savedInstanceState){
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_loading);

        startLoading();


    }

    private void startLoading() {
        Handler handler = new Handler();
        handler.postDelayed(new Runnable() {
            @Override
            public void run(){


                FirebaseFirestore firestore = FirebaseFirestore.getInstance();
                FirebaseFirestoreSettings settings = new FirebaseFirestoreSettings.Builder()
                        .setTimestampsInSnapshotsEnabled(true)
                        .build();
                firestore.setFirestoreSettings(settings);

                new Handler().postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        Intent mainIntent = null;
                        if (FirebaseAuth.getInstance().getCurrentUser() == null) {
                            mainIntent = new Intent(LoadingActivity.this, LoginActivity.class);
                            overridePendingTransition(R.anim.fadein, R.anim.fadeout);


                        } else {
                            mainIntent = new Intent(LoadingActivity.this, MainActivity.class);
                            overridePendingTransition(R.anim.fadein, R.anim.fadeout);

                        }
                        LoadingActivity.this.startActivity(mainIntent);
                        overridePendingTransition(R.anim.fadein, R.anim.fadeout);
                        LoadingActivity.this.finish();
                    }
                },0);
            }
        }, 3000);
    }


}