package com.askj.spsy.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.math.BigDecimal;

@Table(value = "Qpesticide")
public class Qpesticide {
/** 农药信息表; InnoDB free: 12288 kB  */
	/** pesticideid 的中文含义是：农药ID*/
	@Name
	@Column
	private String pesticideid;

	/** pesticidecomid 的中文含义是：农药所属公司ID*/
	@Column
	private String pesticidecomid;

	/** pesticidename 的中文含义是：农药名称*/
	@Column
	private String pesticidename;

	/** pesticidesb 的中文含义是：商标*/
	@Column
	private String pesticidesb;

	/** pesticidesptm 的中文含义是：条码*/
	@Column
	private String pesticidesptm;

	/** pesticidegg 的中文含义是：规格型号*/
	@Column
	private String pesticidegg;

	/** pesticidesccj 的中文含义是：生产厂家*/
	@Column
	private String pesticidesccj;

	/** pesticidepm 的中文含义是：品名*/
	@Column
	private String pesticidepm;

	/** pesticidebzq 的中文含义是：保质期*/
	@Column
	private String pesticidebzq;

	/** pesticidecdjd 的中文含义是：产地/基地名称*/
	@Column
	private String pesticidecdjd;

	/** pesticideplxx 的中文含义是：配料信息*/
	@Column
	private String pesticideplxx;

	/** pesticidecpbzh 的中文含义是：产品标准号*/
	@Column
	private String pesticidecpbzh;

	/** pesticidezl 的中文含义是：产品种类 1药物  2肥料 3针剂aaa100=PESTICIDEZL*/
	@Column
	private String pesticidezl;

	/** pesticidebzqdwcode 的中文含义是：保质期单位代码aaa100=BZQDWMC */
	@Column
	private String pesticidebzqdwcode;

	/** pesticidebzqdwmc 的中文含义是：保质期单位名称*/
	@Column
	private String pesticidebzqdwmc;

	/** pesticidebzgg 的中文含义是：包装规格*/
	@Column
	private String pesticidebzgg;

	/** pesticidecjdh 的中文含义是：厂家电话*/
	@Column
	private String pesticidecjdh;

	/** pesticidecjdz 的中文含义是：厂家地址*/
	@Column
	private String pesticidecjdz;

	/** pesticidejysl 的中文含义是：结余数量*/
	@Column
	private BigDecimal pesticidejysl;

	/** pesticidejj 的中文含义是：农药简介*/
	@Column
	private String pesticidejj;

	/** pesticidesyfw 的中文含义是：农药适用范围*/
	@Column
	private String pesticidesyfw;

	/** pesticidedyzz 的中文含义是：农药对应症状*/
	@Column
	private String pesticidedyzz;


	public void setPesticideid(String pesticideid){
		this.pesticideid=pesticideid;
	}

	public String getPesticideid(){
		return pesticideid;
	}

	public void setPesticidecomid(String pesticidecomid){
		this.pesticidecomid=pesticidecomid;
	}

	public String getPesticidecomid(){
		return pesticidecomid;
	}

	public void setPesticidename(String pesticidename){
		this.pesticidename=pesticidename;
	}

	public String getPesticidename(){
		return pesticidename;
	}

	public void setPesticidesb(String pesticidesb){
		this.pesticidesb=pesticidesb;
	}

	public String getPesticidesb(){
		return pesticidesb;
	}

	public void setPesticidesptm(String pesticidesptm){
		this.pesticidesptm=pesticidesptm;
	}

	public String getPesticidesptm(){
		return pesticidesptm;
	}

	public void setPesticidegg(String pesticidegg){
		this.pesticidegg=pesticidegg;
	}

	public String getPesticidegg(){
		return pesticidegg;
	}

	public void setPesticidesccj(String pesticidesccj){
		this.pesticidesccj=pesticidesccj;
	}

	public String getPesticidesccj(){
		return pesticidesccj;
	}

	public void setPesticidepm(String pesticidepm){
		this.pesticidepm=pesticidepm;
	}

	public String getPesticidepm(){
		return pesticidepm;
	}

	public void setPesticidebzq(String pesticidebzq){
		this.pesticidebzq=pesticidebzq;
	}

	public String getPesticidebzq(){
		return pesticidebzq;
	}

	public void setPesticidecdjd(String pesticidecdjd){
		this.pesticidecdjd=pesticidecdjd;
	}

	public String getPesticidecdjd(){
		return pesticidecdjd;
	}

	public void setPesticideplxx(String pesticideplxx){
		this.pesticideplxx=pesticideplxx;
	}

	public String getPesticideplxx(){
		return pesticideplxx;
	}

	public void setPesticidecpbzh(String pesticidecpbzh){
		this.pesticidecpbzh=pesticidecpbzh;
	}

	public String getPesticidecpbzh(){
		return pesticidecpbzh;
	}

	public void setPesticidezl(String pesticidezl){
		this.pesticidezl=pesticidezl;
	}

	public String getPesticidezl(){
		return pesticidezl;
	}

	public void setPesticidebzqdwcode(String pesticidebzqdwcode){
		this.pesticidebzqdwcode=pesticidebzqdwcode;
	}

	public String getPesticidebzqdwcode(){
		return pesticidebzqdwcode;
	}

	public void setPesticidebzqdwmc(String pesticidebzqdwmc){
		this.pesticidebzqdwmc=pesticidebzqdwmc;
	}

	public String getPesticidebzqdwmc(){
		return pesticidebzqdwmc;
	}

	public void setPesticidebzgg(String pesticidebzgg){
		this.pesticidebzgg=pesticidebzgg;
	}

	public String getPesticidebzgg(){
		return pesticidebzgg;
	}

	public void setPesticidecjdh(String pesticidecjdh){
		this.pesticidecjdh=pesticidecjdh;
	}

	public String getPesticidecjdh(){
		return pesticidecjdh;
	}

	public void setPesticidecjdz(String pesticidecjdz){
		this.pesticidecjdz=pesticidecjdz;
	}

	public String getPesticidecjdz(){
		return pesticidecjdz;
	}

	public void setPesticidejysl(BigDecimal pesticidejysl){
		this.pesticidejysl=pesticidejysl;
	}

	public BigDecimal getPesticidejysl(){
		return pesticidejysl;
	}

	public void setPesticidejj(String pesticidejj){
		this.pesticidejj=pesticidejj;
	}

	public String getPesticidejj(){
		return pesticidejj;
	}

	public void setPesticidesyfw(String pesticidesyfw){
		this.pesticidesyfw=pesticidesyfw;
	}

	public String getPesticidesyfw(){
		return pesticidesyfw;
	}

	public void setPesticidedyzz(String pesticidedyzz){
		this.pesticidedyzz=pesticidedyzz;
	}

	public String getPesticidedyzz(){
		return pesticidedyzz;
	}

}

