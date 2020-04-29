package com.askj.oa.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * @Description Oatask的中文含义是: oa任务表; InnoDB free: 31744 kB
 * @Creation 2018/05/18 11:32:19
 * @Written Create Tool By syh
 **/
@Table(value = "Oatask")
public class Oatask {

    /**
     * oataskid 的中文含义是：oa任务表id
     */
    @Name
    @Column
    private String oataskid;

    /**
     * parenttaskid 的中文含义是：父任务id
     */
    @Column
    private String parenttaskid;

    /**
     * tasktype 的中文含义是：任务形式aaa100=tasktype，0文字，1语音
     */
    @Column
    private String tasktype;

    /**
     * taskcontent 的中文含义是：任务内容
     */
    @Column
    private String taskcontent;

    /**
     * sendtype 的中文含义是：发送方式aaa100=sendtype
     */
    @Column
    private String sendtype;

    /**
     * endtime 的中文含义是：截止时间
     */
    @Column
    private String endtime;

    /**
     * needremindflag 的中文含义是：到期是否提醒aaa100=shifoubz
     */
    @Column
    private String needremindflag;

    /**
     * remindtype 的中文含义是：到期提醒方式aaa100=remindtype
     */
    @Column
    private String remindtype;

    /**
     * taskremindtime 的中文含义是：到期提前提醒时间aaa100=taskremindtime
     */
    @Column
    private String taskremindtime;

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


    public void setOataskid(String oataskid) {
        this.oataskid = oataskid;
    }

    public String getOataskid() {
        return oataskid;
    }

    public void setParenttaskid(String parenttaskid) {
        this.parenttaskid = parenttaskid;
    }

    public String getParenttaskid() {
        return parenttaskid;
    }

    public void setTasktype(String tasktype) {
        this.tasktype = tasktype;
    }

    public String getTasktype() {
        return tasktype;
    }

    public void setTaskcontent(String taskcontent) {
        this.taskcontent = taskcontent;
    }

    public String getTaskcontent() {
        return taskcontent;
    }

    public void setSendtype(String sendtype) {
        this.sendtype = sendtype;
    }

    public String getSendtype() {
        return sendtype;
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

    public void setTaskremindtime(String taskremindtime) {
        this.taskremindtime = taskremindtime;
    }

    public String getTaskremindtime() {
        return taskremindtime;
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

    public void setSfyx(String sfyx) {
        this.sfyx = sfyx;
    }

    public String getSfyx() {
        return sfyx;
    }

}

