package com.askj.exam.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  OtsQuestionTrade的中文含义是: 试题考点对应表; InnoDB free: 21504 kB
 * @Creation     2017/06/02 14:27:18
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ots_question_trade")
public class OtsQuestionTrade {
	/**
	 * @Description qsnTradeId的中文含义是： 考试点信息ID
	 */
	@Column ( value = "qsn_trade_id" )
	@Name
	private String qsnTradeId;

	/**
	 * @Description qsnId的中文含义是： 试题ID
	 */
	@Column ( value = "qsn_id" )
	private String qsnId;

	/**
	 * @Description qsnTrade的中文含义是： 考试点,代码表EXAMTRADE如食品，药品
	 */
	@Column ( value = "qsn_trade" )
	private String qsnTrade;

	/**
	 * @Description qsnTradeId的中文含义是： 考试点信息ID
	 */
	public void setQsnTradeId(String qsnTradeId){ 
		this.qsnTradeId = qsnTradeId;
	}
	/**
	 * @Description qsnTradeId的中文含义是： 考试点信息ID
	 */
	public String getQsnTradeId(){
		return qsnTradeId;
	}
	/**
	 * @Description qsnId的中文含义是： 试题ID
	 */
	public void setQsnId(String qsnId){ 
		this.qsnId = qsnId;
	}
	/**
	 * @Description qsnId的中文含义是： 试题ID
	 */
	public String getQsnId(){
		return qsnId;
	}
	/**
	 * @Description qsnTrade的中文含义是： 考试点,代码表EXAMTRADE如食品，药品
	 */
	public void setQsnTrade(String qsnTrade){ 
		this.qsnTrade = qsnTrade;
	}
	/**
	 * @Description qsnTrade的中文含义是： 考试点,代码表EXAMTRADE如食品，药品
	 */
	public String getQsnTrade(){
		return qsnTrade;
	}
	
}