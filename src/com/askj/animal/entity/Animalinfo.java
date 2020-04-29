package com.askj.animal.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

/**
 *
 *  Animalinfo：动物信息
 *
 *  Animalinfo的描述：
 *
 *  @author : zk
 *  @version : V1.0
 */
@Table(value = "animalinfo")
public class Animalinfo {

    //动物信息id
    @Name
    @Column(value="animalinfoid")
    private String animalinfoid;

    //栅栏id
    @Column(value="fenceid")
    private String fenceid;

    //动物编号
    @Column(value="animalno")
    private String animalno;

    //出生日期
    @Column(value="birthday")
    private String birthday;

    //动物性别[1:公 0:母]
    @Column(value="sex")
    private String sex;

    //毛发颜色(对应aa10表haircolor)
    @Column(value="haircolor")
    private String haircolor;

    //养殖类型(对应aa10表culturestyle)
    @Column(value="culturestyle")
    private String culturestyle;

    //断奶日期
    @Column(value="weaningdate")
    private String weaningdate;

    //断奶体重
    @Column(value="weaningweight")
    private String weaningweight;

    //死亡日期
    @Column(value="deathdate")
    private String deathdate;

    //死亡体重
    @Column(value="deathweight")
    private String deathweight;

    //父id
    @Column(value="fatherid")
    private String fatherid;

    //父编号
    @Column(value="fatherno")
    private String fatherno;

    //母id
    @Column(value="motherid")
    private String motherid;

    //母编号
    @Column(value="motherno")
    private String motherno;

    //录入方式[1:自动 0:手动]
    @Column(value="inputtype")
    private String inputtype;

    //识别码
    @Column(value="identificationcode")
    private String identificationcode;

    //设备类型(对应aa10表equipmenttype)
    @Column(value="equipmenttype")
    private String equipmenttype;

    //操作员
    @Column(value="aae011")
    private String aae011;

    //操作时间
    @Column(value="aae036")
    private String aae036;

    public String getAnimalinfoid() {
        return animalinfoid;
    }

    public void setAnimalinfoid(String animalinfoid) {
        this.animalinfoid = animalinfoid;
    }

    public String getFenceid() {
        return fenceid;
    }

    public void setFenceid(String fenceid) {
        this.fenceid = fenceid;
    }

    public String getAnimalno() {
        return animalno;
    }

    public void setAnimalno(String animalno) {
        this.animalno = animalno;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getHaircolor() {
        return haircolor;
    }

    public void setHaircolor(String haircolor) {
        this.haircolor = haircolor;
    }

    public String getCulturestyle() {
        return culturestyle;
    }

    public void setCulturestyle(String culturestyle) {
        this.culturestyle = culturestyle;
    }

    public String getWeaningdate() {
        return weaningdate;
    }

    public void setWeaningdate(String weaningdate) {
        this.weaningdate = weaningdate;
    }

    public String getWeaningweight() {
        return weaningweight;
    }

    public void setWeaningweight(String weaningweight) {
        this.weaningweight = weaningweight;
    }

    public String getDeathdate() {
        return deathdate;
    }

    public void setDeathdate(String deathdate) {
        this.deathdate = deathdate;
    }

    public String getDeathweight() {
        return deathweight;
    }

    public void setDeathweight(String deathweight) {
        this.deathweight = deathweight;
    }

    public String getFatherid() {
        return fatherid;
    }

    public void setFatherid(String fatherid) {
        this.fatherid = fatherid;
    }

    public String getFatherno() {
        return fatherno;
    }

    public void setFatherno(String fatherno) {
        this.fatherno = fatherno;
    }

    public String getMotherid() {
        return motherid;
    }

    public void setMotherid(String motherid) {
        this.motherid = motherid;
    }

    public String getMotherno() {
        return motherno;
    }

    public void setMotherno(String motherno) {
        this.motherno = motherno;
    }

    public String getInputtype() {
        return inputtype;
    }

    public void setInputtype(String inputtype) {
        this.inputtype = inputtype;
    }

    public String getIdentificationcode() {
        return identificationcode;
    }

    public void setIdentificationcode(String identificationcode) {
        this.identificationcode = identificationcode;
    }

    public String getEquipmenttype() {
        return equipmenttype;
    }

    public void setEquipmenttype(String equipmenttype) {
        this.equipmenttype = equipmenttype;
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
