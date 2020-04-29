package com.askj.train.dto;

import java.sql.Timestamp;

public class OtsCourseAppraiseDTO {
/** 考试数据表  */
	
	/** count 的中文含义是：*/
	private String count;
	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	/** course_id 的中文含义是：*/
	private String courseId;
	
	/** course_id 的中文含义是：*/
	private String userid;

	/** score 的中文含义是：课程评价分值*/
	private Integer score;

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

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public void setScore(Integer score){
		this.score=score;
	}

	public Integer getScore(){
		return score;
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

