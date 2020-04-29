package com.askj.zdhd.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZDHDJCRY的中文含义是: 重大活动检查人员; InnoDB free: 11264 kBDTO
 * @Creation     2016/11/10 17:36:00
 * @Written      Create Tool By zjf 
 **/
public class ZdhdjcryDTO {
	/**
	 * @Description zdhdjcryid的中文含义是： 重大活动检查人员表id
	 */
	private String zdhdjcryid;

	/**
	 * @Description zdhddjid的中文含义是： 重大活动登记表ID
	 */
	private String zdhddjid;

	/**
	 * @Description userid的中文含义是： 人员id
	 */
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