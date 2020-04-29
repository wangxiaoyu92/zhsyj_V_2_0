package com.askj.spsy.dto;

import java.math.BigDecimal;

/**
 * @Description  QPRODUCTPC的中文含义是: 产品批次表（动态属性）; InnoDB free: 2725888 kBDTO
 * @Creation     2016/06/29 10:41:17
 * @Written      Create Tool By zjf 
 **/
public class QproductpcDTO {
	/**
	 * @Description procomid的中文含义是： 产品所属公司ID
	 */
	private String procomid;
	
	
	/**
	 * @Description prozl的中文含义是： 产品种类 对应product表产品种类 手动添加
	 */
	public String getProzl() {
		return prozl;
	}
	/**
	 * @Description prozl的中文含义是： 产品种类 对应product表产品种类 手动添加
	 */
	public void setProzl(String prozl) {
		this.prozl = prozl;
	}
	/**
	 * @Description cppcid的中文含义是： 
	 */
	public String getProname() {
		return proname;
	}
	/**
	 * @Description cppcid的中文含义是： 
	 */
	public void setProname(String proname) {
		this.proname = proname;
	}
	/**
	 * @Description commc的中文含义是： 企业名称 对应pcompany表企业名称 手动添加
	 */
	public String getCommc() {
		return commc;
	}
	/**
	 * @Description commc的中文含义是： 企业名称 对应pcompany表企业名称 手动添加
	 */
	public void setCommc(String commc) {
		this.commc = commc;
	}

	/**
	 * @Description commc的中文含义是： 企业名称 对应pcompany表企业名称 手动添加
	 */
	private String commc;
	/**
	 * @Description prozl的中文含义是： 产品种类 对应product表产品种类 手动添加
	 */
	private String prozl;
	
	/**
	 * @Description proname的中文含义是： 商品名称 对应product表产品名称 手动添加
	 */
	private String proname;
	/**
	 * @Description cppcid的中文含义是： 
	 */
	private String cppcid;

	/**
	 * @Description proid的中文含义是： 商品ID
	 */
	private String proid;

	/**
	 * @Description cppcpch的中文含义是： 商品批次号
	 */
	private String cppcpch;

	/**
	 * @Description cppcscrq的中文含义是： 生产日期
	 */
	private String cppcscrq;

	/**
	 * @Description cppcscsl的中文含义是： 生产数量
	 */
	private BigDecimal cppcscsl;

	/**
	 * @Description cppcsymscbz的中文含义是： 溯源码是否已生成 Y生成 N未生成
	 */
	private String cppcsymscbz;

	/**
	 * @Description cppcscdwdm的中文含义是： 生产单位代码aaa100=CPPCSCDWDM
	 */
	private String cppcscdwdm;
	
	/**
	 * @Description cppcsysl的中文含义是： 剩余数量
	 */
	private BigDecimal cppcsysl;

	/**
	 * @Description cppcid的中文含义是： 
	 */
	public void setCppcid(String cppcid){ 
		this.cppcid = cppcid;
	}
	/**
	 * @Description cppcid的中文含义是： 
	 */
	public String getCppcid(){
		return cppcid;
	}
	/**
	 * @Description proid的中文含义是： 商品ID
	 */
	public void setProid(String proid){ 
		this.proid = proid;
	}
	/**
	 * @Description proid的中文含义是： 商品ID
	 */
	public String getProid(){
		return proid;
	}
	/**
	 * @Description cppcpch的中文含义是： 商品批次号
	 */
	public void setCppcpch(String cppcpch){ 
		this.cppcpch = cppcpch;
	}
	/**
	 * @Description cppcpch的中文含义是： 商品批次号
	 */
	public String getCppcpch(){
		return cppcpch;
	}
	/**
	 * @Description cppcscrq的中文含义是： 生产日期
	 */
	public void setCppcscrq(String cppcscrq){ 
		this.cppcscrq = cppcscrq;
	}
	/**
	 * @Description cppcscrq的中文含义是： 生产日期
	 */
	public String getCppcscrq(){
		return cppcscrq;
	}
	/**
	 * @Description cppcscsl的中文含义是： 生产数量
	 */
	public void setCppcscsl(BigDecimal cppcscsl){ 
		this.cppcscsl = cppcscsl;
	}
	/**
	 * @Description cppcscsl的中文含义是： 生产数量
	 */
	public BigDecimal getCppcscsl(){
		return cppcscsl;
	}
	/**
	 * @Description cppcsymscbz的中文含义是： 溯源码是否已生成 Y生成 N未生成
	 */
	public void setCppcsymscbz(String cppcsymscbz){ 
		this.cppcsymscbz = cppcsymscbz;
	}
	/**
	 * @Description cppcsymscbz的中文含义是： 溯源码是否已生成 Y生成 N未生成
	 */
	public String getCppcsymscbz(){
		return cppcsymscbz;
	}
	/**
	 * @Description cppcscdwdm的中文含义是： 生产单位代码aaa100=CPPCSCDWDM
	 */
	public void setCppcscdwdm(String cppcscdwdm){ 
		this.cppcscdwdm = cppcscdwdm;
	}
	/**
	 * @Description cppcscdwdm的中文含义是： 生产单位代码aaa100=CPPCSCDWDM
	 */
	public String getCppcscdwdm(){
		return cppcscdwdm;
	}
	/**
	 * @Description cppcsysl的中文含义是： 剩余数量
	 */
	public BigDecimal getCppcsysl() {
		return cppcsysl;
	}
	/**
	 * @Description cppcsysl的中文含义是： 剩余数量
	 */
	public void setCppcsysl(BigDecimal cppcsysl) {
		this.cppcsysl = cppcsysl;
	}
	public String getProcomid() {
		return procomid;
	}
	public void setProcomid(String procomid) {
		this.procomid = procomid;
	}
	
	
}