package com.askj.oa.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

@Table(value = "oareportman")
public class Oareportman {
    /**
     * oareportmanid的中文含义是：工作上报关联人id
     */
    @Name
    @Column
    private String oareportmanid;

    /**
     * oareportid 的中文含义是：关联工作上报id
     */
    @Column
    private String oareportid;

    /**
     * userid 的中文含义是：人员id
     */
    @Column
    private String userid;

    /**
     * sfyd 的中文含义是：是否已读，'0'代表未读，'1'代表已读
     */
    @Column
    private String sfyd;

    /**
     * aae011 的中文含义是：操作员
     */
    @Column
    private String aae011;

    /**
     * aae036 的中文含义是：操作时间
     */
    @Column
    private String aae036;

    public String getOareportmanid() {
        return oareportmanid;
    }

    public void setOareportmanid(String oareportmanid) {
        this.oareportmanid = oareportmanid;
    }

    public String getOareportid() {
        return oareportid;
    }

    public void setOareportid(String oareportid) {
        this.oareportid = oareportid;
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
