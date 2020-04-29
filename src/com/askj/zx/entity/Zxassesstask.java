package com.askj.zx.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Table;

/**
 * @Description  ZXASSESSTASK的中文含义是: 征信评估任务单
 * @Creation     2016/01/20 16:49:37
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZXASSESSTASK")
public class Zxassesstask {
	/**
	 * @Description attaskid的中文含义是： 评估任务ID
	 */
	@Column
	private Integer attaskid;

	/**
	 * @Description atlaunchtype的中文含义是： 任务发起类型。 0：企业申请；1：任务指派
	 */
	@Column
	private String atlaunchtype;

	/**
	 * @Description attaskstatus的中文含义是： 任务状态 0:未评估；1：已评估
	 */
	@Column
	private String attaskstatus;

	/**
	 * @Description atdispatchuserid的中文含义是： 任务指派人ID  （若企业申请，则为受理人或审核人ID）
	 */
	@Column
	private Integer atdispatchuserid;

	/**
	 * @Description assessapplayid的中文含义是： 企业申请ID (若指派则为空)
	 */
	@Column
	private Integer assessapplayid;

	/**
	 * @Description businesscode的中文含义是： 采用的评估参数编码 (zxbusinesscode业务节点)
	 */
	@Column
	private String businesscode;

	
		/**
	 * @Description attaskid的中文含义是： 评估任务ID
	 */
	public void setAttaskid(Integer attaskid){ 
		this.attaskid = attaskid;
	}
	/**
	 * @Description attaskid的中文含义是： 评估任务ID
	 */
	public Integer getAttaskid(){
		return attaskid;
	}
	/**
	 * @Description atlaunchtype的中文含义是： 任务发起类型。 0：企业申请；1：任务指派
	 */
	public void setAtlaunchtype(String atlaunchtype){ 
		this.atlaunchtype = atlaunchtype;
	}
	/**
	 * @Description atlaunchtype的中文含义是： 任务发起类型。 0：企业申请；1：任务指派
	 */
	public String getAtlaunchtype(){
		return atlaunchtype;
	}
	/**
	 * @Description attaskstatus的中文含义是： 任务状态 0:未评估；1：已评估
	 */
	public void setAttaskstatus(String attaskstatus){ 
		this.attaskstatus = attaskstatus;
	}
	/**
	 * @Description attaskstatus的中文含义是： 任务状态 0:未评估；1：已评估
	 */
	public String getAttaskstatus(){
		return attaskstatus;
	}
	/**
	 * @Description atdispatchuserid的中文含义是： 任务指派人ID  （若企业申请，则为受理人或审核人ID）
	 */
	public void setAtdispatchuserid(Integer atdispatchuserid){ 
		this.atdispatchuserid = atdispatchuserid;
	}
	/**
	 * @Description atdispatchuserid的中文含义是： 任务指派人ID  （若企业申请，则为受理人或审核人ID）
	 */
	public Integer getAtdispatchuserid(){
		return atdispatchuserid;
	}
	/**
	 * @Description assessapplayid的中文含义是： 企业申请ID (若指派则为空)
	 */
	public void setAssessapplayid(Integer assessapplayid){ 
		this.assessapplayid = assessapplayid;
	}
	/**
	 * @Description assessapplayid的中文含义是： 企业申请ID (若指派则为空)
	 */
	public Integer getAssessapplayid(){
		return assessapplayid;
	}
	/**
	 * @Description businesscode的中文含义是： 采用的评估参数编码 (zxbusinesscode业务节点)
	 */
	public void setBusinesscode(String businesscode){ 
		this.businesscode = businesscode;
	}
	/**
	 * @Description businesscode的中文含义是： 采用的评估参数编码 (zxbusinesscode业务节点)
	 */
	public String getBusinesscode(){
		return businesscode;
	}

	
}