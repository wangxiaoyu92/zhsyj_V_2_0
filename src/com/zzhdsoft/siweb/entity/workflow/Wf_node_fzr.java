package com.zzhdsoft.siweb.entity.workflow;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

/**
 * @Description  Wf_node_fzr的中文含义是: 工作流节点负责人
 * @Creation     2018/06/08 16:35:53
 * @Written      Create Tool By zk
 **/
@Table(value = "WF_NODE_FZR")
public class Wf_node_fzr {

    /**
     * @Description wfnodefzrid的中文含义是： 工作流节点负责人id
     */
    @Column
    @Name
    private String wfnodefzrid;

    /**
     * @Description psbh的中文含义是： 工作流流程编号
     */
    @Column
    private String psbh;

    /**
     * @Description nodeid的中文含义是： 节点id
     */
    @Column
    private String nodeid;

    /**
     * @Description fzruserid的中文含义是： 负责人id
     */
    @Column
    private String fzruserid;

    /**
     * @Description czyuserid的中文含义是： 操作员id
     */
    @Column
    private String czyuserid;

    /**
     * @Description czsj的中文含义是： 操作时间
     */
    @Column
    private String czsj;

    public String getWfnodefzrid() {
        return wfnodefzrid;
    }

    public void setWfnodefzrid(String wfnodefzrid) {
        this.wfnodefzrid = wfnodefzrid;
    }

    public String getPsbh() {
        return psbh;
    }

    public void setPsbh(String psbh) {
        this.psbh = psbh;
    }

    public String getNodeid() {
        return nodeid;
    }

    public void setNodeid(String nodeid) {
        this.nodeid = nodeid;
    }

    public String getFzruserid() {
        return fzruserid;
    }

    public void setFzruserid(String fzruserid) {
        this.fzruserid = fzruserid;
    }

    public String getCzyuserid() {
        return czyuserid;
    }

    public void setCzyuserid(String czyuserid) {
        this.czyuserid = czyuserid;
    }

    public String getCzsj() {
        return czsj;
    }

    public void setCzsj(String czsj) {
        this.czsj = czsj;
    }
}
