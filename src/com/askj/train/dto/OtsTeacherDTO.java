package com.askj.train.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class OtsTeacherDTO {
/** 讲师信息表  */
	/** teacher_id 的中文含义是：讲师ID*/
	private String teacherId;

	/** teacher_name 的中文含义是：名称*/
	private String teacherName;

	/** teacher_age 的中文含义是：年龄*/
	private Short teacherAge;

	/** teacher_sex 的中文含义是：性别*/
	private Integer teacherSex;

	/** teacher_positional 的中文含义是：讲师*/
	private String teacherPositional;

	/** teacher_tel 的中文含义是：联系方式*/
	private String teacherTel;

	/** teacher_weibo 的中文含义是：微博*/
	private String teacherWeibo;

	/** teacher_blog 的中文含义是：博客*/
	private String teacherBlog;

	/** teacher_addr 的中文含义是：地址*/
	private String teacherAddr;

	/** teacher_des 的中文含义是：描述*/
	private String teacherDes;

	/** teacher_email 的中文含义是：邮箱*/
	private String teacherEmail;

	/** teacher_birthday 的中文含义是：生日*/
	private Date teacherBirthday;

	/** aae011 的中文含义是：经办人*/
	private String aae011;

	/** aae036 的中文含义是：经办时间*/
	private Timestamp aae036;

	/** teacherType 的中文含义是：1是内部讲师 0外部讲师*/
	private String teacherType;


	public void setTeacherId(String teacherId){
		this.teacherId=teacherId;
	}

	public String getTeacherId(){
		return teacherId;
	}

	public void setTeacherName(String teacherName){
		this.teacherName=teacherName;
	}

	public String getTeacherName(){
		return teacherName;
	}

	public void setTeacherAge(Short teacherAge){
		this.teacherAge=teacherAge;
	}

	public Short getTeacherAge(){
		return teacherAge;
	}

	public void setTeacherSex(Integer teacherSex){
		this.teacherSex=teacherSex;
	}

	public Integer getTeacherSex(){
		return teacherSex;
	}

	public void setTeacherPositional(String teacherPositional){
		this.teacherPositional=teacherPositional;
	}

	public String getTeacherPositional(){
		return teacherPositional;
	}

	public void setTeacherTel(String teacherTel){
		this.teacherTel=teacherTel;
	}

	public String getTeacherTel(){
		return teacherTel;
	}

	public void setTeacherWeibo(String teacherWeibo){
		this.teacherWeibo=teacherWeibo;
	}

	public String getTeacherWeibo(){
		return teacherWeibo;
	}

	public void setTeacherBlog(String teacherBlog){
		this.teacherBlog=teacherBlog;
	}

	public String getTeacherBlog(){
		return teacherBlog;
	}

	public void setTeacherAddr(String teacherAddr){
		this.teacherAddr=teacherAddr;
	}

	public String getTeacherAddr(){
		return teacherAddr;
	}

	public void setTeacherDes(String teacherDes){
		this.teacherDes=teacherDes;
	}

	public String getTeacherDes(){
		return teacherDes;
	}

	public void setTeacherEmail(String teacherEmail){
		this.teacherEmail=teacherEmail;
	}

	public String getTeacherEmail(){
		return teacherEmail;
	}

	public void setTeacherBirthday(Date teacherBirthday){
		this.teacherBirthday=teacherBirthday;
	}

	public Date getTeacherBirthday(){
		return teacherBirthday;
	}

	public void setAae011(String aae011){
		this.aae011=aae011;
	}

	public String getAae011(){
		return aae011;
	}

	public void setAae036(Timestamp aae036){
		this.aae036=aae036;
	}

	public Timestamp getAae036(){
		return aae036;
	}

	public void setTeacherType(String teacherType){
		this.teacherType = teacherType;
	}

	public String getTeacherType(){
		return teacherType;
	}

}

