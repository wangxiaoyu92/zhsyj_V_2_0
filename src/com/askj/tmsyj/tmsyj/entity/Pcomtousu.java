package com.askj.tmsyj.tmsyj.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "Pcomtousu")
public class Pcomtousu {
/** 我要投诉; InnoDB free: 7168 kB  */
	/** pcomtousuid 的中文含义是：我要投诉id*/
	@Name
	@Column
	private String pcomtousuid;

	/** comid 的中文含义是：被投诉企业id*/
	@Column
	private String comid;

	/** tsrmc 的中文含义是：投诉人姓名*/
	@Column
	private String tsrmc;

	/** tsnr 的中文含义是：投诉内容*/
	@Column
	private String tsnr;

	/** tssj 的中文含义是：投诉时间*/
	@Column
	private String tssj;

	/** sfsl 的中文含义是：是否受理aaa100=shifoubz*/
	@Column
	private String sfsl;

	/** slrid 的中文含义是：受理人id*/
	@Column
	private String slrid;

	/** slrxm 的中文含义是：受理人姓名*/
	@Column
	private String slrxm;

	/** slyj 的中文含义是：受理意见*/
	@Column
	private String slyj;

	/** slsj 的中文含义是：受理时间*/
	@Column
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

}

