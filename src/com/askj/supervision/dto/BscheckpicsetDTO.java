package com.askj.supervision.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  BSCHECKPICSET的中文含义是: 检查计划检查项设置表; InnoDB free: 2689024 kBDTO
 * @Creation     2016/05/16 14:22:53
 * @Written      Create Tool By zjf 
 **/
public class BscheckpicsetDTO {
	//扩展开始
	/**
	 * @Description plantypearea的中文含义是： 计划对于的企业大类
	 */
	private String plantypearea;
	//扩展结束
	/**
	 * @Description picid的中文含义是： 计划项主键
	 */
	private String picid;

	/**
	 * @Description planid的中文含义是： 计划主键
	 */
	private String planid;

	/**
	 * @Description itemid的中文含义是： 项目ID
	 */
	private String itemid;

	/**
	 * @Description contentid的中文含义是： 内容ID
	 */
	private String contentid;

	/**
	 * @Description picoperator的中文含义是： 计划项经办人
	 */
	private String picoperator;

	/**
	 * @Description picoperatedate的中文含义是： 计划项经办时间
	 */
	private String picoperatedate;

	private String[] items;
//	private String[] contentids;
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
	public String[] getItems() {
		return items;
	}
	public void setItems(String[] items) {
		this.items = items;
	}

	public String getPlantypearea() {
		return plantypearea;
	}

	public void setPlantypearea(String plantypearea) {
		this.plantypearea = plantypearea;
	}
}