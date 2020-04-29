package com.askj.exam.dto;

/**
 * @Description  OtsQuestionsCollectDTO 的中文含义是: 收藏试题表; InnoDB free: 9216 kB
 * @Creation     2017/06/29 15:46:45
 * @Written      Create Tool By zjf 
 **/
public class OtsQuestionsCollectDTO {
	/**
	 * @Description qsnCollectId的中文含义是： 主键ID
	 */
	private String qsnCollectId;

	/**
	 * @Description qsnInfoId的中文含义是： 试题ID
	 */
	private String qsnInfoId;

	/**
	 * @Description flag的中文含义是： 收藏标志 0未收藏 1收藏
	 */
	private String flag;

	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	private String aae011;

	/**
	 * @Description aae036的中文含义是： 时间
	 */
	private String aae036;

	/**
	 * @Description qsnCollectId的中文含义是： 主键ID
	 */
	public void setQsnCollectId(String qsnCollectId){ 
		this.qsnCollectId = qsnCollectId;
	}
	/**
	 * @Description qsnCollectId的中文含义是： 主键ID
	 */
	public String getQsnCollectId(){
		return qsnCollectId;
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
	 * @Description flag的中文含义是： 收藏标志 0未收藏 1收藏
	 */
	public void setFlag(String flag){ 
		this.flag = flag;
	}
	/**
	 * @Description flag的中文含义是： 收藏标志 0未收藏 1收藏
	 */
	public String getFlag(){
		return flag;
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