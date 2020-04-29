package com.askj.baseinfo.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "Pgzpjmx")
public class Pgzpjmx {
/** 公众评价明细表  */
	/** pgzpjmxid 的中文含义是：公众评价明细表*/
	@Name
	@Column
	private String pgzpjmxid;

	/** pgzpjid 的中文含义是：公众评价表id*/
	@Column
	private String pgzpjid;

	/** pjcs 的中文含义是：aa10表aaa100=pjcs*/
	@Column
	private String pjcs;

	/** pjxj 的中文含义是：评价星级aaa100=pjxj*/
	@Column
	private String pjxj;


	public void setPgzpjmxid(String pgzpjmxid){
		this.pgzpjmxid=pgzpjmxid;
	}

	public String getPgzpjmxid(){
		return pgzpjmxid;
	}

	public void setPgzpjid(String pgzpjid){
		this.pgzpjid=pgzpjid;
	}

	public String getPgzpjid(){
		return pgzpjid;
	}

	public void setPjcs(String pjcs){
		this.pjcs=pjcs;
	}

	public String getPjcs(){
		return pjcs;
	}

	public void setPjxj(String pjxj){
		this.pjxj=pjxj;
	}

	public String getPjxj(){
		return pjxj;
	}

}

