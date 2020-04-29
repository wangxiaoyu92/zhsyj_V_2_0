package com.askj.jyjc.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class JyjcndwjDTO {

	/** 商品名称*/
	private String mc;

/** 检验检测你点我检; InnoDB free: 7168 kB  */
	/** jyjcndwjid 的中文含义是：检验检测你点我检id*/
	private String jyjcndwjid;

	/** jcypid 的中文含义是：商品id(仪器对接用)*/
	private String aaa027;

	/** jcypmc 的中文含义是：商品名称(仪器对接用-样品名称)*/
	private String ndwjjcyp;

	/** commc 的中文含义是：希望检测的商家或市场*/
	private String ndwjddfl;

	/** jxjcxmmc 的中文含义是：希望检测的项目*/
	private String commc;

	/** jcreason 的中文含义是：希望检测的原因*/
	private String jcreason;

	/** sfgk 的中文含义是：是否公开aaa100=shifoubz*/
	private String sfgk;

	/** sqrxm 的中文含义是：申请人姓名*/
	private String sqrxm;

	/** ryxb 的中文含义是：申请人员性别aaa100=ryxb*/
	private String ryxb;

	/** sqrtel 的中文含义是：申请人电话*/
	private String sqrtel;

	/** sqsj 的中文含义是：申请时间*/
	private String sqsj;
	private String sqstdate;
	private String sqeddate;

	public String getSqstdate() {
		return sqstdate;
	}

	public void setSqstdate(String sqstdate) {
		this.sqstdate = sqstdate;
	}

	public String getSqeddate() {
		return sqeddate;
	}

	public void setSqeddate(String sqeddate) {
		this.sqeddate = sqeddate;
	}

	public void setJyjcndwjid(String jyjcndwjid){
		this.jyjcndwjid=jyjcndwjid;
	}

	public String getJyjcndwjid(){
		return jyjcndwjid;
	}

	public void setCommc(String commc){
		this.commc=commc;
	}

	public String getCommc(){
		return commc;
	}

	public void setJcreason(String jcreason){
		this.jcreason=jcreason;
	}

	public String getJcreason(){
		return jcreason;
	}

	public void setSfgk(String sfgk){
		this.sfgk=sfgk;
	}

	public String getSfgk(){
		return sfgk;
	}

	public void setSqrxm(String sqrxm){
		this.sqrxm=sqrxm;
	}

	public String getSqrxm(){
		return sqrxm;
	}

	public void setRyxb(String ryxb){
		this.ryxb=ryxb;
	}

	public String getRyxb(){
		return ryxb;
	}

	public void setSqrtel(String sqrtel){
		this.sqrtel=sqrtel;
	}

	public String getSqrtel(){
		return sqrtel;
	}

	public void setSqsj(String sqsj){
		this.sqsj=sqsj;
	}

	public String getSqsj(){
		return sqsj;
	}

	public String getAaa027() {
		return aaa027;
	}

	public void setAaa027(String aaa027) {
		this.aaa027 = aaa027;
	}

	public String getNdwjjcyp() {
		return ndwjjcyp;
	}

	public void setNdwjjcyp(String ndwjjcyp) {
		this.ndwjjcyp = ndwjjcyp;
	}

	public String getNdwjddfl() {
		return ndwjddfl;
	}

	public void setNdwjddfl(String ndwjddfl) {
		this.ndwjddfl = ndwjddfl;
	}

	public String getMc() {
		return mc;
	}

	public void setMc(String mc) {
		this.mc = mc;
	}
}

