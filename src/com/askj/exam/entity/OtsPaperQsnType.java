package com.askj.exam.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  OTS_PAPER_QSN_TYPE的中文含义是: 试卷题型对应表
 * @Creation     2017/02/24 16:17:57
 * @Written      Create Tool By zjf 
 **/
@Table(value = "OTS_PAPER_QSN_TYPE")
@PK({"paperInfoId", "qsnType", "qsnTypePosition"})
public class OtsPaperQsnType {
	/**
	 * @Description paperInfoId的中文含义是： 试卷ID
	 */
	@Column(value = "paper_info_id")
	private String paperInfoId;

	/**
	 * @Description qsn_point的中文含义是： 每类试题分值
	 */
	@Column(value = "qsn_point")
	private String qsnPoint;

	/**
	 * @Description qsnType的中文含义是： 试题类型
	 */
	@Column(value = "qsn_type")
	private String qsnType;

	/**
	 * @Description qsnTypeTitle的中文含义是： 试题名称
	 */
	@Column(value = "qsn_type_title")
	private String qsnTypeTitle;

	/**
	 * @Description qsnTypePosition的中文含义是： 试题所处试卷位置
	 */
	@Column(value = "qsn_type_position")
	private String qsnTypePosition;

	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	@Column(value = "aae011")
	private String aae011;

	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	@Column(value = "aae036")
	private String aae036;

	/**
	 * @Description paperInfoId的中文含义是： 试卷ID
	 */
	public String getPaperInfoId() {
		return paperInfoId;
	}
	/**
	 * @Description paperInfoId的中文含义是： 试卷ID
	 */
	public void setPaperInfoId(String paperInfoId) {
		this.paperInfoId = paperInfoId;
	}
	/**
	 * @Description qsn_point的中文含义是： 每类试题分值
	 */
	public String getQsnPoint() {
		return qsnPoint;
	}
	/**
	 * @Description qsn_point的中文含义是： 每类试题分值
	 */
	public void setQsnPoint(String qsnPoint) {
		this.qsnPoint = qsnPoint;
	}
	/**
	 * @Description qsnType的中文含义是： 试题类型
	 */
	public String getQsnType() {
		return qsnType;
	}
	/**
	 * @Description qsnType的中文含义是： 试题类型
	 */
	public void setQsnType(String qsnType) {
		this.qsnType = qsnType;
	}
	/**
	 * @Description qsnTypeTitle的中文含义是： 试题名称
	 */
	public String getQsnTypeTitle() {
		return qsnTypeTitle;
	}
	/**
	 * @Description qsnTypeTitle的中文含义是： 试题名称
	 */
	public void setQsnTypeTitle(String qsnTypeTitle) {
		this.qsnTypeTitle = qsnTypeTitle;
	}
	/**
	 * @Description qsnTypePosition的中文含义是： 试题所处试卷位置
	 */
	public String getQsnTypePosition() {
		return qsnTypePosition;
	}
	/**
	 * @Description qsnTypePosition的中文含义是： 试题所处试卷位置
	 */
	public void setQsnTypePosition(String qsnTypePosition) {
		this.qsnTypePosition = qsnTypePosition;
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
	@Override
	public String toString() {
		return " { 'paperInfoId' : '" + paperInfoId
				+ "', 'qsnPoint' : '" + qsnPoint + "', 'qsnType' : '" + qsnType
				+ "', 'qsnTypeTitle' : '" + qsnTypeTitle + "', 'qsnTypePosition' : '"
				+ qsnTypePosition + "', 'aae011' : '" + aae011 + "', 'aae036' : '"
				+ aae036 + "'} ";
	}
	
}