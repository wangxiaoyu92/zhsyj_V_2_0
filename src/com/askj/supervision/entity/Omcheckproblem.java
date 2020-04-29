package com.askj.supervision.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "Omcheckproblem")
public class Omcheckproblem {
/** 检查依据问题表; InnoDB free: 6144 kB  */
	/** problemid 的中文含义是：主键*/
	@Name
	@Column
	private String problemid;

	/** problemdesc 的中文含义是：问题描述*/
	@Column
	private String problemdesc;

	/** operator 的中文含义是：经办人ID*/
	@Column
	private String operator;

	/** operatorname 的中文含义是：经办人名称*/
	@Column
	private String operatorname;

	/** operatedate 的中文含义是：经办时间*/
	@Column
	private Timestamp operatedate;


	public void setProblemid(String problemid){
		this.problemid=problemid;
	}

	public String getProblemid(){
		return problemid;
	}

	public void setProblemdesc(String problemdesc){
		this.problemdesc=problemdesc;
	}

	public String getProblemdesc(){
		return problemdesc;
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

