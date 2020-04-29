package com.askj.jyjc.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  JYJCJGMAIN的中文含义是: 检验检测结果主表; InnoDB free: 8192 kB
 * @Creation     2016/10/25 16:19:20
 * @Written      Create Tool By zjf 
 **/
@Table(value = "JYJCJGMAIN")
public class Jyjcjgmain {
	/**
	 * @Description impbatchno的中文含义是： 
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_impbatchno')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_impbatchno.nextval from dual"))
	private String impbatchno;

	/**
	 * @Description impczy的中文含义是： 
	 */
	@Column
	private String impczy;

	/**
	 * @Description impczsj的中文含义是： 
	 */
	@Column
	private String impczsj;

	/**
	 * @Description userid的中文含义是： 
	 */
	@Column
	private String userid;

	/**
	 * @Description comid的中文含义是： 
	 */
	@Column
	private String comid;

	
		/**
	 * @Description impbatchno的中文含义是： 
	 */
	public void setImpbatchno(String impbatchno){ 
		this.impbatchno = impbatchno;
	}
	/**
	 * @Description impbatchno的中文含义是： 
	 */
	public String getImpbatchno(){
		return impbatchno;
	}
	/**
	 * @Description impczy的中文含义是： 
	 */
	public void setImpczy(String impczy){ 
		this.impczy = impczy;
	}
	/**
	 * @Description impczy的中文含义是： 
	 */
	public String getImpczy(){
		return impczy;
	}
	/**
	 * @Description impczsj的中文含义是： 
	 */
	public void setImpczsj(String impczsj){ 
		this.impczsj = impczsj;
	}
	/**
	 * @Description impczsj的中文含义是： 
	 */
	public String getImpczsj(){
		return impczsj;
	}
	/**
	 * @Description userid的中文含义是： 
	 */
	public void setUserid(String userid){ 
		this.userid = userid;
	}
	/**
	 * @Description userid的中文含义是： 
	 */
	public String getUserid(){
		return userid;
	}
	/**
	 * @Description comid的中文含义是： 
	 */
	public void setComid(String comid){ 
		this.comid = comid;
	}
	/**
	 * @Description comid的中文含义是： 
	 */
	public String getComid(){
		return comid;
	}

	
}