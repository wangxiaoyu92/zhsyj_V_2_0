package com.askj.exam.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  OTS_QUESTIONS_INFO的中文含义是: 试题信息表
 * @Creation     2017/02/16 14:09:53
 * @Written      Create Tool By zjf 
 **/
@Table(value = "OTS_QUESTIONS_INFO")
public class OtsQuestionsInfo {
	
	/**
	 * @Description qsnInfoId的中文含义是： 试题信息ID
	 */
	@Column(value = "qsn_info_id")
	@Name
	private String qsnInfoId;

	/**
	 * @Description qsnInfoType的中文含义是： 试题类型
	 */
	@Column(value = "qsn_info_type")
	private String qsnInfoType;

	/**
	 * @Description qsnInfoState的中文含义是： 试题状态,0=禁用,1=启用,2=导入
	 */
	@Column(value = "qsn_info_state")
	private String qsnInfoState;

	/**
	 * @Description qsnInfoPreview的中文含义是： 试题预览信息
	 */
	@Column(value = "qsn_info_preview")
	private String qsnInfoPreview;

	/**
	 * @Description qsnInfoDesc的中文含义是： 试题题干描述
	 */
	@Column(value = "qsn_info_desc")
	private String qsnInfoDesc;
	
	/**
	 * @Description qsnInfoExplain的中文含义是： 试题答案解释
	 */
	@Column(value = "qsn_info_explain")
	private String qsnInfoExplain;

	/**
	 * @Description qsnInfoRule的中文含义是： 试题判分规则
	 */
	@Column(value = "qsn_info_rule")
	private String qsnInfoRule;

	/**
	 * @Description qsnInfoTrade的中文含义是： 四品一械大类
	 */
	@Column(value = "qsn_info_trade")
	private String qsnInfoTrade;

	/**
	 * @Description aae013的中文含义是： 备注
	 */
	@Column
	private String aae013;

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
	 * @Description qsnInfoId的中文含义是： 试题信息ID
	 */
	public String getQsnInfoId() {
		return qsnInfoId;
	}
	/**
	 * @Description qsnInfoId的中文含义是： 试题信息ID
	 */
	public void setQsnInfoId(String qsnInfoId) {
		this.qsnInfoId = qsnInfoId;
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
	 * @Description qsnInfoState的中文含义是： 试题状态,0=禁用,1=启用,2=导入
	 */
	public String getQsnInfoState() {
		return qsnInfoState;
	}
	/**
	 * @Description qsnInfoState的中文含义是： 试题状态,0=禁用,1=启用,2=导入
	 */
	public void setQsnInfoState(String qsnInfoState) {
		this.qsnInfoState = qsnInfoState;
	}
	/**
	 * @Description qsnInfoPreview的中文含义是： 试题预览信息
	 */
	public String getQsnInfoPreview() {
		return qsnInfoPreview;
	}
	/**
	 * @Description qsnInfoPreview的中文含义是： 试题预览信息
	 */
	public void setQsnInfoPreview(String qsnInfoPreview) {
		this.qsnInfoPreview = qsnInfoPreview;
	}
	/**
	 * @Description qsnInfoDesc的中文含义是： 试题题干描述
	 */
	public String getQsnInfoDesc() {
		return qsnInfoDesc;
	}
	/**
	 * @Description qsnInfoDesc的中文含义是： 试题题干描述
	 */
	public void setQsnInfoDesc(String qsnInfoDesc) {
		this.qsnInfoDesc = qsnInfoDesc;
	}
	/**
	 * @Description qsnInfoExplain的中文含义是： 试题答案解释
	 */
	public String getQsnInfoExplain() {
		return qsnInfoExplain;
	}
	/**
	 * @Description qsnInfoExplain的中文含义是： 试题答案解释
	 */
	public void setQsnInfoExplain(String qsnInfoExplain) {
		this.qsnInfoExplain = qsnInfoExplain;
	}
	/**
	 * @Description qsnInfoRule的中文含义是： 试题判分规则
	 */
	public String getQsnInfoRule() {
		return qsnInfoRule;
	}
	/**
	 * @Description qsnInfoRule的中文含义是： 试题判分规则
	 */
	public void setQsnInfoRule(String qsnInfoRule) {
		this.qsnInfoRule = qsnInfoRule;
	}
	/**
	 * @Description qsnInfoTrade的中文含义是： 四品一械大类
	 */
	public String getQsnInfoTrade() {
		return qsnInfoTrade;
	}
	/**
	 * @Description qsnInfoTrade的中文含义是： 四品一械大类
	 */
	public void setQsnInfoTrade(String qsnInfoTrade) {
		this.qsnInfoTrade = qsnInfoTrade;
	}
	/**
	 * @Description aae013的中文含义是： 备注
	 */
	public void setAae013(String aae013){ 
		this.aae013 = aae013;
	}
	/**
	 * @Description aae013的中文含义是： 备注
	 */
	public String getAae013(){
		return aae013;
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
		return " { 'qsnInfoId' : '" + qsnInfoId + "', 'qsnInfoType' : '"
				+ qsnInfoType + "', 'qsnInfoState' : '" + qsnInfoState
				+ "', 'qsnInfoPreview' : '" + qsnInfoPreview + "', 'qsnInfoDesc' : '"
				+ qsnInfoDesc + "', 'qsnInfoExplain' : '" + qsnInfoExplain
				+ "', 'qsnInfoRule' : '" + qsnInfoRule + "', 'qsnInfoTrade' : '"
				+ qsnInfoTrade + "', 'aae013' : '" + aae013 + "', 'aae011' : '" + aae011
				+ "', 'aae036' : '" + aae036 + "' } ";
	}
	
	

	
}