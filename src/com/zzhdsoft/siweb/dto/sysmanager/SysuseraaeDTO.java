package com.zzhdsoft.siweb.dto.sysmanager;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  SYSUSERAAE的中文含义是: 操作员有权操作的四品一械大类DTO
 * @Creation     2016/08/15 18:29:41
 * @Written      Create Tool By zjf 
 **/
public class SysuseraaeDTO {
	/**
	 * @Description sysuseraaeid的中文含义是： 操作员有权操作的大类ID
	 */
	private String sysuseraaeid;

	/**
	 * @Description userid的中文含义是： 操作员ID
	 */
	private String userid;

	/**
	 * @Description aae140的中文含义是： 四品一械大类
	 */
	private String aae140;
	
	/**
	 * @Description aae140name的中文含义是： 四品一械大类汉字描述
	 */
	private String aae140name;	

	
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
	public String getAae140name() {
		return aae140name;
	}
	public void setAae140name(String aae140name) {
		this.aae140name = aae140name;
	}

	
}