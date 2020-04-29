package com.askj.tmsyj.tmsyj.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "Hjdjccybg")
public class Hjdjccybg {
/** 监督检查抽样报告; InnoDB free: 51200 kB  */
	/** hjdjccybgid 的中文含义是：监督检查抽样报告id*/
	@Name
	@Column
	private String hjdjccybgid;

	/** hviewjgztid 的中文含义是：监管主体表主键*/
	@Column
	private String hviewjgztid;

	/** jcypid 的中文含义是：商品ID*/
	@Column
	private String jcypid;

	/** rwly 的中文含义是：任务来源*/
	@Column
	private String rwly;

	/** jdcysj 的中文含义是：监督抽样时间*/
	@Column
	private Timestamp jdcysj;

	/** cyr 的中文含义是：抽样人*/
	@Column
	private String cyr;

	/** cydw 的中文含义是：抽样单位*/
	@Column
	private String cydw;

	/** aae011 的中文含义是：操作员*/
	@Column
	private String aae011;

	/** aae036 的中文含义是：操作时间*/
	@Column
	private Timestamp aae036;


	public void setHjdjccybgid(String hjdjccybgid){
		this.hjdjccybgid=hjdjccybgid;
	}

	public String getHjdjccybgid(){
		return hjdjccybgid;
	}

	public void setHviewjgztid(String hviewjgztid){
		this.hviewjgztid=hviewjgztid;
	}

	public String getHviewjgztid(){
		return hviewjgztid;
	}

	public void setJcypid(String jcypid){
		this.jcypid=jcypid;
	}

	public String getJcypid(){
		return jcypid;
	}

	public void setRwly(String rwly){
		this.rwly=rwly;
	}

	public String getRwly(){
		return rwly;
	}

	public Timestamp getJdcysj() {
		return jdcysj;
	}

	public void setJdcysj(Timestamp jdcysj) {
		this.jdcysj = jdcysj;
	}

	public void setCyr(String cyr){
		this.cyr=cyr;
	}

	public String getCyr(){
		return cyr;
	}

	public void setCydw(String cydw){
		this.cydw=cydw;
	}

	public String getCydw(){
		return cydw;
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

