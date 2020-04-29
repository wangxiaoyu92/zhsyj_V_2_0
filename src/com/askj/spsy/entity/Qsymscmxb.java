package com.askj.spsy.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  QSYMSCMXB的中文含义是: 溯源码生产明细表; InnoDB free: 2715648 kB
 * @Creation     2016/07/03 16:41:13
 * @Written      Create Tool By zjf 
 **/
@Table(value = "QSYMSCMXB")
public class Qsymscmxb {
	/**
	 * @Description qsymscmxbid的中文含义是： 
	 */
	@Column
	@Name
	private String qsymscmxbid;

	/**
	 * @Description qsymscbid的中文含义是： 溯源码生成表主键
	 */
	@Column
	private String qsymscbid;

	/**
	 * @Description sym的中文含义是： 溯源码
	 */
	@Column
	private String sym;
	
	/**
	 * @Description qrcodepath的中文含义是：二维码图片存放路径
	 */
	@Column
	private String qrcodepath;		

	
		/**
	 * @Description qsymscmxbid的中文含义是： 
	 */
	public void setQsymscmxbid(String qsymscmxbid){ 
		this.qsymscmxbid = qsymscmxbid;
	}
	/**
	 * @Description qsymscmxbid的中文含义是： 
	 */
	public String getQsymscmxbid(){
		return qsymscmxbid;
	}
	/**
	 * @Description qsymscbid的中文含义是： 溯源码生成表主键
	 */
	public void setQsymscbid(String qsymscbid){ 
		this.qsymscbid = qsymscbid;
	}
	/**
	 * @Description qsymscbid的中文含义是： 溯源码生成表主键
	 */
	public String getQsymscbid(){
		return qsymscbid;
	}
	/**
	 * @Description sym的中文含义是： 溯源码
	 */
	public void setSym(String sym){ 
		this.sym = sym;
	}
	/**
	 * @Description sym的中文含义是： 溯源码
	 */
	public String getSym(){
		return sym;
	}
	public String getQrcodepath() {
		return qrcodepath;
	}
	public void setQrcodepath(String qrcodepath) {
		this.qrcodepath = qrcodepath;
	}

	
	
}