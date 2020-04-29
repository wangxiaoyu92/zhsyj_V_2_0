package com.askj.emergency.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  EMTEAMPERSON的中文含义是: 应急队伍+应急成员关系表; InnoDB free: 2731008 kBDTO
 * @Creation     2016/05/26 15:57:07
 * @Written      Create Tool By zjf 
 **/
public class EmteampersonDTO {
	
	/**
	 * @Description username的中文含义是 用户名 对应用户表中username字段
	 */
	private String username;
	/**
	 * @Description userkind的中文含义是 用户名 对应用户表中userkind字段
	 */
	private String userkind;
	/**
	 * @Description description的中文含义是 用户描述 对应用户表中description字段
	 */
	private String description;
	/**
	 * @Description mobile的中文含义是 手机号（注册时绑定），所有用户不可为空 对应用户表中description字段
	 */
	private String mobile;
	/**
	 * @Description orgname的中文含义是 机构名，所有用户不可为空 对应机构表中orgname字段
	 */
	private String orgname;
	/**
	 * @Description etpid的中文含义是： 小组成员关系ID
	 */
	private String etpid;

	/**
	 * @Description groupid的中文含义是： 应急小组ID
	 */
	private String groupid;

	/**
	 * @Description userid的中文含义是： 用户id
	 */
	private String userid;

	/**
	 * @Description etptype的中文含义是： 小组成员类型
	 */
	private String etptype;

	/**
	 * @Description etpremark的中文含义是： 备注
	 */
	private String etpremark;

	/**
	 * @Description state的中文含义是： 状态 [0:存在 1:删除 2:解散]
	 */
	private String state;

	/**
	 * @Description opepateperson的中文含义是： 经办人
	 */
	private String opepateperson;

	/**
	 * @Description opepatedate的中文含义是： 经办时间
	 */
	private String opepatedate;

	
		/**
	 * @Description etpid的中文含义是： 小组成员关系ID
	 */
	public void setEtpid(String etpid){ 
		this.etpid = etpid;
	}
	/**
	 * @Description etpid的中文含义是： 小组成员关系ID
	 */
	public String getEtpid(){
		return etpid;
	}
	/**
	 * @Description groupid的中文含义是： 应急小组ID
	 */
	public void setGroupid(String groupid){ 
		this.groupid = groupid;
	}
	/**
	 * @Description groupid的中文含义是： 应急小组ID
	 */
	public String getGroupid(){
		return groupid;
	}
	/**
	 * @Description userid的中文含义是： 用户id
	 */
	public void setUserid(String userid){ 
		this.userid = userid;
	}
	/**
	 * @Description userid的中文含义是： 用户id
	 */
	public String getUserid(){
		return userid;
	}
	/**
	 * @Description etptype的中文含义是： 小组成员类型
	 */
	public void setEtptype(String etptype){ 
		this.etptype = etptype;
	}
	/**
	 * @Description etptype的中文含义是： 小组成员类型
	 */
	public String getEtptype(){
		return etptype;
	}
	/**
	 * @Description etpremark的中文含义是： 备注
	 */
	public void setEtpremark(String etpremark){ 
		this.etpremark = etpremark;
	}
	/**
	 * @Description etpremark的中文含义是： 备注
	 */
	public String getEtpremark(){
		return etpremark;
	}
	/**
	 * @Description state的中文含义是： 状态 [0:添加 1:删除]
	 */
	public void setState(String state){ 
		this.state = state;
	}
	/**
	 * @Description state的中文含义是： 状态 [0:添加 1:删除]
	 */
	public String getState(){
		return state;
	}
	/**
	 * @Description opepateperson的中文含义是： 经办人
	 */
	public void setOpepateperson(String opepateperson){ 
		this.opepateperson = opepateperson;
	}
	/**
	 * @Description opepateperson的中文含义是： 经办人
	 */
	public String getOpepateperson(){
		return opepateperson;
	}
	/**
	 * @Description opepatedate的中文含义是： 经办时间
	 */
	public void setOpepatedate(String opepatedate){ 
		this.opepatedate = opepatedate;
	}
	/**
	 * @Description opepatedate的中文含义是： 经办时间
	 */
	public String getOpepatedate(){
		return opepatedate;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getOrgname() {
		return orgname;
	}
	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}
	public String getUserkind() {
		return userkind;
	}
	public void setUserkind(String userkind) {
		this.userkind = userkind;
	}

	
}