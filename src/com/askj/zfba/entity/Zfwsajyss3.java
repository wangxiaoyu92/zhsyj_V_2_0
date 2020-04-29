package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  ZFWSAJYSS3的中文含义是: 执法文书案件移送书; InnoDB free: 75776 kB
 * @Creation     2016/03/14 10:56:50
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSAJYSS3")
public class Zfwsajyss3 {
	/**
	 * @Description ajysid的中文含义是： 案件移送id
	 */
	@Column
	@Name
	private String ajysid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记id
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description zfwsbh的中文含义是： 执法文书编号
	 */
	@Column
	private String zfwsbh;

	/**
	 * @Description ajysbmmc的中文含义是： 受移送部门名称
	 */
	@Column
	private String ajysbmmc;

	/**
	 * @Description ajysms的中文含义是： 案件移送描述(当事人姓名或名称+涉嫌构成的违法行为的概述)
	 */
	@Column
	private String ajysms;

	/**
	 * @Description ajysclzs的中文含义是： 案件移送材料张数
	 */
	@Column
	private Integer ajysclzs;

	/**
	 * @Description ajysrq的中文含义是： 案件移送日期
	 */
	@Column
	private String ajysrq;
	
	/**
	 * @Description ajysysyy的中文含义是： 移送原因(案件发生的时间、主要违法事实及移送原因)
	 */
	@Column
	private String ajysysyy;
	
	/**
	 * @Description ajysdjt的中文含义是： 第几条规定
	 */
	@Column
	private String ajysdjt;	

	
		/**
	 * @Description ajysid的中文含义是： 案件移送id
	 */
	public void setAjysid(String ajysid){ 
		this.ajysid = ajysid;
	}
	/**
	 * @Description ajysid的中文含义是： 案件移送id
	 */
	public String getAjysid(){
		return ajysid;
	}
	/**
	 * @Description ajdjid的中文含义是： 案件登记id
	 */
	public void setAjdjid(String ajdjid){ 
		this.ajdjid = ajdjid;
	}
	/**
	 * @Description ajdjid的中文含义是： 案件登记id
	 */
	public String getAjdjid(){
		return ajdjid;
	}
	/**
	 * @Description zfwsbh的中文含义是： 执法文书编号
	 */
	public void setZfwsbh(String zfwsbh){ 
		this.zfwsbh = zfwsbh;
	}
	/**
	 * @Description zfwsbh的中文含义是： 执法文书编号
	 */
	public String getZfwsbh(){
		return zfwsbh;
	}
	/**
	 * @Description ajysbmmc的中文含义是： 受移送部门名称
	 */
	public void setAjysbmmc(String ajysbmmc){ 
		this.ajysbmmc = ajysbmmc;
	}
	/**
	 * @Description ajysbmmc的中文含义是： 受移送部门名称
	 */
	public String getAjysbmmc(){
		return ajysbmmc;
	}
	/**
	 * @Description ajysms的中文含义是： 案件移送描述
	 */
	public void setAjysms(String ajysms){ 
		this.ajysms = ajysms;
	}
	/**
	 * @Description ajysms的中文含义是： 案件移送描述
	 */
	public String getAjysms(){
		return ajysms;
	}
	/**
	 * @Description ajysclzs的中文含义是： 案件移送材料张数
	 */
	public void setAjysclzs(Integer ajysclzs){ 
		this.ajysclzs = ajysclzs;
	}
	/**
	 * @Description ajysclzs的中文含义是： 案件移送材料张数
	 */
	public Integer getAjysclzs(){
		return ajysclzs;
	}
	/**
	 * @Description ajysrq的中文含义是： 案件移送日期
	 */
	public void setAjysrq(String ajysrq){ 
		this.ajysrq = ajysrq;
	}
	/**
	 * @Description ajysrq的中文含义是： 案件移送日期
	 */
	public String getAjysrq(){
		return ajysrq;
	}
	public String getAjysysyy() {
		return ajysysyy;
	}
	public void setAjysysyy(String ajysysyy) {
		this.ajysysyy = ajysysyy;
	}
	public String getAjysdjt() {
		return ajysdjt;
	}
	public void setAjysdjt(String ajysdjt) {
		this.ajysdjt = ajysdjt;
	}
	
	

	
}