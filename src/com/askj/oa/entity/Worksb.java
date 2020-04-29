package com.askj.oa.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

@Table(value = "worksb")
public class Worksb {
    @Column(value="worksbid")
    @Name
    private String worksbid;
    @Column(value="content")
    private String content;
    @Column(value="time")
    private String time;
    @Column(value="fzr")
    private String fzr;
    @Column(value="userid")
    private String userid;

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

