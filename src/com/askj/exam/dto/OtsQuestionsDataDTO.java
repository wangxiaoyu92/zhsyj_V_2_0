package com.askj.exam.dto;

/**
 * @Description  OTS_QUESTIONS_DATA的中文含义是: 试题数据表DTO
 * @Creation     2017/02/16 10:57:54
 * @Written      Create Tool By zjf 
 **/
public class OtsQuestionsDataDTO {
	
	/**
	 * @Description qsnDataId的中文含义是： 试题数据ID
	 */
	private String qsnDataId;

	/**
	 * @Description qsnInfoId的中文含义是： 关联试题信息ID
	 */
	private String qsnInfoId;

	/**
	 * @Description qsnDataCom的中文含义是： 组件元素:input richtext)
	 */
	private String qsnDataCom;

	/**
	 * @Description qsnDataOption的中文含义是： 组件参数[选项]
	 */
	private String qsnDataOption;

	/**
	 * @Description qsnDataOptiondesc的中文含义是： 组件参数[选项描述]
	 */
	private String qsnDataOptiondesc;

	/**
	 * @Description qsnDataIsanswer的中文含义是： 组件参数[是否为答案]
	 */
	private String qsnDataIsanswer;

	/**
	 * @Description qsnDataSort的中文含义是： 当前结构在整体的位置
	 */
	private String qsnDataSort;

	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	private String aae011;

	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	private String aae036;

	
	public String getQsnDataId() {
		return qsnDataId;
	}
	public void setQsnDataId(String qsnDataId) {
		this.qsnDataId = qsnDataId;
	}
	public String getQsnInfoId() {
		return qsnInfoId;
	}
	public void setQsnInfoId(String qsnInfoId) {
		this.qsnInfoId = qsnInfoId;
	}
	public String getQsnDataCom() {
		return qsnDataCom;
	}
	public void setQsnDataCom(String qsnDataCom) {
		this.qsnDataCom = qsnDataCom;
	}
	public String getQsnDataOption() {
		return qsnDataOption;
	}
	public void setQsnDataOption(String qsnDataOption) {
		this.qsnDataOption = qsnDataOption;
	}
	public String getQsnDataOptiondesc() {
		return qsnDataOptiondesc;
	}
	public void setQsnDataOptiondesc(String qsnDataOptiondesc) {
		this.qsnDataOptiondesc = qsnDataOptiondesc;
	}
	public String getQsnDataIsanswer() {
		return qsnDataIsanswer;
	}
	public void setQsnDataIsanswer(String qsnDataIsanswer) {
		this.qsnDataIsanswer = qsnDataIsanswer;
	}
	public String getQsnDataSort() {
		return qsnDataSort;
	}
	public void setQsnDataSort(String qsnDataSort) {
		this.qsnDataSort = qsnDataSort;
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