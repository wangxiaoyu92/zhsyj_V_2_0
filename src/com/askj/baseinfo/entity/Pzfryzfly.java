package com.askj.baseinfo.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  PZFRYZFLY的中文含义是: 执法人员执法领域，考虑到一个执法人员可能多个执法领域; InnoDB free: 65536 kB
 * @Creation     2016/03/11 14:36:21
 * @Written      Create Tool By zjf 
 **/
@Table(value = "PZFRYZFLY")
public class Pzfryzfly {
	/**
	 * @Description zfrylyid的中文含义是： 
	 */
	@Column
	@Name
	private String zfrylyid;

	/**
	 * @Description zfrylybm的中文含义是： 执法人员领域编码,对应代码表zfrylybm
	 */
	@Column
	private String zfrylybm;
	/**
	 * @Description zfryid的中文含义是： 执法人员id
	 */
	@Column
	private String zfryid;

	
		/**
	 * @Description zfrylyid的中文含义是： 
	 */
	public void setZfrylyid(String zfrylyid){ 
		this.zfrylyid = zfrylyid;
	}
	/**
	 * @Description zfrylyid的中文含义是： 
	 */
	public String getZfrylyid(){
		return zfrylyid;
	}
	/**
	 * @Description zfrylybm的中文含义是： 执法人员领域编码,对应代码表zfrylybm
	 */
	public void setZfrylybm(String zfrylybm){ 
		this.zfrylybm = zfrylybm;
	}
	/**
	 * @Description zfrylybm的中文含义是： 执法人员领域编码,对应代码表zfrylybm
	 */
	public String getZfrylybm(){
		return zfrylybm;
	}
	public String getZfryid() {
		return zfryid;
	}
	public void setZfryid(String zfryid) {
		this.zfryid = zfryid;
	}

	
}