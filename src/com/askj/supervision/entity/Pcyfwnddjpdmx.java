package com.askj.supervision.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "Pcyfwnddjpdmx")
public class Pcyfwnddjpdmx {
/** 餐饮服务食品安全监督年度等级评定表明细; InnoDB free: 14336 kB  */
	/** pcyfwnddjpdmxid 的中文含义是：餐饮服务食品安全监督年度等级评定表明细id*/
	@Name
	@Column
	private String pcyfwnddjpdmxid;

	/** pcyfwnddjpdid 的中文含义是：餐饮服务食品安全监督年度等级评定表id*/
	@Column
	private String pcyfwnddjpdid;

	/** jcrq 的中文含义是：检查日期*/
	@Column
	private Date jcrq;

	/** defen 的中文含义是：得分*/
	@Column
	private String defen;

	/** lhfjndpddj 的中文含义是：评定等级*/
	@Column
	private String lhfjndpddj;


	public void setPcyfwnddjpdmxid(String pcyfwnddjpdmxid){
		this.pcyfwnddjpdmxid=pcyfwnddjpdmxid;
	}

	public String getPcyfwnddjpdmxid(){
		return pcyfwnddjpdmxid;
	}

	public void setPcyfwnddjpdid(String pcyfwnddjpdid){
		this.pcyfwnddjpdid=pcyfwnddjpdid;
	}

	public String getPcyfwnddjpdid(){
		return pcyfwnddjpdid;
	}

	public void setJcrq(Date jcrq){
		this.jcrq=jcrq;
	}

	public Date getJcrq(){
		return jcrq;
	}

	public void setDefen(String defen){
		this.defen=defen;
	}

	public String getDefen(){
		return defen;
	}

	public void setLhfjndpddj(String lhfjndpddj){
		this.lhfjndpddj=lhfjndpddj;
	}

	public String getLhfjndpddj(){
		return lhfjndpddj;
	}

}

