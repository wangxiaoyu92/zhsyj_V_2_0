package com.askj.zfba.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;

import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSCFKYWPYJTZS6的中文含义是: 查封扣押物品移交通知书; InnoDB free: 75776 kBDTO
 * @Creation     2016/03/14 17:17:04
 * @Written      Create Tool By zjf 
 **/
public class Zfwscfkywpyjtzs6DTO {

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
	 * @Description cfkyyjid的中文含义是： 查封扣押移交id
	 */
	private String cfkyyjid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	private String ajdjid;

	/**
	 * @Description wsbh的中文含义是： 文书编号
	 */
	private String wsbh;

	/**
	 * @Description sysbmmc的中文含义是： 受移送部门名称
	 */
	private String sysbmmc;

	/**
	 * @Description wszw的中文含义是： 文书正文部分
	 */
	private String wszw;

	/**
	 * @Description syjmcqz的中文含义是： 食药局名称前缀,见aa01表SPYPJDGLJMC
	 */
	private String syjmcqz;

	/**
	 * @Description cfkyyjrq的中文含义是： 查封扣押移交日期
	 */
	private String cfkyyjrq;

	/**
	 * @Description cfkyyjcsr的中文含义是： 抄送人名称
	 */
	private String cfkyyjcsr;
	
	/**
	 * @Description zfwsdmz的中文含义是： 执法文书代码值
	 */
	private String zfwsdmz;
	
	/**
	 * @Description zfwsqtbid的中文含义是：执法文书所在表ID
	 */
	private String zfwsqtbid;
	
	/**
	 * @Description cfkywfxw的中文含义是： 违法行为
	 */
	private String cfkywfxw;

	/**
	 * @Description cfkyygwp的中文含义是： 有关物品
	 */
	private String cfkyygwp;

	/**
	 * @Description cfkyjdswsbh的中文含义是： 查封扣押决定书编号
	 */
	private String cfkyjdswsbh;

	/**
	 * @Description cfkytitle的中文含义是： 标题查封物品移交通知书，扣押物品移交通知书
	 */
	private String cfkytitle;
	
	

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
	 * @Description wszw的中文含义是： 文书正文部分
	 */
	public void setWszw(String wszw){ 
		this.wszw = wszw;
	}
	/**
	 * @Description wszw的中文含义是： 文书正文部分
	 */
	public String getWszw(){
		return wszw;
	}
	/**
	 * @Description syjmcqz的中文含义是： 食药局名称前缀,见aa01表SPYPJDGLJMC
	 */
	public void setSyjmcqz(String syjmcqz){ 
		this.syjmcqz = syjmcqz;
	}
	/**
	 * @Description syjmcqz的中文含义是： 食药局名称前缀,见aa01表SPYPJDGLJMC
	 */
	public String getSyjmcqz(){
		return syjmcqz;
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
	public String getCfkywfxw() {
		return cfkywfxw;
	}
	public void setCfkywfxw(String cfkywfxw) {
		this.cfkywfxw = cfkywfxw;
	}
	public String getCfkyygwp() {
		return cfkyygwp;
	}
	public void setCfkyygwp(String cfkyygwp) {
		this.cfkyygwp = cfkyygwp;
	}
	public String getCfkyjdswsbh() {
		return cfkyjdswsbh;
	}
	public void setCfkyjdswsbh(String cfkyjdswsbh) {
		this.cfkyjdswsbh = cfkyjdswsbh;
	}
	public String getCfkytitle() {
		return cfkytitle;
	}
	public void setCfkytitle(String cfkytitle) {
		this.cfkytitle = cfkytitle;
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