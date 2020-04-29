package com.askj.animal.dto;

/**
 *
 *  AnimaldeathDTO：动物死亡信息
 *
 *  AnimaldeathDTO的描述：
 *
 *  @author : zk
 *  @version : V1.0
 */
public class AnimaldeathDTO {
    //动物死亡信息id
    private String animaldeathid;

    //动物信息id
    private String animalinfoid;

    //死亡时间
    private String deathdate;

    //死亡体重
    private String deathweight;

    //死亡原因(对应aa10表deathreason)
    private String deathreason;

    //处理方法(对应aa10表treatmentmode)
    private String treatmentmode;

    //症状及用药描述
    private String symptom;

    //动物编号
    private String animalinfono;

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

    public String getAnimalinfono() {
        return animalinfono;
    }

    public void setAnimalinfono(String animalinfono) {
        this.animalinfono = animalinfono;
    }
}
