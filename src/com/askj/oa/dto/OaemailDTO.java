package com.askj.oa.dto;

public class OaemailDTO {
    /**
     * oaemailid 的中文含义是：站内信id
     */
    private String oaemailid;

    /**
     * emailcontent 的中文含义是：站内信内容
     */
    private String emailcontent;

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
    private String sfyd;
    private String zxrUserid;
    private String id;
    private String zxr;
    private String txr;
    private String oaemailmanid;
    public String getOaemailid() {
        return oaemailid;
    }

    public void setOaemailid(String oaemailid) {
        this.oaemailid = oaemailid;
    }

    public String getEmailcontent() {
        return emailcontent;
    }

    public void setEmailcontent(String emailcontent) {
        this.emailcontent = emailcontent;
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

    public String getZxrUserid() {
        return zxrUserid;
    }

    public void setZxrUserid(String zxrUserid) {
        this.zxrUserid = zxrUserid;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getZxr() {
        return zxr;
    }

    public void setZxr(String zxr) {
        this.zxr = zxr;
    }

    public String getTxr() {
        return txr;
    }

    public void setTxr(String txr) {
        this.txr = txr;
    }

    public String getOaemailmanid() {
        return oaemailmanid;
    }

    public void setOaemailmanid(String oaemailmanid) {
        this.oaemailmanid = oaemailmanid;
    }

    public String getSfyd() {
        return sfyd;
    }

    public void setSfyd(String sfyd) {
        this.sfyd = sfyd;
    }
}
