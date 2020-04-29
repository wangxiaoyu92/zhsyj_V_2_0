package com.askj.oa.dto;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * @Description Oameetingrman的中文含义是: oa会议关联人表; InnoDB free: 31744 kB
 * @Creation 2018/05/18 11:16:19
 * @Written Create Tool By syh
 **/
public class OameetingmanDTO {

    /**
     * oameetingrmanid 的中文含义是：oa会议关联人表id
     */
    private String oameetingmanid;

    /**
     * oameetingid 的中文含义是：oa会议表id
     */
    private String oameetingid;

    /**
     * meetingrmantype 的中文含义是：会议关联人类型aaa100=meetingrmantype，1会议纪要记录人2参会人
     */
    private String meetingmantype;

    /**
     * userid 的中文含义是：人员id
     */
    private String userid;

    /**
     * havereadflag 的中文含义是：已读标志aaa100=shifoubz
     */
    private String havereadflag;

    /**
     * receivedflag 的中文含义是：确认收到标志aaa100=shifoubz
     */
    private String receivedflag;

    /**
     * meetingsignflag 的中文含义是：会议签到标志aaa100=shifoubz
     */
    private String meetingsignflag;

    /**
     * completestate 的中文含义是：完成状态aaa100=completestate，0未1已2不能
     */
    private String completestate;

    /**
     * cannotreason 的中文含义是：不能完成原因
     */
    private String cannotreason;

    /**
     * aae011 的中文含义是：操作员
     */
    private String aae011;

    /**
     * aae036 的中文含义是：操作时间
     */
    private String aae036;

    /**
     * tasktransferflag 的中文含义是：任务转交标志aaa100=shifoubz
     */
    private String tasktransferflag;

    /**
     * remark 的中文含义是：备注
     */
    private String remark;

    /**
     * meetingsigntime 的中文含义是：会议签到时间
     */
    private String meetingsigntime;

    /**
     * meetingsignaddr 的中文含义是： 会议签到地点
     */
    private String meetingsignaddr;


    public void setOameetingmanid(String oameetingmanid) {
        this.oameetingmanid = oameetingmanid;
    }

    public String getOameetingmanid() {
        return oameetingmanid;
    }

    public void setOameetingid(String oameetingid) {
        this.oameetingid = oameetingid;
    }

    public String getOameetingid() {
        return oameetingid;
    }

    public void setMeetingmantype(String meetingmantype) {
        this.meetingmantype = meetingmantype;
    }

    public String getMeetingmantype() {
        return meetingmantype;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getUserid() {
        return userid;
    }

    public void setHavereadflag(String havereadflag) {
        this.havereadflag = havereadflag;
    }

    public String getHavereadflag() {
        return havereadflag;
    }

    public void setReceivedflag(String receivedflag) {
        this.receivedflag = receivedflag;
    }

    public String getReceivedflag() {
        return receivedflag;
    }

    public void setMeetingsignflag(String meetingsignflag) {
        this.meetingsignflag = meetingsignflag;
    }

    public String getMeetingsignflag() {
        return meetingsignflag;
    }

    public void setCompletestate(String completestate) {
        this.completestate = completestate;
    }

    public String getCompletestate() {
        return completestate;
    }

    public void setCannotreason(String cannotreason) {
        this.cannotreason = cannotreason;
    }

    public String getCannotreason() {
        return cannotreason;
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

    public void setTasktransferflag(String tasktransferflag) {
        this.tasktransferflag = tasktransferflag;
    }

    public String getTasktransferflag() {
        return tasktransferflag;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getMeetingsigntime() {
        return meetingsigntime;
    }

    public void setMeetingsigntime(String meetingsigntime) {
        this.meetingsigntime = meetingsigntime;
    }

    public String getMeetingsignaddr() {
        return meetingsignaddr;
    }

    public void setMeetingsignaddr(String meetingsignaddr) {
        this.meetingsignaddr = meetingsignaddr;
    }
}

