package com.askj.ncjtjc.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.io.InputStream;

/**
 * @Description CSZP的中文含义是: 两员照片表
 * @Creation 2016/07/26 11:17:32
 * @Written Create Tool By sunyifeng
 **/
@Table(value = "LYZP")
public class Lyzp {

	/**
	 * @Description lyzpid的中文含义是： 两员照片ID
	 */
	@Column
	@Name
	// @Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_lyzpid')"))
	// @Prev(@SQL(db=DB.ORACLE,value="select sq_lyzpid.nextval from dual"))
	private String lyzpid;
	/**
	 * @Description lyid的中文含义是： 两员ID
	 */
	@Column
	private String lyid;
	/**
	 * @Description lyzp的中文含义是： 两员照片
	 */
	@Column
	private InputStream lyzp;

	/**
	 * @Description lyzpid的中文含义是： 两员照片ID
	 */
	public void setLyzpid(String lyzpid) {
		this.lyzpid = lyzpid;
	}

	/**
	 * @Description lyzpid的中文含义是： 两员照片ID
	 */
	public String getLyzpid() {
		return lyzpid;
	}

	/**
	 * @Description lyid的中文含义是： 两员ID
	 */
	public void setLyid(String lyid) {
		this.lyid = lyid;
	}

	/**
	 * @Description lyid的中文含义是： 两员ID
	 */
	public String getLyid() {
		return lyid;
	}

	/**
	 * @Description lyzp的中文含义是： 两员照片
	 */
	public void setLyzp(InputStream lyzp) {
		this.lyzp = lyzp;
	}

	/**
	 * @Description lyzp的中文含义是： 两员照片
	 */
	public InputStream getLyzp() {
		return lyzp;
	}

}