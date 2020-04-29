package com.askj.zfba.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;

import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSCASPB21的中文含义是: 撤案审批表21; InnoDB free: 76800 kBDTO
 * @Creation     2016/03/17 09:12:10
 * @Written      Create Tool By zjf 
 **/
public class Zfwscaspb21DTO {

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
	
	private String caspbid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	
	private String ajdjid;

	/**
	 * @Description caspaqdczy的中文含义是： 案情调查摘要
	 */
	
	private String caspaqdczy;

	/**
	 * @Description caspcaly的中文含义是： 撤案理由
	 */
	
	private String caspcaly;

	/**
	 * @Description caspcbrqz的中文含义是： 承办人1
	 */
	
	private String caspcbrqz;

	/**
	 * @Description caspcbrqzrq的中文含义是： 承办人签字日期
	 */
	
	private String caspcbrqzrq;

	/**
	 * @Description caspcbbmfzr的中文含义是： 承办部门负责人签字
	 */
	
	private String caspcbbmfzr;

	/**
	 * @Description caspcbbmfzrrq的中文含义是： 承办部门负责人签字日期
	 */
	
	private String caspcbbmfzrrq;

	/**
	 * @Description caspshbmyj的中文含义是： 审核部门意见
	 */
	
	private String caspshbmyj;

	/**
	 * @Description caspshfzr的中文含义是： 审核部门负责人
	 */
	
	private String caspshfzr;

	/**
	 * @Description caspshfzrrq的中文含义是： 审核部门负责人签字日期
	 */
	
	private String caspshfzrrq;

	/**
	 * @Description caspspyj的中文含义是： 审批意见
	 */
	
	private String caspspyj;

	/**
	 * @Description caspfzfzr的中文含义是： 分管负责人
	 */
	
	private String caspfzfzr;

	/**
	 * @Description caspfzfzrrq的中文含义是： 分管负责人签字日期
	 */
	
	private String caspfzfzrrq;

	/**
	 * @Description ajdjay的中文含义是： 案件登记案由
	 */
	
	private String ajdjay;

	/**
	 * @Description caspdsr的中文含义是： 当事人
	 */
	
	private String caspdsr;

	/**
	 * @Description caspfddbr的中文含义是： 法定代表人(负责人)
	 */
	
	private String caspfddbr;

	/**
	 * @Description caspdz的中文含义是： 地址
	 */
	
	private String caspdz;

	/**
	 * @Description casplxfs的中文含义是： 联系方式
	 */
	
	private String casplxfs;

	/**
	 * @Description ajdjajly的中文含义是： 案件来源
	 */
	
	private String ajdjajly;
	/**
	 * @Description ajdjajlystr的中文含义是： 案件来源汉字版
	 */
	
	private String ajdjajlystr;

	/**
	 * @Description casplasj的中文含义是： 立案时间
	 */
	
	private String casplasj;

	/**
	 * @Description caspcbrqz2的中文含义是： 承办人签字2
	 */
	
	private String caspcbrqz2;

	
	public String getAjdjajlystr() {
		return ajdjajlystr;
	}

	public void setAjdjajlystr(String ajdjajlystr) {
		this.ajdjajlystr = ajdjajlystr;
	}

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

	public String getCaspbid() {
		return caspbid;
	}

	public void setCaspbid(String caspbid) {
		this.caspbid = caspbid;
	}

	public String getAjdjid() {
		return ajdjid;
	}

	public void setAjdjid(String ajdjid) {
		this.ajdjid = ajdjid;
	}

	public String getCaspaqdczy() {
		return caspaqdczy;
	}

	public void setCaspaqdczy(String caspaqdczy) {
		this.caspaqdczy = caspaqdczy;
	}

	public String getCaspcaly() {
		return caspcaly;
	}

	public void setCaspcaly(String caspcaly) {
		this.caspcaly = caspcaly;
	}

	public String getCaspcbrqz() {
		return caspcbrqz;
	}

	public void setCaspcbrqz(String caspcbrqz) {
		this.caspcbrqz = caspcbrqz;
	}

	public String getCaspcbrqzrq() {
		return caspcbrqzrq;
	}

	public void setCaspcbrqzrq(String caspcbrqzrq) {
		this.caspcbrqzrq = caspcbrqzrq;
	}

	public String getCaspcbbmfzr() {
		return caspcbbmfzr;
	}

	public void setCaspcbbmfzr(String caspcbbmfzr) {
		this.caspcbbmfzr = caspcbbmfzr;
	}

	public String getCaspcbbmfzrrq() {
		return caspcbbmfzrrq;
	}

	public void setCaspcbbmfzrrq(String caspcbbmfzrrq) {
		this.caspcbbmfzrrq = caspcbbmfzrrq;
	}

	public String getCaspshbmyj() {
		return caspshbmyj;
	}

	public void setCaspshbmyj(String caspshbmyj) {
		this.caspshbmyj = caspshbmyj;
	}

	public String getCaspshfzr() {
		return caspshfzr;
	}

	public void setCaspshfzr(String caspshfzr) {
		this.caspshfzr = caspshfzr;
	}

	public String getCaspshfzrrq() {
		return caspshfzrrq;
	}

	public void setCaspshfzrrq(String caspshfzrrq) {
		this.caspshfzrrq = caspshfzrrq;
	}

	public String getCaspspyj() {
		return caspspyj;
	}

	public void setCaspspyj(String caspspyj) {
		this.caspspyj = caspspyj;
	}

	public String getCaspfzfzr() {
		return caspfzfzr;
	}

	public void setCaspfzfzr(String caspfzfzr) {
		this.caspfzfzr = caspfzfzr;
	}

	public String getCaspfzfzrrq() {
		return caspfzfzrrq;
	}

	public void setCaspfzfzrrq(String caspfzfzrrq) {
		this.caspfzfzrrq = caspfzfzrrq;
	}

	public String getAjdjay() {
		return ajdjay;
	}

	public void setAjdjay(String ajdjay) {
		this.ajdjay = ajdjay;
	}

	public String getCaspdsr() {
		return caspdsr;
	}

	public void setCaspdsr(String caspdsr) {
		this.caspdsr = caspdsr;
	}

	public String getCaspfddbr() {
		return caspfddbr;
	}

	public void setCaspfddbr(String caspfddbr) {
		this.caspfddbr = caspfddbr;
	}

	public String getCaspdz() {
		return caspdz;
	}

	public void setCaspdz(String caspdz) {
		this.caspdz = caspdz;
	}

	public String getCasplxfs() {
		return casplxfs;
	}

	public void setCasplxfs(String casplxfs) {
		this.casplxfs = casplxfs;
	}

	public String getAjdjajly() {
		return ajdjajly;
	}

	public void setAjdjajly(String ajdjajly) {
		this.ajdjajly = ajdjajly;
	}

	public String getCasplasj() {
		return casplasj;
	}

	public void setCasplasj(String casplasj) {
		this.casplasj = casplasj;
	}

	public String getCaspcbrqz2() {
		return caspcbrqz2;
	}

	public void setCaspcbrqz2(String caspcbrqz2) {
		this.caspcbrqz2 = caspcbrqz2;
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