package com.askj.supervision.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  BSCHECKTASKDETAIL的中文含义是: 检查任务明细表
 * @Creation     2016/11/01 10:40:16
 * @Written      Create Tool By zjf 
 **/
@Table(value = "BSCHECKTASKDETAIL")
public class Bschecktaskdetail {
	/**
	 * @Description taskdetailid的中文含义是： 任务明细主键
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_taskdetailid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_taskdetailid.nextval from dual"))
	private String taskdetailid;

	/**
	 * @Description taskid的中文含义是： 任务ID
	 */
	@Column
	private String taskid;

	/**
	 * @Description comid的中文含义是： 公司ID
	 */
	@Column
	private String comid;

	/**
	 * @Description flag的中文含义是： 检查进度标志
	 */
	@Column
	private String flag;

	
		/**
	 * @Description taskdetailid的中文含义是： 任务明细主键
	 */
	public void setTaskdetailid(String taskdetailid){ 
		this.taskdetailid = taskdetailid;
	}
	/**
	 * @Description taskdetailid的中文含义是： 任务明细主键
	 */
	public String getTaskdetailid(){
		return taskdetailid;
	}
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
	 * @Description comid的中文含义是： 公司ID
	 */
	public void setComid(String comid){ 
		this.comid = comid;
	}
	/**
	 * @Description comid的中文含义是： 公司ID
	 */
	public String getComid(){
		return comid;
	}
	/**
	 * @Description flag的中文含义是： 检查进度标志
	 */
	public void setFlag(String flag){ 
		this.flag = flag;
	}
	/**
	 * @Description flag的中文含义是： 检查进度标志
	 */
	public String getFlag(){
		return flag;
	}

	
}