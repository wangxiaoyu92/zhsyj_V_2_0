package com.askj.supervision.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  BSCHECKTASKDETAIL的中文含义是: 检查任务明细表DTO
 * @Creation     2016/11/01 10:40:25
 * @Written      Create Tool By zjf 
 **/
public class BschecktaskdetailDTO {
	
	/**
	 * @Description commc的中文含义是： 公司名称
	 */
	private String commc;
	/**
	 * @Description comdz的中文含义是： 公司地址
	 */
	private String comdz;
	
	
	public String getCommc() {
		return commc;
	}
	public void setCommc(String commc) {
		this.commc = commc;
	}
	public String getComdz() {
		return comdz;
	}
	public void setComdz(String comdz) {
		this.comdz = comdz;
	}
	/**
	 * @Description taskdetailid的中文含义是： 任务明细主键
	 */
	private String taskdetailid;

	/**
	 * @Description taskid的中文含义是： 任务ID
	 */
	private String taskid;

	/**
	 * @Description comid的中文含义是： 公司ID
	 */
	private String comid;

	/**
	 * @Description flag的中文含义是： 检查进度标志
	 */
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