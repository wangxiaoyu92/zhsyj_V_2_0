package com.askj.zfba.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFAJZFWSMB的中文含义是: 案件对应的执法文书模板; InnoDB free: 2760704 kBDTO
 * @Creation     2016/04/11 15:55:44
 * @Written      Create Tool By zjf 
 **/
public class ZfajzfwsmbDTO {
	/**
	 * 附页
	 */
	private String spypxzcfwsfyid;
	/**
	 * 行政处罚决定审批表
	 */
	private String xzcfjdspbid;
	
	/**
	 * 听证通知书
	 */
	private String tztzsid;
	/**
	 * 案件讨论记录
	 */
	private String ajjttljlid;
	/**
	 * 查封扣押延期决定书
	 */
	private String cfkyyqtzsid;
	/**
	 * 查封扣押决定书id
	 */
	private String cfkyjdsid;
	/**
	 * 询问调查表id
	 */
	private String xwdcblid;
	/**
	 * @Description laspid的中文含义是： 
	 */
	private String laspid;

	/**
	 * @Description zfwsmbid的中文含义是： 
	 */
	private String zfwsmbid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	private String ajdjid;

	/**
	 * @Description zfwsdmz的中文含义是： 执法文书编号，代码表中的编号
	 */
	private String zfwsdmz;

	/**
	 * @Description zfwsqtbid的中文含义是： 执法文书所在表ID
	 */
	private String zfwsqtbid;

	/**
	 * @Description zfwsmbmc的中文含义是： 执法文书模板名称
	 */
	private String zfwsmbmc;
	
	/**
	 * @Description zfwsmbczy的中文含义是： 操作员
	 */
	private String zfwsmbczy;	
	
	/**
	 * @Description zfwsmbczsj的中文含义是： 操作时间
	 */
	private String zfwsmbczsj;		
	
	/**
	 * @Description aaa027的中文含义是： 地区编码
	 */
	private String aaa027;		
	
	/**
	 * @Description userid的中文含义是： 操作员id，为了控制不是自动添加的模板不允许删除
	 */
	private String userid;	
	
	/**
	 * @Description aaa146的中文含义是： 行政区划名称
	 */
	private String aaa146;	
	
	
	/***********************以下是文书模板管理中要用到的字段************************************/
	//案件执法文书id 
	private String ajzfwsid;
	//附件参数代码名称
	private String fjcsdmmc;
	//附件参数标题
	private String fjcszfwstitle;
	//打开路径
	private String zfwsurl;
	//执法文书用户编号
	private String zfwsuserid;
	//执法文书操作员姓名
	private String zfwsczyxm;
	//执法文书操作时间
	private String zfwsczsj;
	
