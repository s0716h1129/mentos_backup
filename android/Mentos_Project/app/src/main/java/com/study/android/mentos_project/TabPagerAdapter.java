package com.study.android.mentos_project;

import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentStatePagerAdapter;


// 메인 하단 탭바 어뎁터

public class TabPagerAdapter extends FragmentStatePagerAdapter {

    // Count number of tabs
    private int tabCount;

    public TabPagerAdapter(FragmentManager fm, int tabCount) {
        super(fm);
        this.tabCount = tabCount;
    }

    @Override
    public Fragment getItem(int position) {

        // Returning the current tabs
        switch (position) {
            case 0:
                Main1Fragment tabFragment1 = new Main1Fragment();
                return tabFragment1;
            case 1:
                Main2Fragment tabFragment2 = new Main2Fragment();
                return tabFragment2;
            case 2:
                Main3Fragment tabFragment3 = new Main3Fragment();
                return tabFragment3;
            default:
                return null;
        }
    }

    @Override
    public int getCount() {
        return tabCount;
    }
}
