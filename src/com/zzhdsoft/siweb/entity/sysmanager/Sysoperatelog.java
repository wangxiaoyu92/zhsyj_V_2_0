package com.zzhdsoft.siweb.entity.sysmanager;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  SYSOPERATELOG 的中文含义是： 操作日志
 * @Creation     2015/05/30 16:04:12
 * @Written      Create Tool By zzhdsoft 
 **/
@Table(value = "SYSOPERATELOG")
public class Sysoperatelog {
	/**
	 * @Description operatelogid的中文含义是 ：操作日志ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_operatelogid.nextval from dual"))
	private String operatelogid;

	/**
	 * @Description userid的中文含义是 ：用户ID
	 */
	@Column
	private String userid;

	/**
	 * @Description logonid的中文含义是 ：登录ID
	 */
	@Column
	private String logonid;

	/**
	 * @Description userip的中文含义是 ：用户IP
	 */
	@Column
	private String userip;

	/**
	 * @Description operate的中文含义是 ：操作
	 */
	@Column
	private String operate;

	/**
	 * @Description url的中文含义是 ：请求url
	 */
	@Column
	private String url;

	/**
	 * @Description starttime的中文含义是 ：开始时间
	 */
	@Column
	private Timestamp starttime;

	/**
	 * @Description endtime的中文含义是 ：结束时间
	 */
	@Column
	private Timestamp endtime;

	/**
	 * @Description module的中文含义是 ：操作模块
	 */
	@Column
	private String module;

	/**
	 * @Description description的中文含义是 ：描述
	 */
	@Column
	private String description;

	
	/**
	 * @Description username的中文含义是 用户名（非映射字段）
	 */
	private String username;
	/**
	 * @Description userkind的中文含义是 用户类别（非映射字段）
	 */
	private String userkind;
	
	/**
	 * @Description operatelogid的中文含义是： 操作日志ID
	 */
	public void setOperatelogid(String operatelogid){ 
		this.operatelogid = operatelogid;
	}
	/**
	 * @Description operatelogid的中文含义是： 操作日志ID
	 */
	public String getOperatelogid(){
		return operatelogid;
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
	 * @Description logonid的中文含义是： 登录ID
	 */
	public void setLogonid(String logonid){ 
		this.logonid = logonid;
	}
	/**
	 * @Description logonid的中文含义是： 登录ID
	 */
	public String getLogonid(){
		return logonid;
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
	 * @Description operate的中文含义是： 操作
	 */
	public void setOperate(String operate){ 
		this.operate = operate;
	}
	/**
	 * @Description operate的中文含义是： 操作
	 */
	public String getOperate(){
		return operate;
	}
	/**
	 * @Description url的中文含义是： 请求url
	 */
	public void setUrl(String url){ 
		this.url = url;
	}
	/**
	 * @Description url的中文含义是： 请求url
	 */
	public String getUrl(){
		return url;
	}
	/**
	 * @Description starttime的中文含义是： 开始时间
	 */
	public void setStarttime(Timestamp starttime){ 
		this.starttime = starttime;
	}
	/**
	 * @Description starttime的中文含义是： 开始时间
	 */
	public Timestamp getStarttime(){
		return starttime;
	}
	/**
	 * @Description endtime的中文含义是： 结束时间
	 */
	public void setEndtime(Timestamp endtime){ 
		this.endtime = endtime;
	}
	/**
	 * @Description endtime的中文含义是： 结束时间
	 */
	public Timestamp getEndtime(){
		return endtime;
	}
	/**
	 * @Description module的中文含义是： 操作模块
	 */
	public void setModule(String module){ 
		this.module = module;
	}
	/**
	 * @Description module的中文含义是： 操作模块
	 */
	public String getModule(){
		return module;
	}
	/**
	 * @Description description的中文含义是： 描述
	 */
	public void setDescription(String description){ 
		this.description = description;
	}
	/**
	 * @Description description的中文含义是： 描述
	 */
	public String getDescription(){
		return description;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUserkind() {
		return userkind;
	}
	public void setUserkind(String userkind) {
		this.userkind = userkind;
	}

	
}