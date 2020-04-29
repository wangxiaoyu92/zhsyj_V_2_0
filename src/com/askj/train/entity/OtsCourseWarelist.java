package com.askj.train.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Timestamp;

@Table(value = "ots_course_warelist")
public class OtsCourseWarelist {
/** 课程课件对应表  */
	/** course_ware_id 的中文含义是：*/
	@Name
	@Column(value="course_ware_id")
	private String courseWareId;

	/** course_id 的中文含义是：课程ID*/
	@Column(value="course_id")
	private String courseId;

	/** ware_id 的中文含义是：课件ID*/
	@Column(value="ware_id")
	private String wareId;

	/** ware_sequence 的中文含义是：顺序号*/
	@Column(value="ware_sequence")
	private Integer wareSequence;

	/** elective_num 的中文含义是：*/
	@Column(value="elective_num")
	private String electiveNum;

	/** aae011 的中文含义是：经办人*/
	@Column(value="aae011")
	private String aae011;

	/** aae036 的中文含义是：经办时间*/
	@Column(value="aae036")
	private Timestamp aae036;


	public void setCourseWareId(String courseWareId){
		this.courseWareId=courseWareId;
	}

	public String getCourseWareId(){
		return courseWareId;
	}

	public void setCourseId(String courseId){
		this.courseId=courseId;
	}

	public String getCourseId(){
		return courseId;
	}

	public void setWareId(String wareId){
		this.wareId=wareId;
	}

	public String getWareId(){
		return wareId;
	}

	public void setWareSequence(Integer wareSequence){
		this.wareSequence=wareSequence;
	}

	public Integer getWareSequence(){
		return wareSequence;
	}

	public void setElectiveNum(String electiveNum){
		this.electiveNum=electiveNum;
	}

	public String getElectiveNum(){
		return electiveNum;
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

