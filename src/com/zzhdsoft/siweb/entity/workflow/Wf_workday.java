package com.zzhdsoft.siweb.entity.workflow;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  WF_WORKDAY的中文含义是: 工作日设置表
 * @Creation     2016/01/28 11:21:10
 * @Written      Create Tool By zjf 
 **/
@Table(value = "WF_WORKDAY")
public class Wf_workday {
	/**
	 * @Description wdid的中文含义是：年度工作日ID  
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_wdid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_wdid.nextval from dual"))
	private String wdid;

	/**
	 * @Description wdyear的中文含义是： 年度
	 */
	@Column
	private String wdyear;

	/**
	 * @Description wdday的中文含义是： 年度工作日
	 */
	@Column
	private String wdday;

	
		/**
	 * @Description wdid的中文含义是：年度工作日ID    
	 */
	public void setWdid(String wdid){ 
		this.wdid = wdid;
	}
	/**
	 * @Description wdid的中文含义是：年度工作日ID   
	 */
	public String getWdid(){
		return wdid;
	}
	/**
	 * @Description wdyear的中文含义是： 年度
	 */
	public void setWdyear(String wdyear){ 
		this.wdyear = wdyear;
	}
	/**
	 * @Description wdyear的中文含义是： 年度
	 */
	public String getWdyear(){
		return wdyear;
	}
	/**
	 * @Description wdday的中文含义是： 年度工作日
	 */
	public void setWdday(String wdday){ 
		this.wdday = wdday;
	}
	/**
	 * @Description wdday的中文含义是： 年度工作日
	 */
	public String getWdday(){
		return wdday;
	}

	
}