package com.askj.oa.dto;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

/**
 * @Description Oameeting的中文含义是: oa会议表; InnoDB free: 31744 kB
 * @Creation 2018/05/18 11:09:55
 * @Written Create Tool By syh
 **/
public class OameetingDTO {

    /***********************************扩展字段开始***********************************/

    private String jlr;// 记录人
    private String chr;// 参会人
    private List<OameetingDTO> list;
    private String jlrUserid;// 记录人id
    private String chrUserid;// 参会人id
    private String userid;// 人员id
    private String rylx; // 人员类型
    private String havereadflag;// 已读标志  0否1是
    private String receivedflag;  // 确认收到标志  0否1是
    private String meetingsignflag; // 会议签到标志   0否1是
    private String completestate; // 完成状态  0未1已2不能',
    private String cannotreason; //'不能完成原因',
    private Integer hyrwgs;// 会议任务个数
    private String hyrwcontent; // 会议任务内容
    private String username;// 人员姓名
    private String meetingmantype;// 人员类型
    private String txsj;// 到期前提醒时间
    private String oameetingmanid;// 会议关联人主键
    private String txr;// 到期提醒人


    public String getTxr() {
        return txr;
    }

    public void setTxr(String txr) {
        this.txr = txr;
    }

    public String getOameetingmanid() {
        return oameetingmanid;
    }

    public void setOameetingmanid(String oameetingmanid) {
        this.oameetingmanid = oameetingmanid;
    }

    public String getTxsj() {
        return txsj;
    }

    public void setTxsj(String txsj) {
        this.txsj = txsj;
    }

    public String getMeetingmantype() {
        return meetingmantype;
    }

    public void setMeetingmantype(String meetingmantype) {
        this.meetingmantype = meetingmantype;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getHyrwcontent() {
        return hyrwcontent;
    }

    public void setHyrwcontent(String hyrwcontent) {
        this.hyrwcontent = hyrwcontent;
    }

    public Integer getHyrwgs() {
        return hyrwgs;
    }

    public void setHyrwgs(Integer hyrwgs) {
        this.hyrwgs = hyrwgs;
    }

    public String getHavereadflag() {
        return havereadflag;
    }

    public void setHavereadflag(String havereadflag) {
        this.havereadflag = havereadflag;
    }

    public String getReceivedflag() {
        return receivedflag;
    }

    public void setReceivedflag(String receivedflag) {
        this.receivedflag = receivedflag;
    }

    public String getMeetingsignflag() {
        return meetingsignflag;
    }

    public void setMeetingsignflag(String meetingsignflag) {
        this.meetingsignflag = meetingsignflag;
    }

    public String getCompletestate() {
        return completestate;
    }

    public void setCompletestate(String completestate) {
        this.completestate = completestate;
    }

    public String getRylx() {
        return rylx;
    }

    public void setRylx(String rylx) {
        this.rylx = rylx;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getCannotreason() {
        return cannotreason;
    }

    public void setCannotreason(String cannotreason) {
        this.cannotreason = cannotreason;
    }

    public String getJlrUserid() {
        return jlrUserid;
    }

    public void setJlrUserid(String jlrUserid) {
        this.jlrUserid = jlrUserid;
    }

    public String getChrUserid() {
        return chrUserid;
    }

    public void setChrUserid(String chrUserid) {
        this.chrUserid = chrUserid;
    }

    public String getJlr() {
        return jlr;
    }

    public void setJlr(String jlr) {
        this.jlr = jlr;
    }

    public String getChr() {
        return chr;
    }

    public void setChr(String chr) {
        this.chr = chr;
    }

    public List<OameetingDTO> getList() {
        return list;
    }

    public void setList(List<OameetingDTO> list) {
        this.list = list;
    }


    /***********************************扩展字段结束***********************************/

    /**
     * oameetingid 的中文含义是：oa会议表id
     */
    private String oameetingid;

    /**
     * mettingcontent 的中文含义是：会议内容
     */
    private String mettingcontent;

    /**
     * starttime 的中文含义是：开始时间
     */
    private String starttime;

    /**
     * endtime 的中文含义是：结束时间
     */
    private String endtime;

    /**
     * meetingplace 的中文含义是：会议地点
     */
    private String meetingplace;

    /**
     * sendtype 的中文含义是：发送方式aaa100=sendtype
     */
    private String sendtype;

    /**
     * remindtype 的中文含义是：到期提醒方式aaa100=remindtype
     */
    private String remindtype;

    /**
     * meetingremindtime 的中文含义是：到期提前提醒时间aaa100=meetingremindtime
     */
    private String meetingremindtime;

    /**
     * meetingstate 的中文含义是：会议状态aa100=meetingstate
     */
    private String meetingstate;

    /**
     * meetingcancelreason 的中文含义是：会议取消原因
     */
    private String meetingcancelreason;

    /**
     * aae011 的中文含义是：经办人
     */
    private String aae011;

    /**
     * aae036 的中文含义是：经办时间
     */
    private String aae036;

    /**
     * sfyx 的中文含义是：是否有效aaa100=sfyx
     */
    private String sfyx;

    /**
     * needremindflag 的中文含义是：到期是否提醒aaa100=shifoubz
     */
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

