package com.zzhdsoft.siweb.entity.sysmanager;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;
/**
 * @Description  SYSROLEFUNCTION 的中文含义是 角色权限对照表
 * @Creation     2013/11/07 15:08:22
 * @Written      Create Tool By ZhengZhou HuaDong Software 
 **/
@Table(value = "SYSROLEFUNCTION")
public class Sysrolefunction {
	/**
	 * @Description rolefunctionid的中文含义是： 角色和权限的关联代码
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_rolefunctionid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_rolefunctionid.nextval from dual"))
	private String rolefunctionid;

	/**
	 * @Description roleid的中文含义是： 角色代码
	 */
	@Column
	private String roleid;

	/**
	 * @Description functionid的中文含义是： 功能代码
	 */
	@Column
	private String functionid;

	/**
	 * @Description checktype的中文含义是： checkbox选中类型
	 */
	@Column
	private String checktype;

	
		/**
	 * @Description rolefunctionid的中文含义是： 角色和权限的关联代码
	 */
	public void setRolefunctionid(String rolefunctionid){ 
		this.rolefunctionid = rolefunctionid;
	}
	/**
	 * @Description rolefunctionid的中文含义是： 角色和权限的关联代码
	 */
	public String getRolefunctionid(){
		return rolefunctionid;
	}
	/**
	 * @Description roleid的中文含义是： 角色代码
	 */
	public void setRoleid(String roleid){ 
		this.roleid = roleid;
	}
	/**
	 * @Description roleid的中文含义是： 角色代码
	 */
	public String getRoleid(){
		return roleid;
	}
	/**
	 * @Description functionid的中文含义是： 功能代码
	 */
	public void setFunctionid(String functionid){ 
		this.functionid = functionid;
	}
	/**
	 * @Description functionid的中文含义是： 功能代码
	 */
	public String getFunctionid(){
		return functionid;
	}
	/**
	 * @Description checktype的中文含义是： checkbox选中类型
	 */
	public void setChecktype(String checktype){ 
		this.checktype = checktype;
	}
	/**
	 * @Description checktype的中文含义是： checkbox选中类型
	 */
	public String getChecktype(){
		return checktype;
	}

	
}