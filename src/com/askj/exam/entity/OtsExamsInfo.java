package com.askj.exam.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  OtsExamsInfo的中文含义是: 考试信息表
 * @Creation     2017/03/08 14:22:55
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ots_exams_info")
public class OtsExamsInfo {
	/**
	 * @Description examsInfoId的中文含义是： 考试ID
	 */
	@Column ( value = "exams_info_id" )
	@Name
	private String examsInfoId;

	/**
	 * @Description examsInfoState的中文含义是： 考试状态,0=禁用,1=启用（可用）
	 */
	@Column ( value = "exams_info_state" )
	private String examsInfoState;

	/**
	 * @Description examsInfoName的中文含义是： 考试名称
	 */
	@Column ( value = "exams_info_name" )
	private String examsInfoName;

	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	@Column
	private String aae011;

	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	@Column
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
	public String toString() {
		return " { 'examsInfoId' : '" + examsInfoId + "', 'examsInfoState' : '"
				+ examsInfoState + "', 'examsInfoName' : '" + examsInfoName
				+ "', 'aae011' : '" + aae011 + "', 'aae036' : '" + aae036 + "' }";
	}
	
	
	
}