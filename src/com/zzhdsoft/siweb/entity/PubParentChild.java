package com.zzhdsoft.siweb.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  PubParentChild的中文含义是: 通用父子关系表; InnoDB free: 2757632 kB
 * @Creation     2016/05/05 10:19:23
 * @Written      Create Tool By wxy    parentchild
 **/
@Table(value = "PARENTCHILD")
public class PubParentChild {
    //通用父子关系表id
    @Column
    @Name
    private String parentchildid;
    //通用父子关系表类别
    @Column
    private String parentchildlb;
    //通用父子关系表类别名称
    @Column
    private String parentchildlbmc;
    //通用父子关系表父id
    @Column
    private String parentid;
    //通用父子关系表编号
    @Column
    private String bh;
    //通用父子关系表名称
    @Column
    private String mc;
    //通用父子关系表有效标志
    @Column
    private String sfyx;
    //操作员id
    @Column
    private String userid;
    //操作员姓名
    @Column
    private String username;
    //操作时间
    @Column
    private String czsj;
    //属性1
    @Column
    private String sx1;
    //属性2
    @Column
    private String sx2;
    //属性3
    @Column
    private String sx3;
    @Column
    private String sx4;
    @Column
    private String sx5;
    @Column
    private String sx6;
    @Column
    private String sx7;
    @Column
    private String sx8;
    @Column
    private String sx9;
    @Column
    private String sx10;

    public String getParentchildid() {
        return parentchildid;
    }

    public void setParentchildid(String parentchildid) {
        this.parentchildid = parentchildid;
    }

    public String getParentchildlb() {
        return parentchildlb;
    }

    public void setParentchildlb(String parentchildlb) {
        this.parentchildlb = parentchildlb;
    }

    public String getParentchildlbmc() {
        return parentchildlbmc;
    }

    public void setParentchildlbmc(String parentchildlbmc) {
        this.parentchildlbmc = parentchildlbmc;
    }

    public String getParentid() {
        return parentid;
    }

    public void setParentid(String parentid) {
        this.parentid = parentid;
    }

    public String getBh() {
        return bh;
    }

    public void setBh(String bh) {
        this.bh = bh;
    }

    public String getMc() {
        return mc;
    }

    public void setMc(String mc) {
        this.mc = mc;
    }

    public String getSfyx() {
        return sfyx;
    }

    public void setSfyx(String sfyx) {
        this.sfyx = sfyx;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getCzsj() {
        return czsj;
    }

    public void setCzsj(String czsj) {
        this.czsj = czsj;
    }

    public String getSx1() {
        return sx1;
    }

    public void setSx1(String sx1) {
        this.sx1 = sx1;
    }

    public String getSx2() {
        return sx2;
    }

    public void setSx2(String sx2) {
        this.sx2 = sx2;
    }

    public String getSx3() {
        return sx3;
    }

    public void setSx3(String sx3) {
        this.sx3 = sx3;
    }

    public String getSx4() {
        return sx4;
    }

    public void setSx4(String sx4) {
        this.sx4 = sx4;
    }

    public String getSx5() {
        return sx5;
    }

    public void setSx5(String sx5) {
        this.sx5 = sx5;
    }

    public String getSx6() {
        return sx6;
    }

    public void setSx6(String sx6) {
        this.sx6 = sx6;
    }

    public String getSx7() {
        return sx7;
    }

    public void setSx7(String sx7) {
        this.sx7 = sx7;
    }

    public String getSx8() {
        return sx8;
    }

    public void setSx8(String sx8) {
        this.sx8 = sx8;
    }

    public String getSx9() {
        return sx9;
    }

    public void setSx9(String sx9) {
        this.sx9 = sx9;
    }

    public String getSx10() {
        return sx10;
    }

    public void setSx10(String sx10) {
        this.sx10 = sx10;
    }
}
