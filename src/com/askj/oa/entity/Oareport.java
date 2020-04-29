package com.askj.oa.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

@Table(value = "oareport")
public class Oareport {
    /**
     * oareportid 的中文含义是：工作上报id
     */
    @Name
    @Column
    private String oareportid;

    /**
     * reportcontent 的中文含义是：工作上报内容
     */
    @Column
    private String reportcontent;

    /**
     * aae011 的中文含义是：发送人
     */
    @Column
    private String aae011;

    /**
     * aae036 的中文含义是：发送时间
     */
    @Column
    private String aae036;

    /**
     * sfyx 的中文含义是：是否有效
     */
    @Column
    private String sfyx;

    public String getOareportid() {
        return oareportid;
    }

    public void setOareportid(String oareportid) {
        this.oareportid = oareportid;
    }

    public String getReportcontent() {
        return reportcontent;
    }

    public void setReportcontent(String reportcontent) {
        this.reportcontent = reportcontent;
    }

    public String getAae011() {
        return aae011;
    }

    public void setAae011(String aae011) {
        this.aae011 = aae011;
    }

    public String getAae036() {
        return aae036;
    }

    public void setAae036(String aae036) {
        this.aae036 = aae036;
    }

    public String getSfyx() {
        return sfyx;
    }

    public void setSfyx(String sfyx) {
        this.sfyx = sfyx;
    }
}
