package com.askj.tmsyj.tmcsc.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "Psh")
public class Psh {
/** 商户表  */
	/** pshid 的中文含义是：商户id*/
	@Name
	@Column
	private String pshid;

	/** comid 的中文含义是：市场id*/
	@Column
	private String comid;

	/** pscfqid 的中文含义是：市场分区id*/
	@Column
	private String pscfqid;

	/** shtwh 的中文含义是：商户摊位号*/
	@Column
	private String shtwh;

	/** shmc 的中文含义是：商户名称*/
	@Column
	private String shmc;

	/** shjc 的中文含义是：商户简称*/
	@Column
	private String shjc;

	/** shlxr 的中文含义是：商户联系人*/
	@Column
	private String shlxr;

	/** shtxdz 的中文含义是：商户通讯地址*/
	@Column
	private String shtxdz;

	/** shyddh 的中文含义是：移动电话*/
	@Column
	private String shyddh;

	/** shgddh 的中文含义是：固定电话*/
	@Column
	private String shgddh;

	/** shsfzh 的中文含义是：身份证号*/
	@Column
	private String shsfzh;

	/** shzzzmmc 的中文含义是：资质证明名称*/
	@Column
	private String shzzzmmc;

	/** shzzzmbh 的中文含义是：资质证明编号*/
	@Column
	private String shzzzmbh;


	public void setPshid(String pshid){
		this.pshid=pshid;
	}

	public String getPshid(){
		return pshid;
	}

	public void setComid(String comid){
		this.comid=comid;
	}

	public String getComid(){
		return comid;
	}

	public void setPscfqid(String pscfqid){
		this.pscfqid=pscfqid;
	}

	public String getPscfqid(){
		return pscfqid;
	}

	public void setShtwh(String shtwh){
		this.shtwh=shtwh;
	}

	public String getShtwh(){
		return shtwh;
	}

	public void setShmc(String shmc){
		this.shmc=shmc;
	}

	public String getShmc(){
		return shmc;
	}

	public void setShjc(String shjc){
		this.shjc=shjc;
	}

	public String getShjc(){
		return shjc;
	}

	public void setShlxr(String shlxr){
		this.shlxr=shlxr;
	}

	public String getShlxr(){
		return shlxr;
	}

	public void setShtxdz(String shtxdz){
		this.shtxdz=shtxdz;
	}

	public String getShtxdz(){
		return shtxdz;
	}

	public void setShyddh(String shyddh){
		this.shyddh=shyddh;
	}

	public String getShyddh(){
		return shyddh;
	}

	public void setShgddh(String shgddh){
		this.shgddh=shgddh;
	}

	public String getShgddh(){
		return shgddh;
	}

	public void setShsfzh(String shsfzh){
		this.shsfzh=shsfzh;
	}

	public String getShsfzh(){
		return shsfzh;
	}

	public void setShzzzmmc(String shzzzmmc){
		this.shzzzmmc=shzzzmmc;
	}

	public String getShzzzmmc(){
		return shzzzmmc;
	}

	public void setShzzzmbh(String shzzzmbh){
		this.shzzzmbh=shzzzmbh;
	}

	public String getShzzzmbh(){
		return shzzzmbh;
	}

}

