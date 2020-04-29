package com.askj.exam.dto;

/**
 * @Description  OTS_PAPER_QSN_TYPE的中文含义是: 试卷题型对应表DTO
 * @Creation     2017/02/24 16:18:04
 * @Written      Create Tool By zjf 
 **/
public class OtsPaperQsnTypeDTO {
	/**
	 * @Description paperInfoId的中文含义是： 试卷ID
	 */
	private String paperInfoId;

	/**
	 * @Description qsnPoint的中文含义是： 每类试题分值
	 */
	private String qsnPoint;

	/**
	 * @Description qsnType的中文含义是： 试题类型
	 */
	private String qsnType;

	/**
	 * @Description qsnTypeTitle的中文含义是： 试题名称
	 */
	private String qsnTypeTitle;

	/**
	 * @Description qsnTypePosition的中文含义是： 试题所处试卷位置
	 */
	private String qsnTypePosition;

	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	private String aae011;

	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
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
	 * @Description qsnPoint的中文含义是： 每类试题分值
	 */
	public String getQsnPoint() {
		return qsnPoint;
	}
	/**
	 * @Description qsnPoint的中文含义是： 每类试题分值
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

	
}