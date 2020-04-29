package com.zzhdsoft.siweb.entity.sysmanager;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description SYSROLE 的中文含义是： 系统角色表
 * @Creation 2013/10/21 22:42:25
 * @Written Create Tool By ZhengZhou HuaDong Software
 **/
@Table(value = "SYSROLE")
public class Sysrole {
	/**
	 * @Description roleid的中文含义是： 角色ID
	 */
	@Column
	@Name
	// @Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_roleid')"))
	// @Prev(@SQL(db=DB.ORACLE,value="select sq_roleid.nextval from dual"))
	private String roleid;

	/**
	 * @Description roledesc的中文含义是： 角色描述
	 */
	@Column
	private String roledesc;

	/**
	 * @Description rolename的中文含义是： 角色名称
	 */
	@Column
	private String rolename;

	/**
	 * @Description sysroleflag的中文含义是： 系统角色标识 1:系统角色; 0:非系统角色
	 */
	@Column
	private String sysroleflag;

	/**
	 * @Description orgid的中文含义是： 所属机构id,即角色的创建者
	 */
	@Column
	private String orgid;

	/**
	 * @Description orgname的中文含义是： 所属机构名称
	 */
	@Column
	@Readonly
	private String orgname;

	/**
	 * @Description roleid的中文含义是： 角色ID
	 */
	public void setRoleid(String roleid) {
		this.roleid = roleid;
	}

	/**
	 * @Description roleid的中文含义是： 角色ID
	 */
	public String getRoleid() {
		return roleid;
	}

	/**
	 * @Description roledesc的中文含义是： 角色描述
	 */
	public void setRoledesc(String roledesc) {
		this.roledesc = roledesc;
	}

	/**
	 * @Description roledesc的中文含义是： 角色描述
	 */
	public String getRoledesc() {
		return roledesc;
	}

	/**
	 * @Description rolename的中文含义是： 角色名称
	 */
	public void setRolename(String rolename) {
		this.rolename = rolename;
	}

	/**
	 * @Description rolename的中文含义是： 角色名称
	 */
	public String getRolename() {
		return rolename;
	}

	/**
	 * @Description sysroleflag的中文含义是： 系统角色标识 1:系统角色; 0:非系统角色
	 */
	public void setSysroleflag(String sysroleflag) {
		this.sysroleflag = sysroleflag;
	}

	/**
	 * @Description sysroleflag的中文含义是： 系统角色标识 1:系统角色; 0:非系统角色
	 */
	public String getSysroleflag() {
		return sysroleflag;
	}

	/**
	 * @Description orgid的中文含义是： 所属机构id,即角色的创建者
	 */
	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}

	/**
	 * @Description orgid的中文含义是： 所属机构id,即角色的创建者
	 */
	public String getOrgid() {
		return orgid;
	}

	/**
	 * @Description orgname的中文含义是： 所属机构名称
	 */
	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}

	/**
	 * @Description orgname的中文含义是： 所属机构名称
	 */
	public String getOrgname() {
		return orgname;
	}
}