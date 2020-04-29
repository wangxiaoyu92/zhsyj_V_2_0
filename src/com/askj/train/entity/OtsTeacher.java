package com.askj.train.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "ots_teacher")
public class OtsTeacher {
/** 讲师信息表  */
	/** teacher_id 的中文含义是：讲师ID*/
	@Name
	@Column(value="teacher_id")
	private String teacherId;

	/** teacher_name 的中文含义是：名称*/
	@Column(value="teacher_name")
	private String teacherName;

	/** teacher_age 的中文含义是：年龄*/
	@Column(value="teacher_age")
	private Short teacherAge;

	/** teacher_sex 的中文含义是：性别*/
	@Column(value="teacher_sex")
	private Integer teacherSex;

	/** teacher_positional 的中文含义是：讲师*/
	@Column(value="teacher_positional")
	private String teacherPositional;

	/** teacher_tel 的中文含义是：联系方式*/
	@Column(value="teacher_tel")
	private String teacherTel;

	/** teacher_weibo 的中文含义是：微博*/
	@Column(value="teacher_weibo")
	private String teacherWeibo;

	/** teacher_blog 的中文含义是：博客*/
	@Column(value="teacher_blog")
	private String teacherBlog;

	/** teacher_addr 的中文含义是：地址*/
	@Column(value="teacher_addr")
	private String teacherAddr;

	/** teacher_des 的中文含义是：描述*/
	@Column(value="teacher_des")
	private String teacherDes;

	/** teacher_email 的中文含义是：邮箱*/
	@Column(value="teacher_email")
	private String teacherEmail;

	/** teacher_birthday 的中文含义是：生日*/
	@Column(value="teacher_birthday")
	private Date teacherBirthday;

	/** aae011 的中文含义是：经办人*/
	@Column(value="aae011")
	private String aae011;

	/** aae036 的中文含义是：经办时间*/
	@Column(value="aae036")
	private Timestamp aae036;

	/** teacher_type 的中文含义是：1是内部讲师 0外部讲师*/
	@Column(value="teacher_type")
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
		this.teacherType=teacherType;
	}

	public String getTeacherType(){
		return teacherType;
	}

}

