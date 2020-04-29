package com.askj.exam.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  OTS_PAPER_CONTENT的中文含义是: 试卷内容表
 * @Creation     2017/02/24 16:17:45
 * @Written      Create Tool By zjf 
 **/
@Table(value = "OTS_PAPER_CONTENT")
@PK({"paperInfoId", "qsnInfoId"})
public class OtsPaperContent {
	/**
	 * @Description paperInfoId的中文含义是： 试卷ID
	 */
	@Column(value = "paper_info_id")
	private String paperInfoId;

	/**
	 * @Description qsnInfoId的中文含义是： 试题ID
	 */
	@Column(value = "qsn_info_id")
	private String qsnInfoId;

	/**
	 * @Description qsnTypePosition的中文含义是： 试题大题题型所处试卷位置
	 */
	@Column(value = "qsn_type_position")
	private String qsnTypePosition;

	/**
	 * @Description qsnInfoPosition的中文含义是： 试题所处大题位置
	 */
	@Column(value = "qsn_info_position")
	private String qsnInfoPosition;

	/**
	 * @Description qsnInfoPoint的中文含义是： 试题分值
	 */
	@Column(value = "qsn_info_point")
	private String qsnInfoPoint;

	/**
	 * @Description qsnInfoType的中文含义是： 试题类型
	 */
	@Column(value = "qsn_info_type")
	private String qsnInfoType;

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
	 * @Description qsnInfoId的中文含义是： 试题ID
	 */
	public String getQsnInfoId() {
		return qsnInfoId;
	}
	/**
	 * @Description qsnInfoId的中文含义是： 试题ID
	 */
	public void setQsnInfoId(String qsnInfoId) {
		this.qsnInfoId = qsnInfoId;
	}
	/**
	 * @Description qsnTypePosition的中文含义是： 试题大题题型所处试卷位置
	 */
	public String getQsnTypePosition() {
		return qsnTypePosition;
	}
	/**
	 * @Description qsnTypePosition的中文含义是： 试题大题题型所处试卷位置
	 */
	public void setQsnTypePosition(String qsnTypePosition) {
		this.qsnTypePosition = qsnTypePosition;
	}
	/**
	 * @Description qsnInfoPosition的中文含义是： 试题所处大题位置
	 */
	public String getQsnInfoPosition() {
		return qsnInfoPosition;
	}
	/**
	 * @Description qsnInfoPosition的中文含义是： 试题所处大题位置
	 */
	public void setQsnInfoPosition(String qsnInfoPosition) {
		this.qsnInfoPosition = qsnInfoPosition;
	}
	/**
	 * @Description qsnInfoPoint的中文含义是： 试题分值
	 */
	public String getQsnInfoPoint() {
		return qsnInfoPoint;
	}
	/**
	 * @Description qsnInfoPoint的中文含义是： 试题分值
	 */
	public void setQsnInfoPoint(String qsnInfoPoint) {
		this.qsnInfoPoint = qsnInfoPoint;
	}
	/**
	 * @Description qsnInfoType的中文含义是： 试题类型
	 */
	public String getQsnInfoType() {
		return qsnInfoType;
	}
	/**
	 * @Description qsnInfoType的中文含义是： 试题类型
	 */
	public void setQsnInfoType(String qsnInfoType) {
		this.qsnInfoType = qsnInfoType;
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