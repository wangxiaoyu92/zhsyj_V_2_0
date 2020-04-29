package com.askj.aqcx.dto;

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
public class DiscreditenterpriseDTO {
    //主键
    public String id;
    //企业id
    public String comid;
    //企业名称
    public String comname;
    //区分1严重失信 2 失信
    public String type;
    //序号
    public String serialnumber;
    //类别
    public String category;
    //列入失信原因
    public String reason;
    //列入日期
    public Timestamp enrolrq;
    //列入人员
    public String includery;
    //移除失信原因
    public String removal;
    //移除时间
    public Timestamp moverq;
    //移除人
    public String removery;

    public String getComid() {
        return comid;
    }

    public void setComid(String comid) {
        this.comid = comid;
    }

    public String getComname() {
        return comname;
    }

    public void setComname(String comname) {
        this.comname = comname;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getSerialnumber() {
        return serialnumber;
    }

    public void setSerialnumber(String serialnumber) {
        this.serialnumber = serialnumber;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public Timestamp getEnrolrq() {
        return enrolrq;
    }

    public void setEnrolrq(Timestamp enrolrq) {
        this.enrolrq = enrolrq;
    }

    public String getIncludery() {
        return includery;
    }

    public void setIncludery(String includery) {
        this.includery = includery;
    }

    public String getRemoval() {
        return removal;
    }

    public void setRemoval(String removal) {
        this.removal = removal;
    }

    public Timestamp getMoverq() {
        return moverq;
    }

    public void setMoverq(Timestamp moverq) {
        this.moverq = moverq;
    }

    public String getRemovery() {
        return removery;
    }

    public void setRemovery(String removery) {
        this.removery = removery;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}
