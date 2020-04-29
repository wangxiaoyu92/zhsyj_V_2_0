package com.askj.oa.dto;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * @Description Oaschedule的中文含义是: oa日程表; InnoDB free: 31744 kB
 * @Creation 2018/05/18 11:30:33
 * @Written Create Tool By syh
 **/
public class OascheduleDTO {
    /**************************************扩展字段开始****************************************/
    private String rcsj;// 日程时间
    private String remindtime;// 到期提醒时间

    public String getRemindtime() {
        return remindtime;
    }

    public void setRemindtime(String remindtime) {
        this.remindtime = remindtime;
    }

    public String getRcsj() {
        return rcsj;
    }

    public void setRcsj(String rcsj) {
        this.rcsj = rcsj;
    }
    /**************************************扩展字段结束****************************************/

    /**
     * oascheduleid 的中文含义是：oa日程表id
     */
    private String oascheduleid;

    /**
     * schedulecontent 的中文含义是：日程内容
     */
    private String schedulecontent;

    /**
     * starttime 的中文含义是：日程开始时间
     */
    private String starttime;

    /**
     * endtime 的中文含义是：日程结束时间
     */
    private String endtime;

    /**
     * needremindflag 的中文含义是：到期是否提醒aaa100=shifoubz
     */
    private String needremindflag;

    /**
     * remindtype 的中文含义是：到期提醒方式aaa100=remindtype
     */
    private String remindtype;

    /**
     * scheduleremindtime 的中文含义是：日程到期提前提醒时间aaa100=scheduleremindtime
     */
    private String scheduleremindtime;

    /**
     * aae011 的中文含义是：经办人
     */
    private String aae011;

    /**
     * aae036 的中文含义是：经办时间
     */
    private String aae036;

    /**
     * remarks 的中文含义是：备注
     */
    private String remarks;

    /**
     * sfyx 的中文含义是：是否有效aaa100=sfyx
     */
    private String sfyx;


    public void setOascheduleid(String oascheduleid) {
        this.oascheduleid = oascheduleid;
    }

    public String getOascheduleid() {
        return oascheduleid;
    }

    public void setSchedulecontent(String schedulecontent) {
        this.schedulecontent = schedulecontent;
    }

    public String getSchedulecontent() {
        return schedulecontent;
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

    public void setNeedremindflag(String needremindflag) {
        this.needremindflag = needremindflag;
    }

    public String getNeedremindflag() {
        return needremindflag;
    }

    public void setRemindtype(String remindtype) {
        this.remindtype = remindtype;
    }

    public String getRemindtype() {
        return remindtype;
    }

    public void setScheduleremindtime(String scheduleremindtime) {
        this.scheduleremindtime = scheduleremindtime;
    }

    public String getScheduleremindtime() {
        return scheduleremindtime;
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

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setSfyx(String sfyx) {
        this.sfyx = sfyx;
    }

    public String getSfyx() {
        return sfyx;
    }

}

