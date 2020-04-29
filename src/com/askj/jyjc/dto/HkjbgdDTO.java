package com.askj.jyjc.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class HkjbgdDTO {
/** 快检报告单; InnoDB free: 10240 kB  */
	/** hkjbgdid 的中文含义是：快检报告单id*/
	private String hkjbgdid;

	/** kjbgdpch 的中文含义是：快检报告单批次号*/
	private String kjbgdpch;

	/** jcdwfzrqzpic 的中文含义是：快检报告单检测单位负责人签字*/
	private String jcdwfzrqzpic;

	/** jcdwfzrqzrq 的中文含义是：快检报告单检测单位负责人签字日期*/
	private Timestamp jcdwfzrqzrq;

	/** kjbgdjcr 的中文含义是：快检报告单检测人*/
	private String kjbgdjcr;

	/** bjcdwfzrqzpic 的中文含义是：快检报告单被检测单位负责人签字*/
	private String bjcdwfzrqzpic;

	/** bjcdwfzrqzrq 的中文含义是：快检报告单被检测单位负责人签字日期*/
	private Timestamp bjcdwfzrqzrq;

	/** kjbgdprint 的中文含义是：快检报告单printhtml，bstbodyinfo=kjbgd*/
	private String kjbgdprint;

	/** czyxm 的中文含义是：操作员姓名*/
	private String czyxm;

	/** czyid 的中文含义是：操作员id*/
	private String czyid;

	/** aae036 的中文含义是：操作时间*/
	private Timestamp aae036;


	public void setHkjbgdid(String hkjbgdid){
		this.hkjbgdid=hkjbgdid;
	}

	public String getHkjbgdid(){
		return hkjbgdid;
	}

	public void setKjbgdpch(String kjbgdpch){
		this.kjbgdpch=kjbgdpch;
	}

	public String getKjbgdpch(){
		return kjbgdpch;
	}

	public void setJcdwfzrqzpic(String jcdwfzrqzpic){
		this.jcdwfzrqzpic=jcdwfzrqzpic;
	}

	public String getJcdwfzrqzpic(){
		return jcdwfzrqzpic;
	}

	public void setJcdwfzrqzrq(Timestamp jcdwfzrqzrq){
		this.jcdwfzrqzrq=jcdwfzrqzrq;
	}

	public Timestamp getJcdwfzrqzrq(){
		return jcdwfzrqzrq;
	}

	public void setKjbgdjcr(String kjbgdjcr){
		this.kjbgdjcr=kjbgdjcr;
	}

	public String getKjbgdjcr(){
		return kjbgdjcr;
	}

	public void setBjcdwfzrqzpic(String bjcdwfzrqzpic){
		this.bjcdwfzrqzpic=bjcdwfzrqzpic;
	}

	public String getBjcdwfzrqzpic(){
		return bjcdwfzrqzpic;
	}

	public void setBjcdwfzrqzrq(Timestamp bjcdwfzrqzrq){
		this.bjcdwfzrqzrq=bjcdwfzrqzrq;
	}

	public Timestamp getBjcdwfzrqzrq(){
		return bjcdwfzrqzrq;
	}

	public void setKjbgdprint(String kjbgdprint){
		this.kjbgdprint=kjbgdprint;
	}

	public String getKjbgdprint(){
		return kjbgdprint;
	}

	public void setCzyxm(String czyxm){
		this.czyxm=czyxm;
	}

	public String getCzyxm(){
		return czyxm;
	}

	public void setCzyid(String czyid){
		this.czyid=czyid;
	}

	public String getCzyid(){
		return czyid;
	}

	public void setAae036(Timestamp aae036){
		this.aae036=aae036;
	}

	public Timestamp getAae036(){
		return aae036;
	}

}

