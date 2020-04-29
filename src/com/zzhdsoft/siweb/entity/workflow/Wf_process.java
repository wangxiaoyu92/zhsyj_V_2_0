package com.zzhdsoft.siweb.entity.workflow;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  WF_PROCESS的中文含义是: 流程表
 * @Creation     2016/03/10 16:35:53
 * @Written      Create Tool By zjf 
 **/
@Table(value = "WF_PROCESS")
public class Wf_process {
	/**
	 * @Description psid的中文含义是： 工作流流程ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_psid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_psid.nextval from dual"))
	private String psid;

	/**
	 * @Description psbh的中文含义是： 工作流流程编号
	 */
	@Column
	private String psbh;

	/**
	 * @Description psmc的中文含义是： 工作流流程名称
	 */
	@Column
	private String psmc;

	/**
	 * @Description psxml的中文含义是： 工作流流程图
	 */
	@Column
	private String psxml;

	/**
	 * @Description pszt的中文含义是： 工作流状态
	 */
	@Column
	private String pszt;

	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	@Column
	private String aae011;

	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	@Column
	private Timestamp aae036;

	
		/**
	 * @Description psid的中文含义是： 工作流流程ID
	 */
	public void setPsid(String psid){ 
		this.psid = psid;
	}
	/**
	 * @Description psid的中文含义是： 工作流流程ID
	 */
	public String getPsid(){
		return psid;
	}
	/**
	 * @Description psbh的中文含义是： 工作流流程编号
	 */
	public void setPsbh(String psbh){ 
		this.psbh = psbh;
	}
	/**
	 * @Description psbh的中文含义是： 工作流流程编号
	 */
	public String getPsbh(){
		return psbh;
	}
	/**
	 * @Description psmc的中文含义是： 工作流流程名称
	 */
	public void setPsmc(String psmc){ 
		this.psmc = psmc;
	}
	/**
	 * @Description psmc的中文含义是： 工作流流程名称
	 */
	public String getPsmc(){
		return psmc;
	}
	/**
	 * @Description psxml的中文含义是： 工作流流程图
	 */
	public void setPsxml(String psxml){ 
		this.psxml = psxml;
	}
	/**
	 * @Description psxml的中文含义是： 工作流流程图
	 */
	public String getPsxml(){
		return psxml;
	}
	/**
	 * @Description pszt的中文含义是： 工作流状态
	 */
	public void setPszt(String pszt){ 
		this.pszt = pszt;
	}
	/**
	 * @Description pszt的中文含义是： 工作流状态
	 */
	public String getPszt(){
		return pszt;
	}
	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	public void setAae011(String aae011){ 
		this.aae011 = aae011;
	}
	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	public String getAae011(){
		return aae011;
	}
	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	public void setAae036(Timestamp aae036){ 
		this.aae036 = aae036;
	}
	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	public Timestamp getAae036(){
		return aae036;
	}

	
}