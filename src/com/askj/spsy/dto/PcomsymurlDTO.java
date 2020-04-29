package com.askj.spsy.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class PcomsymurlDTO {
/** 企业溯源码跳转地址; InnoDB free: 9216 kB  */
	/** pcomsymurlid 的中文含义是：企业溯源码跳转地址id*/
	private String pcomsymurlid;

	/** comid 的中文含义是：企业id*/
	private String comid;

	/** tzurl 的中文含义是：跳转地址*/
	private String tzurl;


	public void setPcomsymurlid(String pcomsymurlid){
		this.pcomsymurlid=pcomsymurlid;
	}

	public String getPcomsymurlid(){
		return pcomsymurlid;
	}

	public void setComid(String comid){
		this.comid=comid;
	}

	public String getComid(){
		return comid;
	}

	public void setTzurl(String tzurl){
		this.tzurl=tzurl;
	}

	public String getTzurl(){
		return tzurl;
	}

}

