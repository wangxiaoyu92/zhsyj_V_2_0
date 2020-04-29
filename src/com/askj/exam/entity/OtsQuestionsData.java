package com.askj.exam.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  OTS_QUESTIONS_DATA的中文含义是: 试题数据表
 * @Creation     2017/02/16 10:58:55
 * @Written      Create Tool By zjf 
 **/
@Table(value = "OTS_QUESTIONS_DATA")
public class OtsQuestionsData {
	
	/**
	 * @Description qsnDataId的中文含义是： 试题数据ID
	 */
	@Column(value = "qsn_data_id")
	@Name
	private String qsnDataId;

	/**
	 * @Description qsnInfoId的中文含义是： 关联试题信息ID
	 */
	@Column(value = "qsn_info_id")
	private String qsnInfoId;

	/**
	 * @Description qsnDataCom的中文含义是： 组件元素:input richtext)
	 */
	@Column(value = "qsn_data_com")
	private String qsnDataCom;

	/**
	 * @Description qsnDataOption的中文含义是： 组件参数[选项]
	 */
	@Column(value = "qsn_data_option")
	private String qsnDataOption;

	/**
	 * @Description qsnDataOptiondesc的中文含义是： 组件参数[选项描述]
	 */
	@Column(value = "qsn_data_optiondesc")
	private String qsnDataOptiondesc;

	/**
	 * @Description qsnDataIsanswer的中文含义是： 组件参数[是否为答案]
	 */
	@Column(value = "qsn_data_isanswer")
	private String qsnDataIsanswer;

	/**
	 * @Description qsnDataSort的中文含义是： 当前结构在整体的位置
	 */
	@Column(value = "qsn_data_sort")
	private String qsnDataSort;

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
	 * @Description qsnDataId的中文含义是： 试题数据ID
	 */
	public String getQsnDataId() {
		return qsnDataId;
	}
	/**
	 * @Description qsnDataId的中文含义是： 试题数据ID
	 */
	public void setQsnDataId(String qsnDataId) {
		this.qsnDataId = qsnDataId;
	}
	/**
	 * @Description qsnInfoId的中文含义是： 关联试题信息ID
	 */
	public String getQsnInfoId() {
		return qsnInfoId;
	}
	/**
	 * @Description qsnInfoId的中文含义是： 关联试题信息ID
	 */
	public void setQsnInfoId(String qsnInfoId) {
		this.qsnInfoId = qsnInfoId;
	}
	/**
	 * @Description qsnDataCom的中文含义是： 组件元素:input richtext)
	 */
	public String getQsnDataCom() {
		return qsnDataCom;
	}
	/**
	 * @Description qsnDataCom的中文含义是： 组件元素:input richtext)
	 */
	public void setQsnDataCom(String qsnDataCom) {
		this.qsnDataCom = qsnDataCom;
	}
	/**
	 * @Description qsnDataOption的中文含义是： 组件参数[选项]
	 */
	public String getQsnDataOption() {
		return qsnDataOption;
	}
	/**
	 * @Description qsnDataOption的中文含义是： 组件参数[选项]
	 */
	public void setQsnDataOption(String qsnDataOption) {
		this.qsnDataOption = qsnDataOption;
	}
	/**
	 * @Description qsnDataOptiondesc的中文含义是： 组件参数[选项描述]
	 */
	public String getQsnDataOptiondesc() {
		return qsnDataOptiondesc;
	}
	/**
	 * @Description qsnDataOptiondesc的中文含义是： 组件参数[选项描述]
	 */
	public void setQsnDataOptiondesc(String qsnDataOptiondesc) {
		this.qsnDataOptiondesc = qsnDataOptiondesc;
	}
	/**
	 * @Description qsnDataIsanswer的中文含义是： 组件参数[是否为答案]
	 */
	public String getQsnDataIsanswer() {
		return qsnDataIsanswer;
	}
	/**
	 * @Description qsnDataIsanswer的中文含义是： 组件参数[是否为答案]
	 */
	public void setQsnDataIsanswer(String qsnDataIsanswer) {
		this.qsnDataIsanswer = qsnDataIsanswer;
	}
	/**
	 * @Description qsnDataSort的中文含义是： 当前结构在整体的位置
	 */
	public String getQsnDataSort() {
		return qsnDataSort;
	}
	/**
	 * @Description qsnDataSort的中文含义是： 当前结构在整体的位置
	 */
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
	@Override
	public String toString() {
		return " { 'qsnDataId' : '" + qsnDataId + "', 'qsnInfoId' : '"
				+ qsnInfoId + "', 'qsnDataCom' : '" + qsnDataCom + "', 'qsnDataOption' : '"
				+ qsnDataOption + "', 'qsnDataOptiondesc' : '" + qsnDataOptiondesc
				+ "', 'qsnDataIsanswer' : '" + qsnDataIsanswer + "', 'qsnDataSort' : '"
				+ qsnDataSort + "', 'aae011' : '" + aae011 + "', 'aae036' : '" + aae036
				+ "' } ";
	}
	
}