package com.askj.oa.dto;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

/**
 * @Description Oatask的中文含义是: oa任务表; InnoDB free: 31744 kB
 * @Creation 2018/05/18 11:33:29
 * @Written Create Tool By syh
 **/
public class OataskDTO {

    /************************************扩展字段开始****************************************/
    private String zxrUserid;
    private String csrUserid;
    private String zxr;
    private String csr;
    private List<OataskDTO> list;
    private String taskmantype;
    private String userid;
    private String havereadflag;
    private String receivedflag;
    private String completestate;
    private String cannotreason;
    private String tasktransferflag;
    private Integer zrwgs;
    private String zrwnr;
    private String username;
    private String parentcontent;
    private String oameetingid;
    private String oameetingtaskid;
    private String hynr;
    private Integer hygs;
    private String oataskmanid;
    private String txr;
    private String sfcc;


    public String getTxr() {
        return txr;
    }

    public void setTxr(String txr) {
        this.txr = txr;
    }

    public String getOataskmanid() {
        return oataskmanid;
    }

    public void setOataskmanid(String oataskmanid) {
        this.oataskmanid = oataskmanid;
    }

    public Integer getHygs() {
        return hygs;
    }

    public void setHygs(Integer hygs) {
        this.hygs = hygs;
    }

    public String getHynr() {
        return hynr;
    }

    public void setHynr(String hynr) {
        this.hynr = hynr;
    }

    public String getOameetingid() {
        return oameetingid;
    }

    public void setOameetingid(String oameetingid) {
        this.oameetingid = oameetingid;
    }

    public String getOameetingtaskid() {
        return oameetingtaskid;
    }

    public void setOameetingtaskid(String oameetingtaskid) {
        this.oameetingtaskid = oameetingtaskid;
    }

    public String getParentcontent() {
        return parentcontent;
    }

    public void setParentcontent(String parentcontent) {
        this.parentcontent = parentcontent;
    }

    public List<OataskDTO> getList() {
        return list;
    }

    public void setList(List<OataskDTO> list) {
        this.list = list;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Integer getZrwgs() {
        return zrwgs;
    }

    public void setZrwgs(Integer zrwgs) {
        this.zrwgs = zrwgs;
    }

    public String getZrwnr() {
        return zrwnr;
    }

    public void setZrwnr(String zrwnr) {
        this.zrwnr = zrwnr;
    }

    public String getZxr() {
        return zxr;
    }

    public void setZxr(String zxr) {
        this.zxr = zxr;
    }

    public String getCsr() {
        return csr;
    }

    public void setCsr(String csr) {
        this.csr = csr;
    }

    public String getZxrUserid() {
        return zxrUserid;
    }

    public void setZxrUserid(String zxrUserid) {
        this.zxrUserid = zxrUserid;
    }

    public String getCsrUserid() {
        return csrUserid;
    }

    public void setCsrUserid(String csrUserid) {
        this.csrUserid = csrUserid;
    }

    public String getTaskmantype() {
        return taskmantype;
    }

    public void setTaskmantype(String taskmantype) {
        this.taskmantype = taskmantype;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
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

    public String getCompletestate() {
        return completestate;
    }

    public void setCompletestate(String completestate) {
        this.completestate = completestate;
    }

    public String getCannotreason() {
        return cannotreason;
    }

    public void setCannotreason(String cannotreason) {
        this.cannotreason = cannotreason;
    }

    public String getTasktransferflag() {
        return tasktransferflag;
    }

    public void setTasktransferflag(String tasktransferflag) {
        this.tasktransferflag = tasktransferflag;
    }

    /***************************************扩展字段结束********************************************/

    /**
     * oataskid 的中文含义是：oa任务表id
     */
    private String oataskid;

    /**
     * parenttaskid 的中文含义是：父任务id
     */
    private String parenttaskid;

    /**
     * tasktype 的中文含义是：任务形式aaa100=tasktype，0文字，1语音
     */
    private String tasktype;

    /**
     * taskcontent 的中文含义是：任务内容
     */
    private String taskcontent;

    /**
     * sendtype 的中文含义是：发送方式aaa100=sendtype
     */
    private String sendtype;

    /**
     * endtime 的中文含义是：截止时间
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
     * taskremindtime 的中文含义是：到期提前提醒时间aaa100=taskremindtime
     */
    private String taskremindtime;

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

    public String getSfcc() {
        return sfcc;
    }

    public void setSfcc(String sfcc) {
        this.sfcc = sfcc;
    }
}

