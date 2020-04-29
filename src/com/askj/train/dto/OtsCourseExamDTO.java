package com.askj.train.dto;

import java.sql.Timestamp;

public class OtsCourseExamDTO {
/** 课程考试信息对应表  */
	/** course_id 的中文含义是：课程ID*/
	private String courseId;

	/** exams_info_id 的中文含义是：考试ID*/
	private String examsInfoId;

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

	public void setExamsInfoId(String examsInfoId){
		this.examsInfoId=examsInfoId;
	}

	public String getExamsInfoId(){
		return examsInfoId;
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

