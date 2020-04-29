package com.zzhdsoft.siweb.entity.sysmanager;

import org.nutz.dao.entity.annotation.*;
import java.sql.Timestamp;

/**
 * @Description  SYSUSERLOG 的中文含义是 系统用户日志表
 * @Creation     2014/03/07 10:24:21
 * @Written      Create Tool By ZhengZhou HuaDong Software 
 **/
@Table(value = "SYSUSERLOG")
public class Sysuserlog {
	/**
	 * @Description sysuser_log_id的中文含义是： 主键
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_userlogid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_userlogid.nextval from dual"))
	private String userlogid;

	/**
	 * @Description userid的中文含义是： 用户ID
	 */
	@Column
	private String userid;

	/**
	 * @Description changetype的中文含义是： 变动类型：1、注册激活/2、封锁/3、解锁/4、修改密码/5、变更手机号/6、更新指纹
	 */
	@Column
	private String changetype;

	/**
	 * @Description descr的中文含义是： 变动描述/格式：原值  ->新值
	 */
	@Column
	private String descr;

	/**
	 * @Description changetime的中文含义是： 变动日期
	 */
	@Column
	//@Prev(@SQL(db=DB.MYSQL,value="select now()"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sysdate from dual"))
	private Timestamp changetime;

	/**
	 * @Description aae011的中文含义是： 操作员
	 */
	@Column
	private String aae011;

	/**
	 * @Description aae011Name的中文含义是： 操作员姓名
	 */
	@Column("aae011_name")
	private String aae011Name;

	
		/**
	 * @Description userlogid的中文含义是： 主键
	 */
	public void setUserlogid(String userlogid){ 
		this.userlogid = userlogid;
	}
	/**
	 * @Description sysuser_log_id的中文含义是： 主键
	 */
	public String getUserlogid(){
		return userlogid;
	}
	/**
	 * @Description userid的中文含义是： 用户ID
	 */
	public void setUserid(String userid){ 
		this.userid = userid;
	}
	/**
	 * @Description userid的中文含义是： 用户ID
	 */
	public String getUserid(){
		return userid;
	}
	/**
	 * @Description changetype的中文含义是： 变动类型：1、注册激活/2、封锁/3、解锁/4、修改密码/5、变更手机号/6、更新指纹
	 */
	public void setChangetype(String changetype){ 
		this.changetype = changetype;
	}
	/**
	 * @Description changetype的中文含义是： 变动类型：1、注册激活/2、封锁/3、解锁/4、修改密码/5、变更手机号/6、更新指纹
	 */
	public String getChangetype(){
		return changetype;
	}
	/**
	 * @Description descr的中文含义是： 变动描述/格式：原值  ->新值
	 */
	public void setDescr(String descr){ 
		this.descr = descr;
	}
	/**
	 * @Description descr的中文含义是： 变动描述/格式：原值  ->新值
	 */
	public String getDescr(){
		return descr;
	}
	/**
	 * @Description changetime的中文含义是： 变动日期
	 */
	public void setChangetime(Timestamp changetime){ 
		this.changetime = changetime;
	}
	/**
	 * @Description changetime的中文含义是： 变动日期
	 */
	public Timestamp getChangetime(){
		return changetime;
	}
	/**
	 * @Description aae011的中文含义是： 操作员
	 */
	public void setAae011(String aae011){ 
		this.aae011 = aae011;
	}
	/**
	 * @Description aae011的中文含义是： 操作员
	 */
	public String getAae011(){
		return aae011;
	}
	/**
	 * @Description aae011Name的中文含义是： 操作员姓名
	 */
	public void setAae011Name(String aae011Name){
		this.aae011Name = aae011Name;
	}
	/**
	 * @Description aae011ame的中文含义是： 操作员姓名
	 */
	public String getAae011Name(){
		return aae011Name;
	}

	
}