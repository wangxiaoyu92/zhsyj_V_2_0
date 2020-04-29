package com.askj.emergency.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  EMTEAMPERSON的中文含义是: 应急队伍+应急成员关系表; InnoDB free: 2731008 kB
 * @Creation     2016/05/26 15:58:07
 * @Written      Create Tool By zjf 
 **/
@Table(value = "EMTEAMPERSON")
public class Emteamperson {
	/**
	 * @Description etpid的中文含义是： 小组成员关系ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_etpid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_etpid.nextval from dual"))
	private String etpid;

	/**
	 * @Description groupid的中文含义是： 应急小组ID
	 */
	@Column
	private String groupid;

	/**
	 * @Description userid的中文含义是： 用户id
	 */
	@Column
	private String userid;

	/**
	 * @Description etptype的中文含义是： 小组成员类型
	 */
	@Column
	private String etptype;

	/**
	 * @Description etpremark的中文含义是： 备注
	 */
	@Column
	private String etpremark;

	/**
	 * @Description state的中文含义是： 状态 [0:添加 1:删除]
	 */
	@Column
	private String state;

	/**
	 * @Description opepateperson的中文含义是： 经办人
	 */
	@Column
	private String opepateperson;

	/**
	 * @Description opepatedate的中文含义是： 经办时间
	 */
	@Column
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

	
}