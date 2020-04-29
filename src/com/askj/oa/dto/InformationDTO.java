package com.askj.oa.dto;

/**
 * Created by pc on 2018/5/22.
 */
public class InformationDTO {
    /** infoid 的中文含义是：信息管理id*/
    private String infoid;
    /** content 的中文含义是：信息内容*/
    private String content;
    /** department 的中文含义是：信息所属科室*/
    private String orgid;
    /** adopt 的中文含义是：是否采纳*/
    private String adopt;
    //企业门头照路径
    private String xxfjpath;
    //企业门头照名称
    private String xxfjname;
    //所属科室名称
    private String orgname;

    //采纳链接地址
    private String linkaddress;

    private String yearnumber;
    private String monthnumber;
    private String reportTime;


    private String ljsb;

    private String benyue;

    private String juliang;

    private String yueliang;

    private String shengliang;

    private String yueshengliang;

    private String id;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getYearnumber() {
        return yearnumber;
    }

    public void setYearnumber(String yearnumber) {
        this.yearnumber = yearnumber;
    }

    public String getMonthnumber() {
        return monthnumber;
    }

    public void setMonthnumber(String monthnumber) {
        this.monthnumber = monthnumber;
    }

    public String getLjsb() {
        return ljsb;
    }

    public void setLjsb(String ljsb) {
        this.ljsb = ljsb;
    }

    public String getBenyue() {
        return benyue;
    }

    public void setBenyue(String benyue) {
        this.benyue = benyue;
    }

    public String getJuliang() {
        return juliang;
    }

    public void setJuliang(String juliang) {
        this.juliang = juliang;
    }

    public String getYueliang() {
        return yueliang;
    }

    public void setYueliang(String yueliang) {
        this.yueliang = yueliang;
    }

    public String getShengliang() {
        return shengliang;
    }

    public void setShengliang(String shengliang) {
        this.shengliang = shengliang;
    }

    public String getYueshengliang() {
        return yueshengliang;
    }

    public void setYueshengliang(String yueshengliang) {
        this.yueshengliang = yueshengliang;
    }

    public String getLinkaddress() {
        return linkaddress;
    }

    public void setLinkaddress(String linkaddress) {
        this.linkaddress = linkaddress;
    }

    public String getInfoid() {
        return infoid;
    }

    public void setInfoid(String infoid) {
        this.infoid = infoid;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getOrgid() {
        return orgid;
    }

    public void setOrgid(String orgid) {
        this.orgid = orgid;
    }

    public String getAdopt() {
        return adopt;
    }

    public void setAdopt(String adopt) {
        this.adopt = adopt;
    }

    public String getXxfjpath() {
        return xxfjpath;
    }

    public void setXxfjpath(String xxfjpath) {
        this.xxfjpath = xxfjpath;
    }

    public String getXxfjname() {
        return xxfjname;
    }

    public void setXxfjname(String xxfjname) {
        this.xxfjname = xxfjname;
    }

    public String getOrgname() {
        return orgname;
    }

    public void setOrgname(String orgname) {
        this.orgname = orgname;
    }

    public String getReportTime() {
        return reportTime;
    }

    public void setReportTime(String reportTime) {
        this.reportTime = reportTime;
    }
}
