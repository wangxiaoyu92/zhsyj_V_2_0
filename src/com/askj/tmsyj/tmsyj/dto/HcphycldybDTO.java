package com.askj.tmsyj.tmsyj.dto;

import java.sql.Date;
import java.sql.Timestamp;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;

public class HcphycldybDTO {
/** 生产企业产品和原材料对应表  */
	/** hcphycldybid 的中文含义是：生产企业产品和原材料对应表id*/
	private String hcphycldybid;
	/** jcypid 的中文含义是：检测样品ID*/
	//private String jcypid;
	/** jcypmc 的中文含义是：检查样品名称*/
	private String jcypmc;	

	/** cpid 的中文含义是：产品id*/
	private String cpid;

	/** yclid 的中文含义是：原材料id*/
	private String yclid;
	private String jcypid;

	/** aae011 的中文含义是：操作员*/
	private String aae011;

	/** aae036 的中文含义是：操作时间*/
	private Timestamp aae036;
	/** hviewjgztid 的中文含义是：监管主体表主键*/
	private String hviewjgztid;	


	public String getJcypid() {
		return jcypid;
	}

	public void setJcypid(String jcypid) {
		this.jcypid = jcypid;
	}

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

	public String getJcypmc() {
		return jcypmc;
	}

	public void setJcypmc(String jcypmc) {
		this.jcypmc = jcypmc;
	}

}

