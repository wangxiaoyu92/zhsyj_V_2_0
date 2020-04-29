package com.askj.supervision.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  BSCHECKTASK的中文含义是: 检查任务分派概要表
 * @Creation     2016/11/01 10:40:03
 * @Written      Create Tool By zjf 
 **/
@Table(value = "BSCHECKTASK")
public class Bschecktask {
	/**
	 * @Description taskid的中文含义是： 任务ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_taskid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_taskid.nextval from dual"))
	private String taskid;

	/**
	 * @Description planid的中文含义是： 计划ID
	 */
	@Column
	private String planid;

	/**
	 * @Description taskname的中文含义是： 任务名称
	 */
	@Column
	private String taskname;

	/**
	 * @Description taskremark的中文含义是： 任务描述
	 */
	@Column
	private String taskremark;

	/**
	 * @Description tasktimest的中文含义是： 任务开始时间
	 */
	@Column
	private String tasktimest;

	/**
	 * @Description tasktimeed的中文含义是： 任务结束时间
	 */
	@Column
	private String tasktimeed;

	/**
	 * @Description aaa011的中文含义是： 经办人
	 */
	@Column
	private String aaa011;

	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	@Column
	private String aae036;

	
		/**
	 * @Description taskid的中文含义是： 任务ID
	 */
	public void setTaskid(String taskid){ 
		this.taskid = taskid;
	}
	/**
	 * @Description taskid的中文含义是： 任务ID
	 */
	public String getTaskid(){
		return taskid;
	}
	/**
	 * @Description planid的中文含义是： 计划ID
	 */
	public void setPlanid(String planid){ 
		this.planid = planid;
	}
	/**
	 * @Description planid的中文含义是： 计划ID
	 */
	public String getPlanid(){
		return planid;
	}
	/**
	 * @Description taskname的中文含义是： 任务名称
	 */
	public void setTaskname(String taskname){ 
		this.taskname = taskname;
	}
	/**
	 * @Description taskname的中文含义是： 任务名称
	 */
	public String getTaskname(){
		return taskname;
	}
	/**
	 * @Description taskremark的中文含义是： 任务描述
	 */
	public void setTaskremark(String taskremark){ 
		this.taskremark = taskremark;
	}
	/**
	 * @Description taskremark的中文含义是： 任务描述
	 */
	public String getTaskremark(){
		return taskremark;
	}
	/**
	 * @Description tasktimest的中文含义是： 任务开始时间
	 */
	public void setTasktimest(String tasktimest){ 
		this.tasktimest = tasktimest;
	}
	/**
	 * @Description tasktimest的中文含义是： 任务开始时间
	 */
	public String getTasktimest(){
		return tasktimest;
	}
	/**
	 * @Description tasktimeed的中文含义是： 任务结束时间
	 */
	public void setTasktimeed(String tasktimeed){ 
		this.tasktimeed = tasktimeed;
	}
	/**
	 * @Description tasktimeed的中文含义是： 任务结束时间
	 */
	public String getTasktimeed(){
		return tasktimeed;
	}
	/**
	 * @Description aaa011的中文含义是： 经办人
	 */
	public void setAaa011(String aaa011){ 
		this.aaa011 = aaa011;
	}
	/**
	 * @Description aaa011的中文含义是： 经办人
	 */
	public String getAaa011(){
		return aaa011;
	}
	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	public void setAae036(String aae036){ 
		this.aae036 = aae036;
	}
	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	public String getAae036(){
		return aae036;
	}

	
}