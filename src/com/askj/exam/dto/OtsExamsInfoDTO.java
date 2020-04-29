package com.askj.exam.dto;

/**
 * @Description  OtsExamsInfoDTO 的中文含义是: 考试信息表
 * @Creation     2017/03/08 14:23:01
 * @Written      Create Tool By zjf 
 **/
public class OtsExamsInfoDTO {
	
	/**
	 * @Description starttime的中文含义是： 考试开始时间（手动添加）
	 */
	private String starttime;
	/**
	 * @Description endTime的中文含义是： 考试结束时间（手动添加）
	 */
	private String endtime;
	/**
	 * @Description examsType的中文含义是： 考试类型 0=练习,1=考试（手动添加）
	 */
	private String examsType;
	/**
	 * @Description duration的中文含义是： 考试限时，0等于不限时（手动添加）
	 */
	private String duration;
	
	public String getStarttime() {
		return starttime;
	}
	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}
	public String getEndtime() {
		return endtime;
	}
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	public String getExamsType() {
		return examsType;
	}
	public void setExamsType(String examsType) {
		this.examsType = examsType;
	}
	public String getDuration() {
		return duration;
	}
	public void setDuration(String duration) {
		this.duration = duration;
	}

	/**
	 * @Description examsInfoId的中文含义是： 考试ID
	 */
	private String examsInfoId;

	/**
	 * @Description examsInfoState的中文含义是： 考试状态,0=禁用,1=启用（可用）
	 */
	private String examsInfoState;

	/**
	 * @Description examsInfoName的中文含义是： 考试名称
	 */
	private String examsInfoName;

	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	private String aae011;

	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	private String aae036;

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
	 * @Description examsInfoState的中文含义是： 考试状态,0=禁用,1=启用（可用）
	 */
	public void setExamsInfoState(String examsInfoState){ 
		this.examsInfoState = examsInfoState;
	}
	/**
	 * @Description examsInfoState的中文含义是： 考试状态,0=禁用,1=启用（可用）
	 */
	public String getExamsInfoState(){
		return examsInfoState;
	}
	/**
	 * @Description examsInfoName的中文含义是： 考试名称
	 */
	public void setExamsInfoName(String examsInfoName){ 
		this.examsInfoName = examsInfoName;
	}
	/**
	 * @Description examsInfoName的中文含义是： 考试名称
	 */
	public String getExamsInfoName(){
		return examsInfoName;
	}
	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	public void setAae011(String aae011){ 
		this.aae011 = aae011;
	}
	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	public String getAae011(){
		return aae011;
	}
	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	public void setAae036(String aae036){ 
		this.aae036 = aae036;
	}
	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	public String getAae036(){
		return aae036;
	}

}