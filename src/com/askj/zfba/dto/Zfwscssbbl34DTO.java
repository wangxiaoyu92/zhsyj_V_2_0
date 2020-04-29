package com.askj.zfba.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;

import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSCSSBBL34的中文含义是: 陈述申辩笔录; InnoDB free: 76800 kBDTO
 * @Creation     2016/03/19 10:32:55
 * @Written      Create Tool By wanghao 
 **/
public class Zfwscssbbl34DTO {

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
	
	/**
	 * @Description zfwsqtbid的中文含义是：执法文书所在表ID
	 */
	private String zfwsqtbid;
	
	private String cssbblid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	
	private String ajdjid;

	/**
	 * @Description cssbr的中文含义是： 陈述申辩人
	 */
	
	private String cssbr;

	/**
	 * @Description cssbrlxfs的中文含义是： 陈述申辩人联系方式
	 */
	
	private String cssbrlxfs;

	/**
	 * @Description cssbwtdlr的中文含义是： 委托代理人
	 */
	
	private String cssbwtdlr;

	/**
	 * @Description cssbwtdlrzw的中文含义是： 委托代理人职务
	 */
	
	private String cssbwtdlrzw;

	/**
	 * @Description cssbwtdlrsfzh的中文含义是： 身份证号
	 */
	
	private String cssbwtdlrsfzh;

	/**
	 * @Description cssbcbr的中文含义是： 承办人
	 */
	
	private String cssbcbr;

	/**
	 * @Description cssbjlr的中文含义是： 记录人
	 */
	
	private String cssbjlr;

	/**
	 * @Description cssbdd的中文含义是： 陈述申辩地点
	 */
	
	private String cssbdd;

	/**
	 * @Description cssbsj的中文含义是： 陈述申辩时间
	 */
	
	private String cssbsj;

	/**
	 * @Description cssbjzsj的中文含义是： 陈述申辩截止日期
	 */
	
	private String cssbjzsj;

	/**
	 * @Description cssbnr的中文含义是： 陈述申辩内容
	 */
	
	private String cssbnr;

	/**
	 * @Description cssbrqz的中文含义是： 陈述申辩人签字
	 */
	
	private String cssbrqz;

	/**
	 * @Description cssbrqzrq的中文含义是： 陈述申辩人签字日期
	 */
	
	private String cssbrqzrq;

	/**
	 * @Description cssbcbrqz的中文含义是： 承办人签字1
	 */
	
	private String cssbcbrqz;

	/**
	 * @Description cssbcbrqzrq的中文含义是： 承办人签字日期
	 */
	
	private String cssbcbrqzrq;

	/**
	 * @Description cssbjlrqz的中文含义是： 记录人签字
	 */
	
	private String cssbjlrqz;

	/**
	 * @Description cssbjlrqzrq的中文含义是： 记录人签字日期
	 */
	
	private String cssbjlrqzrq;

	/**
	 * @Description ajdjay的中文含义是： 案由
	 */
	
	private String ajdjay;

	/**
	 * @Description cssbdsr的中文含义是： 当事人
	 */
	
	private String cssbdsr;

	/**
	 * @Description cssbcbrqz2的中文含义是： 承办人签字2
	 */
	
	private String cssbcbrqz2;

	public String getZfwsdmz() {
		return zfwsdmz;
	}

	public void setZfwsdmz(String zfwsdmz) {
		this.zfwsdmz = zfwsdmz;
	}

	public String getZfwsqtbid() {
		return zfwsqtbid;
	}

	public void setZfwsqtbid(String zfwsqtbid) {
		this.zfwsqtbid = zfwsqtbid;
	}

	public String getCssbblid() {
		return cssbblid;
	}

	public void setCssbblid(String cssbblid) {
		this.cssbblid = cssbblid;
	}

	public String getAjdjid() {
		return ajdjid;
	}

