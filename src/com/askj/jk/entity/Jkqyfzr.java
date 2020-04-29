package com.askj.jk.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  JKQYFZR的中文含义是: 监控企业负责人表
 * @Creation     2016/12/05 14:01:42
 * @Written      Create Tool By zjf 
 **/
@Table(value = "JKQYFZR")
public class Jkqyfzr {
	/**
	 * @Description jkqyfzrid的中文含义是： 主键
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_jkqyfzrid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_jkqyfzrid.nextval from dual"))
	private String jkqyfzrid;

	/**
	 * @Description comid的中文含义是： 监控企业ID
	 */
	@Column
	private String comid;

	/**
	 * @Description userid的中文含义是： 负责人ID
	 */
	@Column
	private String userid;

	
		/**
	 * @Description jkqyfzrid的中文含义是： 主键
	 */
	public void setJkqyfzrid(String jkqyfzrid){ 
		this.jkqyfzrid = jkqyfzrid;
	}
	/**
	 * @Description jkqyfzrid的中文含义是： 主键
	 */
	public String getJkqyfzrid(){
		return jkqyfzrid;
	}
	/**
	 * @Description comid的中文含义是： 监控企业ID
	 */
	public void setComid(String comid){ 
		this.comid = comid;
	}
	/**
	 * @Description comid的中文含义是： 监控企业ID
	 */
	public String getComid(){
		return comid;
	}
	/**
	 * @Description userid的中文含义是： 负责人ID
	 */
	public void setUserid(String userid){ 
		this.userid = userid;
	}
	/**
	 * @Description userid的中文含义是： 负责人ID
	 */
	public String getUserid(){
		return userid;
	}

	
}