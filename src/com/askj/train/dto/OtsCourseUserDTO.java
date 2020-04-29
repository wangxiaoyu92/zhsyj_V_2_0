package com.askj.train.dto;
/**
 * @Description  OtsCourseUserDTO 的中文含义是: 课程用户中间表
 * @Creation     2017/04/17 15:32:17
 * @Written      Create Tool By kyb 
 **/
public class OtsCourseUserDTO {

	/**
	 * @Description username的中文含义是： 用户名（手动添加）
	 */
	private String username;
	/**
	 * @Description userkind的中文含义是： 用户类别（手动添加）
	 */
	private String userkind;
	/**
	 * @Description description的中文含义是： 用户描述（手动添加）
	 */
	private String description;
	/**
	 * @Description mobile的中文含义是： 用户手机号（手动添加）
	 */
	private String mobile;
	/**
	 * @Description orgname的中文含义是： 组织结构名（手动添加）
	 */
	private String orgname;
	
	/**
	 * @Description username的中文含义是： 用户名（手动添加）
	 */
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	/**
	 * @Description userkind的中文含义是： 用户类别（手动添加）
	 */
	public String getUserkind() {
		return userkind;
	}
	public void setUserkind(String userkind) {
		this.userkind = userkind;
	}
	/**
	 * @Description description的中文含义是： 用户描述（手动添加）
	 */
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	/**
	 * @Description mobile的中文含义是： 用户手机号（手动添加）
	 */
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	/**
	 * @Description orgname的中文含义是： 组织结构名（手动添加）
	 */
	public String getOrgname() {
		return orgname;
	}
	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}
	/**
	 * @Description courseUserId的中文含义是： 课程用户ID
	 */
	private String courseUserId;
	/**
	 * @Description courseId的中文含义是： 课程ID
	 */
	private String courseId;
	/**
	 * @Description userId的中文含义是： 用户ID
	 */
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
