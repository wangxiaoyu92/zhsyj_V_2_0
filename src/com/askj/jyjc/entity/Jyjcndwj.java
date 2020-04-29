package com.askj.jyjc.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "Jyjcndwj")
public class Jyjcndwj {

/** 检验检测你点我检; InnoDB free: 7168 kB  */
	/** jyjcndwjid 的中文含义是：'检验检测你点我检id'*/
	@Name
	@Column
	private String jyjcndwjid;

	/** jcypid 的中文含义是：地区*/
	@Column
	private String aaa027;

	/** jcypmc 的中文含义是：地点分类*/
	@Column
	private String ndwjddfl;

	/** commc 的中文含义是：具体地点*/
	@Column
	private String commc;

	/** jcreason 的中文含义是：'意见及建议'*/
	@Column
	private String jcreason;

	/** sfgk 的中文含义是：是否公开aaa100=shifoubz*/
	@Column
	private String sfgk;

	/** sqrxm 的中文含义是：申请人姓名*/
	@Column
	private String sqrxm;

	/** ryxb 的中文含义是：申请人员性别aaa100=ryxb*/
	@Column
	private String ryxb;

	/** sqrtel 的中文含义是：申请人电话*/
	@Column
	private String sqrtel;

	/** sqsj 的中文含义是：申请时间*/
	@Column
	private String sqsj;


	public void setJyjcndwjid(String jyjcndwjid){
		this.jyjcndwjid=jyjcndwjid;
	}

	public String getJyjcndwjid(){
		return jyjcndwjid;
	}

	public String getAaa027() {
		return aaa027;
	}

	public void setAaa027(String aaa027) {
		this.aaa027 = aaa027;
	}

	public String getNdwjddfl() {
		return ndwjddfl;
	}

	public void setNdwjddfl(String ndwjddfl) {
		this.ndwjddfl = ndwjddfl;
	}

	public void setCommc(String commc){
		this.commc=commc;
	}

	public String getCommc(){
		return commc;
	}

	public void setJcreason(String jcreason){
		this.jcreason=jcreason;
	}

	public String getJcreason(){
		return jcreason;
	}

	public void setSfgk(String sfgk){
		this.sfgk=sfgk;
	}

	public String getSfgk(){
		return sfgk;
	}

	public void setSqrxm(String sqrxm){
		this.sqrxm=sqrxm;
	}

	public String getSqrxm(){
		return sqrxm;
	}

	public void setRyxb(String ryxb){
		this.ryxb=ryxb;
	}

	public String getRyxb(){
		return ryxb;
	}

	public void setSqrtel(String sqrtel){
		this.sqrtel=sqrtel;
	}

	public String getSqrtel(){
		return sqrtel;
	}

	public void setSqsj(String sqsj){
		this.sqsj=sqsj;
	}

	public String getSqsj(){
		return sqsj;
	}

}

