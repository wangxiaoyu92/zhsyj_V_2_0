package com.askj.exam.dto;

/**
 * @Description  OtsResultMateDTO 的中文含义是: 用户考试信息表,开始考试便插入一条数据
 * @Creation     2017/03/13 17:02:07
 * @Written      Create Tool By zjf 
 **/
public class OtsResultMateDTO {
	/**
	 * @Description resultMateId的中文含义是： 用户考试信息ID
	 */
	private String resultMateId;

	/**
	 * @Description resultInfoId的中文含义是： 考试结果信息ID(空=还没有考试结束)
	 */
	private String resultInfoId;

	/**
	 * @Description examInfoId的中文含义是： 关联的考试ID
	 */
	private String examInfoId;

	/**
	 * @Description userId的中文含义是： 用户ID
	 */
	private String userId;
	
	/**
	 * @Description points的中文含义是： 总分
	 */
	private String points;

	/**
	 * @Description paperInfoId的中文含义是： 试卷ID
	 */
	private String paperInfoId;
	
	
	public String getPaperInfoId() {
		return paperInfoId;
	}
	public void setPaperInfoId(String paperInfoId) {
		this.paperInfoId = paperInfoId;
	}
	/**
	 * @Description examsPapersId的中文含义是： 关联考试所使用的试卷`ots_exams_papers`.exams_papers_id
	 */
	private String examsPapersId;
	
	

	/**
	 * @Description courseId的中文含义是： 关联课程ID,表示课程中的考试,`course_id`<>""表示计划课程中的考试
	 */
	private String courseId;

	/**
	 * @Description planId的中文含义是： 关联计划ID,表示计划中考试,`plan_id`<>""表示计划课程中的考试
	 */
	private String planId;

	/**
	 * @Description showTime的中文含义是： 进入考试时间
	 */
	private String showTime;

	/**
	 * @Description times的中文含义是： 当前考试次数,0=表示培训考试,`courseId`和`planId`同时为""则是预先申请数据
	 */
	private String times;

	/**
	 * @Description ipAddress的中文含义是： IP地址
	 */
	private String ipAddress;

	/**
	 * @Description judge的中文含义是： 评分人ID(空=未评卷)
	 */
	private String judge;
	
	
	/**
	 * @Description userName的中文含义是： 用户名（手动添加）
	 */
	private String userName;

	/**
	 * @Description description的中文含义是： 用户描述（手动添加）
	 */
	private String description;

	/**
	 * @Description aac002的中文含义是： 身份证号（手动添加）
	 */
	private String aac002;
	
	/**
	 * @Description costtimes的中文含义是： 已经答卷时间 （手动添加）
	 */
	private String costtimes;
		public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getAac002() {
		return aac002;
	}
	public void setAac002(String aac002) {
		this.aac002 = aac002;
	}
	public String getCosttimes() {
		return costtimes;
	}
	public void setCosttimes(String costtimes) {
		this.costtimes = costtimes;
	}
		/**
	 * @Description resultMateId的中文含义是： 用户考试信息ID
	 */
	public void setResultMateId(String resultMateId){ 
		this.resultMateId = resultMateId;
	}
	/**
	 * @Description resultMateId的中文含义是： 用户考试信息ID
	 */
	public String getResultMateId(){
		return resultMateId;
	}
	/**
	 * @Description resultInfoId的中文含义是： 考试结果信息ID(空=还没有考试结束)
	 */
	public void setResultInfoId(String resultInfoId){ 
		this.resultInfoId = resultInfoId;
	}
	/**
	 * @Description resultInfoId的中文含义是： 考试结果信息ID(空=还没有考试结束)
	 */
	public String getResultInfoId(){
		return resultInfoId;
	}
	/**
	 * @Description examInfoId的中文含义是： 关联的考试ID
	 */
	public void setExamInfoId(String examInfoId){ 
		this.examInfoId = examInfoId;
	}
	/**
	 * @Description examInfoId的中文含义是： 关联的考试ID
	 */
	public String getExamInfoId(){
		return examInfoId;
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
	/**
	 * @Description examsPapersId的中文含义是： 关联考试所使用的试卷`ots_exams_papers`.exams_papers_id
	 */
	public void setExamsPapersId(String examsPapersId){ 
		this.examsPapersId = examsPapersId;
	}
	/**
	 * @Description examsPapersId的中文含义是： 关联考试所使用的试卷`ots_exams_papers`.exams_papers_id
	 */
	public String getExamsPapersId(){
		return examsPapersId;
	}
	/**
	 * @Description courseId的中文含义是： 关联课程ID,表示课程中的考试,`course_id`<>""表示计划课程中的考试
	 */
	public void setCourseId(String courseId){ 
		this.courseId = courseId;
	}
	/**
	 * @Description courseId的中文含义是： 关联课程ID,表示课程中的考试,`course_id`<>""表示计划课程中的考试
	 */
	public String getCourseId(){
		return courseId;
	}
	/**
	 * @Description planId的中文含义是： 关联计划ID,表示计划中考试,`plan_id`<>""表示计划课程中的考试
	 */
	public void setPlanId(String planId){ 
		this.planId = planId;
	}
	/**
	 * @Description planId的中文含义是： 关联计划ID,表示计划中考试,`plan_id`<>""表示计划课程中的考试
	 */
	public String getPlanId(){
		return planId;
	}
	/**
	 * @Description showTime的中文含义是： 进入考试时间
	 */
	public void setShowTime(String showTime){ 
		this.showTime = showTime;
	}
	/**
	 * @Description showTime的中文含义是： 进入考试时间
	 */
	public String getShowTime(){
		return showTime;
	}
	/**
	 * @Description times的中文含义是： 当前考试次数,0=表示培训考试,`courseId`和`planId`同时为""则是预先申请数据
	 */
	public void setTimes(String times){ 
		this.times = times;
	}
	/**
	 * @Description times的中文含义是： 当前考试次数,0=表示培训考试,`courseId`和`planId`同时为""则是预先申请数据
	 */
	public String getTimes(){
		return times;
	}
	/**
	 * @Description ipAddress的中文含义是： IP地址
	 */
	public void setIpAddress(String ipAddress){ 
		this.ipAddress = ipAddress;
	}
	/**
	 * @Description ipAddress的中文含义是： IP地址
	 */
	public String getIpAddress(){
		return ipAddress;
	}
	/**
	 * @Description judge的中文含义是： 评分人ID(空=未评卷)
	 */
	public void setJudge(String judge){ 
		this.judge = judge;
	}
	/**
	 * @Description judge的中文含义是： 评分人ID(空=未评卷)
	 */
	public String getJudge(){
		return judge;
	}
	public String getPoints() {
		return points;
	}
	public void setPoints(String points) {
		this.points = points;
	}

	
}