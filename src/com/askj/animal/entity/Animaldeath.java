package com.askj.animal.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

/**
 *
 *  Animaldeath：动物死亡信息
 *
 *  Animaldeath的描述：
 *
 *  @author : zk
 *  @version : V1.0
 */
@Table(value = "animaldeath")
public class Animaldeath {

    //动物死亡信息id
    @Name
    @Column(value="animaldeathid")
    private String animaldeathid;

    //动物信息id
    @Column(value="animalinfoid")
    private String animalinfoid;

    //死亡时间
    @Column(value="deathdate")
    private String deathdate;

    //死亡体重
    @Column(value="deathweight")
    private String deathweight;

    //死亡原因(对应aa10表deathreason)
    @Column(value="deathreason")
    private String deathreason;

    //处理方法(对应aa10表treatmentmode)
    @Column(value="treatmentmode")
    private String treatmentmode;

    //症状及用药描述
    @Column(value="symptom")
    private String symptom;

    public String getAnimaldeathid() {
        return animaldeathid;
    }

    public void setAnimaldeathid(String animaldeathid) {
        this.animaldeathid = animaldeathid;
    }

    public String getAnimalinfoid() {
        return animalinfoid;
    }

    public void setAnimalinfoid(String animalinfoid) {
        this.animalinfoid = animalinfoid;
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

    public String getDeathreason() {
        return deathreason;
    }

    public void setDeathreason(String deathreason) {
        this.deathreason = deathreason;
    }

    public String getTreatmentmode() {
        return treatmentmode;
    }

    public void setTreatmentmode(String treatmentmode) {
        this.treatmentmode = treatmentmode;
    }

    public String getSymptom() {
        return symptom;
    }

    public void setSymptom(String symptom) {
        this.symptom = symptom;
    }
}
