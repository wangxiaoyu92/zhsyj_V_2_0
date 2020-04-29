package com.askj.supervision.dto;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

public class PcyfwnddjpdmxDTO {
	//kuozhankaishi
	/** lhfjndpddj 的中文含义是：评定等级*/
	private String lhfjndpddjaaa103;
	//kuozhanjieshu
/** 餐饮服务食品安全监督年度等级评定表明细; InnoDB free: 14336 kB  */
	/** pcyfwnddjpdmxid 的中文含义是：餐饮服务食品安全监督年度等级评定表明细id*/
	private String pcyfwnddjpdmxid;

	/** pcyfwnddjpdid 的中文含义是：餐饮服务食品安全监督年度等级评定表id*/
	private String pcyfwnddjpdid;

	/** jcrq 的中文含义是：检查日期*/
	private Date jcrq;

	/** defen 的中文含义是：得分*/
	private String defen;

	/** lhfjndpddj 的中文含义是：评定等级*/
	private String lhfjndpddj;


	/** resultid 的中文含义是：*/
	private String resultid;


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

	public String getLhfjndpddjaaa103() {
		return lhfjndpddjaaa103;
	}

	public void setLhfjndpddjaaa103(String lhfjndpddjaaa103) {
		this.lhfjndpddjaaa103 = lhfjndpddjaaa103;
	}

	public String getResultid() {
		return resultid;
	}

	public void setResultid(String resultid) {
		this.resultid = resultid;
	}
}

