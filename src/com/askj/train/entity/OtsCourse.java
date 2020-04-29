package com.askj.train.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Timestamp;

@Table(value = "ots_course")
public class OtsCourse {
/** 课程信息表  */
	/** course_id 的中文含义是：课件ID*/
	@Name
	@Column(value="course_id")
	private String courseId;

	/** course_name 的中文含义是：课件名称*/
	@Column(value="course_name")
	private String courseName;

	/** course_category 的中文含义是：课件分类*/
	@Column(value="course_category")
	private String courseCategory;

	/** course_status 的中文含义是：课程状态,1=启用,2=禁用,3=删除*/
	@Column(value="course_status")
	private Byte courseStatus;

	/** course_des 的中文含义是：课程描述*/
	@Column(value="course_des")
	private String courseDes;

	/** course_click 的中文含义是：*/
	@Column(value="course_click")
	private Integer courseClick;

	/** course_elective 的中文含义是：*/
	@Column(value="course_elective")
	private Byte courseElective;

	/** course_approve 的中文含义是：*/
	@Column(value="course_approve")
	private Byte courseApprove;

	/** course_pass_condition 的中文含义是：通过条件*/
	@Column(value="course_pass_condition")
	private String coursePassCondition;

	/** course_start_time 的中文含义是：开始学习时间*/
	@Column(value="course_start_time")
	private Timestamp courseStartTime;

	/** course_end_time 的中文含义是：结束学习时间*/
	@Column(value="course_end_time")
	private Timestamp courseEndTime;

	/** class_start_time 的中文含义是：线下上课开始时间*/
	@Column(value="class_start_time")
	private Timestamp classStartTime;

	/** class_end_time 的中文含义是：线下上课结束时间*/
	@Column(value="class_end_time")
	private Timestamp classEndTime;

	/** course_allow_ip 的中文含义是：IP段*/
	@Column(value="course_allow_ip")
	private String courseAllowIp;

	/** course_frontCoverImg 的中文含义是：封面图片*/
	@Column(value="course_frontCoverImg")
	private String courseFrontcoverimg;

	/** course_isModifyProgress 的中文含义是：播放限制*/
	@Column(value="course_isModifyProgress")
	private Byte courseIsmodifyprogress;

	/** course_train_type 的中文含义是：培训类型：线上培训 线下培训*/
	@Column(value="course_train_type")
	private String courseTrainType;

	/** course_offline_length 的中文含义是：线下课程时长*/
	@Column(value="course_offline_length")
	private Float courseOfflineLength;

	/** course_offline_credit 的中文含义是：线下课程学分*/
	@Column(value="course_offline_credit")
	private Float courseOfflineCredit;

	/** course_point_way 的中文含义是：学分计算方式(1-课件学分单算，0-整体通过计算)*/
	@Column(value="course_point_way")
	private Integer coursePointWay;

	/** course_isListShow 的中文含义是：学习计划中的课程是否前台课程列表中显示=1显示=0不显示默认是1*/
	@Column(value="course_isListShow")
	private Byte courseIslistshow;

	/** course_proportion 的中文含义是：课程要看到的百分比*/
	@Column(value="course_proportion")
	private Byte courseProportion;

	/** course_see_single 的中文含义是：1=每个课件都看到上面比例，0=所有课件累计比例达到*/
	@Column(value="course_see_single")
	private Byte courseSeeSingle;

	/** course_auto_adopt 的中文含义是：报名自动审核（0-不，1-是）*/
	@Column(value="course_auto_adopt")
	private Byte courseAutoAdopt;

	/** course_person_amount 的中文含义是：报名人数限制（0-不限制）*/
	@Column(value="course_person_amount")
	private Integer coursePersonAmount;

	/** course_courseLocation 的中文含义是：线下上课地点*/
	@Column(value="course_courseLocation")
	private String courseCourselocation;

	/** registration 的中文含义是：代报名(0-不允许,1-允许)*/
	@Column(value="registration")
	private Byte registration;

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

	public void setCourseName(String courseName){
		this.courseName=courseName;
	}

	public String getCourseName(){
		return courseName;
	}

	public void setCourseCategory(String courseCategory){
		this.courseCategory=courseCategory;
	}

	public String getCourseCategory(){
		return courseCategory;
	}

	public void setCourseStatus(Byte courseStatus){
		this.courseStatus=courseStatus;
	}

	public Byte getCourseStatus(){
		return courseStatus;
	}

