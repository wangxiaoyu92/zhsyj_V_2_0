package com.askj.supervision.dto;

import com.askj.baseinfo.dto.OmLawContentDTO;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * @Description BscheckbasisDTO的中文含义是: 检查依据DTO; InnoDB free: 2715648 kBDTO
 * @Creation 2017/9/21
 * @Written sunyfieng.
 */
public class OmcheckbasisDTO {

    /**
     * flfgInfo 的中文含义是：检查内容－法律法规内容
     */
    private String flfgInfo;

    /**
     * problemInfo 的中文含义是：检查内容－检查问题内容
     */
    private String problemInfo;

    /** content 的中文含义是：检查内容*/
    private String content;

    /** contentdesc 的中文含义是：检查内容描述*/
    private String contentdesc;

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getContentdesc() {
        return contentdesc;
    }

    public void setContentdesc(String contentdesc) {
        this.contentdesc = contentdesc;
    }

    public String getFlfgInfo() {
        return flfgInfo;
    }

    public String getProblemInfo() {
        return problemInfo;
    }

    public void setFlfgInfo(String flfgInfo) {
        this.flfgInfo = flfgInfo;
    }

    public void setProblemInfo(String problemInfo) {
        this.problemInfo = problemInfo;
    }

    /**
     * cbid 的中文含义是：检查内容－检查依据表主键ID
     */
    private String cbid;

    /**
     * contentid 的中文含义是：检查内容ID
     */
    private String contentid;

    /**
     * basisid 的中文含义是：检查依据表ID
     */
    private String basisid;


    /**
     * type 的中文含义是：检查方式
     */
    private String type;

    /**
     * typedesc 的中文含义是：检查方式描述
     */
    private String typedesc;

    /**
     * guide 的中文含义是：检查指南
     */
    private String guide;

    /**
     * punishmeasures 的中文含义是：处罚措施
     */
    private String punishmeasures;

    /**
     * basisdesc 的中文含义是：检查依据描述
     */
    private String basisdesc;

    /**
     * legalitemid 的中文含义是：检查依据法律条款关系表主键
     */
    private String blid;

    /**
     * legalitemid 的中文含义是：法律条款表主键
     */
    private String legalitemid;

    /**
     * bpid 的中文含义是：问题关系表主键
     */
    private String bpid;

    /**
     * problemid 的中文含义是：主键
     */
    private String problemid;

    /**
     * problemdesc 的中文含义是：问题描述
     */
    private String problemdesc;

    /**
     * resultid 的中文含义是：结果ID
     */
    private String resultid;

    /**
     * operatorname 的中文含义是：经办人名称
     */
    private String operatorname;

    /**
     * operatedate 的中文含义是：经办时间
     */
    private Timestamp operatedate;

    /**
     * sort 的中文含义是：排序
     */
    private String sort;

    /**
     * basiscode 的中文含义是：检查依据编号
     */
    private String basiscode;

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public String getBasiscode() {
        return basiscode;
    }

    public void setBasiscode(String basiscode) {
        this.basiscode = basiscode;
    }

    private List<OmLawContentDTO> lawList = new ArrayList<OmLawContentDTO>();

    public String getCbid() {
        return cbid;
    }

    public void setCbid(String cbid) {
        this.cbid = cbid;
    }

    public String getContentid() {
        return contentid;
    }

    public void setContentid(String contentid) {
        this.contentid = contentid;
    }

    public String getBasisid() {
        return basisid;
    }

    public void setBasisid(String basisid) {
        this.basisid = basisid;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTypedesc() {
        return typedesc;
    }

    public void setTypedesc(String typedesc) {
        this.typedesc = typedesc;
    }

    public String getGuide() {
        return guide;
    }

    public void setGuide(String guide) {
        this.guide = guide;
    }

    public String getPunishmeasures() {
        return punishmeasures;
    }

    public void setPunishmeasures(String punishmeasures) {
        this.punishmeasures = punishmeasures;
    }

    public String getBasisdesc() {
        return basisdesc;
    }

    public void setBasisdesc(String basisdesc) {
        this.basisdesc = basisdesc;
    }

    public String getBlid() {
        return blid;
    }

    public void setBlid(String blid) {
        this.blid = blid;
    }

    public String getLegalitemid() {
        return legalitemid;
    }

    public void setLegalitemid(String legalitemid) {
        this.legalitemid = legalitemid;
    }

    public String getBpid() {
        return bpid;
    }

    public void setBpid(String bpid) {
        this.bpid = bpid;
    }

    public String getProblemid() {
        return problemid;
    }

    public void setProblemid(String problemid) {
        this.problemid = problemid;
    }

    public String getProblemdesc() {
        return problemdesc;
    }

    public void setProblemdesc(String problemdesc) {
        this.problemdesc = problemdesc;
    }

    public List<OmLawContentDTO> getLawList() {
        return lawList;
    }

    public void setLawList(List<OmLawContentDTO> lawList) {
        this.lawList = lawList;
    }

    public String getResultid() { return resultid; }

    public void setResultid(String resultid) { this.resultid = resultid; }

    public String getOperatorname() { return operatorname; }

    public void setOperatorname(String operatorname) { this.operatorname = operatorname; }

    public Timestamp getOperatedate() { return operatedate; }

    public void setOperatedate(Timestamp operatedate) { this.operatedate = operatedate; }
}
