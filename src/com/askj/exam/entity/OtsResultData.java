package com.askj.exam.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  OtsResultData的中文含义是: 参加考试结果详细表
 * @Creation     2017/03/13 17:01:21
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ots_result_data")
public class OtsResultData {
	/**
	 * @Description resultDataId的中文含义是： 数据ID
	 */
	@Column ( value = "result_data_id" )
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_result_data_id')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_result_data_id.nextval from dual"))
	private String resultDataId;

	/**
	 * @Description resultInfoId的中文含义是： 关联考试结果ID
	 */
	@Column ( value = "result_info_id" )
	private String resultInfoId;

	/**
	 * @Description questionInfoId的中文含义是： 使用的试题ID
	 */
	@Column ( value = "question_info_id" )
	private String questionInfoId;

	/**
	 * @Description questionInfoAae036的中文含义是： 使用试题的修改时间(作为试题版本)
	 */
	@Column ( value = "question_info_aae036" )
	private String questionInfoAae036;

	/**
	 * @Description resultDataPoints的中文含义是： 在考试中该试题满分
	 */
	@Column ( value = "result_data_points" )
	private String resultDataPoints;

	/**
	 * @Description resultDataScores的中文含义是： 考生的得分
	 */
	@Column ( value = "result_data_scores" )
	private String resultDataScores;

	/**
	 * @Description resultDataRightrate的中文含义是： 本题的正确率(0~100的浮点数)
	 */
	@Column ( value = "result_data_rightrate" )
	private String resultDataRightrate;

	/**
	 * @Description resultDataWrongrate的中文含义是： 本地的错误率(0~100的浮点数)
	 */
	@Column ( value = "result_data_wrongrate" )
	private String resultDataWrongrate;

	/**
	 * @Description resultDataUnknowrate的中文含义是： 未知对错率(手动算分, 0~100的浮点数)
	 */
	@Column ( value = "result_data_unknowrate" )
	private String resultDataUnknowrate;

	/**
	 * @Description resultDataRemark的中文含义是： 试题点评
	 */
	@Column ( value = "result_data_remark" )
	private String resultDataRemark;

	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	@Column
	private String aae036;

	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	@Column
	private String aae011;

	
		/**
	 * @Description resultDataId的中文含义是： 数据ID
	 */
	public void setResultDataId(String resultDataId){ 
		this.resultDataId = resultDataId;
	}
	/**
	 * @Description resultDataId的中文含义是： 数据ID
	 */
	public String getResultDataId(){
		return resultDataId;
	}
	/**
	 * @Description resultInfoId的中文含义是： 关联考试结果ID
	 */
	public void setResultInfoId(String resultInfoId){ 
		this.resultInfoId = resultInfoId;
	}
	/**
	 * @Description resultInfoId的中文含义是： 关联考试结果ID
	 */
	public String getResultInfoId(){
		return resultInfoId;
	}
	/**
	 * @Description questionInfoId的中文含义是： 使用的试题ID
	 */
	public void setQuestionInfoId(String questionInfoId){ 
		this.questionInfoId = questionInfoId;
	}
	/**
	 * @Description questionInfoId的中文含义是： 使用的试题ID
	 */
	public String getQuestionInfoId(){
		return questionInfoId;
	}
	/**
	 * @Description questionInfoAae036的中文含义是： 使用试题的修改时间(作为试题版本)
	 */
	public void setQuestionInfoAae036(String questionInfoAae036){ 
		this.questionInfoAae036 = questionInfoAae036;
	}
	/**
	 * @Description questionInfoAae036的中文含义是： 使用试题的修改时间(作为试题版本)
	 */
	public String getQuestionInfoAae036(){
		return questionInfoAae036;
	}
	/**
	 * @Description resultDataPoints的中文含义是： 在考试中该试题满分
	 */
	public void setResultDataPoints(String resultDataPoints){ 
		this.resultDataPoints = resultDataPoints;
	}
	/**
	 * @Description resultDataPoints的中文含义是： 在考试中该试题满分
	 */
	public String getResultDataPoints(){
		return resultDataPoints;
	}
	/**
	 * @Description resultDataScores的中文含义是： 考生的得分
	 */
	public void setResultDataScores(String resultDataScores){ 
		this.resultDataScores = resultDataScores;
	}
	/**
	 * @Description resultDataScores的中文含义是： 考生的得分
	 */
	public String getResultDataScores(){
		return resultDataScores;
	}
	/**
	 * @Description resultDataRightrate的中文含义是： 本题的正确率(0~100的浮点数)
	 */
	public void setResultDataRightrate(String resultDataRightrate){ 
		this.resultDataRightrate = resultDataRightrate;
	}
	/**
	 * @Description resultDataRightrate的中文含义是： 本题的正确率(0~100的浮点数)
	 */
	public String getResultDataRightrate(){
		return resultDataRightrate;
	}
	/**
	 * @Description resultDataWrongrate的中文含义是： 本地的错误率(0~100的浮点数)
	 */
	public void setResultDataWrongrate(String resultDataWrongrate){ 
		this.resultDataWrongrate = resultDataWrongrate;
	}
	/**
	 * @Description resultDataWrongrate的中文含义是： 本地的错误率(0~100的浮点数)
	 */
	public String getResultDataWrongrate(){
		return resultDataWrongrate;
	}
	/**
	 * @Description resultDataUnknowrate的中文含义是： 未知对错率(手动算分, 0~100的浮点数)
	 */
	public void setResultDataUnknowrate(String resultDataUnknowrate){ 
		this.resultDataUnknowrate = resultDataUnknowrate;
	}
	/**
	 * @Description resultDataUnknowrate的中文含义是： 未知对错率(手动算分, 0~100的浮点数)
	 */
	public String getResultDataUnknowrate(){
		return resultDataUnknowrate;
	}
	/**
	 * @Description resultDataRemark的中文含义是： 试题点评
	 */
	public void setResultDataRemark(String resultDataRemark){ 
		this.resultDataRemark = resultDataRemark;
	}
	/**
	 * @Description resultDataRemark的中文含义是： 试题点评
	 */
	public String getResultDataRemark(){
		return resultDataRemark;
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

	
}