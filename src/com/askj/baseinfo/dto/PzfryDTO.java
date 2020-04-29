package com.askj.baseinfo.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;

import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  PZFRY的中文含义是: 执法人员表; InnoDB free: 76800 kB
 * @Creation     2016/03/18 10:07:08
 * @Written      Create Tool By zjf 
 **/
 
public class PzfryDTO {
	//扩展开始
	/**
	 * @Description zfryzppath的中文含义是： 执法人员照片路径
	 */
	private String zfryzppath;	
	/**
	 * @Description zfryzpname的中文含义是： 执法人员照片名称
	 */
	private String zfryzpname;	
	
	//扩展结束
	/**
	 * @Description zfrylybm的中文含义是： 执法人员领域编码
	 */
	private String zfrylybm;		
	
	/**
	 * @Description zfryzflybmComBo的中文含义是： 执法人员执法领域下拉选项
	 */
	private String zfryzflybmComBo;	
	
	/**
	 * @Description zfryid的中文含义是： 执法人员ID
	 */
	private String zfryid;

	/**
	 * @Description zfrypym的中文含义是： 执法人员姓名拼音缩写
	 */
	
	private String zfrypym;

	/**
	 * @Description zfryxb的中文含义是： 执法人员性别
	 */
	
	private String zfryxb;

	/**
	 * @Description zfrycsrq的中文含义是： 执法人员出生日期
	 */
	
	private String zfrycsrq;

	/**
	 * @Description zfrysfzh的中文含义是： 执法人员身份证号
	 */
	
	private String zfrysfzh;

	/**
	 * @Description zfryzjhm的中文含义是： 执法人员证件号码
	 */
	
	private String zfryzjhm;

	/**
	 * @Description zfryzflyid的中文含义是： 执法人员执法领域对应pzfryzfly表id
	 */
	
	private String zfryzflyid;

	/**
	 * @Description zfrybz的中文含义是： 备注
	 */
	
	private String zfrybz;

	/**
	 * @Description zfryczy的中文含义是： 操作员
	 */
	
	private String zfryczy;

	/**
	 * @Description zfryczsj的中文含义是： 操作时间
	 */
	
	private String zfryczsj;

	/**
	 * @Description zfryzw的中文含义是： 执法人员职务
	 */
	
	private String zfryzw;
	
	/**
	 * @Description zfryzw的中文含义是： 执法人员执法领域编码
	 */
	private String zfryzflybm;
	
	/**
	 * @Description zfryzw的中文含义是： 执法人员执法领域名称
	 */
	private String zfryzflymc;	
	
	/**
	 * @Description mobile2的中文含义是： 执法人员移动电话2
	 */
	private String mobile2;		
	
	/**
	 * @Description telephone的中文含义是： 固定电话
	 */
	private String telephone;		

/////////////////////////////////////////////////////////
	
	
	private String orgname;
	private String aaa027;
	private String mobile;
	private String description;
	private String username;
	private String userid;
	 
