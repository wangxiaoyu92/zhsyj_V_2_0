package com.askj.oa.dto;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * @Description Oatasktransfer的中文含义是: oa任务转交表; InnoDB free: 31744 kB
 * @Creation 2018/05/18 11:37:35
 * @Written Create Tool By syh
 **/
public class OatasktransferDTO {

    /**
     * oatasktransferid 的中文含义是：oa任务转交表id
     */
    private String oatasktransferid;

    /**
     * oataskmanid 的中文含义是：oa任务关联人表id
     */
    private String oataskmanid;

    /**
     * oataskmannewid 的中文含义是：oa任务关联人表newid
     */
    private String oataskmannewid;

    /**
     * aae011 的中文含义是：经办人
     */
    private String aae011;

    /**
     * aae036 的中文含义是：经办时间
     */
    private String aae036;


    public void setOatasktransferid(String oatasktransferid) {
        this.oatasktransferid = oatasktransferid;
    }

    public String getOatasktransferid() {
        return oatasktransferid;
    }

    public void setOataskmanid(String oataskmanid) {
        this.oataskmanid = oataskmanid;
    }

    public String getOataskmanid() {
        return oataskmanid;
    }

    public void setOataskmannewid(String oataskmannewid) {
        this.oataskmannewid = oataskmannewid;
    }

    public String getOataskmannewid() {
        return oataskmannewid;
    }

    public void setAae011(String aae011) {
        this.aae011 = aae011;
    }

    public String getAae011() {
        return aae011;
    }

    public void setAae036(String aae036) {
        this.aae036 = aae036;
    }

    public String getAae036() {
        return aae036;
    }

}

