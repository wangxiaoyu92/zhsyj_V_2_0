package com.askj.animal.dto;

/**
 *
 *  AnimalhouseDTO：动物舍所
 *
 *  AnimalhouseDTO的描述：
 *
 *  @author : zk
 *  @version : V1.0
 */
public class AnimalhouseDTO {

    //舍所id
    private String animalhouseid;

    //舍所编号
    private String houseno;

    //舍所名称
    private String housename;

    //舍所备注
    private String houseremarks;

    //舍所上级id
    private String parenthouseid;

    //组织机构id
    private String orgid;

    //操作员
    private String aae011;

    //操作时间
    private String aae036;

    //子舍所个数
    private String childnum;

    //上级舍所名称
    private String parentname;

    //机构名称
    private String orgname;

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

    public String getChildnum() {
        return childnum;
    }

    public void setChildnum(String childnum) {
        this.childnum = childnum;
    }

    public String getParentname() {
        return parentname;
    }

    public void setParentname(String parentname) {
        this.parentname = parentname;
    }

    public String getOrgname() {
        return orgname;
    }

    public void setOrgname(String orgname) {
        this.orgname = orgname;
    }
}
