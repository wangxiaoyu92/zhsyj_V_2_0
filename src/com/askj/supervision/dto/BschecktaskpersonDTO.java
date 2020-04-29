package com.askj.supervision.dto;

/**
 * @Description  BSCHECKTASKPERSON的中文含义是: 检查任务人员表DTO
 * @Creation     2016/11/01 10:39:35
 * @Written      Create Tool By zjf 
 **/
public class BschecktaskpersonDTO {
	
	/**
	 * @Description bmmc的中文含义是： 部门名称
	 */
	private String orgname;
	
	/**
	 * @Description orgid的中文含义是： 组织机构id
	 */
	private String orgid;
	
	/**
	 * @Description username的中文含义是： 用户名
	 */
	private String username;
	
	/**
	 * @Description description的中文含义是： 用户描述
	 */
	private String description;
	
	public String getOrgid() {
		return orgid;
	}
	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}
	public String getOrgname() {
		return orgname;
	}
	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	/**
	 * @Description id的中文含义是： 主键
	 */
	private String id;

	/**
	 * @Description taskid的中文含义是： 检查任务ID
	 */
	private String taskid;

	/**
	 * @Description userid的中文含义是： 检查人员ID
	 */
	private String userid;

	
		/**
	 * @Description id的中文含义是： 主键
	 */
	public void setId(String id){ 
		this.id = id;
	}
	/**
	 * @Description id的中文含义是： 主键
	 */
	public String getId(){
		return id;
	}
	/**
	 * @Description taskid的中文含义是： 检查任务ID
	 */
	public void setTaskid(String taskid){ 
		this.taskid = taskid;
	}
	/**
	 * @Description taskid的中文含义是： 检查任务ID
	 */
	public String getTaskid(){
		return taskid;
	}
	/**
	 * @Description userid的中文含义是： 检查人员ID
	 */
	public void setUserid(String userid){ 
		this.userid = userid;
	}
	/**
	 * @Description userid的中文含义是： 检查人员ID
	 */
	public String getUserid(){
		return userid;
	}

	
}