package com.askj.tmsyj.tmcsc.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "Pscfq")
public class Pscfq {
/** 市场分区表  */
	/** pscfqid 的中文含义是：市场分区id*/
	@Name
	@Column
	private String pscfqid;

	/** comid 的中文含义是：市场id*/
	@Column
	private String comid;

	/** scfqbh 的中文含义是：市场分区编号*/
	@Column
	private String scfqbh;

	/** scfqmc 的中文含义是：市场分区名称*/
	@Column
	private String scfqmc;

	/** aae011 的中文含义是：操作员*/
	@Column
	private String aae011;

	/** aae036 的中文含义是：操作时间*/
	@Column
	private Timestamp aae036;

	/** aae013 的中文含义是：备注*/
	@Column
	private String aae013;


	public void setPscfqid(String pscfqid){
		this.pscfqid=pscfqid;
	}

	public String getPscfqid(){
		return pscfqid;
	}

	public void setComid(String comid){
		this.comid=comid;
	}

	public String getComid(){
		return comid;
	}

	public void setScfqbh(String scfqbh){
		this.scfqbh=scfqbh;
	}

	public String getScfqbh(){
		return scfqbh;
	}

	public void setScfqmc(String scfqmc){
		this.scfqmc=scfqmc;
	}

	public String getScfqmc(){
		return scfqmc;
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

	public void setAae013(String aae013){
		this.aae013=aae013;
	}

	public String getAae013(){
		return aae013;
	}

}

