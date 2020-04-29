package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*; 

/**
 * @Description  ZFWSXZCFJDSPB27的中文含义是: 行政处罚决定审批表; InnoDB free: 2726912 kB
 * @Creation     2016/06/12 17:40:21
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSXZCFJDSPB27")
public class Zfwsxzcfjdspb27 {
	/**
	 * @Description xzcfjdspbid的中文含义是： 行政处罚决定审批表ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_xzcfjdspbid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_xzcfjdspbid.nextval from dual"))
	private String xzcfjdspbid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description cfspwfss的中文含义是： 主要违法事实
	 */
	@Column
	private String cfspwfss;

	/**
	 * @Description cfspcfjd的中文含义是： 处罚决定
	 */
	@Column
	private String cfspcfjd;

	/**
	 * @Description cfspfj的中文含义是： 附件
	 */
	@Column
	private String cfspfj;

	/**
	 * @Description cfspcbrqz的中文含义是： 承办人签字1
	 */
	@Column
	private String cfspcbrqz;

	/**
	 * @Description cfspcbrqzrq的中文含义是： 承办人签字日期
	 */
	@Column
	private String cfspcbrqzrq;

	/**
	 * @Description cfspcbfzrqzrq的中文含义是： 承办部门负责人签字
	 */
	@Column
	private String cfspcbfzrqzrq;

	/**
	 * @Description cfspshbmyj的中文含义是： 审核部门意见
	 */
	@Column
	private String cfspshbmyj;

	/**
	 * @Description cfspshbmfzr的中文含义是： 审核部门负责人
	 */
	@Column
	private String cfspshbmfzr;

	/**
	 * @Description cfspshbmfzrrq的中文含义是： 审核部门负责人签字日期
	 */
	@Column
	private String cfspshbmfzrrq;

	/**
	 * @Description cfspspyj的中文含义是： 审批意见
	 */
	@Column
	private String cfspspyj;

	/**
	 * @Description cfspspyjfzr的中文含义是： 审批意见负责人
	 */
	@Column
	private String cfspspyjfzr;

	/**
	 * @Description cfspspyjfzrrq的中文含义是： 审批意见负责人签字日期
	 */
	@Column
	private String cfspspyjfzrrq;

	/**
	 * @Description cfspcbbmfzr的中文含义是： 承办部门负责人
	 */
	@Column
	private String cfspcbbmfzr;

	/**
	 * @Description ajdjay的中文含义是： 案由
	 */
	@Column
	private String ajdjay;

	/**
	 * @Description cfspdsr的中文含义是： 当事人
	 */
	@Column
	private String cfspdsr;

	/**
	 * @Description cfspcbrqz2的中文含义是： 承办人签字2
	 */
	@Column
	private String cfspcbrqz2;
	
	/**
	 * @Description cssbjtzqk的中文含义是： 陈述申辩及听证情况
	 */
	@Column
	private String cssbjtzqk;
	
	/**
	 * @Description dsrcssbqk的中文含义是： 事人陈述申辩或听证意见复核及采纳情况
	 */
	@Column
	private String dsrcssbqk;
	
	/**
	 * @Description cbbmscyj的中文含义是： 承办部门审查意见
	 */
	@Column
	private String cbbmscyj;
 
	/**
	 * @Description xzcfjdspbid的中文含义是： 行政处罚决定审批表ID
	 */
	public void setXzcfjdspbid(String xzcfjdspbid){ 
		this.xzcfjdspbid = xzcfjdspbid;
	}
	/**
	 * @Description xzcfjdspbid的中文含义是： 行政处罚决定审批表ID
	 */
	public String getXzcfjdspbid(){
		return xzcfjdspbid;
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
	 * @Description cfspwfss的中文含义是： 主要违法事实
	 */
	public void setCfspwfss(String cfspwfss){ 
		this.cfspwfss = cfspwfss;
	}
	/**
	 * @Description cfspwfss的中文含义是： 主要违法事实
	 */
	public String getCfspwfss(){
		return cfspwfss;
	}
	/**
	 * @Description cfspcfjd的中文含义是： 处罚决定
	 */
	public void setCfspcfjd(String cfspcfjd){ 
		this.cfspcfjd = cfspcfjd;
	}
	/**
	 * @Description cfspcfjd的中文含义是： 处罚决定
	 */
	public String getCfspcfjd(){
		return cfspcfjd;
	}
	/**
	 * @Description cfspfj的中文含义是： 附件
	 */
	public void setCfspfj(String cfspfj){ 
		this.cfspfj = cfspfj;
	}
	/**
	 * @Description cfspfj的中文含义是： 附件
	 */
	public String getCfspfj(){
		return cfspfj;
	}
	/**
	 * @Description cfspcbrqz的中文含义是： 承办人签字1
	 */
	public void setCfspcbrqz(String cfspcbrqz){ 
		this.cfspcbrqz = cfspcbrqz;
	}
	/**
	 * @Description cfspcbrqz的中文含义是： 承办人签字1
	 */
	public String getCfspcbrqz(){
		return cfspcbrqz;
	}
	/**
	 * @Description cfspcbrqzrq的中文含义是： 承办人签字日期
	 */
	public void setCfspcbrqzrq(String cfspcbrqzrq){ 
		this.cfspcbrqzrq = cfspcbrqzrq;
	}
	/**
	 * @Description cfspcbrqzrq的中文含义是： 承办人签字日期
	 */
	public String getCfspcbrqzrq(){
		return cfspcbrqzrq;
	}
	/**
	 * @Description cfspcbfzrqzrq的中文含义是： 承办部门负责人签字
	 */
	public void setCfspcbfzrqzrq(String cfspcbfzrqzrq){ 
		this.cfspcbfzrqzrq = cfspcbfzrqzrq;
	}
	/**
	 * @Description cfspcbfzrqzrq的中文含义是： 承办部门负责人签字
	 */
	public String getCfspcbfzrqzrq(){
		return cfspcbfzrqzrq;
	}
	/**
	 * @Description cfspshbmyj的中文含义是： 审核部门意见
	 */
	public void setCfspshbmyj(String cfspshbmyj){ 
		this.cfspshbmyj = cfspshbmyj;
	}
	/**
	 * @Description cfspshbmyj的中文含义是： 审核部门意见
	 */
	public String getCfspshbmyj(){
		return cfspshbmyj;
	}
	/**
	 * @Description cfspshbmfzr的中文含义是： 审核部门负责人
	 */
	public void setCfspshbmfzr(String cfspshbmfzr){ 
		this.cfspshbmfzr = cfspshbmfzr;
	}
	/**
	 * @Description cfspshbmfzr的中文含义是： 审核部门负责人
	 */
	public String getCfspshbmfzr(){
		return cfspshbmfzr;
	}
	/**
	 * @Description cfspshbmfzrrq的中文含义是： 审核部门负责人签字日期
	 */
	public void setCfspshbmfzrrq(String cfspshbmfzrrq){ 
		this.cfspshbmfzrrq = cfspshbmfzrrq;
	}
	/**
	 * @Description cfspshbmfzrrq的中文含义是： 审核部门负责人签字日期
	 */
	public String getCfspshbmfzrrq(){
		return cfspshbmfzrrq;
	}
	/**
	 * @Description cfspspyj的中文含义是： 审批意见
	 */
	public void setCfspspyj(String cfspspyj){ 
		this.cfspspyj = cfspspyj;
	}
	/**
	 * @Description cfspspyj的中文含义是： 审批意见
	 */
	public String getCfspspyj(){
		return cfspspyj;
	}
	/**
	 * @Description cfspspyjfzr的中文含义是： 审批意见负责人
	 */
	public void setCfspspyjfzr(String cfspspyjfzr){ 
		this.cfspspyjfzr = cfspspyjfzr;
	}
	/**
	 * @Description cfspspyjfzr的中文含义是： 审批意见负责人
	 */
	public String getCfspspyjfzr(){
		return cfspspyjfzr;
	}
	/**
	 * @Description cfspspyjfzrrq的中文含义是： 审批意见负责人签字日期
	 */
	public void setCfspspyjfzrrq(String cfspspyjfzrrq){ 
		this.cfspspyjfzrrq = cfspspyjfzrrq;
	}
	/**
	 * @Description cfspspyjfzrrq的中文含义是： 审批意见负责人签字日期
	 */
	public String getCfspspyjfzrrq(){
		return cfspspyjfzrrq;
	}
	/**
	 * @Description cfspcbbmfzr的中文含义是： 承办部门负责人
	 */
	public void setCfspcbbmfzr(String cfspcbbmfzr){ 
		this.cfspcbbmfzr = cfspcbbmfzr;
	}
	/**
	 * @Description cfspcbbmfzr的中文含义是： 承办部门负责人
	 */
	public String getCfspcbbmfzr(){
		return cfspcbbmfzr;
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
	 * @Description cfspdsr的中文含义是： 当事人
	 */
	public void setCfspdsr(String cfspdsr){ 
		this.cfspdsr = cfspdsr;
	}
	/**
	 * @Description cfspdsr的中文含义是： 当事人
	 */
	public String getCfspdsr(){
		return cfspdsr;
	}
	/**
	 * @Description cfspcbrqz2的中文含义是： 承办人签字2
	 */
	public void setCfspcbrqz2(String cfspcbrqz2){ 
		this.cfspcbrqz2 = cfspcbrqz2;
	}
	/**
	 * @Description cfspcbrqz2的中文含义是： 承办人签字2
	 */
	public String getCfspcbrqz2(){
		return cfspcbrqz2;
	 
	}
	/**
	 * @Description cssbjtzqk的中文含义是： 陈述申辩及听证情况
	 */
	public String getCssbjtzqk() {
		return cssbjtzqk;
	}

	/**
	 * @Description cssbjtzqk的中文含义是： 陈述申辩及听证情况
	 */
	public void setCssbjtzqk(String cssbjtzqk) {
		this.cssbjtzqk = cssbjtzqk;
	}

	/**
	 * @Description dsrcssbqk的中文含义是： 事人陈述申辩或听证意见复核及采纳情况
	 */
	public String getDsrcssbqk() {
		return dsrcssbqk;
	}

	/**
	 * @Description dsrcssbqk的中文含义是： 事人陈述申辩或听证意见复核及采纳情况
	 */
	public void setDsrcssbqk(String dsrcssbqk) {
		this.dsrcssbqk = dsrcssbqk;
	}

	/**
	 * @Description cbbmscyj的中文含义是： 承办部门审查意见
	 */
	public String getCbbmscyj() {
		return cbbmscyj;
	}

	/**
	 * @Description cbbmscyj的中文含义是： 承办部门审查意见
	 */
	public void setCbbmscyj(String cbbmscyj) {
		this.cbbmscyj = cbbmscyj;
	}

	
}