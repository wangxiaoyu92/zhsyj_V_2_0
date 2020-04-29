package com.askj.aqcx.dto;

import java.sql.Timestamp;

/**
 *
 *  TrustworthinessDTO：人员诚信信息
 *
 *  TrustworthinessDTO的描述：
 *
 *  @author : wcl
 *  @version : V1.0
 */
public class TrustworthinessDTO {
    //主键
    private String id;
    private String ryid;
    private String ryname;
    private String ryxm;
    private String rymz;
    private String ryxb;
    private String ryjkqk;
    private String rynl;
    private String rycsrq;
    private String rybyyx;
    private String ryjg;
    private String cxrecord;
    private Timestamp starttime;
    private Timestamp endtime;
    private String situation;
    private String score;
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

    public String getRyxm() {
        return ryxm;
    }

    public void setRyxm(String ryxm) {
        this.ryxm = ryxm;
    }

    public String getRymz() {
        return rymz;
    }

    public void setRymz(String rymz) {
        this.rymz = rymz;
    }

    public String getRyxb() {
        return ryxb;
    }

    public void setRyxb(String ryxb) {
        this.ryxb = ryxb;
    }

    public String getRyjkqk() {
        return ryjkqk;
    }

    public void setRyjkqk(String ryjkqk) {
        this.ryjkqk = ryjkqk;
    }

    public String getRynl() {
        return rynl;
    }

    public void setRynl(String rynl) {
        this.rynl = rynl;
    }

    public String getRycsrq() {
        return rycsrq;
    }

    public void setRycsrq(String rycsrq) {
        this.rycsrq = rycsrq;
    }

    public String getRybyyx() {
        return rybyyx;
    }

    public void setRybyyx(String rybyyx) {
        this.rybyyx = rybyyx;
    }

    public String getRyjg() {
        return ryjg;
    }

    public void setRyjg(String ryjg) {
        this.ryjg = ryjg;
    }
}
