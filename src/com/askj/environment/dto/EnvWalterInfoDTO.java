package com.askj.environment.dto;

/**
 * 
 * EnvWalterInfoDTO的中文名称：水信息DTO
 * 
 * EnvWalterInfoDTO的描述：
 * 
 * Written by : sunyifeng at 2016-06-29 18:42:43 
 */
public class EnvWalterInfoDTO {

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
	

	/**
	 * @Description walterid的中文含义是： 水ID
	 */
	public void setWalterid(String walterid){ 
		this.walterid = walterid;
	}
	/**
	 * @Description walterid的中文含义是： 水ID
	 */
	public String getWalterid(){
		return walterid;
	}
	/**
	 * @Description walterph的中文含义是： PH
	 */
	public void setWalterph(String walterph){ 
		this.walterph = walterph;
	}
	/**
	 * @Description walterph的中文含义是： PH
	 */
	public String getWalterph(){
		return walterph;
	}
	/**
	 * @Description waltero2的中文含义是： 溶氧
	 */
	public void setWaltero2(String waltero2){ 
		this.waltero2 = waltero2;
	}
	/**
	 * @Description waltero2的中文含义是： 溶氧
	 */
	public String getWaltero2(){
		return waltero2;
	}
	/**
	 * @Description waltertemp的中文含义是： 温度
	 */
	public void setWaltertemp(String waltertemp){ 
		this.waltertemp = waltertemp;
	}
	/**
	 * @Description waltertemp的中文含义是： 温度
	 */
	public String getWaltertemp(){
		return waltertemp;
	}
	/**
	 * @Description walterele的中文含义是： 电导率
	 */
	public void setWalterele(String walterele){ 
		this.walterele = walterele;
	}
	/**
	 * @Description walterele的中文含义是： 电导率
	 */
	public String getWalterele(){
		return walterele;
	}
	/**
	 * @Description walterturbidity的中文含义是： 浊度
	 */
	public void setWalterturbidity(String walterturbidity){ 
		this.walterturbidity = walterturbidity;
	}
	/**
	 * @Description walterturbidity的中文含义是： 浊度
	 */
	public String getWalterturbidity(){
		return walterturbidity;
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