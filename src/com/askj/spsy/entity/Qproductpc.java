package com.askj.spsy.entity;

import java.math.BigDecimal;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  QPRODUCTPC的中文含义是: 产品批次表（动态属性）; InnoDB free: 2722816 kB
 * @Creation     2016/06/30 16:28:28
 * @Written      Create Tool By zjf 
 **/
@Table(value = "QPRODUCTPC")
public class Qproductpc {
	/**
	 * @Description cppcid的中文含义是： 
	 */
	@Column
	@Name
	private String cppcid;

	/**
	 * @Description proid的中文含义是： 商品ID
	 */
	@Column
	private String proid;

	/**
	 * @Description cppcpch的中文含义是： 商品批次号
	 */
	@Column
	private String cppcpch;

	/**
	 * @Description cppcscrq的中文含义是： 生产日期
	 */
	@Column
	private String cppcscrq;

	/**
	 * @Description cppcscsl的中文含义是： 生产数量
	 */
	@Column
	private BigDecimal cppcscsl;

	/**
	 * @Description cppcsymscbz的中文含义是： 溯源码是否已生成 Y生成 N未生成
	 */
	@Column
	private String cppcsymscbz;

	/**
	 * @Description cppcscdwdm的中文含义是： 生产单位代码aaa100=CPPCSCDWDM
	 */
	@Column
	private String cppcscdwdm;
	
	/**
	 * @Description cppcsysl的中文含义是： 剩余数量
	 */
	@Column
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
	
}