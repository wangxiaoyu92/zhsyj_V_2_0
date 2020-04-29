package com.askj.zx.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZXBUSINESSPARA的中文含义是: 业务参数表; InnoDB free: 11264 kB
 * @Creation     2016/02/02 09:33:52
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZXBUSINESSPARA")
public class Zxbusinesspara {
	/**
	 * @Description bpid的中文含义是： ID
	 */
	@Column
	private Integer bpid;

	/**
	 * @Description bpcodesubsys的中文含义是： 参数编码 子系统编码
	 */
	@Column
	private String bpcodesubsys;

	/**
	 * @Description bpcodebusiness的中文含义是： 参数编码 业务名称
	 */
	@Column
	private String bpcodebusiness;

	/**
	 * @Description bpcodeitem的中文含义是： 参数编码 项目名称
	 */
	@Column
	private String bpcodeitem;

	/**
	 * @Description bpcodelevel的中文含义是： 参数编码 级别
	 */
	@Column
	private String bpcodelevel;

	/**
	 * @Description bpscore的中文含义是： 得分
	 */
	@Column
	private String bpscore;

	/**
	 * @Description bpratio的中文含义是： 加乘系数
	 */
	@Column
	private String bpratio;

	/**
	 * @Description bpyear的中文含义是： 业务年度
	 */
	@Column
	private String bpyear;

	/**
	 * @Description bpdatebegin的中文含义是： 开始日期
	 */
	@Column
	private Date bpdatebegin;

	/**
	 * @Description bpdateend的中文含义是： 结束日期。  为空则在用
	 */
	@Column
	private Date bpdateend;

	/**
	 * @Description bpenable的中文含义是： 是否启用. 0:未启用；1：启用
	 */
	@Column
	private String bpenable;

	/**
	 * @Description logid的中文含义是： 操作日志ID
	 */
	@Column
	private Integer logid;

	/**
	 * @Description bplevel的中文含义是： 当前级别 (冗余)
	 */
	@Column
	private String bplevel;

	
		/**
	 * @Description bpid的中文含义是： ID
	 */
	public void setBpid(Integer bpid){ 
		this.bpid = bpid;
	}
	/**
	 * @Description bpid的中文含义是： ID
	 */
	public Integer getBpid(){
		return bpid;
	}
	/**
	 * @Description bpcodesubsys的中文含义是： 参数编码 子系统编码
	 */
	public void setBpcodesubsys(String bpcodesubsys){ 
		this.bpcodesubsys = bpcodesubsys;
	}
	/**
	 * @Description bpcodesubsys的中文含义是： 参数编码 子系统编码
	 */
	public String getBpcodesubsys(){
		return bpcodesubsys;
	}
	/**
	 * @Description bpcodebusiness的中文含义是： 参数编码 业务名称
	 */
	public void setBpcodebusiness(String bpcodebusiness){ 
		this.bpcodebusiness = bpcodebusiness;
	}
	/**
	 * @Description bpcodebusiness的中文含义是： 参数编码 业务名称
	 */
	public String getBpcodebusiness(){
		return bpcodebusiness;
	}
	/**
	 * @Description bpcodeitem的中文含义是： 参数编码 项目名称
	 */
	public void setBpcodeitem(String bpcodeitem){ 
		this.bpcodeitem = bpcodeitem;
	}
	/**
	 * @Description bpcodeitem的中文含义是： 参数编码 项目名称
	 */
	public String getBpcodeitem(){
		return bpcodeitem;
	}
	/**
	 * @Description bpcodelevel的中文含义是： 参数编码 级别
	 */
	public void setBpcodelevel(String bpcodelevel){ 
		this.bpcodelevel = bpcodelevel;
	}
	/**
	 * @Description bpcodelevel的中文含义是： 参数编码 级别
	 */
	public String getBpcodelevel(){
		return bpcodelevel;
	}
	/**
	 * @Description bpscore的中文含义是： 得分
	 */
	public void setBpscore(String bpscore){ 
		this.bpscore = bpscore;
	}
	/**
	 * @Description bpscore的中文含义是： 得分
	 */
	public String getBpscore(){
		return bpscore;
	}
	/**
	 * @Description bpratio的中文含义是： 加乘系数
	 */
	public void setBpratio(String bpratio){ 
		this.bpratio = bpratio;
	}
	/**
	 * @Description bpratio的中文含义是： 加乘系数
	 */
	public String getBpratio(){
		return bpratio;
	}
	/**
	 * @Description bpyear的中文含义是： 业务年度
	 */
	public void setBpyear(String bpyear){ 
		this.bpyear = bpyear;
	}
	/**
	 * @Description bpyear的中文含义是： 业务年度
	 */
	public String getBpyear(){
		return bpyear;
	}
	/**
	 * @Description bpdatebegin的中文含义是： 开始日期
	 */
	public void setBpdatebegin(Date bpdatebegin){ 
		this.bpdatebegin = bpdatebegin;
	}
	/**
	 * @Description bpdatebegin的中文含义是： 开始日期
	 */
	public Date getBpdatebegin(){
		return bpdatebegin;
	}
	/**
	 * @Description bpdateend的中文含义是： 结束日期。  为空则在用
	 */
	public void setBpdateend(Date bpdateend){ 
		this.bpdateend = bpdateend;
	}
	/**
	 * @Description bpdateend的中文含义是： 结束日期。  为空则在用
	 */
	public Date getBpdateend(){
		return bpdateend;
	}
	/**
	 * @Description bpenable的中文含义是： 是否启用. 0:未启用；1：启用
	 */
	public void setBpenable(String bpenable){ 
		this.bpenable = bpenable;
	}
	/**
	 * @Description bpenable的中文含义是： 是否启用. 0:未启用；1：启用
	 */
	public String getBpenable(){
		return bpenable;
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
	/**
	 * @Description bplevel的中文含义是： 当前级别 (冗余)
	 */
	public void setBplevel(String bplevel){ 
		this.bplevel = bplevel;
	}
	/**
	 * @Description bplevel的中文含义是： 当前级别 (冗余)
	 */
	public String getBplevel(){
		return bplevel;
	}

	
}