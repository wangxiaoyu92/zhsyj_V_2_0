package com.askj.exam.dto;

/**
 * @Description  OtsQuestionTradeDTO 的中文含义是: 试题考点对应表; InnoDB free: 21504 kB
 * @Creation     2017/06/02 14:28:41
 * @Written      Create Tool By zjf 
 **/
public class OtsQuestionTradeDTO {
	/**
	 * @Description qsnTradeId的中文含义是： 考试点信息ID
	 */
	private String qsnTradeId;

	/**
	 * @Description qsnId的中文含义是： 试题ID
	 */
	private String qsnId;

	/**
	 * @Description qsnTrade的中文含义是： 考试点,代码表EXAMTRADE如食品，药品
	 */
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