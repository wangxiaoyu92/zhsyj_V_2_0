package com.askj.tmsyj.tmsyj.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "Hjcjgjcyqb")
public class Hjcjgjcyqb {
/** 检测机构检测仪器表; InnoDB free: 51200 kB  */
	/** hjcjgjcyqbid 的中文含义是：检测机构检测仪器表id*/
	@Name
	@Column
	private String hjcjgjcyqbid;

	/** hviewjgztid 的中文含义是：监管主体id*/
	@Column
	private String hviewjgztid;

	/** jcyqmc 的中文含义是：检测仪器名称*/
	@Column
	private String jcyqmc;

	/** jcyqxh 的中文含义是：检测仪器型号*/
	@Column
	private String jcyqxh;

	/** jcyqxlh 的中文含义是：检测仪器序列号*/
	@Column
	private String jcyqxlh;

	/** jcyqgmrq 的中文含义是：检测仪器购买日期*/
	@Column
	private Timestamp jcyqgmrq;

	/** jcyqscrq 的中文含义是：检测仪器生产日期*/
	@Column
	private Timestamp jcyqscrq;

	/** jcyqsccj 的中文含义是：检测仪器生产厂家*/
	@Column
	private String jcyqsccj;

	/** jcyqjcxm 的中文含义是：检测仪器检测项目*/
	@Column
	private String jcyqjcxm;

	/** jcyqcpyt 的中文含义是：检测仪器产品用途*/
	@Column
	private String jcyqcpyt;

	/** aae011 的中文含义是：操作员*/
	@Column
	private String aae011;

	/** aae036 的中文含义是：操作时间*/
	@Column
	private Timestamp aae036;


	public void setHjcjgjcyqbid(String hjcjgjcyqbid){
		this.hjcjgjcyqbid=hjcjgjcyqbid;
	}

	public String getHjcjgjcyqbid(){
		return hjcjgjcyqbid;
	}

	public void setHviewjgztid(String hviewjgztid){
		this.hviewjgztid=hviewjgztid;
	}

	public String getHviewjgztid(){
		return hviewjgztid;
	}

	public void setJcyqmc(String jcyqmc){
		this.jcyqmc=jcyqmc;
	}

	public String getJcyqmc(){
		return jcyqmc;
	}

	public void setJcyqxh(String jcyqxh){
		this.jcyqxh=jcyqxh;
	}

	public String getJcyqxh(){
		return jcyqxh;
	}

	public void setJcyqxlh(String jcyqxlh){
		this.jcyqxlh=jcyqxlh;
	}

	public String getJcyqxlh(){
		return jcyqxlh;
	}

	public void setJcyqgmrq(Timestamp jcyqgmrq){
		this.jcyqgmrq=jcyqgmrq;
	}

	public Timestamp getJcyqgmrq(){
		return jcyqgmrq;
	}

	public void setJcyqscrq(Timestamp jcyqscrq){
		this.jcyqscrq=jcyqscrq;
	}

	public Timestamp getJcyqscrq(){
		return jcyqscrq;
	}

	public void setJcyqsccj(String jcyqsccj){
		this.jcyqsccj=jcyqsccj;
	}

	public String getJcyqsccj(){
		return jcyqsccj;
	}

	public void setJcyqjcxm(String jcyqjcxm){
		this.jcyqjcxm=jcyqjcxm;
	}

	public String getJcyqjcxm(){
		return jcyqjcxm;
	}

	public void setJcyqcpyt(String jcyqcpyt){
		this.jcyqcpyt=jcyqcpyt;
	}

	public String getJcyqcpyt(){
		return jcyqcpyt;
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

}

