package com.askj.oa.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

/**
 * Created by pc on 2018/5/22.
 */
@Table(value = "information")
public class Information {
    /** infoid 的中文含义是：信息管理id*/
    @Column(value="infoid")
    @Name
    private String infoid;
    /** content 的中文含义是：信息内容*/
    @Column(value="content")
    private String content;
    /** department 的中文含义是：信息所属科室*/
    @Column(value="orgid")
    private String orgid;
    /** adopt 的中文含义是：是否采纳*/
    @Column(value="adopt")
    private String adopt;
    /** orgname 的中文含义是：科室名称*/
    @Column(value="orgname")
    private String orgname;
    /** linkaddress 的中文含义是：采纳链接*/
    @Column(value="linkaddress")
    private String linkaddress;
    @Column(value="reportTime")
    private String reportTime;

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
