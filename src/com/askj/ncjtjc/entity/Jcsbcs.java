package com.askj.ncjtjc.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  JCSBCS的中文含义是: 聚餐申报厨师; InnoDB free: 2720768 kB
 * @Creation     2016/05/21 19:14:46
 * @Written      Create Tool By zjf 
 **/
@Table(value = "JCSBCS")
public class Jcsbcs {
	/**
	 * @Description jcsbcsid的中文含义是： 聚餐申报厨师id
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_jcsbcsid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_jcsbcsid.nextval from dual"))
	private String jcsbcsid;

	/**
	 * @Description jcsbid的中文含义是： 聚餐申报id
	 */
	@Column
	private String jcsbid;

	/**
	 * @Description csid的中文含义是： 厨师id
	 */
	@Column
	private String csid;

	/**
	 * @Description jcsbcslx的中文含义是： 聚餐申报厨师类型
	 */
	@Column
	private String jcsbcslx;

	
		/**
	 * @Description jcsbcsid的中文含义是： 聚餐申报厨师id
	 */
	public void setJcsbcsid(String jcsbcsid){ 
		this.jcsbcsid = jcsbcsid;
	}
	/**
	 * @Description jcsbcsid的中文含义是： 聚餐申报厨师id
	 */
	public String getJcsbcsid(){
		return jcsbcsid;
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
	 * @Description csid的中文含义是： 厨师id
	 */
	public void setCsid(String csid){ 
		this.csid = csid;
	}
	/**
	 * @Description csid的中文含义是： 厨师id
	 */
	public String getCsid(){
		return csid;
	}
	/**
	 * @Description jcsbcslx的中文含义是： 聚餐申报厨师类型
	 */
	public void setJcsbcslx(String jcsbcslx){ 
		this.jcsbcslx = jcsbcslx;
	}
	/**
	 * @Description jcsbcslx的中文含义是： 聚餐申报厨师类型
	 */
	public String getJcsbcslx(){
		return jcsbcslx;
	}

	
}