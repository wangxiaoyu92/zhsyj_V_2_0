package com.askj.oa.dto;

public class WorksbDTO {

    private String worksbid;

    private String content;

    private String time;

    private String fzr;

    private String userid;

    private String cyry;

    private String id;

    private String name;

    public String getCyry() {
        return cyry;
    }

    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setCyry(String cyry) {
        this.cyry = cyry;
    }

    public String getWorksbid() {
        return worksbid;
    }

    public void setWorksbid(String worksbid) {
        this.worksbid = worksbid;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getFzr() {
        return fzr;
    }

    public void setFzr(String fzr) {
        this.fzr = fzr;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }
}
