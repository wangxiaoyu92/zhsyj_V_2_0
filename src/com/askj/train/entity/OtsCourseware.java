package com.askj.train.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.math.BigDecimal;
import java.sql.Timestamp;

@Table(value = "ots_courseware")
public class OtsCourseware {
/** 课件信息表  */
	/** ware_id 的中文含义是：课件ID*/
	@Name
	@Column(value="ware_id")
	private String wareId;

	/** ware_name 的中文含义是：课件名称*/
	@Column(value="ware_name")
	private String wareName;

	/** ware_status 的中文含义是：课件状态*/
	@Column(value="ware_status")
	private String wareStatus;

	/** ware_credit 的中文含义是：所需积分*/
	@Column(value="ware_credit")
	private Integer wareCredit;

	/** ware_category 的中文含义是：课件分类ID*/
	@Column(value="ware_category")
	private String wareCategory;

	/** ware_type 的中文含义是：课件类型*/
	@Column(value="ware_type")
	private String wareType;

	/** ware_source 的中文含义是：课件来源ID*/
	@Column(value="ware_source")
	private String wareSource;

	/** ware_video 的中文含义是：课件路径*/
	@Column(value="ware_video")
	private String wareVideo;

	/** ware_des 的中文含义是：课件讲义源码*/
	@Column(value="ware_des")
	private String wareDes;

	/** ware_length 的中文含义是：媒体时长*/
	@Column(value="ware_length")
	private Float wareLength;

	/** ware_des_h 的中文含义是：课件讲义源码*/
	@Column(value="ware_des_h")
	private String wareDesH;

	/** ware_point 的中文含义是：课件学分*/
	@Column(value="ware_point")
	private BigDecimal warePoint;

	/** aae011 的中文含义是：经办人*/
	@Column(value="aae011")
	private String aae011;

	/** aae036 的中文含义是：经办时间*/
	@Column(value="aae036")
	private Timestamp aae036;


	public void setWareId(String wareId){
		this.wareId=wareId;
	}

	public String getWareId(){
		return wareId;
	}

	public void setWareName(String wareName){
		this.wareName=wareName;
	}

	public String getWareName(){
		return wareName;
	}

	public void setWareStatus(String wareStatus){
		this.wareStatus=wareStatus;
	}

	public String getWareStatus(){
		return wareStatus;
	}

	public void setWareCredit(Integer wareCredit){
		this.wareCredit=wareCredit;
	}

	public Integer getWareCredit(){
		return wareCredit;
	}

	public void setWareCategory(String wareCategory){
		this.wareCategory=wareCategory;
	}

	public String getWareCategory(){
		return wareCategory;
	}

	public void setWareType(String wareType){
		this.wareType=wareType;
	}

	public String getWareType(){
		return wareType;
	}

	public void setWareSource(String wareSource){
		this.wareSource=wareSource;
	}

	public String getWareSource(){
		return wareSource;
	}

	public void setWareVideo(String wareVideo){
		this.wareVideo=wareVideo;
	}

	public String getWareVideo(){
		return wareVideo;
	}

	public void setWareDes(String wareDes){
		this.wareDes=wareDes;
	}

	public String getWareDes(){
		return wareDes;
	}

	public void setWareLength(Float wareLength){
		this.wareLength=wareLength;
	}

	public Float getWareLength(){
		return wareLength;
	}

	public void setWareDesH(String wareDesH){
		this.wareDesH=wareDesH;
	}

	public String getWareDesH(){
		return wareDesH;
	}

	public void setWarePoint(BigDecimal warePoint){
		this.warePoint=warePoint;
	}

	public BigDecimal getWarePoint(){
		return warePoint;
	}

	public void setAae011(String aae011){
		this.aae011=aae011;
	}

	public String getAae011(){
		return aae011;
	}

	public Timestamp getAae036() {
		return aae036;
	}

	public void setAae036(Timestamp aae036) {
		this.aae036 = aae036;
	}


}

