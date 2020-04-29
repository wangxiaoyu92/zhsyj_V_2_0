package com.zzhdsoft.siweb.entity.sysmanager;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;
/**
 * @Description  SYSCAPTCHA 的中文含义是 验证码记录表
 * @Creation     2014/01/06 15:32:58
 * @Written      Create Tool By ZhengZhou HuaDong Software 
 **/
@Table(value = "SYSCAPTCHA")
public class Syscaptcha {
	/**
	 * @Description syscaptchaid的中文含义是： ID
	 */
	@Column
	@Name
	// @Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_syscaptchaid')"))
	// @Prev(@SQL(db=DB.ORACLE,value="select sq_syscaptchaid.nextval from dual"))
	private String syscaptchaid;

	/**
	 * @Description content的中文含义是： 验证码内容
	 */
	@Column
	private String content;

	/**
	 * @Description sendtime的中文含义是： 发送时间
	 */
	@Column
	@Prev(@SQL(db=DB.ORACLE,value="select sysdate from dual"))
	private Timestamp sendtime;

	/**
	 * @Description mobile的中文含义是： 手机号
	 */
	@Column
	private String mobile;

	/**
	 * @Description userid的中文含义是： 操作员
	 */
	@Column
	private String userid;

	/**
	 * @Description captype的中文含义是： 0 登录 1 激活 2业务办理
	 */
	@Column
	private String captype;

	
		/**
	 * @Description syscaptchaid的中文含义是： ID
	 */
	public void setSyscaptchaid(String syscaptchaid){ 
		this.syscaptchaid = syscaptchaid;
	}
	/**
	 * @Description syscaptchaid的中文含义是： ID
	 */
	public String getSyscaptchaid(){
		return syscaptchaid;
	}
	/**
	 * @Description content的中文含义是： 验证码内容
	 */
	public void setContent(String content){ 
		this.content = content;
	}
	/**
	 * @Description content的中文含义是： 验证码内容
	 */
	public String getContent(){
		return content;
	}
	/**
	 * @Description sendtime的中文含义是： 发送时间
	 */
	public void setSendtime(Timestamp sendtime){ 
		this.sendtime = sendtime;
	}
	/**
	 * @Description sendtime的中文含义是： 发送时间
	 */
	public Timestamp getSendtime(){
		return sendtime;
	}
	/**
	 * @Description mobile的中文含义是： 手机号
	 */
	public void setMobile(String mobile){ 
		this.mobile = mobile;
	}
	/**
	 * @Description mobile的中文含义是： 手机号
	 */
	public String getMobile(){
		return mobile;
	}
	/**
	 * @Description userid的中文含义是： 操作员
	 */
	public void setUserid(String userid){ 
		this.userid = userid;
	}
	/**
	 * @Description userid的中文含义是： 操作员
	 */
	public String getUserid(){
		return userid;
	}
	/**
	 * @Description captype的中文含义是： 0 登录 1 激活 2业务办理
	 */
	public void setCaptype(String captype){ 
		this.captype = captype;
	}
	/**
	 * @Description captype的中文含义是： 0 登录 1 激活 2业务办理
	 */
	public String getCaptype(){
		return captype;
	}

	
}