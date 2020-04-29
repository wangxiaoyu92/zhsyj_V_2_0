package com.askj.signup.entity;

import java.sql.Timestamp;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

@Table(value = "ots_exam_user_enroll")
public class OtsExamUserEnroll {
	/** 考试报名表  */
	/** enroll_id 的中文含义是：报名ID 手动添加*/
	@Name
	@Column(value="enroll_id")
	private String enrollId;
	
	
	/** reg_id 的中文含义是：注册用户id 手动添加*/
	@Column(value="reg_id")
	private String regId;
	
	/** enroll_number 的中文含义是：准考证号*/
	@Column(value="enroll_number")
	private String enrollNumber;
	
	/** enroll_name 的中文含义是：考生名称*/
	@Column(value="enroll_name")
	private String enrollName;
	
	/** enroll_sex 的中文含义是：考生性别*/
	@Column(value="enroll_sex")
	private String enrollSex;
	
	/** enroll_unit 的中文含义是：考生单位*/
	@Column(value="enroll_unit")
	private String enrollUnit;
	
	/** enroll_idcard_type 的中文含义是：考生证件类型*/
	@Column(value="enroll_idcard_type")
	private String enrollIdcardType;


	/** enroll_idcard_no 的中文含义是：考生证件号码*/
	@Column(value="enroll_idcard_no")
	private String enrollIdcardNo;
	
	/** enroll_exam_id 的中文含义是：所报考考试ID*/
	@Column(value="enroll_exam_id")
	private String enrollExamId;
	
	/** enroll_exam_name 的中文含义是：所报考考试名称*/
	@Column(value="enroll_exam_name")
	private String enrollExamName;
	
	/** enroll_state 的中文含义是：状态| 1=未审核 2=审核中 3=审核通过 4=已缴费*/
	@Column(value="enroll_state")
	private String enrollState;
	
	/** enroll_remark 的中文含义是：备注*/
	@Column(value="enroll_remark")
	private String enrollRemark;
	
	/** enroll_time 的中文含义是：报名时间*/
	@Column(value="enroll_time")
	private Timestamp enrollTime;

	public String getEnrollId() {
		return enrollId;
	}

	public void setEnrollId(String enrollId) {
		this.enrollId = enrollId;
	}

	public String getRegId() {
		return regId;
	}

	public void setRegId(String regId) {
		this.regId = regId;
	}

	public String getEnrollNumber() {
		return enrollNumber;
	}

	public void setEnrollNumber(String enrollNumber) {
		this.enrollNumber = enrollNumber;
	}

	public String getEnrollName() {
		return enrollName;
	}

	public void setEnrollName(String enrollName) {
		this.enrollName = enrollName;
	}

	public String getEnrollSex() {
		return enrollSex;
	}

	public void setEnrollSex(String enrollSex) {
		this.enrollSex = enrollSex;
	}

	public String getEnrollUnit() {
		return enrollUnit;
	}

	public void setEnrollUnit(String enrollUnit) {
		this.enrollUnit = enrollUnit;
	}

	public String getEnrollIdcardType() {
		return enrollIdcardType;
	}

	public void setEnrollIdcardType(String enrollIdcardType) {
		this.enrollIdcardType = enrollIdcardType;
	}

	public String getEnrollIdcardNo() {
		return enrollIdcardNo;
	}

	public void setEnrollIdcardNo(String enrollIdcardNo) {
		this.enrollIdcardNo = enrollIdcardNo;
	}

	public String getEnrollExamId() {
		return enrollExamId;
	}

	public void setEnrollExamId(String enrollExamId) {
		this.enrollExamId = enrollExamId;
	}

	public String getEnrollExamName() {
		return enrollExamName;
	}

	public void setEnrollExamName(String enrollExamName) {
		this.enrollExamName = enrollExamName;
	}

	public String getEnrollState() {
		return enrollState;
	}

	public void setEnrollState(String enrollState) {
		this.enrollState = enrollState;
	}

	public String getEnrollRemark() {
		return enrollRemark;
	}

	public void setEnrollRemark(String enrollRemark) {
		this.enrollRemark = enrollRemark;
	}

	public Timestamp getEnrollTime() {
		return enrollTime;
	}

	public void setEnrollTime(Timestamp enrollTime) {
		this.enrollTime = enrollTime;
	}

	
}