	public void setAjdjid(String ajdjid) {
		this.ajdjid = ajdjid;
	}

	public String getCssbr() {
		return cssbr;
	}

	public void setCssbr(String cssbr) {
		this.cssbr = cssbr;
	}

	public String getCssbrlxfs() {
		return cssbrlxfs;
	}

	public void setCssbrlxfs(String cssbrlxfs) {
		this.cssbrlxfs = cssbrlxfs;
	}

	public String getCssbwtdlr() {
		return cssbwtdlr;
	}

	public void setCssbwtdlr(String cssbwtdlr) {
		this.cssbwtdlr = cssbwtdlr;
	}

	public String getCssbwtdlrzw() {
		return cssbwtdlrzw;
	}

	public void setCssbwtdlrzw(String cssbwtdlrzw) {
		this.cssbwtdlrzw = cssbwtdlrzw;
	}

	public String getCssbwtdlrsfzh() {
		return cssbwtdlrsfzh;
	}

	public void setCssbwtdlrsfzh(String cssbwtdlrsfzh) {
		this.cssbwtdlrsfzh = cssbwtdlrsfzh;
	}

	public String getCssbcbr() {
		return cssbcbr;
	}

	public void setCssbcbr(String cssbcbr) {
		this.cssbcbr = cssbcbr;
	}

	public String getCssbjlr() {
		return cssbjlr;
	}

	public void setCssbjlr(String cssbjlr) {
		this.cssbjlr = cssbjlr;
	}

	public String getCssbdd() {
		return cssbdd;
	}

	public void setCssbdd(String cssbdd) {
		this.cssbdd = cssbdd;
	}

	public String getCssbsj() {
		return cssbsj;
	}

	public void setCssbsj(String cssbsj) {
		this.cssbsj = cssbsj;
	}

	public String getCssbjzsj() {
		return cssbjzsj;
	}

	public void setCssbjzsj(String cssbjzsj) {
		this.cssbjzsj = cssbjzsj;
	}

	public String getCssbnr() {
		return cssbnr;
	}

	public void setCssbnr(String cssbnr) {
		this.cssbnr = cssbnr;
	}

	public String getCssbrqz() {
		return cssbrqz;
	}

	public void setCssbrqz(String cssbrqz) {
		this.cssbrqz = cssbrqz;
	}

	public String getCssbrqzrq() {
		return cssbrqzrq;
	}

	public void setCssbrqzrq(String cssbrqzrq) {
		this.cssbrqzrq = cssbrqzrq;
	}

	public String getCssbcbrqz() {
		return cssbcbrqz;
	}

	public void setCssbcbrqz(String cssbcbrqz) {
		this.cssbcbrqz = cssbcbrqz;
	}

	public String getCssbcbrqzrq() {
		return cssbcbrqzrq;
	}

	public void setCssbcbrqzrq(String cssbcbrqzrq) {
		this.cssbcbrqzrq = cssbcbrqzrq;
	}

	public String getCssbjlrqz() {
		return cssbjlrqz;
	}

	public void setCssbjlrqz(String cssbjlrqz) {
		this.cssbjlrqz = cssbjlrqz;
	}

	public String getCssbjlrqzrq() {
		return cssbjlrqzrq;
	}

	public void setCssbjlrqzrq(String cssbjlrqzrq) {
		this.cssbjlrqzrq = cssbjlrqzrq;
	}

	public String getAjdjay() {
		return ajdjay;
	}

	public void setAjdjay(String ajdjay) {
		this.ajdjay = ajdjay;
	}

	public String getCssbdsr() {
		return cssbdsr;
	}

	public void setCssbdsr(String cssbdsr) {
		this.cssbdsr = cssbdsr;
	}

	public String getCssbcbrqz2() {
		return cssbcbrqz2;
	}

	public void setCssbcbrqz2(String cssbcbrqz2) {
		this.cssbcbrqz2 = cssbcbrqz2;
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