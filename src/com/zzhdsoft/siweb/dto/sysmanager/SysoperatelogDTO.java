package com.zzhdsoft.siweb.dto.sysmanager;

import java.sql.Timestamp;

public class SysoperatelogDTO {
/** 系统操作日志; InnoDB free: 10240 kB  */
	/** OPERATELOGID 的中文含义是：操作日志ID*/
	private String operatelogid;

	/** USERID 的中文含义是：用户ID*/
	private String userid;

	/** USERIP 的中文含义是：用户IP*/
	private String userip;

	/** OPERATE 的中文含义是：操作*/
	private String operate;

	/** URL 的中文含义是：请求url*/
	private String url;

	/** STARTTIME 的中文含义是：开始时间*/
	private Timestamp starttime;

	/** ENDTIME 的中文含义是：结束时间*/
	private Timestamp endtime;

	/** MODULE 的中文含义是：操作模块*/
	private String module;

	/** DESCRIPTION 的中文含义是：描述*/
	private String description;
	/* 操作人姓名*/
	private String username;

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public void setOperatelogid(String operatelogid){
		this.operatelogid=operatelogid;
	}

	public String getOperatelogid(){
		return operatelogid;
	}

	public void setUserid(String userid){
		this.userid=userid;
	}

	public String getUserid(){
		return userid;
	}

	public void setUserip(String userip){
		this.userip=userip;
	}

	public String getUserip(){
		return userip;
	}

	public void setOperate(String operate){
		this.operate=operate;
	}

	public String getOperate(){
		return operate;
	}

	public void setUrl(String url){
		this.url=url;
	}

	public String getUrl(){
		return url;
	}

	public void setStarttime(Timestamp starttime){
		this.starttime=starttime;
	}

	public Timestamp getStarttime(){
		return starttime;
	}

	public void setEndtime(Timestamp endtime){
		this.endtime=endtime;
	}

	public Timestamp getEndtime(){
		return endtime;
	}

	public void setModule(String module){
		this.module=module;
	}

	public String getModule(){
		return module;
	}

	public void setDescription(String description){
		this.description=description;
	}

	public String getDescription(){
		return description;
	}

}

