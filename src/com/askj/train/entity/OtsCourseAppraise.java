package com.askj.train.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.PK;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Timestamp;

@Table(value = "ots_course_appraise")
@PK({"courseId", "userid"})
public class OtsCourseAppraise {
/** 考试数据表  */
	/** course_id 的中文含义是：*/
	@Column(value="course_id")
	private String courseId;

	/** userid 的中文含义是：课程评价用户id*/
	@Column(value="userid")
	private String userid;
	
	/** score 的中文含义是：课程评价分值*/
	@Column(value="score")
	private Integer score;

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

