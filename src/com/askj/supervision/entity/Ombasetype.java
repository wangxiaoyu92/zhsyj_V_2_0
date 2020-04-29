package com.askj.supervision.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  OMBASETYPE的中文含义是: InnoDB free: 2713600 kB
 * @Creation     2016/07/06 10:26:51
 * @Written      Create Tool By zjf 
 **/
@Table(value = "OMBASETYPE")
public class Ombasetype {
	/**
	 * @Description basetype的中文含义是： 基本类型 --对应aa10【AAZ903】
	 */
	@Column
	private String basetype;

	/**
	 * @Description itemtype的中文含义是： 检查项目类型 --omcheckgroup[itemid]
	 */
	@Column
	private String itemtype;

	
		/**
	 * @Description basetype的中文含义是： 基本类型 --对应aa10【AAZ903】
	 */
	public void setBasetype(String basetype){ 
		this.basetype = basetype;
	}
	/**
	 * @Description basetype的中文含义是： 基本类型 --对应aa10【AAZ903】
	 */
	public String getBasetype(){
		return basetype;
	}
	/**
	 * @Description itemtype的中文含义是： 检查项目类型 --omcheckgroup[itemid]
	 */
	public void setItemtype(String itemtype){ 
		this.itemtype = itemtype;
	}
	/**
	 * @Description itemtype的中文含义是： 检查项目类型 --omcheckgroup[itemid]
	 */
	public String getItemtype(){
		return itemtype;
	}

	
}