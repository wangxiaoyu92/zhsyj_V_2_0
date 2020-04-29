package com.askj.tmsyj.tmsyj.dto;

public class PcomtousuDTO {

	private String commc;

/** 我要投诉; InnoDB free: 7168 kB  */
	/** pcomtousuid 的中文含义是：我要投诉id*/
	private String pcomtousuid;

	/** comid 的中文含义是：被投诉企业id*/
	private String comid;

	/** tsrmc 的中文含义是：投诉人姓名*/
	private String tsrmc;

	/** tsnr 的中文含义是：投诉内容*/
	private String tsnr;

	/** tssj 的中文含义是：投诉时间*/
	private String tssj;

	/** sfsl 的中文含义是：是否受理aaa100=shifoubz*/
	private String sfsl;

	/** slrid 的中文含义是：受理人id*/
	private String slrid;

	/** slrxm 的中文含义是：受理人姓名*/
	private String slrxm;

	/** slyj 的中文含义是：受理意见*/
	private String slyj;

	/** slsj 的中文含义是：受理时间*/
	private String slsj;


	public void setPcomtousuid(String pcomtousuid){
		this.pcomtousuid=pcomtousuid;
	}

	public String getPcomtousuid(){
		return pcomtousuid;
	}

	public void setComid(String comid){
		this.comid=comid;
	}

	public String getComid(){
		return comid;
	}

	public void setTsrmc(String tsrmc){
		this.tsrmc=tsrmc;
	}

	public String getTsrmc(){
		return tsrmc;
	}

	public void setTsnr(String tsnr){
		this.tsnr=tsnr;
	}

	public String getTsnr(){
		return tsnr;
	}

	public void setTssj(String tssj){
		this.tssj=tssj;
	}

	public String getTssj(){
		return tssj;
	}

	public void setSfsl(String sfsl){
		this.sfsl=sfsl;
	}

	public String getSfsl(){
		return sfsl;
	}

	public void setSlrid(String slrid){
		this.slrid=slrid;
	}

	public String getSlrid(){
		return slrid;
	}

	public void setSlrxm(String slrxm){
		this.slrxm=slrxm;
	}

	public String getSlrxm(){
		return slrxm;
	}

	public void setSlyj(String slyj){
		this.slyj=slyj;
	}

	public String getSlyj(){
		return slyj;
	}

	public void setSlsj(String slsj){
		this.slsj=slsj;
	}

	public String getSlsj(){
		return slsj;
	}

	public String getCommc() {
		return commc;
	}

	public void setCommc(String commc) {
		this.commc = commc;
	}
}

