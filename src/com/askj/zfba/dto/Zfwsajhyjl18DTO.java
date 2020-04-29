package com.askj.zfba.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSAJHYJL18的中文含义是: 案件合议记录18; InnoDB free: 2723840 kBDTO
 * @Creation     2016/06/06 14:52:36
 * @Written      Create Tool By zjf 
 **/
public class Zfwsajhyjl18DTO {

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
	 * @Description zfwsdmz的中文含义是： 执法文书代码值
	 */
	private String zfwsdmz;
	public String getZfwsdmz() {
		return zfwsdmz;
	}
	public void setZfwsdmz(String zfwsdmz) {
		this.zfwsdmz = zfwsdmz;
	}
	/**
	 * @Description ajhyjlid的中文含义是： 案件合议记录ID
	 */
	private String ajhyjlid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	private String ajdjid;

	/**
	 * @Description hysj的中文含义是： 合议时间
	 */
	private String hysj;

	/**
	 * @Description hyzcr的中文含义是： 合议主持人
	 */
	private String hyzcr;

	/**
	 * @Description hydd的中文含义是： 合议地点
	 */
	private String hydd;

	/**
	 * @Description hyry的中文含义是： 合议人员
	 */
	private String hyry;

	/**
	 * @Description hyjlr的中文含义是： 记录人
	 */
	private String hyjlr;

	/**
	 * @Description hyaqjs的中文含义是： 案情介绍
	 */
	private String hyaqjs;

	/**
	 * @Description hytljl的中文含义是： 讨论记录
	 */
	private String hytljl;

	/**
	 * @Description hyyj的中文含义是： 合议意见
	 */
	private String hyyj;

	/**
	 * @Description hyzcrqz的中文含义是： 主持人签字
	 */
	private String hyzcrqz;

	/**
	 * @Description hyjlrqz的中文含义是： 记录人签字
	 */
	private String hyjlrqz;

	/**
	 * @Description hyryqz的中文含义是： 合议人员签字
	 */
	private String hyryqz;

	/**
	 * @Description ajdjay的中文含义是： 案由
	 */
	private String ajdjay;

	/**
	 * @Description hydsr的中文含义是： 当事人
	 */
	private String hydsr;

	/**
	 * @Description hyzjcl的中文含义是： 证据材料
	 */
	private String hyzjcl;

	/**
	 * @Description hywfxwdc的中文含义是： 违法行为等次
	 */
	private String hywfxwdc;

