package com.askj.environment.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;
/**
 * 
 * EnvSoilInfo的中文名称：土壤信息表
 * 
 * EnvSoilInfo的描述：
 * 
 * Written by : sunyifeng at 2016-06-29 17:42:23 
 */
@Table(value = "EnvSoilInfo")
public class EnvSoilInfo {
	/**
	 * @Description proid的中文含义是： 产品id 用于追溯信息的关联
	 */
	@Column
	private String proid;

	/**
	 * @Description cppcpch的中文含义是： 产品批次号 用于追溯信息的关联
	 */
	@Column
	private String cppcpch;
	/**
	 * @Description soilid的中文含义是： 土壤信息ID
	 */
	@Column
	@Name
	private String soilid;
	
	/**
	 * @Description soiltemperature的中文含义是： 土壤温度
	 */
	@Column
	private String soiltemperature;
	
	/**
	 * @Description soilsalinity的中文含义是： 土壤盐分
	 */
	@Column
	private String soilsalinity;
	
	/**
	 * @Description soilmoisture的中文含义是： 土壤水分
	 */
	@Column
	private String soilmoisture;
	
	/**
	 * @Description operatoruserid的中文含义是： 操作用户ID
	 */
	@Column
	private String operatoruserid;
	
	/**
	 * @Description operatorusername的中文含义是： 操作用户名
	 */
	@Column
	private String operatorusername;
	
	/**
	 * @Description operatordate的中文含义是： 操作日期
	 */
	@Column
	private String operatordate;
	
	/**
	 * @Description operatoreditdate的中文含义是： 编辑日期
	 */
	@Column
	private String operatoreditdate;
	

	/**
	 * @Description soilid的中文含义是： 土壤信息ID
	 */
	public void setSoilid(String soilid){ 
		this.soilid = soilid;
	}
	/**
	 * @Description soilid的中文含义是： 土壤信息ID
	 */
	public String getSoilid(){
		return soilid;
	}
	/**
	 * @Description soiltemperature的中文含义是： 土壤温度
	 */
	public void setSoiltemperature(String soiltemperature){ 
		this.soiltemperature = soiltemperature;
	}
	/**
	 * @Description soiltemperature的中文含义是： 土壤温度
	 */
	public String getSoiltemperature(){
		return soiltemperature;
	}
	/**
	 * @Description soilsalinity的中文含义是： 土壤盐分
	 */
	public void setSoilsalinity(String soilsalinity){ 
		this.soilsalinity = soilsalinity;
	}
	/**
	 * @Description soilsalinity的中文含义是： 土壤盐分
	 */
	public String getSoilsalinity(){
		return soilsalinity;
	}
	/**
	 * @Description soilmoisture的中文含义是： 土壤水分
	 */
	public void setSoilmoisture(String soilmoisture){ 
		this.soilmoisture = soilmoisture;
	}
	/**
	 * @Description soilmoisture的中文含义是： 土壤水分
	 */
	public String getSoilmoisture(){
		return soilmoisture;
	}
	/**
	 * @Description operatoruserid的中文含义是： 操作用户ID
	 */
	public void setOperatoruserid(String operatoruserid){ 
		this.operatoruserid = operatoruserid;
	}
	/**
	 * @Description operatoruserid的中文含义是： 操作用户ID
	 */
	public String getOperatoruserid(){
		return operatoruserid;
	}
	/**
	 * @Description operatorusername的中文含义是： 操作用户名
	 */
	public void setOperatorusername(String operatorusername){ 
		this.operatorusername = operatorusername;
	}
	/**
	 * @Description operatorusername的中文含义是： 操作用户名
	 */
	public String getOperatorusername(){
		return operatorusername;
	}
	/**
	 * @Description operatordate的中文含义是： 操作日期
	 */
	public void setOperatordate(String operatordate){
		this.operatordate = operatordate;
	}
	/**
	 * @Description operatordate的中文含义是： 操作日期
	 */
	public String getOperatordate(){
		return operatordate;
	}
	/**
	 * @Description operatoreditdate的中文含义是： 编辑日期
	 */
	public void setOperatoreditdate(String operatoreditdate){
		this.operatoreditdate = operatoreditdate;
	}
	/**
	 * @Description operatoreditdate的中文含义是： 编辑日期
	 */
	public String getOperatoreditdate(){
		return operatoreditdate;
	}

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
}