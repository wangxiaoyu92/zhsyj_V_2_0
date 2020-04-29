package com.askj.exam.dto;

/**
 * @Description  OtsExamUserDTO 的中文含义是: 考试用户中间表
 * @Creation     2017/03/13 15:32:17
 * @Written      Create Tool By zjf 
 **/
public class OtsExamUserDTO {
	
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
	
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUserkind() {
		return userkind;
	}
	public void setUserkind(String userkind) {
		this.userkind = userkind;
	}
	public String getOrgname() {
		return orgname;
	}
	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}

	/**
	 * @Description examUserId的中文含义是： 考试用户ID
	 */
	private String examUserId;

	/**
	 * @Description examsInfoId的中文含义是： 考试ID
	 */
	private String examsInfoId;

	/**
	 * @Description userId的中文含义是： 用户ID
	 */
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