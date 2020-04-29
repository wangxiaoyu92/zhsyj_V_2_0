package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFAJZFWSMBFGCS的中文含义是: 执法文书模板覆盖参数; InnoDB free: 2760704 kB
 * @Creation     2016/04/13 18:53:31
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFAJZFWSMBFGCS")
public class Zfajzfwsmbfgcs {
	/**
	 * @Description zfajzfwsmbfgcsid的中文含义是： 
	 */
	@Column
	@Name
	private String zfajzfwsmbfgcsid;

	/**
	 * @Description atablename的中文含义是： 表名
	 */
	@Column
	private String atablename;

	/**
	 * @Description acolname的中文含义是： 字段名
	 */
	@Column
	private String acolname;

	/**
	 * @Description fgbz的中文含义是： 覆盖标志0否1是
	 */
	@Column
	private String fgbz;

	/**
	 * @Description atablenamemc的中文含义是： 表名汉字
	 */
	@Column
	private String atablenamemc;

	/**
	 * @Description acolnamemc的中文含义是： 列名汉字
	 */
	@Column
	private String acolnamemc;

	
		/**
	 * @Description zfajzfwsmbfgcsid的中文含义是： 
	 */
	public void setZfajzfwsmbfgcsid(String zfajzfwsmbfgcsid){ 
		this.zfajzfwsmbfgcsid = zfajzfwsmbfgcsid;
	}
	/**
	 * @Description zfajzfwsmbfgcsid的中文含义是： 
	 */
	public String getZfajzfwsmbfgcsid(){
		return zfajzfwsmbfgcsid;
	}
	/**
	 * @Description atablename的中文含义是： 表名
	 */
	public void setAtablename(String atablename){ 
		this.atablename = atablename;
	}
	/**
	 * @Description atablename的中文含义是： 表名
	 */
	public String getAtablename(){
		return atablename;
	}
	/**
	 * @Description acolname的中文含义是： 字段名
	 */
	public void setAcolname(String acolname){ 
		this.acolname = acolname;
	}
	/**
	 * @Description acolname的中文含义是： 字段名
	 */
	public String getAcolname(){
		return acolname;
	}
	/**
	 * @Description fgbz的中文含义是： 覆盖标志0否1是
	 */
	public void setFgbz(String fgbz){ 
		this.fgbz = fgbz;
	}
	/**
	 * @Description fgbz的中文含义是： 覆盖标志0否1是
	 */
	public String getFgbz(){
		return fgbz;
	}
	/**
	 * @Description atablenamemc的中文含义是： 表名汉字
	 */
	public void setAtablenamemc(String atablenamemc){ 
		this.atablenamemc = atablenamemc;
	}
	/**
	 * @Description atablenamemc的中文含义是： 表名汉字
	 */
	public String getAtablenamemc(){
		return atablenamemc;
	}
	/**
	 * @Description acolnamemc的中文含义是： 列名汉字
	 */
	public void setAcolnamemc(String acolnamemc){ 
		this.acolnamemc = acolnamemc;
	}
	/**
	 * @Description acolnamemc的中文含义是： 列名汉字
	 */
	public String getAcolnamemc(){
		return acolnamemc;
	}

	
}