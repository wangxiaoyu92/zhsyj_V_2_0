package com.askj.exam.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  OtsResultMate的中文含义是: 用户考试信息表,开始考试便插入一条数据
 * @Creation     2017/03/13 17:02:15
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ots_result_mate")
public class OtsResultMate {
	/**
	 * @Description resultMateId的中文含义是： 用户考试信息ID
	 */
	@Column ( value = "result_mate_id" )
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_result_mate_id')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_result_mate_id.nextval from dual"))
	private String resultMateId;

	/**
	 * @Description resultInfoId的中文含义是： 考试结果信息ID(空=还没有考试结束)
	 */
	@Column ( value = "result_info_id" )
	private String resultInfoId;

	/**
	 * @Description examInfoId的中文含义是： 关联的考试ID
	 */
	@Column ( value = "exam_info_id" )
	private String examInfoId;

	/**
	 * @Description userId的中文含义是： 用户ID
	 */
	@Column ( value = "user_id" )
	private String userId;

	/**
	 * @Description examsPapersId的中文含义是： 关联考试所使用的试卷`ots_exams_papers`.exams_papers_id
	 */
	@Column ( value = "exams_papers_id" )
	private String examsPapersId;

	/**
	 * @Description courseId的中文含义是： 关联课程ID,表示课程中的考试,`course_id`<>""表示计划课程中的考试
	 */
	@Column ( value = "course_id" )
	private String courseId;

	/**
	 * @Description planId的中文含义是： 关联计划ID,表示计划中考试,`plan_id`<>""表示计划课程中的考试
	 */
	@Column ( value = "plan_id" )
	private String planId;

	/**
	 * @Description showTime的中文含义是： 进入考试时间
	 */
	@Column ( value = "show_time" )
	private String showTime;

	/**
	 * @Description times的中文含义是： 当前考试次数,0=表示培训考试,`courseId`和`planId`同时为""则是预先申请数据
	 */
	@Column
	private String times;

	/**
	 * @Description ipAddress的中文含义是： IP地址
	 */
	@Column ( value = "ip_address" )
	private String ipAddress;

	/**
	 * @Description judge的中文含义是： 评分人ID(空=未评卷)
	 */
	@Column
	private String judge;

	
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

	
}