package com.askj.jyjc.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "Jyjcwssj")
public class Jyjcwssj {
/** 网上送检表; InnoDB free: 9216 kB  */
	/** jyjcwssjid 的中文含义是：网上送检表id*/
	@Column
	@Name
	private String jyjcwssjid;

	/** commc 的中文含义是：单位名称*/
	@Column
	private String commc;

	/** lxr 的中文含义是：联系人*/
	@Column
	private String lxr;

	/** lxdh 的中文含义是：联系电话*/
	@Column
	private String lxdh;

	/** sqjcwp 的中文含义是：申请检测物品*/
	@Column
	private String sqjcwp;

	/** sqyy 的中文含义是：申请原因*/
	@Column
	private String sqyy;

	/** sqczyid 的中文含义是：申请操作员id*/
	@Column
	private String sqczyid;

	/** sqczyname 的中文含义是：申请操作员姓名*/
	@Column
	private String sqczyname;

	/** sqsj 的中文含义是：申请时间*/
	@Column
	private String sqsj;

	/** shbz 的中文含义是：审核标志见aaa100=JCJYSHBZ*/
	@Column
	private String shbz;

	/** shwtgyy 的中文含义是：审核未通过原因*/
	@Column
	private String shwtgyy;

	/** shczyid 的中文含义是：审核操作员id*/
	@Column
	private String shczyid;

	/** shczyname 的中文含义是：审核操作员姓名*/
	@Column
	private String shczyname;

	/** shsj 的中文含义是：审核时间*/
	@Column
	private String shsj;

	/** jcorgid 的中文含义是：检测机构id*/
	@Column
	private String jcorgid;

	/** jcorgmc 的中文含义是：检测机构名称(仪器对接用:检测单位)*/
	@Column
	private String jcorgmc;


	public void setJyjcwssjid(String jyjcwssjid){
		this.jyjcwssjid=jyjcwssjid;
	}

	public String getJyjcwssjid(){
		return jyjcwssjid;
	}

	public void setCommc(String commc){
		this.commc=commc;
	}

	public String getCommc(){
		return commc;
	}

	public void setLxr(String lxr){
		this.lxr=lxr;
	}

	public String getLxr(){
		return lxr;
	}

	public void setLxdh(String lxdh){
		this.lxdh=lxdh;
	}

	public String getLxdh(){
		return lxdh;
	}

	public void setSqjcwp(String sqjcwp){
		this.sqjcwp=sqjcwp;
	}

	public String getSqjcwp(){
		return sqjcwp;
	}

	public void setSqyy(String sqyy){
		this.sqyy=sqyy;
	}

	public String getSqyy(){
		return sqyy;
	}

	public void setSqczyid(String sqczyid){
		this.sqczyid=sqczyid;
	}

	public String getSqczyid(){
		return sqczyid;
	}

	public void setSqczyname(String sqczyname){
		this.sqczyname=sqczyname;
	}

	public String getSqczyname(){
		return sqczyname;
	}

	public void setSqsj(String sqsj){
		this.sqsj=sqsj;
	}

	public String getSqsj(){
		return sqsj;
	}

	public void setShbz(String shbz){
		this.shbz=shbz;
	}

	public String getShbz(){
		return shbz;
	}

	public void setShwtgyy(String shwtgyy){
		this.shwtgyy=shwtgyy;
	}

	public String getShwtgyy(){
		return shwtgyy;
	}

	public void setShczyid(String shczyid){
		this.shczyid=shczyid;
	}

	public String getShczyid(){
		return shczyid;
	}

	public void setShczyname(String shczyname){
		this.shczyname=shczyname;
	}

	public String getShczyname(){
		return shczyname;
	}

	public void setShsj(String shsj){
		this.shsj=shsj;
	}

	public String getShsj(){
		return shsj;
	}

	public void setJcorgid(String jcorgid){
		this.jcorgid=jcorgid;
	}

	public String getJcorgid(){
		return jcorgid;
	}

	public void setJcorgmc(String jcorgmc){
		this.jcorgmc=jcorgmc;
	}

	public String getJcorgmc(){
		return jcorgmc;
	}

}

