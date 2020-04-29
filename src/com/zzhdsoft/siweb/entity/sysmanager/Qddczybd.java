package com.zzhdsoft.siweb.entity.sysmanager;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  QDDCZYBD的中文含义是: 操作员签到点绑定表
 * @Creation     2017/02/16 11:50:05
 * @Written      Create Tool By zjf 
 **/
@Table(value = "QDDCZYBD")
public class Qddczybd {
	/**
	 * @Description qddczybdid的中文含义是： 操作员签到点绑定表
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_qddczybdid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_qddczybdid.nextval from dual"))
	private String qddczybdid;

	/**
	 * @Description userid的中文含义是： 操作员ID
	 */
	@Column
	private String userid;

	/**
	 * @Description qddszid的中文含义是： 签到点设置表ID
	 */
	@Column
	private String qddszid;

	/**
	 * @Description aae011的中文含义是： 操作员
	 */
	@Column
	private String aae011;

	/**
	 * @Description aae036的中文含义是： 操作日期
	 */
	@Column
	private String aae036;

	/**
	 * @Description aae013的中文含义是： 备注
	 */
	@Column
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