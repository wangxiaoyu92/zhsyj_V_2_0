package com.askj.baseinfo.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class OmprintDTO {
/** 手机打印和检查模板对应表; InnoDB free: 14336 kB  */
	/** omprintid 的中文含义是：手机打印和检查模板对应表id*/
	private String omprintid;

	/** itemid 的中文含义是：检查模板id*/
	private String itemid;

	/** itemname 的中文含义是：检查模板名称*/
	private String itemname;

	/** tbodytype 的中文含义是：报表编码*/
	private String tbodytype;

	/** miaoshu 的中文含义是：报表描述*/
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

