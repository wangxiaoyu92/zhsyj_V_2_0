package com.askj.train.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.PK;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Timestamp;

@Table(value = "ots_course_teacher")
@PK({"teacherId", "courseId"})
public class OtsCourseTeacher {
/** 课程教师中间表  */
	/** teacher_id 的中文含义是：课程教师ID*/
	@Column(value="teacher_id")
	private String teacherId;

	/** course_id 的中文含义是：课程ID*/
	@Column(value="course_id")
	private String courseId;

	/** aae011 的中文含义是：经办人*/
	@Column(value="aae011")
	private String aae011;

	/** aae036 的中文含义是：经办时间*/
	@Column(value="aae036")
	private Timestamp aae036;


	public void setTeacherId(String teacherId){
		this.teacherId=teacherId;
	}

	public String getTeacherId(){
		return teacherId;
	}

	public void setCourseId(String courseId){
		this.courseId=courseId;
	}

	public String getCourseId(){
		return courseId;
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

}

