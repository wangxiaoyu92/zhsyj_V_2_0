package com.askj.zfba.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;

import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSAJYSS3的中文含义是: 执法文书案件移送书; InnoDB free: 75776 kBDTO
 * @Creation     2016/03/12 13:19:49
 * @Written      Create Tool By zjf 
 **/
public class Zfwsajyss3DTO {
	//扩展开始
	/**
	 * 一个方法被多个地方调用，这个表示是那个地方用，以区别处理
	 */
	private String operatetype;
	/**
	 * comid
	 */
	private String comid;

	//扩展结束


	/**
	 * @Description ajzfwsid的中文含义是： 案件执法文书ID
	 */
	private String ajzfwsid;
	
	/**
	 * @Description ajdjbh的中文含义是： 案件登记编号，手工填写
	 */
	private String ajdjbh;

	public String getAjdjbh() {
		return ajdjbh;
	}
	public void setAjdjbh(String ajdjbh) {
		this.ajdjbh = ajdjbh;
	}
	/**
	 * @Description zfwsdmz的中文含义是： 执法文书代码值
	 */
	private String zfwsdmz;
	/**
	 * @Description zfwsqtbid的中文含义是：执法文书所在表ID
	 */
	private String zfwsqtbid;
	/**
	 * @Description ajysid的中文含义是： 
	 */
	private String ajysid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记id
	 */
	private String ajdjid;

	/**
	 * @Description zfwsbh的中文含义是： 执法文书编号
	 */
	private String zfwsbh;

	/**
	 * @Description ajysbmmc的中文含义是： 受移送部门名称
	 */
	private String ajysbmmc;

	/**
	 * @Description ajysms的中文含义是： 案件移送描述
	 */
	private String ajysms;

	/**
	 * @Description ajysclzs的中文含义是： 案件移送材料张数
	 */
	private Integer ajysclzs;

	/**
	 * @Description ajysrq的中文含义是： 案件移送日期
	 */
	private String ajysrq;	
	
	/**
	 * @Description ajysysyy的中文含义是： 移送原因(案件发生的时间、主要违法事实及移送原因)
	 */
	private String ajysysyy;
	
	/**
	 * @Description ajysdjt的中文含义是： 第几条规定
	 */
	private String ajysdjt;		

	
		/**
	 * @Description ajysid的中文含义是： 
	 */
	public void setAjysid(String ajysid){ 
		this.ajysid = ajysid;
	}
	/**
	 * @Description ajysid的中文含义是： 
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
	/**
	 * @Description zfwsdmz的中文含义是： 执法文书代码值
	 */
	public String getZfwsdmz() {
		return zfwsdmz;
	}
	/**
	 * @Description zfwsdmz的中文含义是： 执法文书代码值
	 */
	public void setZfwsdmz(String zfwsdmz) {
		this.zfwsdmz = zfwsdmz;
	}
	/**
	 * @Description zfwsqtbid的中文含义是： 执法文书所在表ID
	 */
	public String getZfwsqtbid() {
		return zfwsqtbid;
	}
	/**
	 * @Description zfwsqtbid的中文含义是：执法文书所在表ID
	 */
	public void setZfwsqtbid(String zfwsqtbid) {
		this.zfwsqtbid = zfwsqtbid;
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
	public String getAjzfwsid() {
		return ajzfwsid;
	}
	public void setAjzfwsid(String ajzfwsid) {
		this.ajzfwsid = ajzfwsid;
	}

	public String getOperatetype() {
		return operatetype;
	}

	public void setOperatetype(String operatetype) {
		this.operatetype = operatetype;
	}

	public String getComid() {
		return comid;
	}

	public void setComid(String comid) {
		this.comid = comid;
	}
}