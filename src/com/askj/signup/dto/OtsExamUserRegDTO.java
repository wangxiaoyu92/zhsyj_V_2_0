package com.askj.signup.dto;


public class OtsExamUserRegDTO {

	/** regId 的中文含义是：注册ID*/
	private String regId;
	
	/** userid 的中文含义是：用户ID*/
	private String userid;
	
	/** userid 的中文含义是：注册账号*/
	private String regName;
	
	/** regPass 的中文含义是：注册密码*/
	private String regPass;
	
	/** reg_email 的中文含义是：注册邮箱*/
	private String regEmail;
	
	/** reg_tel 的中文含义是：注册手机号*/
	private String regTel;

	public String getRegId() {
		return regId;
	}

	public void setRegId(String regId) {
		this.regId = regId;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getRegName() {
		return regName;
	}

	public void setRegName(String regName) {
		this.regName = regName;
	}

	public String getRegEmail() {
		return regEmail;
	}

	public void setRegEmail(String regEmail) {
		this.regEmail = regEmail;
	}

	public String getRegTel() {
		return regTel;
	}

	public void setRegTel(String regTel) {
		this.regTel = regTel;
	}

	public String getRegPass() {
		return regPass;
	}

	public void setRegPass(String regPass) {
		this.regPass = regPass;
	}
}
