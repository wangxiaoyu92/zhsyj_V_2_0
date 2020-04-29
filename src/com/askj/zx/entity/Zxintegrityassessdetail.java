package com.askj.zx.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZXINTEGRITYASSESSDETAIL的中文含义是: 诚信评估明细表; InnoDB free: 12288 kB
 * @Creation     2016/01/29 08:42:49
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZXINTEGRITYASSESSDETAIL")
public class Zxintegrityassessdetail {
	/**
	 * @Description iadid的中文含义是： 评估明细ID
	 */
	@Column
	private Integer iadid;

	/**
	 * @Description iaid的中文含义是： 评估主表ID
	 */
	@Column
	private Integer iaid;

	/**
	 * @Description bpid的中文含义是： 业务参数ID（标识系统、业务、项目、级别、得分、系数）
	 */
	@Column
	private Integer bpid;

	/**
	 * @Description logid的中文含义是： 业务日志ID
	 */
	@Column
	private Integer logid;

	/**
	 * @Description bcid的中文含义是： 
	 */
	@Column
	private String bcid;

	
		/**
	 * @Description iadid的中文含义是： 评估明细ID
	 */
	public void setIadid(Integer iadid){ 
		this.iadid = iadid;
	}
	/**
	 * @Description iadid的中文含义是： 评估明细ID
	 */
	public Integer getIadid(){
		return iadid;
	}
	/**
	 * @Description iaid的中文含义是： 评估主表ID
	 */
	public void setIaid(Integer iaid){ 
		this.iaid = iaid;
	}
	/**
	 * @Description iaid的中文含义是： 评估主表ID
	 */
	public Integer getIaid(){
		return iaid;
	}
	/**
	 * @Description bpid的中文含义是： 业务参数ID（标识系统、业务、项目、级别、得分、系数）
	 */
	public void setBpid(Integer bpid){ 
		this.bpid = bpid;
	}
	/**
	 * @Description bpid的中文含义是： 业务参数ID（标识系统、业务、项目、级别、得分、系数）
	 */
	public Integer getBpid(){
		return bpid;
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
	 * @Description bcid的中文含义是： 
	 */
	public void setBcid(String bcid){ 
		this.bcid = bcid;
	}
	/**
	 * @Description bcid的中文含义是： 
	 */
	public String getBcid(){
		return bcid;
	}

	
}