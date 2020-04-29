package com.askj.train.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

/**
 * @Description  OtsCourseUser的中文含义是: 课程用户中间表
 * @Creation     2017/04/17 15:32:30
 * @Written      Create Tool By kyb 
 **/
@Table(value="ots_course_user")
public class OtsCourseUser {
	/**
	 * @Description courseUserId的中文含义是： 课程用户ID
	 */
	@Column ( value = "course_user_id" )
	@Name
	private String courseUserId;
	/**
	 * @Description courseId的中文含义是： 课程ID
	 */
	@Column ( value = "course_id" )
	private String courseId;
	/**
	 * @Description userId的中文含义是： 用户ID
	 */
	@Column ( value = "user_id" )
	private String userId;
	
	/**
	 * @Description courseUserId的中文含义是： 课程用户ID
	 */
	public String getCourseUserId() {
		return courseUserId;
	}
	public void setCourseUserId(String courseUserId) {
		this.courseUserId = courseUserId;
	}
	
	/**
	 * @Description courseId的中文含义是： 课程ID
	 */
	public String getCourseId() {
		return courseId;
	}
	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}
	/**
	 * @Description userId的中文含义是： 用户ID
	 */
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
}
