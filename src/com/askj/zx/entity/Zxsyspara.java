package com.askj.zx.entity;

import java.sql.Date;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Table;

/**
 * @Description  ZXSYSPARA的中文含义是: 系统参数表
 * @Creation     2016/01/20 16:52:17
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZXSYSPARA")
public class Zxsyspara {
	/**
	 * @Description spid的中文含义是： ID
	 */
	@Column
	private Integer spid;

	/**
	 * @Description spzxgrade的中文含义是： 企业诚信级别名称
	 */
	@Column
	private String spzxgrade;

	/**
	 * @Description spscorebegin的中文含义是： 本级别起始分值
	 */
	@Column
	private String spscorebegin;

	/**
	 * @Description spscoreend的中文含义是： 本级别结束分值
	 */
	@Column
	private String spscoreend;

	/**
	 * @Description spyear的中文含义是： 业务年度
	 */
	@Column
	private String spyear;

	/**
	 * @Description spdatebegin的中文含义是： 起始日期
	 */
	@Column
	private Date spdatebegin;

	/**
	 * @Description spdateend的中文含义是： 结束日期
	 */
	@Column
	private Date spdateend;

	/**
	 * @Description spenable的中文含义是： 当前是否启用（年度唯一）。0：未启用；1：启用 
	 */
	@Column
	private String spenable;

	/**
	 * @Description logid的中文含义是： 操作日志ID
	 */
	@Column
	private Integer logid;

	
		/**
	 * @Description spid的中文含义是： ID
	 */
	public void setSpid(Integer spid){ 
		this.spid = spid;
	}
	/**
	 * @Description spid的中文含义是： ID
	 */
	public Integer getSpid(){
		return spid;
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
	 * @Description spscorebegin的中文含义是： 本级别起始分值
	 */
	public void setSpscorebegin(String spscorebegin){ 
		this.spscorebegin = spscorebegin;
	}
	/**
	 * @Description spscorebegin的中文含义是： 本级别起始分值
	 */
	public String getSpscorebegin(){
		return spscorebegin;
	}
	/**
	 * @Description spscoreend的中文含义是： 本级别结束分值
	 */
	public void setSpscoreend(String spscoreend){ 
		this.spscoreend = spscoreend;
	}
	/**
	 * @Description spscoreend的中文含义是： 本级别结束分值
	 */
	public String getSpscoreend(){
		return spscoreend;
	}
	/**
	 * @Description spyear的中文含义是： 业务年度
	 */
	public void setSpyear(String spyear){ 
		this.spyear = spyear;
	}
	/**
	 * @Description spyear的中文含义是： 业务年度
	 */
	public String getSpyear(){
		return spyear;
	}
	/**
	 * @Description spdatebegin的中文含义是： 起始日期
	 */
	public void setSpdatebegin(Date spdatebegin){ 
		this.spdatebegin = spdatebegin;
	}
	/**
	 * @Description spdatebegin的中文含义是： 起始日期
	 */
	public Date getSpdatebegin(){
		return spdatebegin;
	}
	/**
	 * @Description spdateend的中文含义是： 结束日期
	 */
	public void setSpdateend(Date spdateend){ 
		this.spdateend = spdateend;
	}
	/**
	 * @Description spdateend的中文含义是： 结束日期
	 */
	public Date getSpdateend(){
		return spdateend;
	}
	/**
	 * @Description spenable的中文含义是： 当前是否启用（年度唯一）。0：未启用；1：启用 
	 */
	public void setSpenable(String spenable){ 
		this.spenable = spenable;
	}
	/**
	 * @Description spenable的中文含义是： 当前是否启用（年度唯一）。0：未启用；1：启用 
	 */
	public String getSpenable(){
		return spenable;
	}
	/**
	 * @Description logid的中文含义是： 操作日志ID
	 */
	public void setLogid(Integer logid){ 
		this.logid = logid;
	}
	/**
	 * @Description logid的中文含义是： 操作日志ID
	 */
	public Integer getLogid(){
		return logid;
	}

	
}