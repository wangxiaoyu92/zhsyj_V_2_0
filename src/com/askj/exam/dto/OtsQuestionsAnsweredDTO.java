package com.askj.exam.dto;

/**
 * @Description  OtsQuestionsAnsweredDTO 的中文含义是: 已回答试题; InnoDB free: 9216 kB
 * @Creation     2017/06/15 16:37:44
 * @Written      Create Tool By zjf 
 **/
public class OtsQuestionsAnsweredDTO {
	/**
	/**
	 * @Description answeredId的中文含义是： 主键ID
	 */
	private String answeredId;

	/**
	 * @Description qsnInfoId的中文含义是： 试题ID
	 */
	private String qsnInfoId;

	/**
	 * @Description answerNumber的中文含义是： 练习次数
	 */
	private String answerNumber;
	
	/**
	 * @Description answerType的中文含义是： 练习类型0 顺序 1随机 2专项 3 错题
	 */
	private String answerType;

	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	private String aae011;

	/**
	 * @Description aae036的中文含义是： 时间
	 */
	private String aae036;

	
		/**
	 * @Description answeredId的中文含义是： 主键ID
	 */
	public void setAnsweredId(String answeredId){ 
		this.answeredId = answeredId;
	}
	/**
	 * @Description answeredId的中文含义是： 主键ID
	 */
	public String getAnsweredId(){
		return answeredId;
	}
	/**
	 * @Description qsnInfoId的中文含义是： 试题ID
	 */
	public void setQsnInfoId(String qsnInfoId){ 
		this.qsnInfoId = qsnInfoId;
	}
	/**
	 * @Description qsnInfoId的中文含义是： 试题ID
	 */
	public String getQsnInfoId(){
		return qsnInfoId;
	}
	/**
	 * @Description answerNumber的中文含义是： 练习次数
	 */
	public void setAnswerNumber(String answerNumber){ 
		this.answerNumber = answerNumber;
	}
	/**
	 * @Description answerNumber的中文含义是： 练习次数
	 */
	public String getAnswerNumber(){
		return answerNumber;
	}
	/**
	 * @Description answerType的中文含义是： 练习类型0 顺序 1随机 2专项 3 错题
	 */
	public String getAnswerType() {
		return answerType;
	}
	/**
	 * @Description answerType的中文含义是： 练习类型0 顺序 1随机 2专项 3 错题
	 */
	public void setAnswerType(String answerType) {
		this.answerType = answerType;
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
	 * @Description aae036的中文含义是： 时间
	 */
	public void setAae036(String aae036){ 
		this.aae036 = aae036;
	}
	/**
	 * @Description aae036的中文含义是： 时间
	 */
	public String getAae036(){
		return aae036;
	}

	
}