	public String getOrgname() {
		return orgname;
	}
	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}
	public String getAaa027() {
		return aaa027;
	}
	public void setAaa027(String aaa027) {
		this.aaa027 = aaa027;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
		/**
	 * @Description zfryid的中文含义是： 执法人员ID
	 */
	public void setZfryid(String zfryid){ 
		this.zfryid = zfryid;
	}
	/**
	 * @Description zfryid的中文含义是： 执法人员ID
	 */
	public String getZfryid(){
		return zfryid;
	}
	/**
	 * @Description zfrypym的中文含义是： 执法人员姓名拼音缩写
	 */
	public void setZfrypym(String zfrypym){ 
		this.zfrypym = zfrypym;
	}
	/**
	 * @Description zfrypym的中文含义是： 执法人员姓名拼音缩写
	 */
	public String getZfrypym(){
		return zfrypym;
	}
	/**
	 * @Description zfryxb的中文含义是： 执法人员性别
	 */
	public void setZfryxb(String zfryxb){ 
		this.zfryxb = zfryxb;
	}
	/**
	 * @Description zfryxb的中文含义是： 执法人员性别
	 */
	public String getZfryxb(){
		return zfryxb;
	}
	/**
	 * @Description zfrycsrq的中文含义是： 执法人员出生日期
	 */
	public void setZfrycsrq(String zfrycsrq){ 
		this.zfrycsrq = zfrycsrq;
	}
	/**
	 * @Description zfrycsrq的中文含义是： 执法人员出生日期
	 */
	public String getZfrycsrq(){
		return zfrycsrq;
	}
	/**
	 * @Description zfrysfzh的中文含义是： 执法人员身份证号
	 */
	public void setZfrysfzh(String zfrysfzh){ 
		this.zfrysfzh = zfrysfzh;
	}
	/**
	 * @Description zfrysfzh的中文含义是： 执法人员身份证号
	 */
	public String getZfrysfzh(){
		return zfrysfzh;
	}
	/**
	 * @Description zfryzjhm的中文含义是： 执法人员证件号码
	 */
	public void setZfryzjhm(String zfryzjhm){ 
		this.zfryzjhm = zfryzjhm;
	}
	/**
	 * @Description zfryzjhm的中文含义是： 执法人员证件号码
	 */
	public String getZfryzjhm(){
		return zfryzjhm;
	}
	/**
	 * @Description zfryzflyid的中文含义是： 执法人员执法领域对应pzfryzfly表id
	 */
	public void setZfryzflyid(String zfryzflyid){ 
		this.zfryzflyid = zfryzflyid;
	}
	/**
	 * @Description zfryzflyid的中文含义是： 执法人员执法领域对应pzfryzfly表id
	 */
	public String getZfryzflyid(){
		return zfryzflyid;
	}
	/**
	 * @Description zfrybz的中文含义是： 备注
	 */
	public void setZfrybz(String zfrybz){ 
		this.zfrybz = zfrybz;
	}
	/**
	 * @Description zfrybz的中文含义是： 备注
	 */
	public String getZfrybz(){
		return zfrybz;
	}
	/**
	 * @Description zfryczy的中文含义是： 操作员
	 */
	public void setZfryczy(String zfryczy){ 
		this.zfryczy = zfryczy;
	}
	/**
	 * @Description zfryczy的中文含义是： 操作员
	 */
	public String getZfryczy(){
		return zfryczy;
	}
	/**
	 * @Description zfryczsj的中文含义是： 操作时间
	 */
	public void setZfryczsj(String zfryczsj){ 
		this.zfryczsj = zfryczsj;
	}
	/**
	 * @Description zfryczsj的中文含义是： 操作时间
	 */
	public String getZfryczsj(){
		return zfryczsj;
	}
	/**
	 * @Description zfryzw的中文含义是： 执法人员职务
	 */
	public void setZfryzw(String zfryzw){ 
		this.zfryzw = zfryzw;
	}
	/**
	 * @Description zfryzw的中文含义是： 执法人员职务
	 */
	public String getZfryzw(){
		return zfryzw;
	}
	public String getZfryzflybm() {
		return zfryzflybm;
	}
	public void setZfryzflybm(String zfryzflybm) {
		this.zfryzflybm = zfryzflybm;
	}
	public String getZfryzflymc() {
		return zfryzflymc;
	}
	public void setZfryzflymc(String zfryzflymc) {
		this.zfryzflymc = zfryzflymc;
	}
	public String getZfryzflybmComBo() {
		return zfryzflybmComBo;
	}
	public void setZfryzflybmComBo(String zfryzflybmComBo) {
		this.zfryzflybmComBo = zfryzflybmComBo;
	}
	public String getMobile2() {
		return mobile2;
	}
	public void setMobile2(String mobile2) {
		this.mobile2 = mobile2;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getZfrylybm() {
		return zfrylybm;
	}
	public void setZfrylybm(String zfrylybm) {
		this.zfrylybm = zfrylybm;
	}
	public String getZfryzppath() {
		return zfryzppath;
	}
	public void setZfryzppath(String zfryzppath) {
		this.zfryzppath = zfryzppath;
	}
	public String getZfryzpname() {
		return zfryzpname;
	}
	public void setZfryzpname(String zfryzpname) {
		this.zfryzpname = zfryzpname;
	}
	
	

	
}
