package com.askj.oa.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * @Description Oameetingtask的中文含义是: oa会议纪要任务表; InnoDB free: 31744 kB
 * @Creation 2018/05/18 11:18:33
 * @Written Create Tool By syh
 **/
@Table(value = "Oameetingtask")
public class Oameetingtask {

    /**
     * oameetingtaskid 的中文含义是：oa会议纪要任务表
     */
    @Name
    @Column
    private String oameetingtaskid;

    /**
     * oameetingid 的中文含义是：oa会议表id
     */
    @Column
    private String oameetingid;

    /**
     * oataskid 的中文含义是：oa任务表id
     */
    @Column
    private String oataskid;

    /**
     * aae011 的中文含义是：经办人
     */
    @Column
    private String aae011;

    /**
     * aae036 的中文含义是：经办时间
     */
    @Column
    private String aae036;


    public void setOameetingtaskid(String oameetingtaskid) {
        this.oameetingtaskid = oameetingtaskid;
    }

    public String getOameetingtaskid() {
        return oameetingtaskid;
    }

    public void setOameetingid(String oameetingid) {
        this.oameetingid = oameetingid;
    }

    public String getOameetingid() {
        return oameetingid;
    }

    public void setOataskid(String oataskid) {
        this.oataskid = oataskid;
    }

    public String getOataskid() {
        return oataskid;
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

