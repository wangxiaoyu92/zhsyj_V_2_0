package com.askj.oa.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * @Description Oameeting的中文含义是: oa会议表; InnoDB free: 31744 kB
 * @Creation 2018/05/18 11:09:20
 * @Written Create Tool By syh
 **/
@Table(value = "Oameeting")
public class Oameeting {

    /**
     * oameetingid 的中文含义是：oa会议表id
     */
    @Name
    @Column
    private String oameetingid;

    /**
     * mettingcontent 的中文含义是：会议内容
     */
    @Column
    private String mettingcontent;

    /**
     * starttime 的中文含义是：开始时间
     */
    @Column
    private String starttime;

    /**
     * endtime 的中文含义是：结束时间
     */
    @Column
    private String endtime;

    /**
     * meetingplace 的中文含义是：会议地点
     */
    @Column
    private String meetingplace;

    /**
     * sendtype 的中文含义是：发送方式aaa100=sendtype
     */
    @Column
    private String sendtype;

    /**
     * remindtype 的中文含义是：到期提醒方式aaa100=remindtype
     */
    @Column
    private String remindtype;

    /**
     * meetingremindtime 的中文含义是：到期提前提醒时间aaa100=meetingremindtime
     */
    @Column
    private String meetingremindtime;

    /**
     * meetingstate 的中文含义是：会议状态aa100=meetingstate
     */
    @Column
    private String meetingstate;

    /**
     * meetingcancelreason 的中文含义是：会议取消原因
     */
    @Column
    private String meetingcancelreason;

    /**
     * aae011 的中文含义是：经办人
     */
    @Column
    private String aae011;

    /**
     * aae036 的中文含义是：经办时间
     */
    @Column
    private String aae036;

    /**
     * sfyx 的中文含义是：是否有效aaa100=sfyx
     */
    @Column
    private String sfyx;

    /**
     * needremindflag 的中文含义是：到期是否提醒aaa100=shifoubz
     */
    @Column
    private String needremindflag;


    public void setOameetingid(String oameetingid) {
        this.oameetingid = oameetingid;
    }

    public String getOameetingid() {
        return oameetingid;
    }

    public void setMettingcontent(String mettingcontent) {
        this.mettingcontent = mettingcontent;
    }

    public String getMettingcontent() {
        return mettingcontent;
    }

    public void setStarttime(String starttime) {
        this.starttime = starttime;
    }

    public String getStarttime() {
        return starttime;
    }

    public void setEndtime(String endtime) {
        this.endtime = endtime;
    }

    public String getEndtime() {
        return endtime;
    }

    public void setMeetingplace(String meetingplace) {
        this.meetingplace = meetingplace;
    }

    public String getMeetingplace() {
        return meetingplace;
    }

    public void setSendtype(String sendtype) {
        this.sendtype = sendtype;
    }

    public String getSendtype() {
        return sendtype;
    }

    public void setRemindtype(String remindtype) {
        this.remindtype = remindtype;
    }

    public String getRemindtype() {
        return remindtype;
    }

    public void setMeetingremindtime(String meetingremindtime) {
        this.meetingremindtime = meetingremindtime;
    }

    public String getMeetingremindtime() {
        return meetingremindtime;
    }

    public void setMeetingstate(String meetingstate) {
        this.meetingstate = meetingstate;
    }

    public String getMeetingstate() {
        return meetingstate;
    }

    public void setMeetingcancelreason(String meetingcancelreason) {
        this.meetingcancelreason = meetingcancelreason;
    }

    public String getMeetingcancelreason() {
        return meetingcancelreason;
    }

    public void setAae011(String aae011) {
        this.aae011 = aae011;
    }

    public String getAae011() {
        return aae011;
    }

    public void setAae036(String aae036) {
        this.aae036 = aae036;
    }

    public String getAae036() {
        return aae036;
    }

    public String getSfyx() {
        return sfyx;
    }

    public void setSfyx(String sfyx) {
        this.sfyx = sfyx;
    }

    public String getNeedremindflag() {
        return needremindflag;
    }

    public void setNeedremindflag(String needremindflag) {
        this.needremindflag = needremindflag;
    }
}

