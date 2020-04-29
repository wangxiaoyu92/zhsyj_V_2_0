package com.askj.oa.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "InforeGulations")
/**
*
*  Inforegulations的中文名称：信息上报数量设置
*
*  Inforegulations的描述：
*
*  @author : 孙意峰
*  @version : V1.0
*/
public class InforeGulations {

    /** id 的中文含义是：主键id*/

    @Name
    @Column
    private String id;
    /** orgid 的中文含义是：组织机构id*/

    @Column
    private String orgid;
    /** yearnumber 的中文含义是：年数量*/

    @Column
    private Integer yearnumber;
    /** monthnumber 的中文含义是：月数量*/

    @Column
    private Integer monthnumber;
    /** localdistinction 的中文含义是：1:代表局采纳2：省市采纳*/

    @Column
    private String localdistinction;

    /** orgname 的中文含义是 科室*/
    @Column(value="orgname")
    private String orgname;


    public String getId() {
        return id;
    }

    public void setId(String id){
        this.id = id;
    }
    public String getOrgid() {
        return orgid;
    }

    public void setOrgid(String orgid){
        this.orgid = orgid;
    }
    public Integer getYearnumber() {
        return yearnumber;
    }

    public void setYearnumber(Integer yearnumber){
        this.yearnumber = yearnumber;
    }
    public Integer getMonthnumber() {
        return monthnumber;
    }

    public void setMonthnumber(Integer monthnumber){
        this.monthnumber = monthnumber;
    }
    public String getLocaldistinction() {
        return localdistinction;
    }

    public void setLocaldistinction(String localdistinction){
        this.localdistinction = localdistinction;
    }

    public String getOrgname() {
        return orgname;
    }

    public void setOrgname(String orgname) {
        this.orgname = orgname;
    }

}

