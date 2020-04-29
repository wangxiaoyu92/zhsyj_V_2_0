package com.askj.oa.dto;

public class OaemailmanDTO {

    /**
     * oaemailmanid的中文含义是：站内信关联人id
     */
    private String oaemailmanid;

    /**
     * oaemailid 的中文含义是：关联站内信id
     */
    private String oaemailid;

    /**
     * userid 的中文含义是：人员id
     */
    private String userid;

    /**
     * sfyd 的中文含义是：是否已读，'0'代表未读，'1'代表已读
     */
    private String sfyd;

    /**
     * aae011 的中文含义是：操作员
     */
    private String aae011;

    /**
     * aae036 的中文含义是：操作时间
     */
    private String aae036;

    public String getOaemailmanid() {
        return oaemailmanid;
    }

    public void setOaemailmanid(String oaemailmanid) {
        this.oaemailmanid = oaemailmanid;
    }

    public String getOaemailid() {
        return oaemailid;
    }

    public void setOaemailid(String oaemailid) {
        this.oaemailid = oaemailid;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getSfyd() {
        return sfyd;
    }

    public void setSfyd(String sfyd) {
        this.sfyd = sfyd;
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
}
