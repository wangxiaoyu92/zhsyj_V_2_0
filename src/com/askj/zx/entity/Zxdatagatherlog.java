package com.askj.zx.entity;

import java.sql.Date;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Table;

/**
 * @Description  ZXDATAGATHERLOG的中文含义是: 诚信数据采集日志表
 * @Creation     2016/01/20 16:50:57
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZXDATAGATHERLOG")
public class Zxdatagatherlog {
	/**
	 * @Description dglid的中文含义是： ID
	 */
	@Column
	private Integer dglid;

	/**
	 * @Description dglsourcetype的中文含义是： 数据来源
	 */
	@Column
	private String dglsourcetype;

	/**
	 * @Description dgdate的中文含义是： 生效日期
	 */
	@Column
	private Date dgdate;

	/**
	 * @Description dgused的中文含义是： 是否已使用 0：未使用；1：已使用
	 */
	@Column
	private String dgused;

	/**
	 * @Description dgenable的中文含义是： 是否启用; 0:不启用；1启用
	 */
	@Column
	private String dgenable;

	/**
	 * @Description bccodesubsys的中文含义是： 业务编码 子系统
	 */
	@Column
	private String bccodesubsys;

	/**
	 * @Description bccodebusiness的中文含义是： 业务编码 业务
	 */
	@Column
	private String bccodebusiness;

	/**
	 * @Description bccodeitem的中文含义是： 业务编码 项目
	 */
	@Column
	private String bccodeitem;

	/**
	 * @Description bccodelevel的中文含义是： 业务编码 级别
	 */
	@Column
	private String bccodelevel;

	/**
	 * @Description dgscore的中文含义是： 得分
	 */
	@Column
	private Integer dgscore;

	
		/**
	 * @Description dglid的中文含义是： ID
	 */
	public void setDglid(Integer dglid){ 
		this.dglid = dglid;
	}
	/**
	 * @Description dglid的中文含义是： ID
	 */
	public Integer getDglid(){
		return dglid;
	}
	/**
	 * @Description dglsourcetype的中文含义是： 数据来源
	 */
	public void setDglsourcetype(String dglsourcetype){ 
		this.dglsourcetype = dglsourcetype;
	}
	/**
	 * @Description dglsourcetype的中文含义是： 数据来源
	 */
	public String getDglsourcetype(){
		return dglsourcetype;
	}
	/**
	 * @Description dgdate的中文含义是： 生效日期
	 */
	public void setDgdate(Date dgdate){ 
		this.dgdate = dgdate;
	}
	/**
	 * @Description dgdate的中文含义是： 生效日期
	 */
	public Date getDgdate(){
		return dgdate;
	}
	/**
	 * @Description dgused的中文含义是： 是否已使用 0：未使用；1：已使用
	 */
	public void setDgused(String dgused){ 
		this.dgused = dgused;
	}
	/**
	 * @Description dgused的中文含义是： 是否已使用 0：未使用；1：已使用
	 */
	public String getDgused(){
		return dgused;
	}
	/**
	 * @Description dgenable的中文含义是： 是否启用; 0:不启用；1启用
	 */
	public void setDgenable(String dgenable){ 
		this.dgenable = dgenable;
	}
	/**
	 * @Description dgenable的中文含义是： 是否启用; 0:不启用；1启用
	 */
	public String getDgenable(){
		return dgenable;
	}
	/**
	 * @Description bccodesubsys的中文含义是： 业务编码 子系统
	 */
	public void setBccodesubsys(String bccodesubsys){ 
		this.bccodesubsys = bccodesubsys;
	}
	/**
	 * @Description bccodesubsys的中文含义是： 业务编码 子系统
	 */
	public String getBccodesubsys(){
		return bccodesubsys;
	}
	/**
	 * @Description bccodebusiness的中文含义是： 业务编码 业务
	 */
	public void setBccodebusiness(String bccodebusiness){ 
		this.bccodebusiness = bccodebusiness;
	}
	/**
	 * @Description bccodebusiness的中文含义是： 业务编码 业务
	 */
	public String getBccodebusiness(){
		return bccodebusiness;
	}
	/**
	 * @Description bccodeitem的中文含义是： 业务编码 项目
	 */
	public void setBccodeitem(String bccodeitem){ 
		this.bccodeitem = bccodeitem;
	}
	/**
	 * @Description bccodeitem的中文含义是： 业务编码 项目
	 */
	public String getBccodeitem(){
		return bccodeitem;
	}
	/**
	 * @Description bccodelevel的中文含义是： 业务编码 级别
	 */
	public void setBccodelevel(String bccodelevel){ 
		this.bccodelevel = bccodelevel;
	}
	/**
	 * @Description bccodelevel的中文含义是： 业务编码 级别
	 */
	public String getBccodelevel(){
		return bccodelevel;
	}
	/**
	 * @Description dgscore的中文含义是： 得分
	 */
	public void setDgscore(Integer dgscore){ 
		this.dgscore = dgscore;
	}
	/**
	 * @Description dgscore的中文含义是： 得分
	 */
	public Integer getDgscore(){
		return dgscore;
	}

	
}