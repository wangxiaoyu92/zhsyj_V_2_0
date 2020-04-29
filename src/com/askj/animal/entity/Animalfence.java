package com.askj.animal.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

/**
 *
 *  Animalfence：动物舍所
 *
 *  Animalhouse的描述：
 *
 *  @author : zk
 *  @version : V1.0
 */
@Table(value = "animalfence")
public class Animalfence {

    //舍所id
    @Name
    @Column(value="animalfenceid")
    private String animalfenceid;

    //栅栏编号
    @Column(value="fenceno")
    private String fenceno;

    //栅栏名称
    @Column(value="fencename")
    private String fencename;

    //栅栏备注
    @Column(value="fenceremarks")
    private String fenceremarks;

    //动物舍所id
    @Column(value="houseid")
    private String houseid;

    //动物舍所编号
    @Column(value="houseno")
    private String houseno;

    //操作员
    @Column(value="aae011")
    private String aae011;

    //操作时间
    @Column(value="aae036")
    private String aae036;

    public String getAnimalfenceid() {
        return animalfenceid;
    }

    public void setAnimalfenceid(String animalfenceid) {
        this.animalfenceid = animalfenceid;
    }

    public String getFenceno() {
        return fenceno;
    }

    public void setFenceno(String fenceno) {
        this.fenceno = fenceno;
    }

    public String getFencename() {
        return fencename;
    }

    public void setFencename(String fencename) {
        this.fencename = fencename;
    }

    public String getFenceremarks() {
        return fenceremarks;
    }

    public void setFenceremarks(String fenceremarks) {
        this.fenceremarks = fenceremarks;
    }

    public String getHouseid() {
        return houseid;
    }

    public void setHouseid(String houseid) {
        this.houseid = houseid;
    }

    public String getHouseno() {
        return houseno;
    }

    public void setHouseno(String houseno) {
        this.houseno = houseno;
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
