package com.askj.emergency.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  EMEVENTCHECKIN的中文含义是: 突发事件登记表; InnoDB free: 2731008 kB
 * @Creation     2016/05/25 15:37:58
 * @Written      Create Tool By zjf 
 **/
@Table(value = "EMEVENTCHECKIN")
public class Emeventcheckin {
	/**
	 * @Description eventid的中文含义是： 事件ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_eventid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_eventid.nextval from dual"))
	private String eventid;

	/**
	 * @Description newsid的中文含义是： 备案信息ID
	 */
	@Column
	private String newsid;

	/**
	 * @Description newsinitiator的中文含义是： 事件上报人
	 */
	@Column
	private String newsinitiator;

	/**
	 * @Description eventaddress的中文含义是： 事件发生地点
	 */
	@Column
	private String eventaddress;
	
	
	/**
	 * @Description eventwdzb的中文含义是： 事件发生地经度坐标
	 */
	@Column
	private String eventjdzb;
	
	/**
	 * @Description eventwdzb的中文含义是： 事件发生地纬度坐标
	 */
	@Column
	private String eventwdzb;
	
	/**
	 * @Description eventfinder的中文含义是： 事件上报人联系方式
	 */
	@Column
	private String eventfinder;

	/**
	 * @Description eventdate的中文含义是： 事件发生时间
	 */
	@Column
	private String eventdate;

	/**
	 * @Description eventcontent的中文含义是： 事件内容
	 */
	@Column
	private String eventcontent;

	/**
	 * @Description eventlevel的中文含义是： 事件等级
	 */
	@Column
	private String eventlevel;

	/**
	 * @Description remark的中文含义是： 备注
	 */
	@Column
	private String remark;

	/**
	 * @Description eventstate的中文含义是： 事件处理状态
	 */
	@Column
	private String eventstate;
	
	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	@Column
	private String aaa027;

	/**
	 * @Description operateperson的中文含义是： 经办人
	 */
	@Column
	private String operateperson;

	/**
	 * @Description operatedate的中文含义是： 经办时间
	 */
	@Column
	private String operatedate;

	
		/**
	 * @Description eventid的中文含义是： 事件ID
	 */
	public void setEventid(String eventid){ 
		this.eventid = eventid;
	}
	/**
	 * @Description eventid的中文含义是： 事件ID
	 */
	public String getEventid(){
		return eventid;
	}
	/**
	 * @Description newsid的中文含义是： 备案信息ID
	 */
	public void setNewsid(String newsid){ 
		this.newsid = newsid;
	}
	/**
	 * @Description newsid的中文含义是： 备案信息ID
	 */
	public String getNewsid(){
		return newsid;
	}
	/**
	 * @Description newsinitiator的中文含义是： 事件上报人
	 */
	public void setNewsinitiator(String newsinitiator){ 
		this.newsinitiator = newsinitiator;
	}
	/**
	 * @Description newsinitiator的中文含义是： 事件上报人
	 */
	public String getNewsinitiator(){
		return newsinitiator;
	}
	/**
	 * @Description eventaddress的中文含义是： 事件发生地点
	 */
	public void setEventaddress(String eventaddress){ 
		this.eventaddress = eventaddress;
	}
	/**
	 * @Description eventaddress的中文含义是： 事件发生地点
	 */
	public String getEventaddress(){
		return eventaddress;
	}
	
	/**
	 * @Description eventjdzb的中文含义是： 事件发生地经度坐标
	 */
	public void setEventjdzb(String eventjdzb){ 
		this.eventjdzb = eventjdzb;
	}
	/**
	 * @Description eventlevel的中文含义是： 事件发生地经度坐标
	 */
	public String getEventjdzb(){
		return eventjdzb;
	}
	
	/**
	 * @Description eventwdzb的中文含义是： 事件发生地纬度坐标
	 */
	public void setEventwdzb(String eventwdzb){ 
		this.eventwdzb = eventwdzb;
	}
	/**
	 * @Description eventlevel的中文含义是： 事件发生地纬度坐标
	 */
	public String getEventwdzb(){
		return eventwdzb;
	}
	
	/**
	 * @Description eventfinder的中文含义是： 事件上报人联系方式
	 */
	public void setEventfinder(String eventfinder){ 
		this.eventfinder = eventfinder;
	}
	/**
	 * @Description eventfinder的中文含义是： 事件上报人联系方式
	 */
	public String getEventfinder(){
		return eventfinder;
	}
	/**
	 * @Description eventdate的中文含义是： 事件发生时间
	 */
	public void setEventdate(String eventdate){ 
		this.eventdate = eventdate;
	}
	/**
	 * @Description eventdate的中文含义是： 事件发生时间
	 */
	public String getEventdate(){
		return eventdate;
	}
	/**
	 * @Description eventcontent的中文含义是： 事件内容
	 */
	public void setEventcontent(String eventcontent){ 
		this.eventcontent = eventcontent;
	}
	/**
	 * @Description eventcontent的中文含义是： 事件内容
	 */
	public String getEventcontent(){
		return eventcontent;
	}
	/**
	 * @Description eventlevel的中文含义是： 事件等级
	 */
	public void setEventlevel(String eventlevel){ 
		this.eventlevel = eventlevel;
	}
	/**
	 * @Description eventlevel的中文含义是： 事件等级
	 */
	public String getEventlevel(){
		return eventlevel;
	}
	
	/**
	 * @Description remark的中文含义是： 备注
	 */
	public void setRemark(String remark){ 
		this.remark = remark;
	}
	/**
	 * @Description remark的中文含义是： 备注
	 */
	public String getRemark(){
		return remark;
	}
	/**
	 * @Description eventstate的中文含义是： 事件处理状态
	 */
	public void setEventstate(String eventstate){ 
		this.eventstate = eventstate;
	}
	/**
	 * @Description eventstate的中文含义是： 事件处理状态
	 */
	public String getEventstate(){
		return eventstate;
	}
	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	public void setAaa027(String aaa027){ 
		this.aaa027 = aaa027;
	}
	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	public String getAaa027(){
		return aaa027;
	}
	/**
	 * @Description operateperson的中文含义是： 经办人
	 */
	public void setOperateperson(String operateperson){ 
		this.operateperson = operateperson;
	}
	/**
	 * @Description operateperson的中文含义是： 经办人
	 */
	public String getOperateperson(){
		return operateperson;
	}
	/**
	 * @Description operatedate的中文含义是： 经办时间
	 */
	public void setOperatedate(String operatedate){ 
		this.operatedate = operatedate;
	}
	/**
	 * @Description operatedate的中文含义是： 经办时间
	 */
	public String getOperatedate(){
		return operatedate;
	}

	
}