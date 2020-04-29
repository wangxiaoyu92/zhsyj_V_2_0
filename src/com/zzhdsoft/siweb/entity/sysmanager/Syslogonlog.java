package com.zzhdsoft.siweb.entity.sysmanager;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  SYSLOGONLOG的中文含义是: 系统登录历史纪录; InnoDB free: 2731008 kB
 * @Creation     2016/05/27 10:28:57
 * @Written      Create Tool By zjf 
 **/
@Table(value = "SYSLOGONLOG")
public class Syslogonlog {
	/**
	 * @Description logonlogid的中文含义是： 登录日志ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_logonlogid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_logonlogid.nextval from dual"))
	private String logonlogid;

	/**
	 * @Description userid的中文含义是： 用户ID
	 */
	@Column
	private String userid;

	/**
	 * @Description userip的中文含义是： 用户IP
	 */
	@Column
	private String userip;

	/**
	 * @Description logontime的中文含义是： 上线时间
	 */
	@Column
	private Timestamp logontime;

	/**
	 * @Description logofftime的中文含义是： 下线时间
	 */
	@Column
	private Timestamp logofftime;

	/**
	 * @Description logonflag的中文含义是： 登录成功标志，1为平台登录，0为手机登录
	 */
	@Column
	private String logonflag;

	/**
	 * @Description logfailedreason的中文含义是： 登录失败原因
	 */
	@Column
	private String logfailedreason;

	/**
	 * @Description logonappvision的中文含义是： 登录APP版本号
	 */
	@Column
	private String logonappvision;
	
	/**
	 * @Description logonlogid的中文含义是： 登录日志ID
	 */
	public void setLogonlogid(String logonlogid){ 
		this.logonlogid = logonlogid;
	}
	/**
	 * @Description logonlogid的中文含义是： 登录日志ID
	 */
	public String getLogonlogid(){
		return logonlogid;
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
	 * @Description userip的中文含义是： 用户IP
	 */
	public void setUserip(String userip){ 
		this.userip = userip;
	}
	/**
	 * @Description userip的中文含义是： 用户IP
	 */
	public String getUserip(){
		return userip;
	}
	/**
	 * @Description logontime的中文含义是： 上线时间
	 */
	public void setLogontime(Timestamp logontime){ 
		this.logontime = logontime;
	}
	/**
	 * @Description logontime的中文含义是： 上线时间
	 */
	public Timestamp getLogontime(){
		return logontime;
	}
	/**
	 * @Description logofftime的中文含义是： 下线时间
	 */
	public void setLogofftime(Timestamp logofftime){ 
		this.logofftime = logofftime;
	}
	/**
	 * @Description logofftime的中文含义是： 下线时间
	 */
	public Timestamp getLogofftime(){
		return logofftime;
	}
	/**
	 * @Description logonflag的中文含义是： 登录成功标志，1为平台登录，0为手机登录
	 */
	public void setLogonflag(String logonflag){ 
		this.logonflag = logonflag;
	}
	/**
	 * @Description logonflag的中文含义是： 登录成功标志，1为平台登录，0为手机登录
	 */
	public String getLogonflag(){
		return logonflag;
	}
	/**
	 * @Description logfailedreason的中文含义是： 登录失败原因
	 */
	public void setLogfailedreason(String logfailedreason){ 
		this.logfailedreason = logfailedreason;
	}
	/**
	 * @Description logfailedreason的中文含义是： 登录失败原因
	 */
	public String getLogfailedreason(){
		return logfailedreason;
	}

	/**
	 * @Description logonappvision的中文含义是： 登录APP版本号
	 */
	public void setLogonappvision(String logonappvision){ 
		this.logonappvision = logonappvision;
	}
	/**
	 * @Description logonappvision的中文含义是： 登录APP版本号
	 */
	public String getLogonappvision(){
		return logonappvision;
	}
}