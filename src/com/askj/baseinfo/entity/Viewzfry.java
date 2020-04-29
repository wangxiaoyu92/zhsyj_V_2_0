package com.askj.baseinfo.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  VIEWZFRY的中文含义是: VIEW
 * @Creation     2016/03/17 18:15:56
 * @Written      Create Tool By zjf 
 **/
@Table(value = "VIEWZFRY")
public class Viewzfry {
	/**
	 * @Description userid的中文含义是： 用户ID（关键字）
	 */
	@Column
	private String userid;

	/**
	 * @Description username的中文含义是： 用户名
	 */
	@Column
	private String username;

	/**
	 * @Description description的中文含义是： 用户描述
	 */
	@Column
	private String description;

	/**
	 * @Description mobile的中文含义是： 手机号（注册时绑定），所有用户不可为空
	 */
	@Column
	private String mobile;

	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	@Column
	private String aaa027;

	/**
	 * @Description orgname的中文含义是： 机构名称
	 */
	@Column
	private String orgname;

	/**
	 * @Description zfryid的中文含义是： 执法人员ID
	 */
	@Column
	private String zfryid;

	/**
	 * @Description zfrypym的中文含义是： 执法人员姓名拼音缩写
	 */
	@Column
	private String zfrypym;

	/**
	 * @Description zfryxb的中文含义是： 执法人员性别
	 */
	@Column
	private String zfryxb;

	/**
	 * @Description zfrycsrq的中文含义是： 执法人员出生日期
	 */
	@Column
	private String zfrycsrq;

	/**
	 * @Description zfrysfzh的中文含义是： 执法人员身份证号
	 */
	@Column
	private String zfrysfzh;

	/**
	 * @Description zfryzjhm的中文含义是： 执法人员证件号码
	 */
	@Column
	private String zfryzjhm;

	/**
	 * @Description zfryzflyid的中文含义是： 执法人员执法领域对应pzfryzfly表id
	 */
	@Column
	private String zfryzflyid;

	/**
	 * @Description zfrybz的中文含义是： 备注
	 */
	@Column
	private String zfrybz;

	/**
	 * @Description zfryzw的中文含义是： 执法人员职务
	 */
	@Column
	private String zfryzw;
	
	/**
	 * @Description zfryzw的中文含义是： 执法人员职务
	 */
	@Column
	private String zfryzflybm;
	
	/**
	 * @Description zfryzw的中文含义是： 执法人员职务
	 */
	@Column
	private String zfryzflymc;	
	
	/**
	 * @Description mobile2的中文含义是： 手机号2
	 */
	@Column
	private String mobile2;	
	
	/**
	 * @Description telephone的中文含义是： 执法人员职务
	 */
	@Column
	private String telephone;		

	
		/**
	 * @Description userid的中文含义是： 用户ID（关键字）
	 */
	public void setUserid(String userid){ 
		this.userid = userid;
	}
	/**
	 * @Description userid的中文含义是： 用户ID（关键字）
	 */
	public String getUserid(){
		return userid;
	}
	/**
	 * @Description username的中文含义是： 用户名
	 */
	public void setUsername(String username){ 
		this.username = username;
	}
	/**
	 * @Description username的中文含义是： 用户名
	 */
	public String getUsername(){
		return username;
	}
	/**
	 * @Description description的中文含义是： 用户描述
	 */
	public void setDescription(String description){ 
		this.description = description;
	}
	/**
	 * @Description description的中文含义是： 用户描述
	 */
	public String getDescription(){
		return description;
	}
	/**
	 * @Description mobile的中文含义是： 手机号（注册时绑定），所有用户不可为空
	 */
	public void setMobile(String mobile){ 
		this.mobile = mobile;
	}
	/**
	 * @Description mobile的中文含义是： 手机号（注册时绑定），所有用户不可为空
	 */
	public String getMobile(){
		return mobile;
	}
	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	public void setAaa027(String aaa027){ 
		this.aaa027 = aaa027;
	}
	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	public String getAaa027(){
		return aaa027;
	}
	/**
	 * @Description orgname的中文含义是： 机构名称
	 */
	public void setOrgname(String orgname){ 
		this.orgname = orgname;
	}
	/**
	 * @Description orgname的中文含义是： 机构名称
	 */
	public String getOrgname(){
		return orgname;
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
	
	

	
}