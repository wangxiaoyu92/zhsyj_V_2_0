package com.askj.baseinfo.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  VIEWZFAJZFWS的中文含义是: VIEWDTO
 * @Creation     2016/02/22 11:54:08
 * @Written      Create Tool By zjf 
 **/
public class ViewzfajzfwsDTO {
	/**
	 * @Description fjcspx的中文含义是： 
	 */
	private String fjcspx;	
	
	/**
	 * @Description ajzfwsorderlist的中文含义是： 
	 */
	private String ajzfwsorderlist;	
	
	/**
	 * @Description ajzfwsid的中文含义是： 
	 */
	private String ajzfwsid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	private String ajdjid;

	/**
	 * @Description zfwsbh的中文含义是： 执法文书编号，代码表中的编号
	 */
	private String zfwsbh;

	/**
	 * @Description zfwsid的中文含义是： 执法文书所在表ID
	 */
	private String zfwsid;

	/**
	 * @Description zfwsycfjzs的中文含义是： 已传附件张数
	 */
	private Integer zfwsycfjzs;

	/**
	 * @Description zfwstzbz的中文含义是： 执法文书填写标志0未1已
	 */
	private String zfwstzbz;
	
	/**
	 * @Description fjcsid的中文含义是： 附件参数表ID
	 */
	private String fjcsid;

	/**
	 * @Description fjcsdmlb的中文含义是： 代码类别
	 */
	private String fjcsdmlb;

	/**
	 * @Description fjcsdmlbmc的中文含义是： 代码类别名称
	 */
	private String fjcsdmlbmc;

	/**
	 * @Description fjcsdmz的中文含义是： 代码值
	 */
	private String fjcsdmz;

	/**
	 * @Description fjcsdmmc的中文含义是： 代码名称
	 */
	private String fjcsdmmc;

	/**
	 * @Description fjcsksrq的中文含义是： 开始日期
	 */
	private String fjcsksrq;

	/**
	 * @Description fjcszzrq的中文含义是： 终止日期
	 */
	private String fjcszzrq;

	/**
	 * @Description fjcsqyflag的中文含义是： 启用标志1启用0未启用
	 */
	private String fjcsqyflag;
	/**
	 * @Description fjcsfjbc的中文含义是： 附件上传类型专用0不是必须传1必须传
	 */
	private String fjcsfjbc;

	private String userid;
	private String operatetype;//手机端或者电脑端 1电脑2手机

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getOperatetype() {
		return operatetype;
	}

	public void setOperatetype(String operatetype) {
		this.operatetype = operatetype;
	}

	/**
	 * @Description fjcsid的中文含义是： 附件参数表ID
	 */
	public void setFjcsid(String fjcsid){ 
		this.fjcsid = fjcsid;
	}
	/**
	 * @Description fjcsid的中文含义是： 附件参数表ID
	 */
	public String getFjcsid(){
		return fjcsid;
	}
	/**
	 * @Description fjcsdmlb的中文含义是： 代码类别
	 */
	public void setFjcsdmlb(String fjcsdmlb){ 
		this.fjcsdmlb = fjcsdmlb;
	}
	/**
	 * @Description fjcsdmlb的中文含义是： 代码类别
	 */
	public String getFjcsdmlb(){
		return fjcsdmlb;
	}
	/**
	 * @Description fjcsdmlbmc的中文含义是： 代码类别名称
	 */
	public void setFjcsdmlbmc(String fjcsdmlbmc){ 
		this.fjcsdmlbmc = fjcsdmlbmc;
	}
	/**
	 * @Description fjcsdmlbmc的中文含义是： 代码类别名称
	 */
	public String getFjcsdmlbmc(){
		return fjcsdmlbmc;
	}
	/**
	 * @Description fjcsdmz的中文含义是： 代码值
	 */
	public void setFjcsdmz(String fjcsdmz){ 
		this.fjcsdmz = fjcsdmz;
	}
	/**
	 * @Description fjcsdmz的中文含义是： 代码值
	 */
	public String getFjcsdmz(){
		return fjcsdmz;
	}
	/**
	 * @Description fjcsdmmc的中文含义是： 代码名称
	 */
	public void setFjcsdmmc(String fjcsdmmc){ 
		this.fjcsdmmc = fjcsdmmc;
	}
	/**
	 * @Description fjcsdmmc的中文含义是： 代码名称
	 */
	public String getFjcsdmmc(){
		return fjcsdmmc;
	}
	/**
	 * @Description fjcsksrq的中文含义是： 开始日期
	 */
	public void setFjcsksrq(String fjcsksrq){ 
		this.fjcsksrq = fjcsksrq;
	}
	/**
	 * @Description fjcsksrq的中文含义是： 开始日期
	 */
	public String getFjcsksrq(){
		return fjcsksrq;
	}
	/**
	 * @Description fjcszzrq的中文含义是： 终止日期
	 */
	public void setFjcszzrq(String fjcszzrq){ 
		this.fjcszzrq = fjcszzrq;
	}
	/**
	 * @Description fjcszzrq的中文含义是： 终止日期
	 */
	public String getFjcszzrq(){
		return fjcszzrq;
	}
	/**
	 * @Description fjcsqyflag的中文含义是： 启用标志1启用0未启用
	 */
	public void setFjcsqyflag(String fjcsqyflag){ 
		this.fjcsqyflag = fjcsqyflag;
	}
	/**
	 * @Description fjcsqyflag的中文含义是： 启用标志1启用0未启用
	 */
	public String getFjcsqyflag(){
		return fjcsqyflag;
	}
	/**
	 * @Description fjcsfjbc的中文含义是： 附件上传类型专用0不是必须传1必须传
	 */
	public void setFjcsfjbc(String fjcsfjbc){ 
		this.fjcsfjbc = fjcsfjbc;
	}
	/**
	 * @Description fjcsfjbc的中文含义是： 附件上传类型专用0不是必须传1必须传
	 */
	public String getFjcsfjbc(){
		return fjcsfjbc;
	}
	public String getAjzfwsid() {
		return ajzfwsid;
	}
	public void setAjzfwsid(String ajzfwsid) {
		this.ajzfwsid = ajzfwsid;
	}
	public String getAjdjid() {
		return ajdjid;
	}
	public void setAjdjid(String ajdjid) {
		this.ajdjid = ajdjid;
	}
	public String getZfwsbh() {
		return zfwsbh;
	}
	public void setZfwsbh(String zfwsbh) {
		this.zfwsbh = zfwsbh;
	}
	public String getZfwsid() {
		return zfwsid;
	}
	public void setZfwsid(String zfwsid) {
		this.zfwsid = zfwsid;
	}
	public Integer getZfwsycfjzs() {
		return zfwsycfjzs;
	}
	public void setZfwsycfjzs(Integer zfwsycfjzs) {
		this.zfwsycfjzs = zfwsycfjzs;
	}
	public String getZfwstzbz() {
		return zfwstzbz;
	}
	public void setZfwstzbz(String zfwstzbz) {
		this.zfwstzbz = zfwstzbz;
	}
	public String getAjzfwsorderlist() {
		return ajzfwsorderlist;
	}
	public void setAjzfwsorderlist(String ajzfwsorderlist) {
		this.ajzfwsorderlist = ajzfwsorderlist;
	}
	public String getFjcspx() {
		return fjcspx;
	}
	public void setFjcspx(String fjcspx) {
		this.fjcspx = fjcspx;
	}
	
	
	
}