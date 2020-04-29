package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFAJCBR的中文含义是: 立案表对应的执法人员信息; InnoDB free: 76800 kB
 * @Creation     2016/03/18 14:50:00
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFAJCBR")
public class Zfajcbr {
	/**
	 * @Description ajcbrid的中文含义是： 
	 */
	@Column
	@Name
	private String ajcbrid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description userid的中文含义是： 对应sysuser表ID，对应viewZfry中userid
	 */
	@Column
	private String userid;

	/**
	 * @Description zfryxm的中文含义是： 执法人员姓名
	 */
	@Column
	private String zfryxm;

	/**
	 * @Description zfrysflx的中文含义是： 执法人员身份类型如1组员0组长见代表表zfrysflx
	 */
	@Column
	private String zfrysflx;

	/**
	 * @Description zfryzjhm的中文含义是： 执法人员证件号码
	 */
	@Column
	private String zfryzjhm;

	/**
	 * @Description zfrybmmc的中文含义是： 执法人员部门名称
	 */
	@Column
	private String zfrybmmc;

	/**
	 * @Description zfryzw的中文含义是： 执法人员职务
	 */
	@Column
	private String zfryzw;

	
		/**
	 * @Description ajcbrid的中文含义是： 
	 */
	public void setAjcbrid(String ajcbrid){ 
		this.ajcbrid = ajcbrid;
	}
	/**
	 * @Description ajcbrid的中文含义是： 
	 */
	public String getAjcbrid(){
		return ajcbrid;
	}
	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	public void setAjdjid(String ajdjid){ 
		this.ajdjid = ajdjid;
	}
	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	public String getAjdjid(){
		return ajdjid;
	}
	/**
	 * @Description userid的中文含义是： 对应sysuser表ID，对应viewZfry中userid
	 */
	public void setUserid(String userid){ 
		this.userid = userid;
	}
	/**
	 * @Description userid的中文含义是： 对应sysuser表ID，对应viewZfry中userid
	 */
	public String getUserid(){
		return userid;
	}
	/**
	 * @Description zfryxm的中文含义是： 执法人员姓名
	 */
	public void setZfryxm(String zfryxm){ 
		this.zfryxm = zfryxm;
	}
	/**
	 * @Description zfryxm的中文含义是： 执法人员姓名
	 */
	public String getZfryxm(){
		return zfryxm;
	}
	/**
	 * @Description zfrysflx的中文含义是： 执法人员身份类型如1组员0组长见代表表zfrysflx
	 */
	public void setZfrysflx(String zfrysflx){ 
		this.zfrysflx = zfrysflx;
	}
	/**
	 * @Description zfrysflx的中文含义是： 执法人员身份类型如1组员0组长见代表表zfrysflx
	 */
	public String getZfrysflx(){
		return zfrysflx;
	}
	/**
	 * @Description zfryzjhm的中文含义是： 执法人员证件号码
	 */
	public void setZfryzjhm(String zfryzjhm){ 
		this.zfryzjhm = zfryzjhm;
	}
	/**
	 * @Description zfryzjhm的中文含义是： 执法人员证件号码
	 */
	public String getZfryzjhm(){
		return zfryzjhm;
	}
	/**
	 * @Description zfrybmmc的中文含义是： 执法人员部门名称
	 */
	public void setZfrybmmc(String zfrybmmc){ 
		this.zfrybmmc = zfrybmmc;
	}
	/**
	 * @Description zfrybmmc的中文含义是： 执法人员部门名称
	 */
	public String getZfrybmmc(){
		return zfrybmmc;
	}
	/**
	 * @Description zfryzw的中文含义是： 执法人员职务
	 */
	public void setZfryzw(String zfryzw){ 
		this.zfryzw = zfryzw;
	}
	/**
	 * @Description zfryzw的中文含义是： 执法人员职务
	 */
	public String getZfryzw(){
		return zfryzw;
	}

	
}