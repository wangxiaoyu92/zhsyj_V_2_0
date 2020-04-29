package com.askj.oa.dto;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * @Description Oamatterdynamic的中文含义是: oa事项动态; InnoDB free: 31744 kB
 * @Creation 2018/05/18 10:50:25
 * @Written Create Tool By syh
 **/

public class OamatterdynamicDTO {
    /********************************扩展字段开始************************************/
    private String remark;// 备注
    private String oataskid;// 任务id
    private String oameetingid;// 会议id
    private String shifouhuiyi;// 判断会议或者任务的标志位

    public String getOataskid() {
        return oataskid;
    }

    public void setOataskid(String oataskid) {
        this.oataskid = oataskid;
    }

    public String getOameetingid() {
        return oameetingid;
    }

    public void setOameetingid(String oameetingid) {
        this.oameetingid = oameetingid;
    }

    public String getShifouhuiyi() {
        return shifouhuiyi;
    }

    public void setShifouhuiyi(String shifouhuiyi) {
        this.shifouhuiyi = shifouhuiyi;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }


    /********************************扩展字段结束************************************/

    /**
     * oamatterdynamicid 的中文含义是：oa任务动态id
     */
    private String oamatterdynamicid;

    /**
     * othertableid 的中文含义是：其他表id
     */
    private String othertableid;

    /**
     * replytype 的中文含义是：回复类型aaa100=replytype，0系统回复信息1相关人回复
     */
    private String replytype;

    /**
     * replycontent 的中文含义是：动态内容
     */
    private String replycontent;

    /**
     * aae011 的中文含义是：操作员
     */
    private String aae011;

    /**
     * aae036 的中文含义是：操作时间
     */
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

