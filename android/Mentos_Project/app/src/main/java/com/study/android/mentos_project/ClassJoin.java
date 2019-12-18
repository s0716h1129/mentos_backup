package com.study.android.mentos_project;

public class ClassJoin {
    private String join_class_num;
    private String class_name;
    private String class_mento;
    private String class_place;
    private String class_startdate;
    private String class_enddate;
    private String class_starttime;
    private String class_endtime;

    public ClassJoin(String join_class_num, String class_name, String class_mento, String class_place, String class_startdate, String class_enddate, String class_starttime, String class_endtime) {
        this.join_class_num = join_class_num;
        this.class_name = class_name;
        this.class_mento = class_mento;
        this.class_place = class_place;
        this.class_startdate = class_startdate;
        this.class_enddate = class_enddate;
        this.class_starttime = class_starttime;
        this.class_endtime = class_endtime;
    }

    public String getClass_name() {
        return class_name;
    }

    public String getClass_mento() {
        return class_mento;
    }

    public String getClass_place() {
        return class_place;
    }

    public String getClass_startdate() {
        return class_startdate;
    }

    public String getClass_enddate() {
        return class_enddate;
    }

    public String getClass_starttime() {
        return class_starttime;
    }

    public String getClass_endtime() {
        return class_endtime;
    }

    public String getJoin_class_num() {
        return join_class_num;
    }

    public void setClass_name(String class_name) {
        this.class_name = class_name;
    }

    public void setClass_mento(String class_mento) {
        this.class_mento = class_mento;
    }

    public void setClass_place(String class_place) {
        this.class_place = class_place;
    }

    public void setClass_startdate(String class_startdate) {
        this.class_startdate = class_startdate;
    }

    public void setClass_enddate(String class_enddate) {
        this.class_enddate = class_enddate;
    }

    public void setClass_starttime(String class_starttime) {
        this.class_starttime = class_starttime;
    }

    public void setClass_endtime(String class_endtime) {
        this.class_endtime = class_endtime;
    }

    public void setJoin_class_num(String join_class_num) {
        this.join_class_num = join_class_num;
    }
}
