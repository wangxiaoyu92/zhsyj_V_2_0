package com.askj.spsy.dto;

/**
 * @Description  QPRODUCTSZGCXX的中文含义是: 产品生长生产过程信息表DTO
 * @Creation     2016/07/20 18:29:09
 * @Written      Create Tool By zjf 
 **/
public class QproductszhjxxDTO {

	/**
	 * @Description proid的中文含义是： 产品ID
	 */
	private String proid;

	/**
	 * @Description cppcpch的中文含义是： 批次号
	 */
	private String cppcpch;

	/*************大气信息***************/
	/**
	 * @Description airid的中文含义是： 大气信息主键
	 */
	private String airid;

	/**
	 * @Description airtsp的中文含义是： 总悬浮颗粒物
	 */
	private String airtsp;

	/**
	 * @Description airthc的中文含义是： 总碳氢化合物
	 */
	private String airthc;

	/**
	 * @Description airto的中文含义是： 总氧化剂
	 */
	private String airto;

	/**
	 * @Description airoxynitride的中文含义是： 氮氧化物
	 */
	private String airoxynitride;

	/**
	 * @Description airso2的中文含义是： 二氧化硫
	 */
	private String airso2;

	/**
	 * @Description airco的中文含义是： 一氧化碳
	 */
	private String airco;

	/**
	 * @Description airdustfall的中文含义是： 降尘
	 */
	private String airdustfall;

	/*************土壤信息***************/
	/**
	 * @Description soilid的中文含义是： 土壤信息ID
	 */
	private String soilid;

	/**
	 * @Description soiltemperature的中文含义是： 土壤温度
	 */
	private String soiltemperature;

	/**
	 * @Description soilsalinity的中文含义是： 土壤盐分
	 */
	private String soilsalinity;

	/**
	 * @Description soilmoisture的中文含义是： 土壤水分
	 */
	private String soilmoisture;

	/*************水信息***************/
	/**
	 * @Description walterid的中文含义是： 水ID
	 */
	private String walterid;

	/**
	 * @Description walterph的中文含义是： PH
	 */
	private String walterph;

	/**
	 * @Description waltero2的中文含义是： 溶氧
	 */
	private String waltero2;

	/**
	 * @Description waltertemp的中文含义是： 温度
	 */
	private String waltertemp;

	/**
	 * @Description walterele的中文含义是： 电导率
	 */
	private String walterele;

	/**
	 * @Description walterturbidity的中文含义是： 浊度
	 */
	private String walterturbidity;

	public String getProid() {
		return proid;
	}

	public void setProid(String proid) {
		this.proid = proid;
	}

	public String getCppcpch() {
		return cppcpch;
	}

	public void setCppcpch(String cppcpch) {
		this.cppcpch = cppcpch;
	}

	public String getAirid() {
		return airid;
	}

	public void setAirid(String airid) {
		this.airid = airid;
	}

	public String getAirtsp() {
		return airtsp;
	}

	public void setAirtsp(String airtsp) {
		this.airtsp = airtsp;
	}

	public String getAirthc() {
		return airthc;
	}

	public void setAirthc(String airthc) {
		this.airthc = airthc;
	}

	public String getAirto() {
		return airto;
	}

	public void setAirto(String airto) {
		this.airto = airto;
	}

	public String getAiroxynitride() {
		return airoxynitride;
	}

	public void setAiroxynitride(String airoxynitride) {
		this.airoxynitride = airoxynitride;
	}

	public String getAirso2() {
		return airso2;
	}

	public void setAirso2(String airso2) {
		this.airso2 = airso2;
	}

	public String getAirco() {
		return airco;
	}

	public void setAirco(String airco) {
		this.airco = airco;
	}

	public String getAirdustfall() {
		return airdustfall;
	}

	public void setAirdustfall(String airdustfall) {
		this.airdustfall = airdustfall;
	}

	public String getSoilid() {
		return soilid;
	}

	public void setSoilid(String soilid) {
		this.soilid = soilid;
	}

	public String getSoiltemperature() {
		return soiltemperature;
	}

	public void setSoiltemperature(String soiltemperature) {
		this.soiltemperature = soiltemperature;
	}

	public String getSoilsalinity() {
		return soilsalinity;
	}

	public void setSoilsalinity(String soilsalinity) {
		this.soilsalinity = soilsalinity;
	}

	public String getSoilmoisture() {
		return soilmoisture;
	}

	public void setSoilmoisture(String soilmoisture) {
		this.soilmoisture = soilmoisture;
	}

	public String getWalterid() {
		return walterid;
	}

	public void setWalterid(String walterid) {
		this.walterid = walterid;
	}

	public String getWalterph() {
		return walterph;
	}

	public void setWalterph(String walterph) {
		this.walterph = walterph;
	}

	public String getWaltero2() {
		return waltero2;
	}

	public void setWaltero2(String waltero2) {
		this.waltero2 = waltero2;
	}

	public String getWaltertemp() {
		return waltertemp;
	}

	public void setWaltertemp(String waltertemp) {
		this.waltertemp = waltertemp;
	}

	public String getWalterele() {
		return walterele;
	}

	public void setWalterele(String walterele) {
		this.walterele = walterele;
	}

	public String getWalterturbidity() {
		return walterturbidity;
	}

	public void setWalterturbidity(String walterturbidity) {
		this.walterturbidity = walterturbidity;
	}
}