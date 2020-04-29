package com.askj.train.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.PK;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Timestamp;

@Table(value = "ots_course_homework")
@PK({"courseId", "homeworkId"})
public class OtsCourseHomework {
/** 课程作业中间表  */
	/** course_id 的中文含义是：课程ID*/
	@Column(value="course_id")
	private String courseId;

	/** homework_id 的中文含义是：作业id*/
	@Column(value="homework_id")
	private String homeworkId;

	/** aae011 的中文含义是：经办人*/
	@Column(value="aae011")
	private String aae011;

	/** aae036 的中文含义是：经办时间*/
	@Column(value="aae036")
	private Timestamp aae036;


	public void setCourseId(String courseId){
		this.courseId=courseId;
	}

	public String getCourseId(){
		return courseId;
	}

	public void setHomeworkId(String homeworkId){
		this.homeworkId=homeworkId;
	}

	public String getHomeworkId(){
		return homeworkId;
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

