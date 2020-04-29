package com.askj.ncjtjc.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  JCSBCD的中文含义是: 聚餐申报菜单; InnoDB free: 2720768 kB
 * @Creation     2016/05/21 19:14:53
 * @Written      Create Tool By zjf 
 **/
@Table(value = "JCSBCD")
public class Jcsbcd {
	/**
	 * @Description jcsbcdid的中文含义是： 聚餐申报菜单id
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_jcsbcdid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_jcsbcdid.nextval from dual"))
	private String jcsbcdid;

	/**
	 * @Description jcsbid的中文含义是： 聚餐申报id
	 */
	@Column
	private String jcsbid;

	/**
	 * @Description jcsbcdlx的中文含义是： 聚餐申报菜单类型
	 */
	@Column
	private String jcsbcdlx;

	/**
	 * @Description jcsbcdmc的中文含义是： 聚餐申报菜单名
	 */
	@Column
	private String jcsbcdmc;

	
		/**
	 * @Description jcsbcdid的中文含义是： 聚餐申报菜单id
	 */
	public void setJcsbcdid(String jcsbcdid){ 
		this.jcsbcdid = jcsbcdid;
	}
	/**
	 * @Description jcsbcdid的中文含义是： 聚餐申报菜单id
	 */
	public String getJcsbcdid(){
		return jcsbcdid;
	}
	/**
	 * @Description jcsbid的中文含义是： 聚餐申报id
	 */
	public void setJcsbid(String jcsbid){ 
		this.jcsbid = jcsbid;
	}
	/**
	 * @Description jcsbid的中文含义是： 聚餐申报id
	 */
	public String getJcsbid(){
		return jcsbid;
	}
	/**
	 * @Description jcsbcdlx的中文含义是： 聚餐申报菜单类型
	 */
	public void setJcsbcdlx(String jcsbcdlx){ 
		this.jcsbcdlx = jcsbcdlx;
	}
	/**
	 * @Description jcsbcdlx的中文含义是： 聚餐申报菜单类型
	 */
	public String getJcsbcdlx(){
		return jcsbcdlx;
	}
	/**
	 * @Description jcsbcdmc的中文含义是： 聚餐申报菜单名
	 */
	public void setJcsbcdmc(String jcsbcdmc){ 
		this.jcsbcdmc = jcsbcdmc;
	}
	/**
	 * @Description jcsbcdmc的中文含义是： 聚餐申报菜单名
	 */
	public String getJcsbcdmc(){
		return jcsbcdmc;
	}

	
}