package com.askj.animal.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

/**
 *
 *  Animalhouse：动物舍所
 *
 *  Animalhouse的描述：
 *
 *  @author : zk
 *  @version : V1.0
 */
@Table(value = "animalhouse")
public class Animalhouse {

    //舍所id
    @Name
    @Column(value="animalhouseid")
    private String animalhouseid;

    //舍所编号
    @Column(value="houseno")
    private String houseno;

    //舍所名称
    @Column(value="housename")
    private String housename;

    //舍所备注
    @Column(value="houseremarks")
    private String houseremarks;

    //舍所上级id
    @Column(value="parenthouseid")
    private String parenthouseid;

    //组织机构id
    @Column(value="orgid")
    private String orgid;

    //操作员
    @Column(value="aae011")
    private String aae011;

    //操作时间
    @Column(value="aae036")
    private String aae036;

    public String getAnimalhouseid() {
        return animalhouseid;
    }

    public void setAnimalhouseid(String animalhouseid) {
        this.animalhouseid = animalhouseid;
    }

    public String getHouseno() {
        return houseno;
    }

    public void setHouseno(String houseno) {
        this.houseno = houseno;
    }

    public String getHousename() {
        return housename;
    }

    public void setHousename(String housename) {
        this.housename = housename;
    }

    public String getHouseremarks() {
        return houseremarks;
    }

    public void setHouseremarks(String houseremarks) {
        this.houseremarks = houseremarks;
    }

    public String getParenthouseid() {
        return parenthouseid;
    }

    public void setParenthouseid(String parenthouseid) {
        this.parenthouseid = parenthouseid;
    }

    public String getOrgid() {
        return orgid;
    }

    public void setOrgid(String orgid) {
        this.orgid = orgid;
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