	/**
	 * @Description jytk的中文含义是： 条款
	 */
	private String jytk;

	
		/**
	 * @Description ajhyjlid的中文含义是： 案件合议记录ID
	 */
	public void setAjhyjlid(String ajhyjlid){ 
		this.ajhyjlid = ajhyjlid;
	}
	/**
	 * @Description ajhyjlid的中文含义是： 案件合议记录ID
	 */
	public String getAjhyjlid(){
		return ajhyjlid;
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
	 * @Description hysj的中文含义是： 合议时间
	 */
	public void setHysj(String hysj){ 
		this.hysj = hysj;
	}
	/**
	 * @Description hysj的中文含义是： 合议时间
	 */
	public String getHysj(){
		return hysj;
	}
	/**
	 * @Description hyzcr的中文含义是： 合议主持人
	 */
	public void setHyzcr(String hyzcr){ 
		this.hyzcr = hyzcr;
	}
	/**
	 * @Description hyzcr的中文含义是： 合议主持人
	 */
	public String getHyzcr(){
		return hyzcr;
	}
	/**
	 * @Description hydd的中文含义是： 合议地点
	 */
	public void setHydd(String hydd){ 
		this.hydd = hydd;
	}
	/**
	 * @Description hydd的中文含义是： 合议地点
	 */
	public String getHydd(){
		return hydd;
	}
	/**
	 * @Description hyry的中文含义是： 合议人员
	 */
	public void setHyry(String hyry){ 
		this.hyry = hyry;
	}
	/**
	 * @Description hyry的中文含义是： 合议人员
	 */
	public String getHyry(){
		return hyry;
	}
	/**
	 * @Description hyjlr的中文含义是： 记录人
	 */
	public void setHyjlr(String hyjlr){ 
		this.hyjlr = hyjlr;
	}
	/**
	 * @Description hyjlr的中文含义是： 记录人
	 */
	public String getHyjlr(){
		return hyjlr;
	}
	/**
	 * @Description hyaqjs的中文含义是： 案情介绍
	 */
	public void setHyaqjs(String hyaqjs){ 
		this.hyaqjs = hyaqjs;
	}
	/**
	 * @Description hyaqjs的中文含义是： 案情介绍
	 */
	public String getHyaqjs(){
		return hyaqjs;
	}
	/**
	 * @Description hytljl的中文含义是： 讨论记录
	 */
	public void setHytljl(String hytljl){ 
		this.hytljl = hytljl;
	}
	/**
	 * @Description hytljl的中文含义是： 讨论记录
	 */
	public String getHytljl(){
		return hytljl;
	}
	/**
	 * @Description hyyj的中文含义是： 合议意见
	 */
	public void setHyyj(String hyyj){ 
		this.hyyj = hyyj;
	}
	/**
	 * @Description hyyj的中文含义是： 合议意见
	 */
	public String getHyyj(){
		return hyyj;
	}
	/**
	 * @Description hyzcrqz的中文含义是： 主持人签字
	 */
	public void setHyzcrqz(String hyzcrqz){ 
		this.hyzcrqz = hyzcrqz;
	}
	/**
	 * @Description hyzcrqz的中文含义是： 主持人签字
	 */
	public String getHyzcrqz(){
		return hyzcrqz;
	}
	/**
	 * @Description hyjlrqz的中文含义是： 记录人签字
	 */
	public void setHyjlrqz(String hyjlrqz){ 
		this.hyjlrqz = hyjlrqz;
	}
	/**
	 * @Description hyjlrqz的中文含义是： 记录人签字
	 */
	public String getHyjlrqz(){
		return hyjlrqz;
	}
	/**
	 * @Description hyryqz的中文含义是： 合议人员签字
	 */
	public void setHyryqz(String hyryqz){ 
		this.hyryqz = hyryqz;
	}
	/**
	 * @Description hyryqz的中文含义是： 合议人员签字
	 */
	public String getHyryqz(){
		return hyryqz;
	}
	/**
	 * @Description ajdjay的中文含义是： 案由
	 */
	public void setAjdjay(String ajdjay){ 
		this.ajdjay = ajdjay;
	}
	/**
	 * @Description ajdjay的中文含义是： 案由
	 */
	public String getAjdjay(){
		return ajdjay;
	}
	/**
	 * @Description hydsr的中文含义是： 当事人
	 */
	public void setHydsr(String hydsr){ 
		this.hydsr = hydsr;
	}
	/**
	 * @Description hydsr的中文含义是： 当事人
	 */
	public String getHydsr(){
		return hydsr;
	}
	/**
	 * @Description hyzjcl的中文含义是： 证据材料
	 */
	public void setHyzjcl(String hyzjcl){ 
		this.hyzjcl = hyzjcl;
	}
	/**
	 * @Description hyzjcl的中文含义是： 证据材料
	 */
	public String getHyzjcl(){
		return hyzjcl;
	}
	/**
	 * @Description hywfxwdc的中文含义是： 违法行为等次
	 */
	public void setHywfxwdc(String hywfxwdc){ 
		this.hywfxwdc = hywfxwdc;
	}
	/**
	 * @Description hywfxwdc的中文含义是： 违法行为等次
	 */
	public String getHywfxwdc(){
		return hywfxwdc;
	}
	/**
	 * @Description jytk的中文含义是： 条款
	 */
	public void setJytk(String jytk){ 
		this.jytk = jytk;
	}
	/**
	 * @Description jytk的中文含义是： 条款
	 */
	public String getJytk(){
		return jytk;
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