package com.askj.supervision.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  BSCHECKTASK的中文含义是: 检查任务分派概要表DTO
 * @Creation     2016/11/01 10:39:55
 * @Written      Create Tool By zjf 
 **/
public class BschecktaskDTO {
	
	/**
	 * @Description comgrid_rows的中文含义是： 检查企业
	 */
	private String comgrid_rows;
	
	/**
	 * @Description rygrid_rows的中文含义是： 检查人员
	 */
	private String rygrid_rows;
	

	private String aaz093;
	
	 
	public String getAaz093() {
		return aaz093;
	}
	public void setAaz093(String aaz093) {
		this.aaz093 = aaz093;
	}
	public String getComgrid_rows() {
		return comgrid_rows;
	}
	public void setComgrid_rows(String comgrid_rows) {
		this.comgrid_rows = comgrid_rows;
	}
	public String getRygrid_rows() {
		return rygrid_rows;
	}
	public void setRygrid_rows(String rygrid_rows) {
		this.rygrid_rows = rygrid_rows;
	}
	/**
	 * @Description taskid的中文含义是： 任务ID
	 */
	private String taskid;

	/**
	 * @Description planid的中文含义是： 计划ID
	 */
	private String planid;

	/**
	 * @Description taskname的中文含义是： 任务名称
	 */
	private String taskname;

	/**
	 * @Description taskremark的中文含义是： 任务描述
	 */
	private String taskremark;

	/**
	 * @Description tasktimest的中文含义是： 任务开始时间
	 */
	private String tasktimest;

	/**
	 * @Description tasktimeed的中文含义是： 任务结束时间
	 */
	private String tasktimeed;

	/**
	 * @Description aaa011的中文含义是： 经办人
	 */
	private String aaa011;

	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	private String aae036;
	
	/**
	 * @Description userid的中文含义是： 用户id
	 */
	 private String userid;
	 /**
	  * @Description plantitle的中文含义是：计划标题
	  */
	 private String plantitle;
	 /**
	  * @Description plantype的中文含义是： 计划类型
	  */
	 private String plantype;
	 /**
	  * @Description commc的中文含义是：企业名称
	  */
	 private String commc;
	 /**
	  * @Description  comdalei的中文含义是：企业大类
	  */
	 private String  comdalei;
	 /**
	  * @Description  comid的中文含义是：企业id
	  */
	 private String  comid;
	 /**
	  * @Description  aaa027的中文含义是：发统区
	  */
	 private String  aaa027;

    

    public String getAaa027() {
		return aaa027;
	}
	public void setAaa027(String aaa027) {
		this.aaa027 = aaa027;
	}
	public String getComid() {
		return comid;
	}
	public void setComid(String comid) {
		this.comid = comid;
	}
	public String getPlantitle() {
		return plantitle;
	}
	public void setPlantitle(String plantitle) {
		this.plantitle = plantitle;
	}
	public String getPlantype() {
		return plantype;
	}
	public void setPlantype(String plantype) {
		this.plantype = plantype;
	}
	public String getCommc() {
		return commc;
	}
	public void setCommc(String commc) {
		this.commc = commc;
	}
	public String getComdalei() {
		return comdalei;
	}
	public void setComdalei(String comdalei) {
		this.comdalei = comdalei;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
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