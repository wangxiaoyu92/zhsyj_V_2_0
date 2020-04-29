package com.askj.zx.entity;

import java.sql.Date;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Table;

/**
 * @Description  ZXASSESSAPPLY的中文含义是: 征信评估申请表
 * @Creation     2016/01/20 16:48:27
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZXASSESSAPPLY")
public class Zxassessapply {
	/**
	 * @Description aaid的中文含义是： 申请表ID
	 */
	@Column
	private Integer aaid;

	/**
	 * @Description aaapplyuserid的中文含义是： 发起人ID
	 */
	@Column
	private Integer aaapplyuserid;

	/**
	 * @Description comid的中文含义是： 企业ID
	 */
	@Column
	private Integer comid;

	/**
	 * @Description aaapplydate的中文含义是： 申请时间
	 */
	@Column
	private Date aaapplydate;

	/**
	 * @Description aastatus的中文含义是： 状态 0：未提交；1：未受理；2：已受理
	 */
	@Column
	private String aastatus;

	/**
	 * @Description aaacceptuserid的中文含义是： 受理人ID
	 */
	@Column
	private Integer aaacceptuserid;

	/**
	 * @Description aaacceptdate的中文含义是： 受理时间
	 */
	@Column
	private Date aaacceptdate;

	
		/**
	 * @Description aaid的中文含义是： 申请表ID
	 */
	public void setAaid(Integer aaid){ 
		this.aaid = aaid;
	}
	/**
	 * @Description aaid的中文含义是： 申请表ID
	 */
	public Integer getAaid(){
		return aaid;
	}
	/**
	 * @Description aaapplyuserid的中文含义是： 发起人ID
	 */
	public void setAaapplyuserid(Integer aaapplyuserid){ 
		this.aaapplyuserid = aaapplyuserid;
	}
	/**
	 * @Description aaapplyuserid的中文含义是： 发起人ID
	 */
	public Integer getAaapplyuserid(){
		return aaapplyuserid;
	}
	/**
	 * @Description comid的中文含义是： 企业ID
	 */
	public void setComid(Integer comid){ 
		this.comid = comid;
	}
	/**
	 * @Description comid的中文含义是： 企业ID
	 */
	public Integer getComid(){
		return comid;
	}
	/**
	 * @Description aaapplydate的中文含义是： 申请时间
	 */
	public void setAaapplydate(Date aaapplydate){ 
		this.aaapplydate = aaapplydate;
	}
	/**
	 * @Description aaapplydate的中文含义是： 申请时间
	 */
	public Date getAaapplydate(){
		return aaapplydate;
	}
	/**
	 * @Description aastatus的中文含义是： 状态 0：未提交；1：未受理；2：已受理
	 */
	public void setAastatus(String aastatus){ 
		this.aastatus = aastatus;
	}
	/**
	 * @Description aastatus的中文含义是： 状态 0：未提交；1：未受理；2：已受理
	 */
	public String getAastatus(){
		return aastatus;
	}
	/**
	 * @Description aaacceptuserid的中文含义是： 受理人ID
	 */
	public void setAaacceptuserid(Integer aaacceptuserid){ 
		this.aaacceptuserid = aaacceptuserid;
	}
	/**
	 * @Description aaacceptuserid的中文含义是： 受理人ID
	 */
	public Integer getAaacceptuserid(){
		return aaacceptuserid;
	}
	/**
	 * @Description aaacceptdate的中文含义是： 受理时间
	 */
	public void setAaacceptdate(Date aaacceptdate){ 
		this.aaacceptdate = aaacceptdate;
	}
	/**
	 * @Description aaacceptdate的中文含义是： 受理时间
	 */
	public Date getAaacceptdate(){
		return aaacceptdate;
	}

	
}