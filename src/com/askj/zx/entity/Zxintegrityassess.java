package com.askj.zx.entity;

import java.sql.Date;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

/**
 * @Description  ZXINTEGRITYASSESS的中文含义是: 诚信评估表; InnoDB free: 28672 kB
 * @Creation     2016/01/20 14:06:10
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZXINTEGRITYASSESS")
public class Zxintegrityassess {
	/**
	 * @Description iaid的中文含义是： 评估表ID
	 */
	@Id
	@Column
	private Integer iaid;

	/**
	 * @Description comid的中文含义是： 企业ID
	 */
	@Column
	private Integer comid;

	/**
	 * @Description taskid的中文含义是： 评估任务ID （评估由哪里发起）
	 */
	@Column
	private Integer taskid;

	/**
	 * @Description userid的中文含义是： 录入人员ID
	 */
	@Column
	private Integer userid;

	/**
	 * @Description spyear的中文含义是： 年度
	 */
	@Column
	private String spyear;

	/**
	 * @Description iaaccessdate的中文含义是： 评估日期
	 */
	@Column
	private Date iaaccessdate;

	/**
	 * @Description logid的中文含义是： 业务日志ID
	 */
	@Column
	private Integer logid;

	/**
	 * @Description iascore的中文含义是： 得分
	 */
	@Column
	private String iascore;

	/**
	 * @Description spzxgrade的中文含义是： 企业诚信级别名称
	 */
	@Column
	private String spzxgrade;

	/**
	 * @Description bccode的中文含义是： 采用的业务参数编码 zxBusinessCode,业务级别
	 */
	@Column
	private String bccode;

	
		/**
	 * @Description iaid的中文含义是： 评估表ID
	 */
	public void setIaid(Integer iaid){ 
		this.iaid = iaid;
	}
	/**
	 * @Description iaid的中文含义是： 评估表ID
	 */
	public Integer getIaid(){
		return iaid;
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
	 * @Description taskid的中文含义是： 评估任务ID （评估由哪里发起）
	 */
	public void setTaskid(Integer taskid){ 
		this.taskid = taskid;
	}
	/**
	 * @Description taskid的中文含义是： 评估任务ID （评估由哪里发起）
	 */
	public Integer getTaskid(){
		return taskid;
	}
	/**
	 * @Description userid的中文含义是： 录入人员ID
	 */
	public void setUserid(Integer userid){ 
		this.userid = userid;
	}
	/**
	 * @Description userid的中文含义是： 录入人员ID
	 */
	public Integer getUserid(){
		return userid;
	}
	/**
	 * @Description spyear的中文含义是： 年度
	 */
	public void setSpyear(String spyear){ 
		this.spyear = spyear;
	}
	/**
	 * @Description spyear的中文含义是： 年度
	 */
	public String getSpyear(){
		return spyear;
	}
	/**
	 * @Description iaaccessdate的中文含义是： 评估日期
	 */
	public void setIaaccessdate(Date iaaccessdate){ 
		this.iaaccessdate = iaaccessdate;
	}
	/**
	 * @Description iaaccessdate的中文含义是： 评估日期
	 */
	public Date getIaaccessdate(){
		return iaaccessdate;
	}
	/**
	 * @Description logid的中文含义是： 业务日志ID
	 */
	public void setLogid(Integer logid){ 
		this.logid = logid;
	}
	/**
	 * @Description logid的中文含义是： 业务日志ID
	 */
	public Integer getLogid(){
		return logid;
	}
	/**
	 * @Description iascore的中文含义是： 得分
	 */
	public void setIascore(String iascore){ 
		this.iascore = iascore;
	}
	/**
	 * @Description iascore的中文含义是： 得分
	 */
	public String getIascore(){
		return iascore;
	}
	/**
	 * @Description spzxgrade的中文含义是： 企业诚信级别名称
	 */
	public void setSpzxgrade(String spzxgrade){ 
		this.spzxgrade = spzxgrade;
	}
	/**
	 * @Description spzxgrade的中文含义是： 企业诚信级别名称
	 */
	public String getSpzxgrade(){
		return spzxgrade;
	}
	/**
	 * @Description bccode的中文含义是： 采用的业务参数编码 zxBusinessCode,业务级别
	 */
	public void setBccode(String bccode){ 
		this.bccode = bccode;
	}
	/**
	 * @Description bccode的中文含义是： 采用的业务参数编码 zxBusinessCode,业务级别
	 */
	public String getBccode(){
		return bccode;
	}

	
}