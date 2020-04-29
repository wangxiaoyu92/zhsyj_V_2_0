package com.askj.baseinfo.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "Omprint")
public class Omprint {
/** 手机打印和检查模板对应表; InnoDB free: 14336 kB  */
	/** omprintid 的中文含义是：手机打印和检查模板对应表id*/
	@Name
	@Column
	private String omprintid;

	/** itemid 的中文含义是：检查模板id*/
	@Column
	private String itemid;

	/** itemname 的中文含义是：检查模板名称*/
	@Column
	private String itemname;

	/** tbodytype 的中文含义是：报表编码*/
	@Column
	private String tbodytype;

	/** miaoshu 的中文含义是：报表描述*/
	@Column
	private String miaoshu;


	public void setOmprintid(String omprintid){
		this.omprintid=omprintid;
	}

	public String getOmprintid(){
		return omprintid;
	}

	public void setItemid(String itemid){
		this.itemid=itemid;
	}

	public String getItemid(){
		return itemid;
	}

	public void setItemname(String itemname){
		this.itemname=itemname;
	}

	public String getItemname(){
		return itemname;
	}

	public void setTbodytype(String tbodytype){
		this.tbodytype=tbodytype;
	}

	public String getTbodytype(){
		return tbodytype;
	}

	public void setMiaoshu(String miaoshu){
		this.miaoshu=miaoshu;
	}

	public String getMiaoshu(){
		return miaoshu;
	}

}

