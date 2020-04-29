package com.askj.jyjc.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

/**
 * @Description  JYCJSSXZ的中文含义是: 安全监督抽检实施细则;
 * Created by ce on 2018/5/18.
 */
@Table(value = "JYCJSSXZ")
public class Jycjssxz {

    /**
     * @Description jycjssxzid的中文含义是： 安全监督抽检实施细则id
     */
    @Column
    @Name
    private String jycjssxzid;

    /**
     * @Description viewjycjcpflid的中文含义是： 抽检产品分类主键
     */
    @Column
    private String viewjycjcpflid;

    /**
     * @Description syfw的中文含义是： 适用范围
     */
    @Column
    private String syfw;

    /**
     * @Description cpzl的中文含义是： 产品种类
     */
    @Column
    private String cpzl;

    /**
     * @Description jyjj的中文含义是： 检验依据
     */
    @Column
    private String jyjj;

    /**
     * @Description cyxhhgg的中文含义是： 抽样型号或规格
     */
    @Column
    private String cyxhhgg;

    /**
     * @Description cyffjsl的中文含义是： 抽样方法及数量
     */
    @Column
    private String cyffjsl;

    /**
     * @Description cyd的中文含义是： 抽样单
     */
    @Column
    private String cyd;

    /**
     * @Description fyhypyszc的中文含义是： 封样和样品运输贮存
     */
    @Column
    private String fyhypyszc;

    /**
     * @Description jyxmdesc的中文含义是： 检验项目【明细检验项目在另外表存】
     */
    @Column
    private String jyxmdesc;

    /**
     * @Description pdyzyjl的中文含义是： 判断原则与结论
     */
    @Column
    private String pdyzyjl;

    /**
     * @Description zhms的中文含义是： 综合描述
     */
    @Column
    private String zhms;

    /**
     * @Description aae011的中文含义是： 操作员
     */
    @Column
    private String aae011;

    /**
     * @Description aae036的中文含义是： 操作时间
     */
    @Column
    private String aae036;

    public String getJycjssxzid() {
        return jycjssxzid;
    }

    public void setJycjssxzid(String jycjssxzid) {
        this.jycjssxzid = jycjssxzid;
    }

    public String getViewjycjcpflid() {
        return viewjycjcpflid;
    }

    public void setViewjycjcpflid(String viewjycjcpflid) {
        this.viewjycjcpflid = viewjycjcpflid;
    }

    public String getSyfw() {
        return syfw;
    }

    public void setSyfw(String syfw) {
        this.syfw = syfw;
    }

    public String getCpzl() {
        return cpzl;
    }

    public void setCpzl(String cpzl) {
        this.cpzl = cpzl;
    }

    public String getJyjj() {
        return jyjj;
    }

    public void setJyjj(String jyjj) {
        this.jyjj = jyjj;
    }

    public String getCyxhhgg() {
        return cyxhhgg;
    }

    public void setCyxhhgg(String cyxhhgg) {
        this.cyxhhgg = cyxhhgg;
    }

    public String getCyffjsl() {
        return cyffjsl;
    }

    public void setCyffjsl(String cyffjsl) {
        this.cyffjsl = cyffjsl;
    }

    public String getCyd() {
        return cyd;
    }

    public void setCyd(String cyd) {
        this.cyd = cyd;
    }

    public String getFyhypyszc() {
        return fyhypyszc;
    }

    public void setFyhypyszc(String fyhypyszc) {
        this.fyhypyszc = fyhypyszc;
    }

    public String getJyxmdesc() {
        return jyxmdesc;
    }

    public void setJyxmdesc(String jyxmdesc) {
        this.jyxmdesc = jyxmdesc;
    }

    public String getPdyzyjl() {
        return pdyzyjl;
    }

    public void setPdyzyjl(String pdyzyjl) {
        this.pdyzyjl = pdyzyjl;
    }

    public String getZhms() {
        return zhms;
    }

    public void setZhms(String zhms) {
        this.zhms = zhms;
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
