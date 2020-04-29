package com.askj.zfba.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;

import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSCSSBFHYJS35的中文含义是: 陈述申辩复核意见书; InnoDB free: 76800 kBDTO
 * @Creation     2016/03/19 10:49:42
 * @Written      Create Tool By zjf 
 **/
public class Zfwscssbfhyjs35DTO {

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
	
	private String cssbfhyjsid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	
	private String ajdjid;

	/**
	 * @Description sbfhncfyj的中文含义是： 拟处罚意见
	 */
	
	private String sbfhncfyj;

	/**
	 * @Description sbfhcssbjbqk的中文含义是： 陈述申辩基本情况
	 */
	
	private String sbfhcssbjbqk;

	/**
	 * @Description sbfhbmyj的中文含义是： 复核部门意见
	 */
	
	private String sbfhbmyj;

	/**
	 * @Description sbfhfzrqz的中文含义是： 负责人签字
	 */
	
	private String sbfhfzrqz;

	/**
	 * @Description sbfhfzrqzrq的中文含义是： 负责人签字日期
	 */
	
	private String sbfhfzrqzrq;

	/**
	 * @Description ajdjay的中文含义是： 案由
	 */
	
	private String ajdjay;

	/**
	 * @Description sbfhdsr的中文含义是： 当事人
	 */
	
	private String sbfhdsr;

	/**
	 * @Description sbfhfddbr的中文含义是： 法定代表人（负责人）
	 */
	
	private String sbfhfddbr;

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

	public String getCssbfhyjsid() {
		return cssbfhyjsid;
	}

	public void setCssbfhyjsid(String cssbfhyjsid) {
		this.cssbfhyjsid = cssbfhyjsid;
	}

	public String getAjdjid() {
		return ajdjid;
	}

	public void setAjdjid(String ajdjid) {
		this.ajdjid = ajdjid;
	}

	public String getSbfhncfyj() {
		return sbfhncfyj;
	}

	public void setSbfhncfyj(String sbfhncfyj) {
		this.sbfhncfyj = sbfhncfyj;
	}

	public String getSbfhcssbjbqk() {
		return sbfhcssbjbqk;
	}

	public void setSbfhcssbjbqk(String sbfhcssbjbqk) {
		this.sbfhcssbjbqk = sbfhcssbjbqk;
	}

	public String getSbfhbmyj() {
		return sbfhbmyj;
	}

	public void setSbfhbmyj(String sbfhbmyj) {
		this.sbfhbmyj = sbfhbmyj;
	}

	public String getSbfhfzrqz() {
		return sbfhfzrqz;
	}

	public void setSbfhfzrqz(String sbfhfzrqz) {
		this.sbfhfzrqz = sbfhfzrqz;
	}

	public String getSbfhfzrqzrq() {
		return sbfhfzrqzrq;
	}

	public void setSbfhfzrqzrq(String sbfhfzrqzrq) {
		this.sbfhfzrqzrq = sbfhfzrqzrq;
	}

	public String getAjdjay() {
		return ajdjay;
	}

	public void setAjdjay(String ajdjay) {
		this.ajdjay = ajdjay;
	}

	public String getSbfhdsr() {
		return sbfhdsr;
	}

	public void setSbfhdsr(String sbfhdsr) {
		this.sbfhdsr = sbfhdsr;
	}

	public String getSbfhfddbr() {
		return sbfhfddbr;
	}

	public void setSbfhfddbr(String sbfhfddbr) {
		this.sbfhfddbr = sbfhfddbr;
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