		/**
	 * @Description zfwsmbid的中文含义是： 
	 */
	public void setZfwsmbid(String zfwsmbid){ 
		this.zfwsmbid = zfwsmbid;
	}
	/**
	 * @Description zfwsmbid的中文含义是： 
	 */
	public String getZfwsmbid(){
		return zfwsmbid;
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
	 * @Description zfwsdmz的中文含义是： 执法文书编号，代码表中的编号
	 */
	public void setZfwsdmz(String zfwsdmz){ 
		this.zfwsdmz = zfwsdmz;
	}
	/**
	 * @Description zfwsdmz的中文含义是： 执法文书编号，代码表中的编号
	 */
	public String getZfwsdmz(){
		return zfwsdmz;
	}
	/**
	 * @Description zfwsqtbid的中文含义是： 执法文书所在表ID
	 */
	public void setZfwsqtbid(String zfwsqtbid){ 
		this.zfwsqtbid = zfwsqtbid;
	}
	/**
	 * @Description zfwsqtbid的中文含义是： 执法文书所在表ID
	 */
	public String getZfwsqtbid(){
		return zfwsqtbid;
	}
	/**
	 * @Description zfwsmbmc的中文含义是： 执法文书模板名称
	 */
	public void setZfwsmbmc(String zfwsmbmc){ 
		this.zfwsmbmc = zfwsmbmc;
	}
	/**
	 * @Description zfwsmbmc的中文含义是： 执法文书模板名称
	 */
	public String getZfwsmbmc(){
		return zfwsmbmc;
	}
	public String getZfwsmbczy() {
		return zfwsmbczy;
	}
	public void setZfwsmbczy(String zfwsmbczy) {
		this.zfwsmbczy = zfwsmbczy;
	}
	public String getZfwsmbczsj() {
		return zfwsmbczsj;
	}
	public void setZfwsmbczsj(String zfwsmbczsj) {
		this.zfwsmbczsj = zfwsmbczsj;
	}
	public String getAaa027() {
		return aaa027;
	}
	public void setAaa027(String aaa027) {
		this.aaa027 = aaa027;
	}
	public String getLaspid() {
		return laspid;
	}
	public void setLaspid(String laspid) {
		this.laspid = laspid;
	}
	public String getSpypxzcfwsfyid() {
		return spypxzcfwsfyid;
	}
	public void setSpypxzcfwsfyid(String spypxzcfwsfyid) {
		this.spypxzcfwsfyid = spypxzcfwsfyid;
	}
	public String getXzcfjdspbid() {
		return xzcfjdspbid;
	}
	public void setXzcfjdspbid(String xzcfjdspbid) {
		this.xzcfjdspbid = xzcfjdspbid;
	}
	public String getTztzsid() {
		return tztzsid;
	}
	public void setTztzsid(String tztzsid) {
		this.tztzsid = tztzsid;
	}
	public String getAjjttljlid() {
		return ajjttljlid;
	}
	public void setAjjttljlid(String ajjttljlid) {
		this.ajjttljlid = ajjttljlid;
	}
	public String getCfkyyqtzsid() {
		return cfkyyqtzsid;
	}
	public void setCfkyyqtzsid(String cfkyyqtzsid) {
		this.cfkyyqtzsid = cfkyyqtzsid;
	}
	public String getCfkyjdsid() {
		return cfkyjdsid;
	}
	public void setCfkyjdsid(String cfkyjdsid) {
		this.cfkyjdsid = cfkyjdsid;
	}
	public String getXwdcblid() {
		return xwdcblid;
	}
	public void setXwdcblid(String xwdcblid) {
		this.xwdcblid = xwdcblid;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getAaa146() {
		return aaa146;
	}
	public void setAaa146(String aaa146) {
		this.aaa146 = aaa146;
	}
	public String getAjzfwsid() {
		return ajzfwsid;
	}
	public void setAjzfwsid(String ajzfwsid) {
		this.ajzfwsid = ajzfwsid;
	}
	public String getFjcsdmmc() {
		return fjcsdmmc;
	}
	public void setFjcsdmmc(String fjcsdmmc) {
		this.fjcsdmmc = fjcsdmmc;
	}
	public String getFjcszfwstitle() {
		return fjcszfwstitle;
	}
	public void setFjcszfwstitle(String fjcszfwstitle) {
		this.fjcszfwstitle = fjcszfwstitle;
	}
	public String getZfwsurl() {
		return zfwsurl;
	}
	public void setZfwsurl(String zfwsurl) {
		this.zfwsurl = zfwsurl;
	}
	public String getZfwsuserid() {
		return zfwsuserid;
	}
	public void setZfwsuserid(String zfwsuserid) {
		this.zfwsuserid = zfwsuserid;
	}
	public String getZfwsczyxm() {
		return zfwsczyxm;
	}
	public void setZfwsczyxm(String zfwsczyxm) {
		this.zfwsczyxm = zfwsczyxm;
	}
	public String getZfwsczsj() {
		return zfwsczsj;
	}
	public void setZfwsczsj(String zfwsczsj) {
		this.zfwsczsj = zfwsczsj;
	}
	
}