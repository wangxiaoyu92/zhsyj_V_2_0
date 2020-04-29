package com.askj.tmsyj.tmsyj.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "Hjgztkhgx")
public class Hjgztkhgx {
/** 监管主体客户关系表; InnoDB free: 231424 kB  */
	/** hjgztkhgxid 的中文含义是：监管主体客户关系表id*/
	@Name
	@Column
	private String hjgztkhgxid;

	/** jgztkhgx 的中文含义是：客户关系*/
	@Column
	private String jgztkhgx;

	/** hviewjgztid 的中文含义是：监管主体ID*/
	@Column
	private String hviewjgztid;

	/** jgztkhbh 的中文含义是：客户编号*/
	@Column
	private String jgztkhbh;

	/** jgztkhmc 的中文含义是：客户名称*/
	@Column
	private String jgztkhmc;

	/** jgztkhmcjc 的中文含义是：客户名称简称*/
	@Column
	private String jgztkhmcjc;

	/** jgztkhlxr 的中文含义是：联系人*/
	@Column
	private String jgztkhlxr;

	/** jgztkhyddh 的中文含义是：移动电话*/
	@Column
	private String jgztkhyddh;

	/** jgztkhgddh 的中文含义是：固定电话*/
	@Column
	private String jgztkhgddh;

	/** jgztkhlxdz 的中文含义是：联系地址*/
	@Column
	private String jgztkhlxdz;

	/** jgztkhzzzmmc 的中文含义是：资质证明名称*/
	@Column
	private String jgztkhzzzmmc;

	/** jgztkhzzzmbh 的中文含义是：资质证明编号*/
	@Column
	private String jgztkhzzzmbh;

	/** jgztfwnfww 的中文含义是：客户范围内范围外*/
	@Column
	private String jgztfwnfww;

	/** jgztfwnztid 的中文含义是：范围内客户主体id，对应主体表id*/
	@Column
	private String jgztfwnztid;

	/** aaa027 的中文含义是：统筹区*/
	@Column
	private String aaa027;


	public void setHjgztkhgxid(String hjgztkhgxid){
		this.hjgztkhgxid=hjgztkhgxid;
	}

	public String getHjgztkhgxid(){
		return hjgztkhgxid;
	}

	public void setJgztkhgx(String jgztkhgx){
		this.jgztkhgx=jgztkhgx;
	}

	public String getJgztkhgx(){
		return jgztkhgx;
	}

	public void setHviewjgztid(String hviewjgztid){
		this.hviewjgztid=hviewjgztid;
	}

	public String getHviewjgztid(){
		return hviewjgztid;
	}

	public void setJgztkhbh(String jgztkhbh){
		this.jgztkhbh=jgztkhbh;
	}

	public String getJgztkhbh(){
		return jgztkhbh;
	}

	public void setJgztkhmc(String jgztkhmc){
		this.jgztkhmc=jgztkhmc;
	}

	public String getJgztkhmc(){
		return jgztkhmc;
	}

	public void setJgztkhmcjc(String jgztkhmcjc){
		this.jgztkhmcjc=jgztkhmcjc;
	}

	public String getJgztkhmcjc(){
		return jgztkhmcjc;
	}

	public void setJgztkhlxr(String jgztkhlxr){
		this.jgztkhlxr=jgztkhlxr;
	}

	public String getJgztkhlxr(){
		return jgztkhlxr;
	}

	public void setJgztkhyddh(String jgztkhyddh){
		this.jgztkhyddh=jgztkhyddh;
	}

	public String getJgztkhyddh(){
		return jgztkhyddh;
	}

	public void setJgztkhgddh(String jgztkhgddh){
		this.jgztkhgddh=jgztkhgddh;
	}

	public String getJgztkhgddh(){
		return jgztkhgddh;
	}

	public void setJgztkhlxdz(String jgztkhlxdz){
		this.jgztkhlxdz=jgztkhlxdz;
	}

	public String getJgztkhlxdz(){
		return jgztkhlxdz;
	}

	public void setJgztkhzzzmmc(String jgztkhzzzmmc){
		this.jgztkhzzzmmc=jgztkhzzzmmc;
	}

	public String getJgztkhzzzmmc(){
		return jgztkhzzzmmc;
	}

	public void setJgztkhzzzmbh(String jgztkhzzzmbh){
		this.jgztkhzzzmbh=jgztkhzzzmbh;
	}

	public String getJgztkhzzzmbh(){
		return jgztkhzzzmbh;
	}

	public void setJgztfwnfww(String jgztfwnfww){
		this.jgztfwnfww=jgztfwnfww;
	}

	public String getJgztfwnfww(){
		return jgztfwnfww;
	}

	public void setJgztfwnztid(String jgztfwnztid){
		this.jgztfwnztid=jgztfwnztid;
	}

	public String getJgztfwnztid(){
		return jgztfwnztid;
	}

	public void setAaa027(String aaa027){
		this.aaa027=aaa027;
	}

	public String getAaa027(){
		return aaa027;
	}

}

