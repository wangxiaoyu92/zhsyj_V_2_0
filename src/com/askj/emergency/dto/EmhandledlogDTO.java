package com.askj.emergency.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  EMHANDLEDLOG的中文含义是: 处理事件协作日志表; InnoDB free: 2731008 kBDTO
 * @Creation     2016/05/25 16:06:38
 * @Written      Create Tool By zjf 
 **/
public class EmhandledlogDTO {
	/**
	 * @Description logid的中文含义是： 处理日志ID
	 */
	private String logid;

	/**
	 * @Description etpid的中文含义是： 小组成员关系ID
	 */
	private String etpid;

	/**
	 * @Description eventid的中文含义是： 事件ID
	 */
	private String eventid;

	/**
	 * @Description loginfo的中文含义是： 处理信息
	 */
	private String loginfo;

	/**
	 * @Description logstate的中文含义是： 处理结果状态
	 */
	private String logstate;

	/**
	 * @Description remark的中文含义是： 备注
	 */
	private String remark;

	/**
	 * @Description sortid的中文含义是： 处理序号
	 */
	private String sortid;

	/**
	 * @Description opepateperson的中文含义是： 经办人
	 */
	private String opepateperson;

	/**
	 * @Description opepatedate的中文含义是： 经办时间
	 */
	private String opepatedate;

	
		/**
	 * @Description logid的中文含义是： 处理日志ID
	 */
	public void setLogid(String logid){ 
		this.logid = logid;
	}
	/**
	 * @Description logid的中文含义是： 处理日志ID
	 */
	public String getLogid(){
		return logid;
	}
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
	 * @Description eventid的中文含义是： 事件ID
	 */
	public void setEventid(String eventid){ 
		this.eventid = eventid;
	}
	/**
	 * @Description eventid的中文含义是： 事件ID
	 */
	public String getEventid(){
		return eventid;
	}
	/**
	 * @Description loginfo的中文含义是： 处理信息
	 */
	public void setLoginfo(String loginfo){ 
		this.loginfo = loginfo;
	}
	/**
	 * @Description loginfo的中文含义是： 处理信息
	 */
	public String getLoginfo(){
		return loginfo;
	}
	/**
	 * @Description logstate的中文含义是： 处理结果状态
	 */
	public void setLogstate(String logstate){ 
		this.logstate = logstate;
	}
	/**
	 * @Description logstate的中文含义是： 处理结果状态
	 */
	public String getLogstate(){
		return logstate;
	}
	/**
	 * @Description remark的中文含义是： 备注
	 */
	public void setRemark(String remark){ 
		this.remark = remark;
	}
	/**
	 * @Description remark的中文含义是： 备注
	 */
	public String getRemark(){
		return remark;
	}
	/**
	 * @Description sortid的中文含义是： 处理序号
	 */
	public void setSortid(String sortid){ 
		this.sortid = sortid;
	}
	/**
	 * @Description sortid的中文含义是： 处理序号
	 */
	public String getSortid(){
		return sortid;
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