package com.zzhdsoft.siweb.dto.sysmanager;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;

import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  QDDCZYBD的中文含义是: 操作员签到点绑定表DTO
 * @Creation     2017/02/15 16:46:12
 * @Written      Create Tool By zjf 
 **/
public class QddczybdDTO {
	/**
	 * @Description qddczybdid的中文含义是： 操作员签到点绑定表
	 */
	private String qddczybdid;

	/**
	 * @Description userid的中文含义是： 操作员ID
	 */
	private String userid;

	/**
	 * @Description qddszid的中文含义是： 签到点设置表ID
	 */
	private String qddszid;

	/**
	 * @Description aae011的中文含义是： 操作员
	 */
	private String aae011;

	/**
	 * @Description aae036的中文含义是： 操作日期
	 */
	private String aae036;

	/**
	 * @Description aae013的中文含义是： 备注
	 */
	private String aae013; 
	
	 
		/**
	 * @Description qddczybdid的中文含义是： 操作员签到点绑定表
	 */
	public void setQddczybdid(String qddczybdid){ 
		this.qddczybdid = qddczybdid;
	}
	/**
	 * @Description qddczybdid的中文含义是： 操作员签到点绑定表
	 */
	public String getQddczybdid(){
		return qddczybdid;
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
	 * @Description qddszid的中文含义是： 签到点设置表ID
	 */
	public void setQddszid(String qddszid){ 
		this.qddszid = qddszid;
	}
	/**
	 * @Description qddszid的中文含义是： 签到点设置表ID
	 */
	public String getQddszid(){
		return qddszid;
	}
	/**
	 * @Description aae011的中文含义是： 操作员
	 */
	public void setAae011(String aae011){ 
		this.aae011 = aae011;
	}
	/**
	 * @Description aae011的中文含义是： 操作员
	 */
	public String getAae011(){
		return aae011;
	}
	/**
	 * @Description aae036的中文含义是： 操作日期
	 */
	public void setAae036(String aae036){ 
		this.aae036 = aae036;
	}
	/**
	 * @Description aae036的中文含义是： 操作日期
	 */
	public String getAae036(){
		return aae036;
	}
	/**
	 * @Description aae013的中文含义是： 备注
	 */
	public void setAae013(String aae013){ 
		this.aae013 = aae013;
	}
	/**
	 * @Description aae013的中文含义是： 备注
	 */
	public String getAae013(){
		return aae013;
	}

	
}