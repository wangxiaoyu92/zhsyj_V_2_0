package com.askj.baseinfo.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "Hviewjgzt")
public class Hviewjgzt {
/** 监管主体表; InnoDB free: 161792 kB  */
	/** hviewjgztid 的中文含义是：监管主体表主键*/
	@Name
	@Column
	private String hviewjgztid;

	/** jgztbh 的中文含义是：监管主体编号*/
	@Column
	private String jgztbh;

	/** jgztmc 的中文含义是：监管主体名称*/
	@Column
	private String jgztmc;

	/** jgztmcjc 的中文含义是：监管主体名称简称*/
	@Column
	private String jgztmcjc;

	/** jgztlxr 的中文含义是：监管主体联系人*/
	@Column
	private String jgztlxr;

	/** jgztlxrgddh 的中文含义是：监管主体联系人固定电话*/
	@Column
	private String jgztlxrgddh;

	/** jgztlxryddh 的中文含义是：监管主体联系人移动电话*/
	@Column
	private String jgztlxryddh;

	/** jgzttxdz 的中文含义是：监管主体通讯地址*/
	@Column
	private String jgzttxdz;

	/** aaa027 的中文含义是：监管主体归属统筹区*/
	@Column
	private String aaa027;

	/** jgztzzzmmc 的中文含义是：监管主体资质证明名称*/
	@Column
	private String jgztzzzmmc;

	/** jgztzzzmbh 的中文含义是：监管主体资质证明编号*/
	@Column
	private String jgztzzzmbh;

	/** jgztlx 的中文含义是：监管主体类型aaa100=jgztlx1企业2商户*/
	@Column
	private String jgztlx;

	/** jgztgsztid 的中文含义是：监管主体归属主体*/
	@Column
	private String jgztgsztid;

	/** jgztfwnfww 的中文含义是：客户范围内范围外*/
	@Column
	private String jgztfwnfww;


	public void setHviewjgztid(String hviewjgztid){
		this.hviewjgztid=hviewjgztid;
	}

	public String getHviewjgztid(){
		return hviewjgztid;
	}

	public void setJgztbh(String jgztbh){
		this.jgztbh=jgztbh;
	}

	public String getJgztbh(){
		return jgztbh;
	}

	public void setJgztmc(String jgztmc){
		this.jgztmc=jgztmc;
	}

	public String getJgztmc(){
		return jgztmc;
	}

	public void setJgztmcjc(String jgztmcjc){
		this.jgztmcjc=jgztmcjc;
	}

	public String getJgztmcjc(){
		return jgztmcjc;
	}

	public void setJgztlxr(String jgztlxr){
		this.jgztlxr=jgztlxr;
	}

	public String getJgztlxr(){
		return jgztlxr;
	}

	public void setJgztlxrgddh(String jgztlxrgddh){
		this.jgztlxrgddh=jgztlxrgddh;
	}

	public String getJgztlxrgddh(){
		return jgztlxrgddh;
	}

	public void setJgztlxryddh(String jgztlxryddh){
		this.jgztlxryddh=jgztlxryddh;
	}

	public String getJgztlxryddh(){
		return jgztlxryddh;
	}

	public void setJgzttxdz(String jgzttxdz){
		this.jgzttxdz=jgzttxdz;
	}

	public String getJgzttxdz(){
		return jgzttxdz;
	}

	public void setAaa027(String aaa027){
		this.aaa027=aaa027;
	}

	public String getAaa027(){
		return aaa027;
	}

	public void setJgztzzzmmc(String jgztzzzmmc){
		this.jgztzzzmmc=jgztzzzmmc;
	}

	public String getJgztzzzmmc(){
		return jgztzzzmmc;
	}

	public void setJgztzzzmbh(String jgztzzzmbh){
		this.jgztzzzmbh=jgztzzzmbh;
	}

	public String getJgztzzzmbh(){
		return jgztzzzmbh;
	}

	public void setJgztlx(String jgztlx){
		this.jgztlx=jgztlx;
	}

	public String getJgztlx(){
		return jgztlx;
	}

	public void setJgztgsztid(String jgztgsztid){
		this.jgztgsztid=jgztgsztid;
	}

	public String getJgztgsztid(){
		return jgztgsztid;
	}

	public void setJgztfwnfww(String jgztfwnfww){
		this.jgztfwnfww=jgztfwnfww;
	}

	public String getJgztfwnfww(){
		return jgztfwnfww;
	}

}

