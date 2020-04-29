package com.askj.supervision.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  BSCHECKTASKPERSON的中文含义是: 检查任务人员表
 * @Creation     2016/11/01 10:39:10
 * @Written      Create Tool By zjf 
 **/
@Table(value = "BSCHECKTASKPERSON")
public class Bschecktaskperson {
	/**
	 * @Description id的中文含义是： 主键
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_id')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_id.nextval from dual"))
	private String id;

	/**
	 * @Description taskid的中文含义是： 检查任务ID
	 */
	@Column
	private String taskid;

	/**
	 * @Description userid的中文含义是： 检查人员ID
	 */
	@Column
	private String userid;

	
		/**
	 * @Description id的中文含义是： 主键
	 */
	public void setId(String id){ 
		this.id = id;
	}
	/**
	 * @Description id的中文含义是： 主键
	 */
	public String getId(){
		return id;
	}
	/**
	 * @Description taskid的中文含义是： 检查任务ID
	 */
	public void setTaskid(String taskid){ 
		this.taskid = taskid;
	}
	/**
	 * @Description taskid的中文含义是： 检查任务ID
	 */
	public String getTaskid(){
		return taskid;
	}
	/**
	 * @Description userid的中文含义是： 检查人员ID
	 */
	public void setUserid(String userid){ 
		this.userid = userid;
	}
	/**
	 * @Description userid的中文含义是： 检查人员ID
	 */
	public String getUserid(){
		return userid;
	}

	
}