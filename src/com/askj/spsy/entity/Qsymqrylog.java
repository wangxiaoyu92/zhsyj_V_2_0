package com.askj.spsy.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "Qsymqrylog")
public class Qsymqrylog {
/** 溯源码查询日志; InnoDB free: 7168 kB  */
	/** qsymqrylogid 的中文含义是：溯源码查询日志ID*/
	@Name
	@Column
	private String qsymqrylogid;

	/** qrysym 的中文含义是：溯源码*/
	@Column
	private String qrysym;

	/** qrytime 的中文含义是：查询时间*/
	@Column
	private Timestamp qrytime;

	/** qryposition 的中文含义是：查询地点*/
	@Column
	private String qryposition;


	public void setQsymqrylogid(String qsymqrylogid){
		this.qsymqrylogid=qsymqrylogid;
	}

	public String getQsymqrylogid(){
		return qsymqrylogid;
	}

	public void setQrysym(String qrysym){
		this.qrysym=qrysym;
	}

	public String getQrysym(){
		return qrysym;
	}

	public void setQrytime(Timestamp qrytime){
		this.qrytime=qrytime;
	}

	public Timestamp getQrytime(){
		return qrytime;
	}

	public void setQryposition(String qryposition){
		this.qryposition=qryposition;
	}

	public String getQryposition(){
		return qryposition;
	}

}

