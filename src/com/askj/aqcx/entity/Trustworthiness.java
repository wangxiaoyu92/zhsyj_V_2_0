package com.askj.aqcx.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Timestamp;

/**
 *
 *  DiscreditenterpriseDto：企业失信
 *
 *  DiscreditenterpriseDto的描述：
 *
 *  @author : wcl
 *  @version : V1.0
 */
@Table(value = "trustworthiness")
public class Trustworthiness {
    //企业id
    @Name
    @Column(value="id")
    private String id;
    @Column(value="ryid")
    private String ryid;
    @Column(value="ryname")
    private String ryname;
    @Column(value="cxrecord")
    private String cxrecord;
    @Column(value="starttime")
    private Timestamp starttime;
    @Column(value="endtime")
    private Timestamp endtime;
    @Column(value="situation")
    private String situation;
    @Column(value="score")
    private String score;
    @Column(value="telephone")
    private String telephone;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getRyid() {
        return ryid;
    }

    public void setRyid(String ryid) {
        this.ryid = ryid;
    }

    public String getCxrecord() {
        return cxrecord;
    }

    public void setCxrecord(String cxrecord) {
        this.cxrecord = cxrecord;
    }

    public Timestamp getStarttime() {
        return starttime;
    }

    public void setStarttime(Timestamp starttime) {
        this.starttime = starttime;
    }

    public Timestamp getEndtime() {
        return endtime;
    }

    public void setEndtime(Timestamp endtime) {
        this.endtime = endtime;
    }

    public String getSituation() {
        return situation;
    }

    public void setSituation(String situation) {
        this.situation = situation;
    }

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getRyname() {
        return ryname;
    }

    public void setRyname(String ryname) {
        this.ryname = ryname;
    }
}
