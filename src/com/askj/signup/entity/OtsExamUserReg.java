package com.askj.signup.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

@Table(value = "ots_exam_user_reg")
public class OtsExamUserReg {
	/** regId 的中文含义是：注册ID*/
	@Name
	@Column(value="reg_id")
	private String regId;
	
	/** userid 的中文含义是：用户ID*/
	@Column(value="userid")
	private String userid;
	
	/** reg_name 的中文含义是：注册账号*/
	@Column(value="reg_name")
	private String regName;
	
	/** reg_email 的中文含义是：注册邮箱*/
	@Column(value="reg_email")
	private String regEmail;
	
	/** reg_tel 的中文含义是：注册手机号*/
	@Column(value="reg_tel")
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
	
}
