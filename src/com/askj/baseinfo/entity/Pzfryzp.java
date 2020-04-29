package com.askj.baseinfo.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;

import java.sql.Date;
import java.sql.Timestamp;
import java.io.InputStream;
import java.math.BigDecimal;

/**
 * @Description  PZFRYZP的中文含义是: 执法人员照片; InnoDB free: 75776 kB
 * @Creation     2016/03/15 16:39:51
 * @Written      Create Tool By zjf 
 **/
@Table(value = "PZFRYZP")
public class Pzfryzp {
	/**
	 * @Description zfryzpid的中文含义是： 
	 */
	@Column
	@Name
	private String zfryzpid;

	/**
	 * @Description zfryid的中文含义是： 执法人员id对应pzfry表
	 */
	@Column
	private Integer zfryid;

	/**
	 * @Description zfryzp的中文含义是： 执法人员照片
	 */
	@Column
	private InputStream zfryzp;

	
		/**
	 * @Description zfryzpid的中文含义是： 
	 */
	public void setZfryzpid(String zfryzpid){ 
		this.zfryzpid = zfryzpid;
	}
	/**
	 * @Description zfryzpid的中文含义是： 
	 */
	public String getZfryzpid(){
		return zfryzpid;
	}
	/**
	 * @Description zfryid的中文含义是： 执法人员id对应pzfry表
	 */
	public void setZfryid(Integer zfryid){ 
		this.zfryid = zfryid;
	}
	/**
	 * @Description zfryid的中文含义是： 执法人员id对应pzfry表
	 */
	public Integer getZfryid(){
		return zfryid;
	}
	/**
	 * @Description zfryzp的中文含义是： 执法人员照片
	 */
	public void setZfryzp(InputStream fis){ 
		this.zfryzp = zfryzp;
	}
	/**
	 * @Description zfryzp的中文含义是： 执法人员照片
	 */
	public InputStream getZfryzp(){
		return zfryzp;
	}

	
}