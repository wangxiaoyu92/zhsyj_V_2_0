package com.askj.supervision.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  BSCHECKPICSET的中文含义是: 检查计划检查项设置表; InnoDB free: 2689024 kB
 * @Creation     2016/05/16 14:22:15
 * @Written      Create Tool By zjf 
 **/
@Table(value = "BSCHECKPICSET")
public class Bscheckpicset {
	/**
	 * @Description picid的中文含义是： 计划项主键
	 */
	 @Column 
	 @Name
	private String picid;

	/**
	 * @Description planid的中文含义是： 计划主键
	 */
	@Column
	private String planid;

	/**
	 * @Description itemid的中文含义是： 项目ID
	 */
	@Column
	private String itemid;

	/**
	 * @Description contentid的中文含义是： 内容ID
	 */
	@Column
	private String contentid;

	/**
	 * @Description picoperator的中文含义是： 计划项经办人
	 */
	@Column
	private String picoperator;

	/**
	 * @Description picoperatedate的中文含义是： 计划项经办时间
	 */
	@Column
	private String picoperatedate;

	
		/**
	 * @Description picid的中文含义是： 计划项主键
	 */
	public void setPicid(String picid){ 
		this.picid = picid;
	}
	/**
	 * @Description picid的中文含义是： 计划项主键
	 */
	public String getPicid(){
		return picid;
	}
	/**
	 * @Description planid的中文含义是： 计划主键
	 */
	public void setPlanid(String planid){ 
		this.planid = planid;
	}
	/**
	 * @Description planid的中文含义是： 计划主键
	 */
	public String getPlanid(){
		return planid;
	}
	/**
	 * @Description itemid的中文含义是： 项目ID
	 */
	public void setItemid(String itemid){ 
		this.itemid = itemid;
	}
	/**
	 * @Description itemid的中文含义是： 项目ID
	 */
	public String getItemid(){
		return itemid;
	}
	/**
	 * @Description contentid的中文含义是： 内容ID
	 */
	public void setContentid(String contentid){ 
		this.contentid = contentid;
	}
	/**
	 * @Description contentid的中文含义是： 内容ID
	 */
	public String getContentid(){
		return contentid;
	}
	/**
	 * @Description picoperator的中文含义是： 计划项经办人
	 */
	public void setPicoperator(String picoperator){ 
		this.picoperator = picoperator;
	}
	/**
	 * @Description picoperator的中文含义是： 计划项经办人
	 */
	public String getPicoperator(){
		return picoperator;
	}
	/**
	 * @Description picoperatedate的中文含义是： 计划项经办时间
	 */
	public void setPicoperatedate(String picoperatedate){ 
		this.picoperatedate = picoperatedate;
	}
	/**
	 * @Description picoperatedate的中文含义是： 计划项经办时间
	 */
	public String getPicoperatedate(){
		return picoperatedate;
	}

	
}