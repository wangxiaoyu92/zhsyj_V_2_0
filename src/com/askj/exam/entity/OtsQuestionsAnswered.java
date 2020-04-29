package com.askj.exam.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  OtsQuestionsAnswered的中文含义是: 已回答试题; InnoDB free: 9216 kB
 * @Creation     2017/06/15 16:37:50
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ots_questions_answered")
public class OtsQuestionsAnswered {
	/**
	 * @Description answeredId的中文含义是： 主键ID
	 */
	@Column ( value = "answered_id" )
	@Name
	private String answeredId;

	/**
	 * @Description qsnInfoId的中文含义是： 试题ID
	 */
	@Column ( value = "qsn_info_id" )
	private String qsnInfoId;

	/**
	 * @Description answerNumber的中文含义是： 练习次数
	 */
	@Column ( value = "answer_number" )
	private String answerNumber;
	
	/**
	 * @Description answerType的中文含义是： 练习类型0 顺序 1随机 2专项 3 错题
	 */
	@Column ( value = "answer_type" )
	private String answerType;

	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	@Column
	private String aae011;

	/**
	 * @Description aae036的中文含义是： 时间
	 */
	@Column
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