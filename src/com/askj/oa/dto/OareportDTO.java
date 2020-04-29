package com.askj.oa.dto;

public class OareportDTO {
    /**
     * oareportid 的中文含义是：工作上报id
     */

    private String oareportid;

    /**
     * reportcontent 的中文含义是：工作上报内容
     */
    private String reportcontent;

    /**
     * aae011 的中文含义是：发送人
     */
    private String aae011;

    /**
     * aae036 的中文含义是：发送时间
     */
    private String aae036;

    /**
     * sfyx 的中文含义是：是否有效
     */
    private String sfyx;

    private String txr;
    private String zxrUserid;
    private String zxr;
    private String id;
    private String oareportmanid;
    private String sfyd;

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

    public String getTxr() {
        return txr;
    }

    public void setTxr(String txr) {
        this.txr = txr;
    }

    public String getZxrUserid() {
        return zxrUserid;
    }

    public void setZxrUserid(String zxrUserid) {
        this.zxrUserid = zxrUserid;
    }

    public String getZxr() {
        return zxr;
    }

    public void setZxr(String zxr) {
        this.zxr = zxr;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getOareportmanid() {
        return oareportmanid;
    }

    public void setOareportmanid(String oareportmanid) {
        this.oareportmanid = oareportmanid;
    }

    public String getSfyd() {
        return sfyd;
    }

    public void setSfyd(String sfyd) {
        this.sfyd = sfyd;
    }
}
