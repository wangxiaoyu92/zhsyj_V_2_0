package com.askj.ncjtjc.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  JCSBPSWP的中文含义是: 聚餐申报配送物品表; InnoDB free: 2720768 kB
 * @Creation     2016/05/24 09:58:43
 * @Written      Create Tool By zjf 
 **/
@Table(value = "JCSBPSWP")
public class Jcsbpswp {
	/**
	 * @Description jcsbpswpid的中文含义是： 聚餐申报配送物品id
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_jcsbpswpid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_jcsbpswpid.nextval from dual"))
	private String jcsbpswpid;

	/**
	 * @Description jcsbid的中文含义是： 聚餐申报id
	 */
	@Column
	private String jcsbid;

	/**
	 * @Description jcsbpswplx的中文含义是： 聚餐申报配送物品类型
	 */
	@Column
	private String jcsbpswplx;

	/**
	 * @Description jcsbpswpmc的中文含义是： 聚餐申报配送物品名称
	 */
	@Column
	private String jcsbpswpmc;

	/**
	 * @Description jcsbpswppp的中文含义是： 聚餐申报配送物品品牌
	 */
	@Column
	private String jcsbpswppp;

	/**
	 * @Description jcsbpswpsl的中文含义是： 聚餐申报配送物品数量
	 */
	@Column
	private String jcsbpswpsl;

	
		/**
	 * @Description jcsbpswpid的中文含义是： 聚餐申报配送物品id
	 */
	public void setJcsbpswpid(String jcsbpswpid){ 
		this.jcsbpswpid = jcsbpswpid;
	}
	/**
	 * @Description jcsbpswpid的中文含义是： 聚餐申报配送物品id
	 */
	public String getJcsbpswpid(){
		return jcsbpswpid;
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
	 * @Description jcsbpswplx的中文含义是： 聚餐申报配送物品类型
	 */
	public void setJcsbpswplx(String jcsbpswplx){ 
		this.jcsbpswplx = jcsbpswplx;
	}
	/**
	 * @Description jcsbpswplx的中文含义是： 聚餐申报配送物品类型
	 */
	public String getJcsbpswplx(){
		return jcsbpswplx;
	}
	/**
	 * @Description jcsbpswpmc的中文含义是： 聚餐申报配送物品名称
	 */
	public void setJcsbpswpmc(String jcsbpswpmc){ 
		this.jcsbpswpmc = jcsbpswpmc;
	}
	/**
	 * @Description jcsbpswpmc的中文含义是： 聚餐申报配送物品名称
	 */
	public String getJcsbpswpmc(){
		return jcsbpswpmc;
	}
	/**
	 * @Description jcsbpswppp的中文含义是： 聚餐申报配送物品品牌
	 */
	public void setJcsbpswppp(String jcsbpswppp){ 
		this.jcsbpswppp = jcsbpswppp;
	}
	/**
	 * @Description jcsbpswppp的中文含义是： 聚餐申报配送物品品牌
	 */
	public String getJcsbpswppp(){
		return jcsbpswppp;
	}
	/**
	 * @Description jcsbpswpsl的中文含义是： 聚餐申报配送物品数量
	 */
	public void setJcsbpswpsl(String jcsbpswpsl){ 
		this.jcsbpswpsl = jcsbpswpsl;
	}
	/**
	 * @Description jcsbpswpsl的中文含义是： 聚餐申报配送物品数量
	 */
	public String getJcsbpswpsl(){
		return jcsbpswpsl;
	}

	
}