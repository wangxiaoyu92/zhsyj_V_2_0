package com.zzhdsoft.siweb.entity.sysmanager;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  QDDSZ的中文含义是: 
 * @Creation     2017/02/15 16:44:13
 * @Written      Create Tool By zjf 
 **/
@Table(value = "QDDSZ")
public class Qddsz {
	/**
	 * @Description qddszid的中文含义是： 签到点设置表ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_qddszid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_qddszid.nextval from dual"))
	private String qddszid;

	/**
	 * @Description qddmc的中文含义是： 签到点名称
	 */
	@Column
	private String qddmc;

	/**
	 * @Description qddjdzb的中文含义是： 签到点经度坐标
	 */
	@Column
	private String qddjdzb;

	/**
	 * @Description qddwdzb的中文含义是： 签到点纬度坐标
	 */
	@Column
	private String qddwdzb;

	/**
	 * @Description qddyxjl的中文含义是： 签到点有效距离(以米为单位)
	 */
	@Column
	private String qddyxjl;

	/**
	 * @Description qdddz的中文含义是： 签到点地址
	 */
	@Column
	private String qdddz;

	/**
	 * @Description aae011的中文含义是： 操作员
	 */
	@Column
	private String aae011;

	/**
	 * @Description aae036的中文含义是： 操作时间
	 */
	@Column
	private String aae036;

	/**
	 * @Description aae013的中文含义是： 备注
	 */
	@Column
	private String aae013;

	/**
	 * @Description aae100的中文含义是： 是否有效0无效1有效
	 */
	@Column
	private String aae100;

	
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
	 * @Description qddmc的中文含义是： 签到点名称
	 */
	public void setQddmc(String qddmc){ 
		this.qddmc = qddmc;
	}
	/**
	 * @Description qddmc的中文含义是： 签到点名称
	 */
	public String getQddmc(){
		return qddmc;
	}
	/**
	 * @Description qddjdzb的中文含义是： 签到点经度坐标
	 */
	public void setQddjdzb(String qddjdzb){ 
		this.qddjdzb = qddjdzb;
	}
	/**
	 * @Description qddjdzb的中文含义是： 签到点经度坐标
	 */
	public String getQddjdzb(){
		return qddjdzb;
	}
	/**
	 * @Description qddwdzb的中文含义是： 签到点纬度坐标
	 */
	public void setQddwdzb(String qddwdzb){ 
		this.qddwdzb = qddwdzb;
	}
	/**
	 * @Description qddwdzb的中文含义是： 签到点纬度坐标
	 */
	public String getQddwdzb(){
		return qddwdzb;
	}
	/**
	 * @Description qddyxjl的中文含义是： 签到点有效距离(以米为单位)
	 */
	public void setQddyxjl(String qddyxjl){ 
		this.qddyxjl = qddyxjl;
	}
	/**
	 * @Description qddyxjl的中文含义是： 签到点有效距离(以米为单位)
	 */
	public String getQddyxjl(){
		return qddyxjl;
	}
	/**
	 * @Description qdddz的中文含义是： 签到点地址
	 */
	public void setQdddz(String qdddz){ 
		this.qdddz = qdddz;
	}
	/**
	 * @Description qdddz的中文含义是： 签到点地址
	 */
	public String getQdddz(){
		return qdddz;
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
	 * @Description aae036的中文含义是： 操作时间
	 */
	public void setAae036(String aae036){ 
		this.aae036 = aae036;
	}
	/**
	 * @Description aae036的中文含义是： 操作时间
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
	/**
	 * @Description aae100的中文含义是： 是否有效0无效1有效
	 */
	public void setAae100(String aae100){ 
		this.aae100 = aae100;
	}
	/**
	 * @Description aae100的中文含义是： 是否有效0无效1有效
	 */
	public String getAae100(){
		return aae100;
	}

	
}