	public void setCourseDes(String courseDes){
		this.courseDes=courseDes;
	}

	public String getCourseDes(){
		return courseDes;
	}

	public void setCourseClick(Integer courseClick){
		this.courseClick=courseClick;
	}

	public Integer getCourseClick(){
		return courseClick;
	}

	public void setCourseElective(Byte courseElective){
		this.courseElective=courseElective;
	}

	public Byte getCourseElective(){
		return courseElective;
	}

	public void setCourseApprove(Byte courseApprove){
		this.courseApprove=courseApprove;
	}

	public Byte getCourseApprove(){
		return courseApprove;
	}

	public void setCoursePassCondition(String coursePassCondition){
		this.coursePassCondition=coursePassCondition;
	}

	public String getCoursePassCondition(){
		return coursePassCondition;
	}

	public void setCourseStartTime(Timestamp courseStartTime){
		this.courseStartTime=courseStartTime;
	}

	public Timestamp getCourseStartTime(){
		return courseStartTime;
	}

	public void setCourseEndTime(Timestamp courseEndTime){
		this.courseEndTime=courseEndTime;
	}

	public Timestamp getCourseEndTime(){
		return courseEndTime;
	}

	public void setClassStartTime(Timestamp classStartTime){
		this.classStartTime=classStartTime;
	}

	public Timestamp getClassStartTime(){
		return classStartTime;
	}

	public void setClassEndTime(Timestamp classEndTime){
		this.classEndTime=classEndTime;
	}

	public Timestamp getClassEndTime(){
		return classEndTime;
	}

	public void setCourseAllowIp(String courseAllowIp){
		this.courseAllowIp=courseAllowIp;
	}

	public String getCourseAllowIp(){
		return courseAllowIp;
	}

	public void setCourseFrontcoverimg(String courseFrontcoverimg){
		this.courseFrontcoverimg=courseFrontcoverimg;
	}

	public String getCourseFrontcoverimg(){
		return courseFrontcoverimg;
	}

	public void setCourseIsmodifyprogress(Byte courseIsmodifyprogress){
		this.courseIsmodifyprogress=courseIsmodifyprogress;
	}

	public Byte getCourseIsmodifyprogress(){
		return courseIsmodifyprogress;
	}

	public void setCourseTrainType(String courseTrainType){
		this.courseTrainType=courseTrainType;
	}

	public String getCourseTrainType(){
		return courseTrainType;
	}

	public void setCourseOfflineLength(Float courseOfflineLength){
		this.courseOfflineLength=courseOfflineLength;
	}

	public Float getCourseOfflineLength(){
		return courseOfflineLength;
	}

	public void setCourseOfflineCredit(Float courseOfflineCredit){
		this.courseOfflineCredit=courseOfflineCredit;
	}

	public Float getCourseOfflineCredit(){
		return courseOfflineCredit;
	}

	public void setCoursePointWay(Integer coursePointWay){
		this.coursePointWay=coursePointWay;
	}

	public Integer getCoursePointWay(){
		return coursePointWay;
	}

	public void setCourseIslistshow(Byte courseIslistshow){
		this.courseIslistshow=courseIslistshow;
	}

	public Byte getCourseIslistshow(){
		return courseIslistshow;
	}

	public void setCourseProportion(Byte courseProportion){
		this.courseProportion=courseProportion;
	}

	public Byte getCourseProportion(){
		return courseProportion;
	}

	public void setCourseSeeSingle(Byte courseSeeSingle){
		this.courseSeeSingle=courseSeeSingle;
	}

	public Byte getCourseSeeSingle(){
		return courseSeeSingle;
	}

	public void setCourseAutoAdopt(Byte courseAutoAdopt){
		this.courseAutoAdopt=courseAutoAdopt;
	}

	public Byte getCourseAutoAdopt(){
		return courseAutoAdopt;
	}

	public void setCoursePersonAmount(Integer coursePersonAmount){
		this.coursePersonAmount=coursePersonAmount;
	}

	public Integer getCoursePersonAmount(){
		return coursePersonAmount;
	}

	public void setCourseCourselocation(String courseCourselocation){
		this.courseCourselocation=courseCourselocation;
	}

	public String getCourseCourselocation(){
		return courseCourselocation;
	}

	public void setRegistration(Byte registration){
		this.registration=registration;
	}

	public Byte getRegistration(){
		return registration;
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

