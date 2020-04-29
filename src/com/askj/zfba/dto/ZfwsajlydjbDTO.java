package com.askj.zfba.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;

import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSAJLYDJB的中文含义是: 执法文书案件来源登记表; InnoDB free: 10240 kBDTO
 * @Creation     2016/02/24 11:37:59
 * @Written      Create Tool By zjf 
 **/
public class ZfwsajlydjbDTO {
	/**
	 * 手机或是电脑
	 */
	private String sjordn;		
	/**
	 * 
	 */
	private String userid;	
	/**
	 * @Description zfwsqtbid的中文含义是： 执法文书其他表ID
	 */
	private String zfwsqtbid;
	
	/**
	 * @Description zfwsdmz的中文含义是： 执法文书代码值
	 */
	private String zfwsdmz;
	/**
	 * @Description ajdjajlystr的中文含义是：案件登记来源对应的汉字
	 */
	
	private String ajdjajlystr;	
	/**
	 * @Description ajzfwsid的中文含义是： 案件执法文书ID
	 */
	private String ajzfwsid;	
	
	
	
	/**
	 * @Description zfwslydjid的中文含义是： 
	 */
	private String zfwslydjid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	private String ajdjid;

	/**
	 * @Description ajlyfzr的中文含义是： 负责人
	 */
	private String ajlyfzr;

	/**
	 * @Description ajlyfzrqzsj的中文含义是： 负责人签字时间
	 */
	private String ajlyfzrqzsj;

	/**
	 * @Description ajlywsbh的中文含义是： 文书编号
	 */
	@Column
	private String ajlywsbh;

	/**
	 * @Description ajdjajly的中文含义是： 案件来源
	 */
	private String ajdjajly;

	/**
	 * @Description ajlydsr的中文含义是： 当事人
	 */
	private String ajlydsr;

	/**
	 * @Description ajlydz的中文含义是： 地址
	 */
	private String ajlydz;

	/**
	 * @Description ajlyyb的中文含义是： 邮编
	 */
	private String ajlyyb;

	/**
	 * @Description ajlyfddbr的中文含义是： 法定代表人（负责人）自然人
	 */
	private String ajlyfddbr;

	/**
	 * @Description ajlylxdh的中文含义是： 联系电话
	 */
	private String ajlylxdh;

	/**
	 * @Description ajlyfddbrsfzh的中文含义是： 法定代表人（负责人）自然人身份证号码
	 */
	private String ajlyfddbrsfzh;

	/**
	 * @Description ajlydjsj的中文含义是： 登记时间
	 */
	private String ajlydjsj;

	/**
	 * @Description ajlyjbqkjs的中文含义是： 基本情况介绍
	 */
	private String ajlyjbqkjs;

	/**
	 * @Description ajlyfj的中文含义是： 附件
	 */
	private String ajlyfj;

	/**
	 * @Description ajlyjlrqz的中文含义是： 记录人签字
	 */
	private String ajlyjlrqz;

	/**
	 * @Description ajlyjlrqzrq的中文含义是： 记录人签字日期
	 */
	private String ajlyjlrqzrq;

	/**
	 * @Description ajlyclyj的中文含义是： 处理意见
	 */
	private String ajlyclyj;

	public String getZfwsdmz() {
		return zfwsdmz;
	}

	public void setZfwsdmz(String zfwsdmz) {
		this.zfwsdmz = zfwsdmz;
	}

	public String getAjdjajlystr() {
		return ajdjajlystr;
	}

	public void setAjdjajlystr(String ajdjajlystr) {
		this.ajdjajlystr = ajdjajlystr;
	}

	public String getZfwslydjid() {
		return zfwslydjid;
	}

	public void setZfwslydjid(String zfwslydjid) {
		this.zfwslydjid = zfwslydjid;
	}

	public String getAjdjid() {
		return ajdjid;
	}

	public void setAjdjid(String ajdjid) {
		this.ajdjid = ajdjid;
	}

	public String getAjlyfzr() {
		return ajlyfzr;
	}

	public void setAjlyfzr(String ajlyfzr) {
		this.ajlyfzr = ajlyfzr;
	}

	public String getAjlyfzrqzsj() {
		return ajlyfzrqzsj;
	}

	public void setAjlyfzrqzsj(String ajlyfzrqzsj) {
		this.ajlyfzrqzsj = ajlyfzrqzsj;
	}

	public String getAjlywsbh() {
		return ajlywsbh;
	}

	public void setAjlywsbh(String ajlywsbh) {
		this.ajlywsbh = ajlywsbh;
	}

	public String getAjdjajly() {
		return ajdjajly;
	}

	public void setAjdjajly(String ajdjajly) {
		this.ajdjajly = ajdjajly;
	}

	public String getAjlydsr() {
		return ajlydsr;
	}

	public void setAjlydsr(String ajlydsr) {
		this.ajlydsr = ajlydsr;
	}

	public String getAjlydz() {
		return ajlydz;
	}

	public void setAjlydz(String ajlydz) {
		this.ajlydz = ajlydz;
	}

	public String getAjlyyb() {
		return ajlyyb;
	}

	public void setAjlyyb(String ajlyyb) {
		this.ajlyyb = ajlyyb;
	}

	public String getAjlyfddbr() {
		return ajlyfddbr;
	}

	public void setAjlyfddbr(String ajlyfddbr) {
		this.ajlyfddbr = ajlyfddbr;
	}

	public String getAjlylxdh() {
		return ajlylxdh;
	}

	public void setAjlylxdh(String ajlylxdh) {
		this.ajlylxdh = ajlylxdh;
	}

	public String getAjlyfddbrsfzh() {
		return ajlyfddbrsfzh;
	}

	public void setAjlyfddbrsfzh(String ajlyfddbrsfzh) {
		this.ajlyfddbrsfzh = ajlyfddbrsfzh;
	}

	public String getAjlydjsj() {
		return ajlydjsj;
	}

	public void setAjlydjsj(String ajlydjsj) {
		this.ajlydjsj = ajlydjsj;
	}

	public String getAjlyjbqkjs() {
		return ajlyjbqkjs;
	}

	public void setAjlyjbqkjs(String ajlyjbqkjs) {
		this.ajlyjbqkjs = ajlyjbqkjs;
	}

	public String getAjlyfj() {
		return ajlyfj;
	}

	public void setAjlyfj(String ajlyfj) {
		this.ajlyfj = ajlyfj;
	}

	public String getAjlyjlrqz() {
		return ajlyjlrqz;
	}

	public void setAjlyjlrqz(String ajlyjlrqz) {
		this.ajlyjlrqz = ajlyjlrqz;
	}

	public String getAjlyjlrqzrq() {
		return ajlyjlrqzrq;
	}

	public void setAjlyjlrqzrq(String ajlyjlrqzrq) {
		this.ajlyjlrqzrq = ajlyjlrqzrq;
	}

	public String getAjlyclyj() {
		return ajlyclyj;
	}

	public void setAjlyclyj(String ajlyclyj) {
		this.ajlyclyj = ajlyclyj;
	}

	public String getAjzfwsid() {
		return ajzfwsid;
	}

	public void setAjzfwsid(String ajzfwsid) {
		this.ajzfwsid = ajzfwsid;
	}

	public String getZfwsqtbid() {
		return zfwsqtbid;
	}

	public void setZfwsqtbid(String zfwsqtbid) {
		this.zfwsqtbid = zfwsqtbid;
	}

	public String getSjordn() {
		return sjordn;
	}

	public String getUserid() {
		return userid;
	}

	public void setSjordn(String sjordn) {
		this.sjordn = sjordn;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	
	
}