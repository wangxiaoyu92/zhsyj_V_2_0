package com.askj.baseinfo.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "Pcheckfreg")
public class Pcheckfreg {
/** 检查频次表; InnoDB free: 4096 kB  */
	/** pcheckfregid 的中文含义是：检查频次表id*/
	@Name
	@Column
	private String pcheckfregid;

	/** orgprop 的中文含义是：科室属性*/
	@Column
	private String orgprop;

	/** orgpropdesc 的中文含义是：科室属性描述*/
	@Column
	private String orgpropdesc;

	/** itemtype 的中文含义是：检查类型*/
	@Column
	private String itemtype;

	/** itemtypedesc 的中文含义是：检查类型描述*/
	@Column
	private String itemtypedesc;

	/** lhfjndpddj 的中文含义是：评定等级*/
	@Column
	private String lhfjndpddj;

	/** lhfjndpddjdesc 的中文含义是：评定等级描述*/
	@Column
	private String lhfjndpddjdesc;

	/** checkpc 的中文含义是：检查频次*/
	@Column
	private Short checkpc;

	/** plancodebz 的中文含义是：生成计划编码标志*/
	@Column
	private String plancodebz;

	/** plannamebz 的中文含义是：生成计划名称标志*/
	@Column
	private String plannamebz;

	/** czy 的中文含义是：操作员*/
	@Column
	private String czy;

	/** czsj 的中文含义是：操作时间*/
	@Column
	private Timestamp czsj;


	public void setPcheckfregid(String pcheckfregid){
		this.pcheckfregid=pcheckfregid;
	}

	public String getPcheckfregid(){
		return pcheckfregid;
	}

	public void setOrgprop(String orgprop){
		this.orgprop=orgprop;
	}

	public String getOrgprop(){
		return orgprop;
	}

	public void setOrgpropdesc(String orgpropdesc){
		this.orgpropdesc=orgpropdesc;
	}

	public String getOrgpropdesc(){
		return orgpropdesc;
	}

	public void setItemtype(String itemtype){
		this.itemtype=itemtype;
	}

	public String getItemtype(){
		return itemtype;
	}

	public void setItemtypedesc(String itemtypedesc){
		this.itemtypedesc=itemtypedesc;
	}

	public String getItemtypedesc(){
		return itemtypedesc;
	}

	public void setLhfjndpddj(String lhfjndpddj){
		this.lhfjndpddj=lhfjndpddj;
	}

	public String getLhfjndpddj(){
		return lhfjndpddj;
	}

	public void setLhfjndpddjdesc(String lhfjndpddjdesc){
		this.lhfjndpddjdesc=lhfjndpddjdesc;
	}

	public String getLhfjndpddjdesc(){
		return lhfjndpddjdesc;
	}

	public void setCheckpc(Short checkpc){
		this.checkpc=checkpc;
	}

	public Short getCheckpc(){
		return checkpc;
	}

	public void setPlancodebz(String plancodebz){
		this.plancodebz=plancodebz;
	}

	public String getPlancodebz(){
		return plancodebz;
	}

	public void setPlannamebz(String plannamebz){
		this.plannamebz=plannamebz;
	}

	public String getPlannamebz(){
		return plannamebz;
	}

	public void setCzy(String czy){
		this.czy=czy;
	}

	public String getCzy(){
		return czy;
	}

	public void setCzsj(Timestamp czsj){
		this.czsj=czsj;
	}

	public Timestamp getCzsj(){
		return czsj;
	}

}

