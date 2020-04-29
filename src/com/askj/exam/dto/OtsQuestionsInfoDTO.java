package com.askj.exam.dto;

/**
 * @Description  OTS_QUESTIONS_INFO的中文含义是: 试题信息表DTO
 * @Creation     2017/02/16 14:10:26
 * @Written      Create Tool By zjf 
 **/
public class OtsQuestionsInfoDTO {
	
	/**
	 * 练习类型， 手动添加（练习时使用0 顺序 1随机 2专项 3 错题）
	 */
	private String answerType;
	
	/**
	 * 收藏标志， 手动添加（练习时使用 0 未收藏 1收藏）
	 */
	private String flag;
	/**
	 * 选择错误选项， 手动添加（错题练习时使用）
	 */
	private String qsnErrorItem;
	/**
	 * 对应试题数据表组件参数【选项描述】， 手动添加
	 */
	private String[] qsnDataOptiondescArr;
	
	/**
	 * 错题id， 手动添加（错题练习时使用，根据这个可以移除错题库）
	 */
	private String errorId;
	
	/**
	 * 对应试题数据表当前结构在整体的位置， 手动添加
	 */
	private String qsnDataSort;
	
	/**
	 * @Description qsnInfoId的中文含义是： 试题信息ID
	 */
	private String qsnInfoId;

	/**
	 * @Description qsnInfoType的中文含义是： 试题类型
	 */
	private String qsnInfoType;

	/**
	 * @Description qsnInfoState的中文含义是： 试题状态,0=禁用,1=启用,2=导入
	 */
	private String qsnInfoState;

	/**
	 * @Description qsnInfoPreview的中文含义是： 试题预览信息
	 */
	private String qsnInfoPreview;

	/**
	 * @Description qsnInfoDesc的中文含义是： 试题题干描述
	 */
	private String qsnInfoDesc;
	
	/**
	 * @Description qsnInfoExplain的中文含义是： 试题答案解释
	 */
	private String qsnInfoExplain;

	/**
	 * @Description qsnInfoRule的中文含义是： 试题判分规则
	 */
	private String qsnInfoRule;

	/**
	 * @Description qsnInfoTrade的中文含义是： 四品一械大类
	 */
	private String qsnInfoTrade;

	/**
	 * @Description aae013的中文含义是： 备注
	 */
	private String aae013;

	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	private String aae011;

	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	private String aae036;

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
	public String getQsnDataSort() {
		return qsnDataSort;
	}
	public void setQsnDataSort(String qsnDataSort) {
		this.qsnDataSort = qsnDataSort;
	}
	public String getQsnInfoId() {
		return qsnInfoId;
	}
	public void setQsnInfoId(String qsnInfoId) {
		this.qsnInfoId = qsnInfoId;
	}
	public String getQsnInfoType() {
		return qsnInfoType;
	}
	public void setQsnInfoType(String qsnInfoType) {
		this.qsnInfoType = qsnInfoType;
	}
	public String getQsnInfoState() {
		return qsnInfoState;
	}
	public void setQsnInfoState(String qsnInfoState) {
		this.qsnInfoState = qsnInfoState;
	}
	public String[] getQsnDataOptiondescArr() {
		return qsnDataOptiondescArr;
	}
	public void setQsnDataOptiondescArr(String[] qsnDataOptiondescArr) {
		this.qsnDataOptiondescArr = qsnDataOptiondescArr;
	}
	public String getQsnErrorItem() {
		return qsnErrorItem;
	}
	public void setQsnErrorItem(String qsnErrorItem) {
		this.qsnErrorItem = qsnErrorItem;
	}
	public String getAnswerType() {
		return answerType;
	}
	public void setAnswerType(String answerType) {
		this.answerType = answerType;
	}
	public String getQsnInfoPreview() {
		return qsnInfoPreview;
	}
	public void setQsnInfoPreview(String qsnInfoPreview) {
		this.qsnInfoPreview = qsnInfoPreview;
	}
	public String getQsnInfoDesc() {
		return qsnInfoDesc;
	}
	public void setQsnInfoDesc(String qsnInfoDesc) {
		this.qsnInfoDesc = qsnInfoDesc;
	}
	public String getQsnInfoExplain() {
		return qsnInfoExplain;
	}
	public void setQsnInfoExplain(String qsnInfoExplain) {
		this.qsnInfoExplain = qsnInfoExplain;
	}
	public String getQsnInfoRule() {
		return qsnInfoRule;
	}
	public void setQsnInfoRule(String qsnInfoRule) {
		this.qsnInfoRule = qsnInfoRule;
	}
	public String getQsnInfoTrade() {
		return qsnInfoTrade;
	}
	public void setQsnInfoTrade(String qsnInfoTrade) {
		this.qsnInfoTrade = qsnInfoTrade;
	}
	public String getErrorId() {
		return errorId;
	}
	public void setErrorId(String errorId) {
		this.errorId = errorId;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	
}