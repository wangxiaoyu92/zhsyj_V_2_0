package com.askj.train.dto;

import java.sql.Timestamp;

/**
 * 
 *  OtsCourseDTO的中文名称：课程信息表
 *
 *  OtsCourseDTO的描述：
 *
 *  @author : zy
 *  @version : V1.0
 */
public class OtsCourseDTO {
	
	/** userid 的中文含义是：用户id（手动添加）*/
	private String userid;
	
	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	/** score 的中文含义是：对该课程的评价分数（手动添加）*/
	private String score;

	public String getScore() {
		return score;
	}

	public void setScore(String score) {
		this.score = score;
	}

	/** courseWares 的中文含义是：课程对应课件（手动添加）*/
	private String courseWares;
	
	public String getCourseWares() {
		return courseWares;
	}

	public void setCourseWares(String courseWares) {
		this.courseWares = courseWares;
	}
	
	/** warecount 的中文含义是：课程对应课件数（手动添加）*/
	private String warecount;
	
	public String getWarecount() {
		return warecount;
	}

	public void setWarecount(String warecount) {
		this.warecount = warecount;
	}

	/** courseTeachers 的中文含义是：课程对应教师（手动添加）*/
	private String courseTeachers;

	public String getCourseTeachers() {
		return courseTeachers;
	}

	public void setCourseTeachers(String courseTeachers) {
		this.courseTeachers = courseTeachers;
	}

	/** course_id 的中文含义是：课程ID*/
	private String courseId;

	/** course_name 的中文含义是：课程名称*/
	private String courseName;
	/** course_name 的中文含义是：教师名称*/
	private String teacherName;
	/** course_category 的中文含义是：课程分类*/
	private String courseCategory;

	/** course_status 的中文含义是：课程状态,1=启用,2=禁用*/
	private Byte courseStatus;

	/** course_des 的中文含义是：课程描述*/
	private String courseDes;

	/** course_click 的中文含义是：*/
	private Integer courseClick;

	/** course_elective 的中文含义是：*/
	private Byte courseElective;

	/** course_approve 的中文含义是：*/
	private Byte courseApprove;

	/** course_pass_condition 的中文含义是：通过条件*/
	private String coursePassCondition;

	/** course_start_time 的中文含义是：开始学习时间*/
	private Timestamp courseStartTime;

	/** course_end_time 的中文含义是：结束学习时间*/
	private Timestamp courseEndTime;

	/** class_start_time 的中文含义是：线下上课开始时间*/
	private Timestamp classStartTime;

	/** class_end_time 的中文含义是：线下上课结束时间*/
	private Timestamp classEndTime;

	/** course_allow_ip 的中文含义是：IP段*/
	private String courseAllowIp;

	/** course_frontCoverImg 的中文含义是：封面图片*/
	private String courseFrontcoverimg;

	/** course_isModifyProgress 的中文含义是：播放限制*/
	private Byte courseIsmodifyprogress;

	/** course_train_type 的中文含义是：培训类型：线上培训 线下培训*/
	private String courseTrainType;

	/** course_offline_length 的中文含义是：线下课程时长*/
	private Float courseOfflineLength;

	/** course_offline_credit 的中文含义是：线下课程学分*/
	private Float courseOfflineCredit;

	/** course_point_way 的中文含义是：学分计算方式(1-课件学分单算，0-整体通过计算)*/
	private Integer coursePointWay;

	/** course_isListShow 的中文含义是：学习计划中的课程是否前台课程列表中显示=1显示=0不显示默认是1*/
	private Byte courseIslistshow;

	/** course_proportion 的中文含义是：课程要看到的百分比*/
	private Byte courseProportion;

	/** course_see_single 的中文含义是：1=每个课件都看到上面比例，0=所有课件累计比例达到*/
	private Byte courseSeeSingle;

	/** course_auto_adopt 的中文含义是：报名自动审核（0-不，1-是）*/
	private Byte courseAutoAdopt;

	/** course_person_amount 的中文含义是：报名人数限制（0-不限制）*/
	private Integer coursePersonAmount;

	/** course_courseLocation 的中文含义是：线下上课地点*/
	private String courseCourselocation;

	/** registration 的中文含义是：代报名(0-不允许,1-允许)*/
	private Byte registration;

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

	public String getTeacherName() {
		return teacherName;
	}

	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
	}

}

