package com.zzhdsoft.siweb.entity.workflow;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  WF_YEWU_PROCESS的中文含义是: 业务工作流关系表
 * @Creation     2016/03/16 10:42:09
 * @Written      Create Tool By zjf 
 **/
@Table(value = "WF_YEWU_PROCESS")
public class Wf_yewu_process {
	/**
	 * @Description yewuprocessid的中文含义是： 业务工作流关系表ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_yewuprocessid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_yewuprocessid.nextval from dual"))
	private String yewuprocessid;

	/**
	 * @Description yewumc的中文含义是： 业务名称
	 */
	@Column
	private String yewumc;

	/**
	 * @Description yewumcpym的中文含义是： 业务名称拼音码
	 */
	@Column
	private String yewumcpym;

	/**
	 * @Description sfqygzl的中文含义是： 是否启用工作流
	 */
	@Column
	private String sfqygzl;

	/**
	 * @Description psbh的中文含义是： 要绑定的工作流编号
	 */
	@Column
	private String psbh;

	/**
	 * @Description aae036的中文含义是： 绑定时间
	 */
	@Column
	private Timestamp aae036;

	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	@Column
	private String aaa027;

	
		/**
	 * @Description yewuprocessid的中文含义是： 业务工作流关系表ID
	 */
	public void setYewuprocessid(String yewuprocessid){ 
		this.yewuprocessid = yewuprocessid;
	}
	/**
	 * @Description yewuprocessid的中文含义是： 业务工作流关系表ID
	 */
	public String getYewuprocessid(){
		return yewuprocessid;
	}
	/**
	 * @Description yewumc的中文含义是： 业务名称
	 */
	public void setYewumc(String yewumc){ 
		this.yewumc = yewumc;
	}
	/**
	 * @Description yewumc的中文含义是： 业务名称
	 */
	public String getYewumc(){
		return yewumc;
	}
	/**
	 * @Description yewumcpym的中文含义是： 业务名称拼音码
	 */
	public void setYewumcpym(String yewumcpym){ 
		this.yewumcpym = yewumcpym;
	}
	/**
	 * @Description yewumcpym的中文含义是： 业务名称拼音码
	 */
	public String getYewumcpym(){
		return yewumcpym;
	}
	/**
	 * @Description sfqygzl的中文含义是： 是否启用工作流
	 */
	public void setSfqygzl(String sfqygzl){ 
		this.sfqygzl = sfqygzl;
	}
	/**
	 * @Description sfqygzl的中文含义是： 是否启用工作流
	 */
	public String getSfqygzl(){
		return sfqygzl;
	}
	/**
	 * @Description psbh的中文含义是： 要绑定的工作流编号
	 */
	public void setPsbh(String psbh){ 
		this.psbh = psbh;
	}
	/**
	 * @Description psbh的中文含义是： 要绑定的工作流编号
	 */
	public String getPsbh(){
		return psbh;
	}
	/**
	 * @Description aae036的中文含义是： 绑定时间
	 */
	public void setAae036(Timestamp aae036){ 
		this.aae036 = aae036;
	}
	/**
	 * @Description aae036的中文含义是： 绑定时间
	 */
	public Timestamp getAae036(){
		return aae036;
	}
	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	public void setAaa027(String aaa027){ 
		this.aaa027 = aaa027;
	}
	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	public String getAaa027(){
		return aaa027;
	}

	
}