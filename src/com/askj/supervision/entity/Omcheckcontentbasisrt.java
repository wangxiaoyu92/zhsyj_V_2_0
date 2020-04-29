package com.askj.supervision.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "Omcheckcontentbasisrt")
public class Omcheckcontentbasisrt {
/** 检查内容-检查依据关系表; InnoDB free: 6144 kB  */
	/** cbid 的中文含义是：主键ID*/
	@Column
	private String cbid;

	/** contentid 的中文含义是：检查内容ID*/
	@Column
	private String contentid;

	/** basisid 的中文含义是：检查依据表ID*/
	@Column
	private String basisid;

	/** operator 的中文含义是：经办人ID*/
	@Column
	private String operator;

	/** operatorname 的中文含义是：经办人名称*/
	@Column
	private String operatorname;

	/** operatedate 的中文含义是：经办时间*/
	@Column
	private Timestamp operatedate;


	public void setCbid(String cbid){
		this.cbid=cbid;
	}

	public String getCbid(){
		return cbid;
	}

	public void setContentid(String contentid){
		this.contentid=contentid;
	}

	public String getContentid(){
		return contentid;
	}

	public void setBasisid(String basisid){
		this.basisid=basisid;
	}

	public String getBasisid(){
		return basisid;
	}

	public void setOperator(String operator){
		this.operator=operator;
	}

	public String getOperator(){
		return operator;
	}

	public void setOperatorname(String operatorname){
		this.operatorname=operatorname;
	}

	public String getOperatorname(){
		return operatorname;
	}

	public void setOperatedate(Timestamp operatedate){
		this.operatedate=operatedate;
	}

	public Timestamp getOperatedate(){
		return operatedate;
	}

}

