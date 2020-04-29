package com.askj.zx.entity;

import java.sql.Date; 

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

/**
 * @Description  ZXINTEGRITYPUBLICITY的中文含义是: 征集公示表; InnoDB free: 28672 kB
 * @Creation     2016/01/20 14:00:59
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZXINTEGRITYPUBLICITY")
public class Zxintegritypublicity {
	/**
	 * @Description ipid的中文含义是： ID
	 */
	@Id
	@Column
	private Integer ipid;

	/**
	 * @Description comid的中文含义是： 企业ID
	 */
	@Column
	private Integer comid;

	/**
	 * @Description iaid的中文含义是： 评估ID
	 */
	@Column
	private Integer iaid;

	/**
	 * @Description ipdate的中文含义是： 评估日期
	 */
	@Column
	private Date ipdate;

	/**
	 * @Description ipupdate的中文含义是： 上榜时间
	 */
	@Column
	private Date ipupdate;

	/**
	 * @Description ipuserid的中文含义是： 操作员ID
	 */
	@Column
	private Integer ipuserid;

	/**
	 * @Description logid的中文含义是： 日志ID
	 */
	@Column
	private Integer logid;

	/**
	 * @Description ipenable的中文含义是： 是否启用; 0:不启用； 1：启用
	 */
	@Column
	private String ipenable;

	/**
	 * @Description ipnote的中文含义是： 备注
	 */
	@Column
	private String ipnote;

	
		/**
	 * @Description ipid的中文含义是： ID
	 */
	public void setIpid(Integer ipid){ 
		this.ipid = ipid;
	}
	/**
	 * @Description ipid的中文含义是： ID
	 */
	public Integer getIpid(){
		return ipid;
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
	 * @Description iaid的中文含义是： 评估ID
	 */
	public void setIaid(Integer iaid){ 
		this.iaid = iaid;
	}
	/**
	 * @Description iaid的中文含义是： 评估ID
	 */
	public Integer getIaid(){
		return iaid;
	}
	/**
	 * @Description ipdate的中文含义是： 评估日期
	 */
	public void setIpdate(Date ipdate){ 
		this.ipdate = ipdate;
	}
	/**
	 * @Description ipdate的中文含义是： 评估日期
	 */
	public Date getIpdate(){
		return ipdate;
	}
	/**
	 * @Description ipupdate的中文含义是： 上榜时间
	 */
	public void setIpupdate(Date ipupdate){ 
		this.ipupdate = ipupdate;
	}
	/**
	 * @Description ipupdate的中文含义是： 上榜时间
	 */
	public Date getIpupdate(){
		return ipupdate;
	}
	/**
	 * @Description ipuserid的中文含义是： 操作员ID
	 */
	public void setIpuserid(Integer ipuserid){ 
		this.ipuserid = ipuserid;
	}
	/**
	 * @Description ipuserid的中文含义是： 操作员ID
	 */
	public Integer getIpuserid(){
		return ipuserid;
	}
	/**
	 * @Description logid的中文含义是： 日志ID
	 */
	public void setLogid(Integer logid){ 
		this.logid = logid;
	}
	/**
	 * @Description logid的中文含义是： 日志ID
	 */
	public Integer getLogid(){
		return logid;
	}
	/**
	 * @Description ipenable的中文含义是： 是否启用; 0:不启用； 1：启用
	 */
	public void setIpenable(String ipenable){ 
		this.ipenable = ipenable;
	}
	/**
	 * @Description ipenable的中文含义是： 是否启用; 0:不启用； 1：启用
	 */
	public String getIpenable(){
		return ipenable;
	}
	/**
	 * @Description ipnote的中文含义是： 备注
	 */
	public void setIpnote(String ipnote){ 
		this.ipnote = ipnote;
	}
	/**
	 * @Description ipnote的中文含义是： 备注
	 */
	public String getIpnote(){
		return ipnote;
	}

	
}