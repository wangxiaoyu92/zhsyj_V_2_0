package com.askj.supervision.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "Omcheckbasislegalrt")
public class Omcheckbasislegalrt {
/** 检查依据-法律条款关系表; InnoDB free: 6144 kB  */
	/** blid 的中文含义是：主键*/
	@Name
	@Column
	private String blid;

	/** basisid 的中文含义是：检查依据表主键*/
	@Column
	private String basisid;

	/** legalitemid 的中文含义是：法律条款表主键*/
	@Column
	private String legalitemid;

	/** operator 的中文含义是：经办人ID*/
	@Column
	private String operator;

	/** operatorname 的中文含义是：经办人名称*/
	@Column
	private String operatorname;

	/** operatedate 的中文含义是：经办时间*/
	@Column
	private Timestamp operatedate;


	public void setBlid(String blid){
		this.blid=blid;
	}

	public String getBlid(){
		return blid;
	}

	public void setBasisid(String basisid){
		this.basisid=basisid;
	}

	public String getBasisid(){
		return basisid;
	}

	public void setLegalitemid(String legalitemid){
		this.legalitemid=legalitemid;
	}

	public String getLegalitemid(){
		return legalitemid;
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

