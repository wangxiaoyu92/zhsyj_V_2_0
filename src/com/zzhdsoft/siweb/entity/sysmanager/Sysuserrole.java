package com.zzhdsoft.siweb.entity.sysmanager;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;
/**
 * @Description  SYSUSERROLE 的中文含义是 用户角色对照表
 * @Creation     2013/10/21 22:41:50
 * @Written      Create Tool By ZhengZhou HuaDong Software 
 **/
@Table(value = "SYSUSERROLE")
public class Sysuserrole {
	/**
	 * @Description userroleid的中文含义是： 用户角色关联代码
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_userroleid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_userroleid.nextval from dual"))
	private String userroleid;

	/**
	 * @Description userid的中文含义是： 用户代码
	 */
	@Column
	private String userid;

	/**
	 * @Description roleid的中文含义是： 角色代码
	 */
	@Column
	private String roleid;

	
		/**
	 * @Description userroleid的中文含义是： 用户角色关联代码
	 */
	public void setUserroleid(String userroleid){ 
		this.userroleid = userroleid;
	}
	/**
	 * @Description userroleid的中文含义是： 用户角色关联代码
	 */
	public String getUserroleid(){
		return userroleid;
	}
	/**
	 * @Description userid的中文含义是： 用户代码
	 */
	public void setUserid(String userid){ 
		this.userid = userid;
	}
	/**
	 * @Description userid的中文含义是： 用户代码
	 */
	public String getUserid(){
		return userid;
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

	
}