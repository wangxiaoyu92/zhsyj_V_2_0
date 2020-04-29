package com.askj.spsy.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  QSYMSCB的中文含义是: 溯源码生成表; InnoDB free: 2715648 kB
 * @Creation     2016/07/03 16:40:56
 * @Written      Create Tool By zjf 
 **/
@Table(value = "QSYMSCB")
public class Qsymscb {
	/**
	 * @Description qsymscbid的中文含义是： 
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_qsymscbid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_qsymscbid.nextval from dual"))
	private String qsymscbid;

	/**
	 * @Description cppcid的中文含义是： 产品批次表主键
	 */
	@Column
	private String cppcid;

	/**
	 * @Description symksh的中文含义是： 开始号
	 */
	@Column
	private String symksh;

	/**
	 * @Description symjsh的中文含义是： 结束号
	 */
	@Column
	private String symjsh;

	/**
	 * @Description symsqr的中文含义是： 申请人
	 */
	@Column
	private String symsqr;

	/**
	 * @Description symsqsj的中文含义是： 申请时间
	 */
	@Column
	private String symsqsj;

	
		/**
	 * @Description qsymscbid的中文含义是： 
	 */
	public void setQsymscbid(String qsymscbid){ 
		this.qsymscbid = qsymscbid;
	}
	/**
	 * @Description qsymscbid的中文含义是： 
	 */
	public String getQsymscbid(){
		return qsymscbid;
	}
	/**
	 * @Description cppcid的中文含义是： 产品批次表主键
	 */
	public void setCppcid(String cppcid){ 
		this.cppcid = cppcid;
	}
	/**
	 * @Description cppcid的中文含义是： 产品批次表主键
	 */
	public String getCppcid(){
		return cppcid;
	}
	/**
	 * @Description symksh的中文含义是： 开始号
	 */
	public void setSymksh(String symksh){ 
		this.symksh = symksh;
	}
	/**
	 * @Description symksh的中文含义是： 开始号
	 */
	public String getSymksh(){
		return symksh;
	}
	/**
	 * @Description symjsh的中文含义是： 结束号
	 */
	public void setSymjsh(String symjsh){ 
		this.symjsh = symjsh;
	}
	/**
	 * @Description symjsh的中文含义是： 结束号
	 */
	public String getSymjsh(){
		return symjsh;
	}
	/**
	 * @Description symsqr的中文含义是： 申请人
	 */
	public void setSymsqr(String symsqr){ 
		this.symsqr = symsqr;
	}
	/**
	 * @Description symsqr的中文含义是： 申请人
	 */
	public String getSymsqr(){
		return symsqr;
	}
	/**
	 * @Description symsqsj的中文含义是： 申请时间
	 */
	public void setSymsqsj(String symsqsj){ 
		this.symsqsj = symsqsj;
	}
	/**
	 * @Description symsqsj的中文含义是： 申请时间
	 */
	public String getSymsqsj(){
		return symsqsj;
	}

	
}