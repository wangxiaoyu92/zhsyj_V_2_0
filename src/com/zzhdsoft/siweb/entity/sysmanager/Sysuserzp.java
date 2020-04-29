package com.zzhdsoft.siweb.entity.sysmanager;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Blob;
import java.sql.Date;
import java.sql.Timestamp;
import java.io.InputStream;
import java.math.BigDecimal;

/**
 * @Description SYSUSERZP的中文含义是: 系统用户照片表
 * @Creation 2015/12/30 11:17:32
 * @Written Create Tool By zjf
 **/
@Table(value = "SYSUSERZP")
public class Sysuserzp {

	/**
	 * @Description lszpid的中文含义是： 系统用户照片ID
	 */
	@Column
	@Name
	// @Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_sysuserzpid')"))
	// @Prev(@SQL(db=DB.ORACLE,value="select sq_sysuserzpid.nextval from dual"))
	private String sysuserzpid;
	/**
	 * @Description sysuserid的中文含义是： 系统用户ID
	 */
	@Column
	private String userid;
	/**
	 * @Description sysuserzp的中文含义是： 系统用户照片
	 */
	@Column
	private InputStream sysuserzp;

	/**
	 * @Description sysuserzpid的中文含义是： 系统用户照片ID
	 */
	public void setSysuserzpid(String sysuserzpid) {
		this.sysuserzpid = sysuserzpid;
	}

	/**
	 * @Description sysuserzpid的中文含义是： 系统用户照片ID
	 */
	public String getSysuserzpid() {
		return sysuserzpid;
	}

	/**
	 * @Description sysuserid的中文含义是： 系统用户ID
	 */
	public void setUserid(String userid) {
		this.userid = userid;
	}

	/**
	 * @Description sysuserid的中文含义是： 系统用户ID
	 */
	public String getUserid() {
		return userid;
	}

	/**
	 * @Description sysuserzp的中文含义是： 系统用户照片
	 */
	public void setSysuserzp(InputStream sysuserzp) {
		this.sysuserzp = sysuserzp;
	}

	/**
	 * @Description sysuserzp的中文含义是： 系统用户照片
	 */
	public InputStream getSysuserzp() {
		return sysuserzp;
	}

}