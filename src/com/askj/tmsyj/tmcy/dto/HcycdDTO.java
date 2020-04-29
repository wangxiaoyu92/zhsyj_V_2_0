package com.askj.tmsyj.tmcy.dto;

import java.sql.Timestamp;

/**
 * @Description  HcycdDTO 的中文含义是: 餐饮菜单表; InnoDB free: 10240 kB
 * @Creation     2017/03/21 09:54:21
 * @Written      Create Tool By zjf 
 **/
public class HcycdDTO {
	/**
	 * @Description hcycdid的中文含义是： 餐饮菜单表id
	 */
	private String hcycdid;

	/**
	 * @Description comid的中文含义是： 企业id
	 */
	private String comid;
	private String commc;

	/**
	 * @Description cpmc的中文含义是： 菜品名称
	 */
	private String cpmc;

	/**
	 * @Description cpjc的中文含义是： 菜品简称
	 */
	private String cpjc;

	/**
	 * @Description cpjj的中文含义是： 菜品简介
	 */
	private String cpjj;

	/**
	 * @Description cpsssj的中文含义是： 菜品上市时间
	 */
	private Timestamp cpsssj;

	/**
	 * @Description sjbz的中文含义是： 上架标志
	 */
	private String sjbz;

	/**
	 * @Description caixi的中文含义是： 菜系aaa100=caixi
	 */
	private String caixi;
	private String caixiinfo;

	/**
	 * @Description caipingl的中文含义是： 菜品归类aaa100=caipingl
	 */
	private String caipingl;
	private String caipinglinfo;

	/**
	 * @Description cpjg的中文含义是： 菜品价格
	 */
	private double cpjg;

	/**
	 * @Description aae011的中文含义是： 操作员
	 */
	private String aae011;

	/**
	 * @Description aae036的中文含义是： 操作时间
	 */
	private Timestamp aae036;
	private String fjpath;
	   
	
	public String getFjpath() {
		return fjpath;
	}
	public void setFjpath(String fjpath) {
		this.fjpath = fjpath;
	}
	public String getCommc() {
		return commc;
	}
	public void setCommc(String commc) {
		this.commc = commc;
	}
	public String getCaixiinfo() {
		return caixiinfo;
	}
	public void setCaixiinfo(String caixiinfo) {
		this.caixiinfo = caixiinfo;
	}
	public String getCaipinglinfo() {
		return caipinglinfo;
	}
	public void setCaipinglinfo(String caipinglinfo) {
		this.caipinglinfo = caipinglinfo;
	}
		/**
	 * @Description hcycdid的中文含义是： 餐饮菜单表id
	 */
	public void setHcycdid(String hcycdid){ 
		this.hcycdid = hcycdid;
	}
	/**
	 * @Description hcycdid的中文含义是： 餐饮菜单表id
	 */
	public String getHcycdid(){
		return hcycdid;
	}
	/**
	 * @Description comid的中文含义是： 企业id
	 */
	public void setComid(String comid){ 
		this.comid = comid;
	}
	/**
	 * @Description comid的中文含义是： 企业id
	 */
	public String getComid(){
		return comid;
	}
	/**
	 * @Description cpmc的中文含义是： 菜品名称
	 */
	public void setCpmc(String cpmc){ 
		this.cpmc = cpmc;
	}
	/**
	 * @Description cpmc的中文含义是： 菜品名称
	 */
	public String getCpmc(){
		return cpmc;
	}
	/**
	 * @Description cpjc的中文含义是： 菜品简称
	 */
	public void setCpjc(String cpjc){ 
		this.cpjc = cpjc;
	}
	/**
	 * @Description cpjc的中文含义是： 菜品简称
	 */
	public String getCpjc(){
		return cpjc;
	}
	/**
	 * @Description cpjj的中文含义是： 菜品简介
	 */
	public void setCpjj(String cpjj){ 
		this.cpjj = cpjj;
	}
	/**
	 * @Description cpjj的中文含义是： 菜品简介
	 */
	public String getCpjj(){
		return cpjj;
	}
	/**
	 * @Description cpsssj的中文含义是： 菜品上市时间
	 */
	public void setCpsssj(Timestamp cpsssj){ 
		this.cpsssj = cpsssj;
	}
	/**
	 * @Description cpsssj的中文含义是： 菜品上市时间
	 */
	public Timestamp getCpsssj(){
		return cpsssj;
	}
	/**
	 * @Description sjbz的中文含义是： 上架标志
	 */
	public void setSjbz(String sjbz){ 
		this.sjbz = sjbz;
	}
	/**
	 * @Description sjbz的中文含义是： 上架标志
	 */
	public String getSjbz(){
		return sjbz;
	}
	/**
	 * @Description caixi的中文含义是： 菜系aaa100=caixi
	 */
	public void setCaixi(String caixi){ 
		this.caixi = caixi;
	}
	/**
	 * @Description caixi的中文含义是： 菜系aaa100=caixi
	 */
	public String getCaixi(){
		return caixi;
	}
	/**
	 * @Description caipingl的中文含义是： 菜品归类aaa100=caipingl
	 */
	public void setCaipingl(String caipingl){ 
		this.caipingl = caipingl;
	}
	/**
	 * @Description caipingl的中文含义是： 菜品归类aaa100=caipingl
	 */
	public String getCaipingl(){
		return caipingl;
	}
	/**
	 * @Description cpjg的中文含义是： 菜品价格
	 */
	public void setCpjg(double cpjg){ 
		this.cpjg = cpjg;
	}
	/**
	 * @Description cpjg的中文含义是： 菜品价格
	 */
	public double getCpjg(){
		return cpjg;
	}
	/**
	 * @Description aae011的中文含义是： 操作员
	 */
	public void setAae011(String aae011){ 
		this.aae011 = aae011;
	}
	/**
	 * @Description aae011的中文含义是： 操作员
	 */
	public String getAae011(){
		return aae011;
	}
	/**
	 * @Description aae036的中文含义是： 操作时间
	 */
	public void setAae036(Timestamp aae036){ 
		this.aae036 = aae036;
	}
	/**
	 * @Description aae036的中文含义是： 操作时间
	 */
	public Timestamp getAae036(){
		return aae036;
	}

	
}