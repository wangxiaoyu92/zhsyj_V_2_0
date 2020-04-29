package com.askj.oa.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

/**
 * @Description oaemail的中文含义是: 站内信表;
 **/
@Table(value = "oaemail")
public class Oaemail {

    /**
     * oaemailid 的中文含义是：站内信id
     */
    @Name
    @Column
    private String oaemailid;

    /**
     * emailcontent 的中文含义是：站内信内容
     */
    @Column
    private String emailcontent;

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
}
