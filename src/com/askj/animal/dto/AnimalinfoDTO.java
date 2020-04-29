package com.askj.animal.dto;

/**
 *
 *  AnimalinfoDTO：动物信息
 *
 *  AnimalinfoDTO的描述：
 *
 *  @author : zk
 *  @version : V1.0
 */
public class AnimalinfoDTO {
    //动物信息id
    private String animalinfoid;

    //栅栏id
    private String fenceid;

    //动物编号
    private String animalno;

    //出生日期
    private String birthday;

    //动物性别[1:公 0:母]
    private String sex;

    //毛发颜色(对应aa10表haircolor)
    private String haircolor;

    //养殖类型(对应aa10表culturestyle)
    private String culturestyle;

    //断奶日期
    private String weaningdate;

    //断奶体重
    private String weaningweight;

    //死亡日期
    private String deathdate;

    //死亡体重
    private String deathweight;

    //父id
    private String fatherid;

    //父编号
    private String fatherno;

    //母id
    private String motherid;

    //母编号
    private String motherno;

    //录入方式[1:自动 0:手动]
    private String inputtype;

    //识别码
    private String identificationcode;

    //设备类型(对应aa10表equipmenttype)
    private String equipmenttype;

    //操作员
    private String aae011;

    //操作时间
    private String aae036;

    //栅栏名称
    private String fencename;

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

    public String getFencename() {
        return fencename;
    }

    public void setFencename(String fencename) {
        this.fencename = fencename;
    }
}
