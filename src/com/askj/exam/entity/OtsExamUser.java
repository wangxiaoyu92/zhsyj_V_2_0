package com.askj.exam.entity;

import org.nutz.dao.entity.annotation.*;
/**
 * @Description  OtsExamUser的中文含义是: 考试用户中间表
 * @Creation     2017/03/13 15:32:30
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ots_exam_user")
public class OtsExamUser {
	/**
	 * @Description examUserId的中文含义是： 考试用户ID
	 */
	@Column ( value = "exam_user_id" )
	@Name
	private String examUserId;

	/**
	 * @Description examsInfoId的中文含义是： 考试ID
	 */
	@Column ( value = "exams_info_id" )
	private String examsInfoId;

	/**
	 * @Description userId的中文含义是： 用户ID
	 */
	@Column ( value = "user_id" )
	private String userId;

	/**
	 * @Description examUserId的中文含义是： 考试用户ID
	 */
	public void setExamUserId(String examUserId){ 
		this.examUserId = examUserId;
	}
	/**
	 * @Description examUserId的中文含义是： 考试用户ID
	 */
	public String getExamUserId(){
		return examUserId;
	}
	/**
	 * @Description examsInfoId的中文含义是： 考试ID
	 */
	public void setExamsInfoId(String examsInfoId){ 
		this.examsInfoId = examsInfoId;
	}
	/**
	 * @Description examsInfoId的中文含义是： 考试ID
	 */
	public String getExamsInfoId(){
		return examsInfoId;
	}
	/**
	 * @Description userId的中文含义是： 用户ID
	 */
	public void setUserId(String userId){ 
		this.userId = userId;
	}
	/**
	 * @Description userId的中文含义是： 用户ID
	 */
	public String getUserId(){
		return userId;
	}

	
}