package com.askj.supervision.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "Omcheckbasis")
public class Omcheckbasis {
/** 检查依据表; InnoDB free: 6144 kB  */
	/** basisid 的中文含义是：主键*/
	@Name
	@Column
	private String basisid;

	/** type 的中文含义是：检查方式*/
	@Column
	private String type;

	/** typedesc 的中文含义是：检查方式描述*/
	@Column
	private String typedesc;

	/** guide 的中文含义是：检查指南*/
	@Column
	private String guide;

	/** punishmeasures 的中文含义是：处罚措施*/
	@Column
	private String punishmeasures;

	/** basisdesc 的中文含义是：检查依据描述*/
	@Column
	private String basisdesc;

	/** operator 的中文含义是：经办人ID*/
	@Column
	private String operator;

	/** operatorname 的中文含义是：经办人名称*/
	@Column
	private String operatorname;

	/** operatedate 的中文含义是：经办时间*/
	@Column
	private Timestamp operatedate;

	/** operatedate 的中文含义是：排序*/
	@Column
	private String sort;

	/** operatedate 的中文含义是：检查依据编号*/
	@Column
	private String basiscode;

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getBasiscode() {
		return basiscode;
	}

	public void setBasiscode(String basiscode) {
		this.basiscode = basiscode;
	}

	public void setBasisid(String basisid){
		this.basisid=basisid;
	}

	public String getBasisid(){
		return basisid;
	}

	public void setType(String type){
		this.type=type;
	}

	public String getType(){
		return type;
	}

	public void setTypedesc(String typedesc){
		this.typedesc=typedesc;
	}

	public String getTypedesc(){
		return typedesc;
	}

	public void setGuide(String guide){
		this.guide=guide;
	}

	public String getGuide(){
		return guide;
	}

	public void setPunishmeasures(String punishmeasures){
		this.punishmeasures=punishmeasures;
	}

	public String getPunishmeasures(){
		return punishmeasures;
	}

	public void setBasisdesc(String basisdesc){
		this.basisdesc=basisdesc;
	}

	public String getBasisdesc(){
		return basisdesc;
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

