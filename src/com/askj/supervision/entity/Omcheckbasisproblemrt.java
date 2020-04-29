package com.askj.supervision.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "Omcheckbasisproblemrt")
public class Omcheckbasisproblemrt {
/** 检查依据-问题关系表; InnoDB free: 6144 kB  */
	/** bpid 的中文含义是：主键*/
	@Name
	@Column
	private String bpid;

	/** basisid 的中文含义是：检查依据表主键*/
	@Column
	private String basisid;

	/** problemid 的中文含义是：法律条款表主键*/
	@Column
	private String problemid;

	/** operator 的中文含义是：经办人ID*/
	@Column
	private String operator;

	/** operatorname 的中文含义是：经办人名称*/
	@Column
	private String operatorname;

	/** operatedate 的中文含义是：经办时间*/
	@Column
	private Timestamp operatedate;


	public void setBpid(String bpid){
		this.bpid=bpid;
	}

	public String getBpid(){
		return bpid;
	}

	public void setBasisid(String basisid){
		this.basisid=basisid;
	}

	public String getBasisid(){
		return basisid;
	}

	public void setProblemid(String problemid){
		this.problemid=problemid;
	}

	public String getProblemid(){
		return problemid;
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

