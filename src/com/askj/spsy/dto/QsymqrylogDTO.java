package com.askj.spsy.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class QsymqrylogDTO {
	//扩展开始
	/** qrycount 的中文含义是：查询次数*/
	private int qrycount;
	//扩展结束
/** 溯源码查询日志; InnoDB free: 7168 kB  */
	/** qsymqrylogid 的中文含义是：溯源码查询日志ID*/
	private String qsymqrylogid;

	/** qrysym 的中文含义是：溯源码*/
	private String qrysym;

	/** qrytime 的中文含义是：查询时间*/
	private Timestamp qrytime;

	/** qryposition 的中文含义是：查询地点*/
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

	public int getQrycount() {
		return qrycount;
	}

	public void setQrycount(int qrycount) {
		this.qrycount = qrycount;
	}

	
	
}

