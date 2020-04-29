package com.askj.aqcx.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Timestamp;

/**
 * Created by pc on 2018/3/23.
 */
@Table(value = "discreditenterprise")
public class Discreditenterprise {
    //企业id
    @Name
    @Column(value="id")
    public String id;
    @Column(value="comid")
    public String comid;
    //企业名称
    @Column(value="comname")
    public String comname;
    //区分1严重失信 2 失信
    @Column(value="type")
    public String type;
    //序号
    @Column(value="serialnumber")
    public String serialnumber;
    //类别
    @Column(value="category")
    public String category;
    //列入失信原因
    @Column(value="reason")
    public String reason;
    //列入日期
    @Column(value="enrolrq")
    public Timestamp enrolrq;
    //列入人员
    @Column(value="includery")
    public String includery;
    //移除失信原因
    @Column(value="removal")
    public String removal;
    //移除时间
    @Column(value="moverq")
    public Timestamp moverq;
    //移除人
    @Column(value="removery")
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
