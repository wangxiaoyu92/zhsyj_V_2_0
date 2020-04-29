package com.askj.environment.dto;


/**
 * 
 * EnvAirInfoDTO的中文名称：大气信息DTO
 * 
 * EnvAirInfoDTO的描述：
 * 
 * Written by : sunyifeng at 2016-06-29 17:39:25 
 */
public class EnvAirInfoDTO {

	/**
	 * @Description operatoruserid的中文含义是： 操作用户ID
	 */
	private String operatoruserid;
	/**
	 * @Description operatorusername的中文含义是： 操作用户名
	 */
	private String operatorusername;
	/**
	 * @Description operatordate的中文含义是： 操作日期
	 */
	private String operatordate;
	/**
	 * @Description proid的中文含义是： 产品id 用于追溯信息的关联
	 */
	private String proid;

	/**
	 * @Description cppcpch的中文含义是： 产品批次号 用于追溯信息的关联
	 */
	private String cppcpch;
	/**
	 * @Description airid的中文含义是： 主键
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
	

	/**
	 * @Description airid的中文含义是： 主键
	 */
	public void setAirid(String airid){ 
		this.airid = airid;
	}
	/**
	 * @Description airid的中文含义是： 主键
	 */
	public String getAirid(){
		return airid;
	}
	/**
	 * @Description airtsp的中文含义是： 总悬浮颗粒物
	 */
	public void setAirtsp(String airtsp){ 
		this.airtsp = airtsp;
	}
	/**
	 * @Description airtsp的中文含义是： 总悬浮颗粒物
	 */
	public String getAirtsp(){
		return airtsp;
	}
	/**
	 * @Description airthc的中文含义是： 总碳氢化合物
	 */
	public void setAirthc(String airthc){ 
		this.airthc = airthc;
	}
	/**
	 * @Description airthc的中文含义是： 总碳氢化合物
	 */
	public String getAirthc(){
		return airthc;
	}
	/**
	 * @Description airto的中文含义是： 总氧化剂
	 */
	public void setAirto(String airto){ 
		this.airto = airto;
	}
	/**
	 * @Description airto的中文含义是： 总氧化剂
	 */
	public String getAirto(){
		return airto;
	}
	/**
	 * @Description airoxynitride的中文含义是： 氮氧化物
	 */
	public void setAiroxynitride(String airoxynitride){ 
		this.airoxynitride = airoxynitride;
	}
	/**
	 * @Description airoxynitride的中文含义是： 氮氧化物
	 */
	public String getAiroxynitride(){
		return airoxynitride;
	}
	/**
	 * @Description airso2的中文含义是： 二氧化硫
	 */
	public void setAirso2(String airso2){ 
		this.airso2 = airso2;
	}
	/**
	 * @Description airso2的中文含义是： 二氧化硫
	 */
	public String getAirso2(){
		return airso2;
	}
	/**
	 * @Description airco的中文含义是： 一氧化碳
	 */
	public void setAirco(String airco){ 
		this.airco = airco;
	}
	/**
	 * @Description airco的中文含义是： 一氧化碳
	 */
	public String getAirco(){
		return airco;
	}
	/**
	 * @Description airdustfall的中文含义是： 降尘
	 */
	public void setAirdustfall(String airdustfall){ 
		this.airdustfall = airdustfall;
	}
	/**
	 * @Description airdustfall的中文含义是： 降尘
	 */
	public String getAirdustfall(){
		return airdustfall;
	}

	public String getOperatoruserid() {
		return operatoruserid;
	}

	public void setOperatoruserid(String operatoruserid) {
		this.operatoruserid = operatoruserid;
	}

	public String getOperatorusername() {
		return operatorusername;
	}

	public void setOperatorusername(String operatorusername) {
		this.operatorusername = operatorusername;
	}

	public String getOperatordate() {
		return operatordate;
	}

	public void setOperatordate(String operatordate) {
		this.operatordate = operatordate;
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