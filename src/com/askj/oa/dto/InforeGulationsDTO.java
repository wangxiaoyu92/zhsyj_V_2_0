package com.askj.oa.dto;

/**
 * Created by pc on 2018/5/24.
 */
public class InforeGulationsDTO {
    private String id;

    /** orgid 的中文含义是：科室*/
    private String orgid;

    /** yearNumber 的中文含义是：年数量*/
    private Integer yearnumber;

    /** monthNumber 的中文含义是：月数量*/
    private Integer monthnumber;

    /** localdistinction 的中文含义是：省市划分*/
    private String localdistinction;

    private String orgname;

    public String getOrgname() {
        return orgname;
    }

    public void setOrgname(String orgname) {
        this.orgname = orgname;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getOrgid() {
        return orgid;
    }

    public void setOrgid(String orgid) {
        this.orgid = orgid;
    }

    public Integer getYearnumber() {
        return yearnumber;
    }

    public void setYearnumber(Integer yearnumber) {
        this.yearnumber = yearnumber;
    }

    public Integer getMonthnumber() {
        return monthnumber;
    }

    public void setMonthnumber(Integer monthnumber) {
        this.monthnumber = monthnumber;
    }

    public String getLocaldistinction() {
        return localdistinction;
    }

    public void setLocaldistinction(String localdistinction) {
        this.localdistinction = localdistinction;
    }
}
