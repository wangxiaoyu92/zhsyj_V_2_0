package com.askj.baseinfo.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  PFJCSORDER的中文含义是: 附件参数排序表; InnoDB free: 13312 kB
 * @Creation     2016/12/28 15:37:00
 * @Written      Create Tool By zjf 
 **/
@Table(value = "PFJCSORDER")
public class Pfjcsorder {
	/**
	 * @Description pfjcsorderid的中文含义是： 
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_pfjcsorderid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_pfjcsorderid.nextval from dual"))
	private String pfjcsorderid;

	/**
	 * @Description userid的中文含义是： 对应操作员表主键
	 */
	@Column
	private String userid;

	/**
	 * @Description fjcsid的中文含义是： 对应附件参数表主键
	 */
	@Column
	private String fjcsid;

	/**
	 * @Description fjcspx的中文含义是： 排序值
	 */
	@Column
	private String fjcspx;

	
		/**
	 * @Description pfjcsorderid的中文含义是： 
	 */
	public void setPfjcsorderid(String pfjcsorderid){ 
		this.pfjcsorderid = pfjcsorderid;
	}
	/**
	 * @Description pfjcsorderid的中文含义是： 
	 */
	public String getPfjcsorderid(){
		return pfjcsorderid;
	}
	/**
	 * @Description userid的中文含义是： 对应操作员表主键
	 */
	public void setUserid(String userid){ 
		this.userid = userid;
	}
	/**
	 * @Description userid的中文含义是： 对应操作员表主键
	 */
	public String getUserid(){
		return userid;
	}
	/**
	 * @Description fjcsid的中文含义是： 对应附件参数表主键
	 */
	public void setFjcsid(String fjcsid){ 
		this.fjcsid = fjcsid;
	}
	/**
	 * @Description fjcsid的中文含义是： 对应附件参数表主键
	 */
	public String getFjcsid(){
		return fjcsid;
	}
	public String getFjcspx() {
		return fjcspx;
	}
	public void setFjcspx(String fjcspx) {
		this.fjcspx = fjcspx;
	}


	
}