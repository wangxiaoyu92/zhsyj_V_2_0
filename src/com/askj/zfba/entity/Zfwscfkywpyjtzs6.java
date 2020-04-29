package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSCFKYWPYJTZS6的中文含义是: 查封扣押物品移交通知书; InnoDB free: 2721792 kB
 * @Creation     2016/06/16 10:53:30
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSCFKYWPYJTZS6")
public class Zfwscfkywpyjtzs6 {
	/**
	 * @Description cfkyyjid的中文含义是： 查封扣押移交id
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_cfkyyjid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_cfkyyjid.nextval from dual"))
	private String cfkyyjid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description wsbh的中文含义是： 文书编号
	 */
	@Column
	private String wsbh;

	/**
	 * @Description sysbmmc的中文含义是： 受移送部门名称
	 */
	@Column
	private String sysbmmc;

	/**
	 * @Description cfkyyjrq的中文含义是： 查封扣押移交日期
	 */
	@Column
	private String cfkyyjrq;

	/**
	 * @Description cfkyyjcsr的中文含义是： 抄送人名称
	 */
	@Column
	private String cfkyyjcsr;

	/**
	 * @Description cfkywfxw的中文含义是： 违法行为
	 */
	@Column
	private String cfkywfxw;

	/**
	 * @Description cfkyygwp的中文含义是： 有关物品
	 */
	@Column
	private String cfkyygwp;

	/**
	 * @Description cfkyjdswsbh的中文含义是： 查封扣押决定书编号
	 */
	@Column
	private String cfkyjdswsbh;

	/**
	 * @Description cfkytitle的中文含义是： 标题查封物品移交通知书，扣押物品移交通知书
	 */
	@Column
	private String cfkytitle;

	
		/**
	 * @Description cfkyyjid的中文含义是： 查封扣押移交id
	 */
	public void setCfkyyjid(String cfkyyjid){ 
		this.cfkyyjid = cfkyyjid;
	}
	/**
	 * @Description cfkyyjid的中文含义是： 查封扣押移交id
	 */
	public String getCfkyyjid(){
		return cfkyyjid;
	}
	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	public void setAjdjid(String ajdjid){ 
		this.ajdjid = ajdjid;
	}
	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	public String getAjdjid(){
		return ajdjid;
	}
	/**
	 * @Description wsbh的中文含义是： 文书编号
	 */
	public void setWsbh(String wsbh){ 
		this.wsbh = wsbh;
	}
	/**
	 * @Description wsbh的中文含义是： 文书编号
	 */
	public String getWsbh(){
		return wsbh;
	}
	/**
	 * @Description sysbmmc的中文含义是： 受移送部门名称
	 */
	public void setSysbmmc(String sysbmmc){ 
		this.sysbmmc = sysbmmc;
	}
	/**
	 * @Description sysbmmc的中文含义是： 受移送部门名称
	 */
	public String getSysbmmc(){
		return sysbmmc;
	}
	/**
	 * @Description cfkyyjrq的中文含义是： 查封扣押移交日期
	 */
	public void setCfkyyjrq(String cfkyyjrq){ 
		this.cfkyyjrq = cfkyyjrq;
	}
	/**
	 * @Description cfkyyjrq的中文含义是： 查封扣押移交日期
	 */
	public String getCfkyyjrq(){
		return cfkyyjrq;
	}
	/**
	 * @Description cfkyyjcsr的中文含义是： 抄送人名称
	 */
	public void setCfkyyjcsr(String cfkyyjcsr){ 
		this.cfkyyjcsr = cfkyyjcsr;
	}
	/**
	 * @Description cfkyyjcsr的中文含义是： 抄送人名称
	 */
	public String getCfkyyjcsr(){
		return cfkyyjcsr;
	}
	/**
	 * @Description cfkywfxw的中文含义是： 违法行为
	 */
	public void setCfkywfxw(String cfkywfxw){ 
		this.cfkywfxw = cfkywfxw;
	}
	/**
	 * @Description cfkywfxw的中文含义是： 违法行为
	 */
	public String getCfkywfxw(){
		return cfkywfxw;
	}
	/**
	 * @Description cfkyygwp的中文含义是： 有关物品
	 */
	public void setCfkyygwp(String cfkyygwp){ 
		this.cfkyygwp = cfkyygwp;
	}
	/**
	 * @Description cfkyygwp的中文含义是： 有关物品
	 */
	public String getCfkyygwp(){
		return cfkyygwp;
	}
	/**
	 * @Description cfkyjdswsbh的中文含义是： 查封扣押决定书编号
	 */
	public void setCfkyjdswsbh(String cfkyjdswsbh){ 
		this.cfkyjdswsbh = cfkyjdswsbh;
	}
	/**
	 * @Description cfkyjdswsbh的中文含义是： 查封扣押决定书编号
	 */
	public String getCfkyjdswsbh(){
		return cfkyjdswsbh;
	}
	/**
	 * @Description cfkytitle的中文含义是： 标题查封物品移交通知书，扣押物品移交通知书
	 */
	public void setCfkytitle(String cfkytitle){ 
		this.cfkytitle = cfkytitle;
	}
	/**
	 * @Description cfkytitle的中文含义是： 标题查封物品移交通知书，扣押物品移交通知书
	 */
	public String getCfkytitle(){
		return cfkytitle;
	}

	
}