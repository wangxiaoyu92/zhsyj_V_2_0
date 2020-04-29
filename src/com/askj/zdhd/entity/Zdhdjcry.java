package com.askj.zdhd.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZDHDJCRY的中文含义是: 重大活动检查人员; InnoDB free: 11264 kB
 * @Creation     2016/11/10 17:35:08
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZDHDJCRY")
public class Zdhdjcry {
	/**
	 * @Description zdhdjcryid的中文含义是： 重大活动检查人员表id
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_zdhdjcryid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_zdhdjcryid.nextval from dual"))
	private String zdhdjcryid;

	/**
	 * @Description zdhddjid的中文含义是： 重大活动登记表ID
	 */
	@Column
	private String zdhddjid;

	/**
	 * @Description userid的中文含义是： 人员id
	 */
	@Column
	private String userid;

	
		/**
	 * @Description zdhdjcryid的中文含义是： 重大活动检查人员表id
	 */
	public void setZdhdjcryid(String zdhdjcryid){ 
		this.zdhdjcryid = zdhdjcryid;
	}
	/**
	 * @Description zdhdjcryid的中文含义是： 重大活动检查人员表id
	 */
	public String getZdhdjcryid(){
		return zdhdjcryid;
	}
	/**
	 * @Description zdhddjid的中文含义是： 重大活动登记表ID
	 */
	public void setZdhddjid(String zdhddjid){ 
		this.zdhddjid = zdhddjid;
	}
	/**
	 * @Description zdhddjid的中文含义是： 重大活动登记表ID
	 */
	public String getZdhddjid(){
		return zdhddjid;
	}
	/**
	 * @Description userid的中文含义是： 人员id
	 */
	public void setUserid(String userid){ 
		this.userid = userid;
	}
	/**
	 * @Description userid的中文含义是： 人员id
	 */
	public String getUserid(){
		return userid;
	}

	
}