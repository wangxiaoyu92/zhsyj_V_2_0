package com.askj.baseinfo.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;

import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  PCYZDSZMAIN的中文含义是: 常用字段值设置主表; InnoDB free: 2726912 kB
 * @Creation     2016/06/08 15:44:10
 * @Written      Create Tool By zjf 
 **/
@Table(value = "PCYZDSZMAIN")
public class Pcyzdszmain {
	/**
	 * @Description pcyzdszmainid的中文含义是： id
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_pcyzdszmainid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_pcyzdszmainid.nextval from dual"))
	private String pcyzdszmainid;

	/**
	 * @Description tabname的中文含义是： 表名
	 */
	@Column
	private String tabname;

	/**
	 * @Description tabnamedesc的中文含义是： 表描述
	 */
	@Column
	private String tabnamedesc;

	/**
	 * @Description colname的中文含义是： 列名
	 */
	@Column
	private String colname;

	/**
	 * @Description colnamedesc的中文含义是： 列描述
	 */
	@Column
	private String colnamedesc;

	
		/**
	 * @Description pcyzdszmainid的中文含义是： id
	 */
	public void setPcyzdszmainid(String pcyzdszmainid){ 
		this.pcyzdszmainid = pcyzdszmainid;
	}
	/**
	 * @Description pcyzdszmainid的中文含义是： id
	 */
	public String getPcyzdszmainid(){
		return pcyzdszmainid;
	}
	/**
	 * @Description tabname的中文含义是： 表名
	 */
	public void setTabname(String tabname){ 
		this.tabname = tabname;
	}
	/**
	 * @Description tabname的中文含义是： 表名
	 */
	public String getTabname(){
		return tabname;
	}
	/**
	 * @Description tabnamedesc的中文含义是： 表描述
	 */
	public void setTabnamedesc(String tabnamedesc){ 
		this.tabnamedesc = tabnamedesc;
	}
	/**
	 * @Description tabnamedesc的中文含义是： 表描述
	 */
	public String getTabnamedesc(){
		return tabnamedesc;
	}
	/**
	 * @Description colname的中文含义是： 列名
	 */
	public void setColname(String colname){ 
		this.colname = colname;
	}
	/**
	 * @Description colname的中文含义是： 列名
	 */
	public String getColname(){
		return colname;
	}
	/**
	 * @Description colnamedesc的中文含义是： 列描述
	 */
	public void setColnamedesc(String colnamedesc){ 
		this.colnamedesc = colnamedesc;
	}
	/**
	 * @Description colnamedesc的中文含义是： 列描述
	 */
	public String getColnamedesc(){
		return colnamedesc;
	}

	
	

	
}