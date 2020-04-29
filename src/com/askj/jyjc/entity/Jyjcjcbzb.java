package com.askj.jyjc.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Timestamp;

/**
 * @DDescription  JYJCJCBZB中文含义是：检验检测检测标准表
 * Created by dpx on 2018/5/15.
 */
@Table(value = "JYJCJCBZB")
public class Jyjcjcbzb {
    @Column
    @Name
    private String jyjcjcbzbid;
    @Column
    private String jyjcbzfenlei;
    @Column
    private String bzbh;
    @Column
    private String engname;
    @Column
    private String chinaname;
    @Column
    private String jyjcbzstate;
    @Column
    private String tdqk;
    @Column
    private String jyjczbfenlei;
    @Column
    private String jyjcicsfenlei;
    @Column
    private String jyjcudcfenlei;
    @Column
    private String fbbm;
    @Column
    private Timestamp fbrq;
    @Column
    private Timestamp ssrq;
    @Column
    private Timestamp zfrq;
    @Column
    private Timestamp sfrq;
    @Column
    private Timestamp fsrq;
    @Column
    private String tcdw;
    @Column
    private String gkdw;
    @Column
    private String zgbm;
    @Column
    private String qcdw;
    @Column
    private String rcr;
    @Column
    private String bzcontent;
    @Column
    private String aae011;
    @Column
    private String aae036;
    @Column
    private String sfyx;

    public String getJyjcjcbzbid() {
        return jyjcjcbzbid;
    }

    public void setJyjcjcbzbid(String jyjcjcbzbid) {
        this.jyjcjcbzbid = jyjcjcbzbid;
    }

    public String getJyjcbzfenlei() {
        return jyjcbzfenlei;
    }

    public void setJyjcbzfenlei(String jyjcbzfenlei) {
        this.jyjcbzfenlei = jyjcbzfenlei;
    }

    public String getBzbh() {
        return bzbh;
    }

    public void setBzbh(String bzbh) {
        this.bzbh = bzbh;
    }

    public String getEngname() {
        return engname;
    }

    public void setEngname(String engname) {
        this.engname = engname;
    }

    public String getChinaname() {
        return chinaname;
    }

    public void setChinaname(String chinaname) {
        this.chinaname = chinaname;
    }

    public String getJyjcbzstate() {
        return jyjcbzstate;
    }

    public void setJyjcbzstate(String jyjcbzstate) {
        this.jyjcbzstate = jyjcbzstate;
    }

    public String getTdqk() {
        return tdqk;
    }

    public void setTdqk(String tdqk) {
        this.tdqk = tdqk;
    }

    public String getJyjczbfenlei() {
        return jyjczbfenlei;
    }

    public void setJyjczbfenlei(String jyjczbfenlei) {
        this.jyjczbfenlei = jyjczbfenlei;
    }

    public String getJyjcicsfenlei() {
        return jyjcicsfenlei;
    }

    public void setJyjcicsfenlei(String jyjcicsfenlei) {
        this.jyjcicsfenlei = jyjcicsfenlei;
    }

    public String getJyjcudcfenlei() {
        return jyjcudcfenlei;
    }

    public void setJyjcudcfenlei(String jyjcudcfenlei) {
        this.jyjcudcfenlei = jyjcudcfenlei;
    }

    public String getFbbm() {
        return fbbm;
    }

    public void setFbbm(String fbbm) {
        this.fbbm = fbbm;
    }

    public String getTcdw() {
        return tcdw;
    }

    public void setTcdw(String tcdw) {
        this.tcdw = tcdw;
    }

    public String getGkdw() {
        return gkdw;
    }

    public void setGkdw(String gkdw) {
        this.gkdw = gkdw;
    }

    public String getZgbm() {
        return zgbm;
    }

    public void setZgbm(String zgbm) {
        this.zgbm = zgbm;
    }

    public String getQcdw() {
        return qcdw;
    }

    public void setQcdw(String qcdw) {
        this.qcdw = qcdw;
    }

    public String getRcr() {
        return rcr;
    }

    public void setRcr(String rcr) {
        this.rcr = rcr;
    }

    public String getBzcontent() {
        return bzcontent;
    }

    public void setBzcontent(String bzcontent) {
        this.bzcontent = bzcontent;
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

    public String getSfyx() {
        return sfyx;
    }

    public void setSfyx(String sfyx) {
        this.sfyx = sfyx;
    }

    public Timestamp getFbrq() {
        return fbrq;
    }

    public void setFbrq(Timestamp fbrq) {
        this.fbrq = fbrq;
    }

    public Timestamp getSsrq() {
        return ssrq;
    }

    public void setSsrq(Timestamp ssrq) {
        this.ssrq = ssrq;
    }

    public Timestamp getZfrq() {
        return zfrq;
    }

    public void setZfrq(Timestamp zfrq) {
        this.zfrq = zfrq;
    }

    public Timestamp getSfrq() {
        return sfrq;
    }

    public void setSfrq(Timestamp sfrq) {
        this.sfrq = sfrq;
    }

    public Timestamp getFsrq() {
        return fsrq;
    }

    public void setFsrq(Timestamp fsrq) {
        this.fsrq = fsrq;
    }
}
