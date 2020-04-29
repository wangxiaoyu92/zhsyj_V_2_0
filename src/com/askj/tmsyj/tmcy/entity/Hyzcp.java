package com.askj.tmsyj.tmcy.entity;

import org.nutz.dao.entity.annotation.*;
import java.sql.Date;
import java.sql.Timestamp;

/**
 * @Description  Hyzcp的中文含义是: 一周菜谱表
 * @Creation     2017/03/24 17:08:39
 * @Written      Create Tool By zjf 
 **/
@Table(value = "hyzcp")
public class Hyzcp {
	/**
	 * @Description hyzcpid的中文含义是： 一周菜谱表id
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_hyzcpid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_hyzcpid.nextval from dual"))
	private String hyzcpid;

	/**
	 * @Description cprq的中文含义是： 菜谱日期
	 */
	@Column
	private Date cprq;

	/**
	 * @Description cpxq的中文含义是： 菜谱星期
	 */
	@Column
	private String cpxq;

	/**
	 * @Description jccc的中文含义是： 就餐餐次aaa100=jccc
	 */
	@Column
	private String jccc;

	/**
	 * @Description cpmc的中文含义是： 菜谱名称
	 */
	@Column
	private String cpmc;

	/**
	 * @Description aae011的中文含义是： 操作员
	 */
	@Column
	private String aae011;

	/**
	 * @Description aae036的中文含义是： 操作时间
	 */
	@Column
	private Timestamp aae036;

	/**
	 * @Description comid的中文含义是： comid
	 */
	@Column
	private String comid;

	
		/**
	 * @Description hyzcpid的中文含义是： 一周菜谱表id
	 */
	public void setHyzcpid(String hyzcpid){ 
		this.hyzcpid = hyzcpid;
	}
	/**
	 * @Description hyzcpid的中文含义是： 一周菜谱表id
	 */
	public String getHyzcpid(){
		return hyzcpid;
	}
	/**
	 * @Description cprq的中文含义是： 菜谱日期
	 */
	public void setCprq(Date cprq){ 
		this.cprq = cprq;
	}
	/**
	 * @Description cprq的中文含义是： 菜谱日期
	 */
	public Date getCprq(){
		return cprq;
	}
	/**
	 * @Description cpxq的中文含义是： 菜谱星期
	 */
	public void setCpxq(String cpxq){ 
		this.cpxq = cpxq;
	}
	/**
	 * @Description cpxq的中文含义是： 菜谱星期
	 */
	public String getCpxq(){
		return cpxq;
	}
	/**
	 * @Description jccc的中文含义是： 就餐餐次aaa100=jccc
	 */
	public void setJccc(String jccc){ 
		this.jccc = jccc;
	}
	/**
	 * @Description jccc的中文含义是： 就餐餐次aaa100=jccc
	 */
	public String getJccc(){
		return jccc;
	}
	/**
	 * @Description cpmc的中文含义是： 菜谱名称
	 */
	public void setCpmc(String cpmc){ 
		this.cpmc = cpmc;
	}
	/**
	 * @Description cpmc的中文含义是： 菜谱名称
	 */
	public String getCpmc(){
		return cpmc;
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
	public void setAae036(Timestamp aae036){ 
		this.aae036 = aae036;
	}
	/**
	 * @Description aae036的中文含义是： 操作时间
	 */
	public Timestamp getAae036(){
		return aae036;
	}
	/**
	 * @Description comid的中文含义是： comid
	 */
	public void setComid(String comid){ 
		this.comid = comid;
	}
	/**
	 * @Description comid的中文含义是： comid
	 */
	public String getComid(){
		return comid;
	}

	
}