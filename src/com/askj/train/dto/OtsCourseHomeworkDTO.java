package com.askj.train.dto;

import java.sql.Timestamp;

public class OtsCourseHomeworkDTO {
/** 课程作业中间表  */
	/** homeworks 的中文含义是：作业（手动添加）*/
	private String homeworks;
	
	public String getHomeworks() {
		return homeworks;
	}

	public void setHomeworks(String homeworks) {
		this.homeworks = homeworks;
	}
	/** course_id 的中文含义是：课程ID*/
	private String courseId;

	/** homework_id 的中文含义是：作业id*/
	private String homeworkId;

	/** aae011 的中文含义是：经办人*/
	private String aae011;

	/** aae036 的中文含义是：经办时间*/
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

