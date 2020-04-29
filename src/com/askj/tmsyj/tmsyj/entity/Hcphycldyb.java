package com.askj.tmsyj.tmsyj.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "Hcphycldyb")
public class Hcphycldyb {
/** 生产企业产品和原材料对应表  */
	/** hcphycldybid 的中文含义是：生产企业产品和原材料对应表id*/
	@Column
	private String hcphycldybid;

	/** cpid 的中文含义是：产品id*/
	@Column
	private String cpid;

	/** yclid 的中文含义是：原材料id*/
	@Column
	private String yclid;

	/** aae011 的中文含义是：操作员*/
	@Column
	private String aae011;

	/** aae036 的中文含义是：操作时间*/
	@Column
	private Timestamp aae036;
	
	/** hviewjgztid 的中文含义是：监管主体表主键*/
	@Column
	private String hviewjgztid;


	public void setHcphycldybid(String hcphycldybid){
		this.hcphycldybid=hcphycldybid;
	}

	public String getHcphycldybid(){
		return hcphycldybid;
	}

	public void setCpid(String cpid){
		this.cpid=cpid;
	}

	public String getCpid(){
		return cpid;
	}

	public void setYclid(String yclid){
		this.yclid=yclid;
	}

	public String getYclid(){
		return yclid;
	}

	public void setAae011(String aae011){
		this.aae011=aae011;
	}

	public String getAae011(){
		return aae011;
	}

	public void setAae036(Timestamp aae036){
		this.aae036=aae036;
	}

	public Timestamp getAae036(){
		return aae036;
	}

	public String getHviewjgztid() {
		return hviewjgztid;
	}

	public void setHviewjgztid(String hviewjgztid) {
		this.hviewjgztid = hviewjgztid;
	}

}

