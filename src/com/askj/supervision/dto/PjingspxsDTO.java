package com.askj.supervision.dto;

import org.nutz.dao.entity.annotation.Column;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class PjingspxsDTO {
	//扩展开始
	/** userid 的中文含义是：userid*/
	private String userid;

	//扩展结束

/** 食品销售企业静态风险因素量化分值表; InnoDB free: 14336 kB  */
	/** pjingspxsid 的中文含义是：食品销售企业静态风险因素量化分值表*/
	private String pjingspxsid;

	/** comid 的中文含义是：企业id*/
	private String comid;

	/** ayear 的中文含义是：年度*/
	private String checkyear;

	/** spjycsmj 的中文含义是：食品经营场所面积*/
	private String spjycsmj;

	/** ybzcw 的中文含义是：预包装食品单品数常温*/
	private String ybzcw;

	/** ybzlc 的中文含义是：预包装食品单品数冷藏*/
	private String ybzlc;

	/** ybzld 的中文含义是：预包装食品单品数冷冻*/
	private String ybzld;

	/** szcw 的中文含义是：散装食品单品数常温*/
	private String szcw;

	/** szlc 的中文含义是：散装食品单品数冷藏*/
	private String szlc;

	/** szld 的中文含义是：散装食品单品数冷冻*/
	private String szld;

	/** ghzsl 的中文含义是：供货者数量*/
	private String ghzsl;

	/** dfzh 的中文含义是：得分总和*/
	private String dfzh;

	/** aae011 的中文含义是：操作员*/
	private String aae011;

	/** aae036 的中文含义是：操作时间*/
	private Timestamp aae036;


	/** resultid 的中文含义是：*/
	private String resultid ;


	public void setPjingspxsid(String pjingspxsid){
		this.pjingspxsid=pjingspxsid;
	}

	public String getPjingspxsid(){
		return pjingspxsid;
	}

	public void setComid(String comid){
		this.comid=comid;
	}

	public String getComid(){
		return comid;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getCheckyear() {
		return checkyear;
	}

	public void setCheckyear(String checkyear) {
		this.checkyear = checkyear;
	}

	public String getSpjycsmj() {
		return spjycsmj;
	}

	public void setSpjycsmj(String spjycsmj) {
		this.spjycsmj = spjycsmj;
	}

	public String getYbzcw() {
		return ybzcw;
	}

	public void setYbzcw(String ybzcw) {
		this.ybzcw = ybzcw;
	}

	public String getYbzlc() {
		return ybzlc;
	}

	public void setYbzlc(String ybzlc) {
		this.ybzlc = ybzlc;
	}

	public String getYbzld() {
		return ybzld;
	}

	public void setYbzld(String ybzld) {
		this.ybzld = ybzld;
	}

	public String getSzcw() {
		return szcw;
	}

	public void setSzcw(String szcw) {
		this.szcw = szcw;
	}

	public String getSzlc() {
		return szlc;
	}

	public void setSzlc(String szlc) {
		this.szlc = szlc;
	}

	public String getSzld() {
		return szld;
	}

	public void setSzld(String szld) {
		this.szld = szld;
	}

	public String getGhzsl() {
		return ghzsl;
	}

	public void setGhzsl(String ghzsl) {
		this.ghzsl = ghzsl;
	}

	public String getDfzh() {
		return dfzh;
	}

	public void setDfzh(String dfzh) {
		this.dfzh = dfzh;
	}

	public String getAae011() {
		return aae011;
	}

	public void setAae011(String aae011) {
		this.aae011 = aae011;
	}

	public Timestamp getAae036() {
		return aae036;
	}

	public void setAae036(Timestamp aae036) {
		this.aae036 = aae036;
	}

	public String getResultid() {
		return resultid;
	}

	public void setResultid(String resultid) {
		this.resultid = resultid;
	}
}

