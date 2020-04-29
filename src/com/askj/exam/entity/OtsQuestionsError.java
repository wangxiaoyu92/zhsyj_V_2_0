package com.askj.exam.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  OtsQuestionsError的中文含义是: 试题错题库; InnoDB free: 5120 kB
 * @Creation     2017/06/08 14:57:26
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ots_questions_error")
public class OtsQuestionsError {
	/**
	 * @Description errorId的中文含义是： 错题ID
	 */
	@Column ( value = "error_id" )
	@Name
	private String errorId;

	/**
	 * @Description qsnInfoId的中文含义是： 试题ID
	 */
	@Column ( value = "qsn_info_id" )
	private String qsnInfoId;

	/**
	 * @Description qsnErrorItem的中文含义是： 错误原因
	 */
	@Column ( value = "qsn_error_item" )
	private String qsnErrorItem;

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
	 * @Description errorId的中文含义是： 错题ID
	 */
	public void setErrorId(String errorId){ 
		this.errorId = errorId;
	}
	/**
	 * @Description errorId的中文含义是： 错题ID
	 */
	public String getErrorId(){
		return errorId;
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
	 * @Description qsnErrorItem的中文含义是： 错误原因
	 */
	public void setQsnErrorItem(String qsnErrorItem){ 
		this.qsnErrorItem = qsnErrorItem;
	}
	/**
	 * @Description qsnErrorItem的中文含义是： 错误原因
	 */
	public String getQsnErrorItem(){
		return qsnErrorItem;
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