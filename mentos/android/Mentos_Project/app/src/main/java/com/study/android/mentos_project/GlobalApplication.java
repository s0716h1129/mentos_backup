package com.study.android.mentos_project;
import android.app.Activity;
import android.app.Application;
import android.util.Log;

import com.kakao.auth.KakaoSDK;

// 카카오페이 결제

public class GlobalApplication extends Application {

    private static GlobalApplication mInstance;
    private static volatile Activity currentActivity = null;

    public static Activity getCurrentActivity() {
        Log.d("TAG", "++ currentActivity : " + (currentActivity != null ? currentActivity.getClass().getSimpleName() : ""));
        return currentActivity;
    }

    public static void setCurrentActivity(Activity currentActivity) {
        GlobalApplication.currentActivity = currentActivity;
    }

    public static GlobalApplication getGlobalApplicationContext() {
        if(mInstance == null)
            throw new IllegalStateException("this application does not inherit GlobalApplication");
        return mInstance;
    }

    @Override
    public void onCreate() {
        super.onCreate();
        mInstance = this;
        KakaoSDK.init(new KakaoSDKAdapter());
    }
}