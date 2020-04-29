package com.zzhdsoft.siweb.entity.sysmanager;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  SYSUSERAAE的中文含义是: 操作员有权操作的四品一械大类
 * @Creation     2016/08/15 18:29:36
 * @Written      Create Tool By zjf 
 **/
@Table(value = "SYSUSERAAE")
public class Sysuseraae {
	/**
	 * @Description sysuseraaeid的中文含义是： 操作员有权操作的大类ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_sysuseraaeid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_sysuseraaeid.nextval from dual"))
	private String sysuseraaeid;

	/**
	 * @Description userid的中文含义是： 操作员ID
	 */
	@Column
	private String userid;

	/**
	 * @Description aae140的中文含义是： 四品一械大类
	 */
	@Column
	private String aae140;

	
		/**
	 * @Description sysuseraaeid的中文含义是： 操作员有权操作的大类ID
	 */
	public void setSysuseraaeid(String sysuseraaeid){ 
		this.sysuseraaeid = sysuseraaeid;
	}
	/**
	 * @Description sysuseraaeid的中文含义是： 操作员有权操作的大类ID
	 */
	public String getSysuseraaeid(){
		return sysuseraaeid;
	}
	/**
	 * @Description userid的中文含义是： 操作员ID
	 */
	public void setUserid(String userid){ 
		this.userid = userid;
	}
	/**
	 * @Description userid的中文含义是： 操作员ID
	 */
	public String getUserid(){
		return userid;
	}
	/**
	 * @Description aae140的中文含义是： 四品一械大类
	 */
	public void setAae140(String aae140){ 
		this.aae140 = aae140;
	}
	/**
	 * @Description aae140的中文含义是： 四品一械大类
	 */
	public String getAae140(){
		return aae140;
	}

	
}