package com.askj.oa.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * @Description Oamatterdynamic的中文含义是: oa事项动态; InnoDB free: 31744 kB
 * @Creation 2018/05/18 10:45:25
 * @Written Create Tool By syh
 **/
@Table(value = "Oamatterdynamic")
public class Oamatterdynamic {

    /**
     * oamatterdynamicid 的中文含义是：oa任务动态id
     */
    @Name
    @Column
    private String oamatterdynamicid;

    /**
     * othertableid 的中文含义是：其他表id
     */
    @Column
    private String othertableid;

    /**
     * replytype 的中文含义是：回复类型aaa100=replytype，0系统回复信息1相关人回复
     */
    @Column
    private String replytype;

    /**
     * replycontent 的中文含义是：动态内容
     */
    @Column
    private String replycontent;

    /**
     * aae011 的中文含义是：操作员
     */
    @Column
    private String aae011;

    /**
     * aae036 的中文含义是：操作时间
     */
    @Column
    private String aae036;


    public void setOamatterdynamicid(String oamatterdynamicid) {
        this.oamatterdynamicid = oamatterdynamicid;
    }

    public String getOamatterdynamicid() {
        return oamatterdynamicid;
    }

    public void setOthertableid(String othertableid) {
        this.othertableid = othertableid;
    }

    public String getOthertableid() {
        return othertableid;
    }

    public void setReplytype(String replytype) {
        this.replytype = replytype;
    }

    public String getReplytype() {
        return replytype;
    }

    public void setReplycontent(String replycontent) {
        this.replycontent = replycontent;
    }

    public String getReplycontent() {
        return replycontent;
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

