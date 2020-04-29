package com.askj.ncjtjc.entity;

import org.nutz.dao.entity.annotation.*;
import java.io.InputStream;

/**
 * @Description CSZP的中文含义是: 厨师照片表
 * @Creation 2015/12/30 11:17:32
 * @Written Create Tool By zjf
 **/
@Table(value = "CSZP")
public class Cszp {

	/**
	 * @Description lszpid的中文含义是： 厨师照片ID
	 */
	@Column
	@Name
	// @Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_cszpid')"))
	// @Prev(@SQL(db=DB.ORACLE,value="select sq_cszpid.nextval from dual"))
	private String cszpid;
	/**
	 * @Description csid的中文含义是： 厨师ID
	 */
	@Column
	private String csid;
	/**
	 * @Description cszp的中文含义是： 厨师照片
	 */
	@Column
	private InputStream cszp;

	/**
	 * @Description cszpid的中文含义是： 厨师照片ID
	 */
	public void setCszpid(String cszpid) {
		this.cszpid = cszpid;
	}

	/**
	 * @Description cszpid的中文含义是： 厨师照片ID
	 */
	public String getCszpid() {
		return cszpid;
	}

	/**
	 * @Description csid的中文含义是： 厨师ID
	 */
	public void setCsid(String csid) {
		this.csid = csid;
	}

	/**
	 * @Description csid的中文含义是： 厨师ID
	 */
	public String getCsid() {
		return csid;
	}

	/**
	 * @Description cszp的中文含义是： 厨师照片
	 */
	public void setCszp(InputStream cszp) {
		this.cszp = cszp;
	}

	/**
	 * @Description cszp的中文含义是： 厨师照片
	 */
	public InputStream getCszp() {
		return cszp;
	}

}