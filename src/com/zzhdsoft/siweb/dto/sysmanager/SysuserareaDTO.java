package com.zzhdsoft.siweb.dto.sysmanager;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  SYSUSERAREA的中文含义是: 操作员有权操作的地区DTO
 * @Creation     2016/08/15 18:25:48
 * @Written      Create Tool By zjf 
 **/
public class SysuserareaDTO {
	/**
	 * @Description sysuserareaid的中文含义是： 操作员有权操作的地区ID
	 */
	private String sysuserareaid;

	/**
	 * @Description userid的中文含义是： 操作员ID
	 */
	private String userid;

	/**
	 * @Description aaa027的中文含义是： 操作有权操作的统筹区
	 */
	private String aaa027;

	
		/**
	 * @Description sysuserareaid的中文含义是： 操作员有权操作的地区ID
	 */
	public void setSysuserareaid(String sysuserareaid){ 
		this.sysuserareaid = sysuserareaid;
	}
	/**
	 * @Description sysuserareaid的中文含义是： 操作员有权操作的地区ID
	 */
	public String getSysuserareaid(){
		return sysuserareaid;
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
	 * @Description aaa027的中文含义是： 操作有权操作的统筹区
	 */
	public void setAaa027(String aaa027){ 
		this.aaa027 = aaa027;
	}
	/**
	 * @Description aaa027的中文含义是： 操作有权操作的统筹区
	 */
	public String getAaa027(){
		return aaa027;
	}

	
}