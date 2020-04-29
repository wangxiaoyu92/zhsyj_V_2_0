package com.askj.spsy.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  QCPHCLDYGX的中文含义是: 产品和材料对应关系; InnoDB free: 2713600 kBDTO
 * @Creation     2016/07/06 17:50:42
 * @Written      Create Tool By zjf 
 **/
public class QcphcldygxDTO {
	/**
	 * @Description qcphcldygxid的中文含义是： 产品和材料对应关系id
	 */
	private String qcphcldygxid;

	/**
	 * @Description proid的中文含义是： 产品id
	 */
	private String proid;

	/**
	 * @Description cpclid的中文含义是： 产品材料ID
	 */
	private String cpclid;

	
		/**
	 * @Description qcphcldygxid的中文含义是： 产品和材料对应关系id
	 */
	public void setQcphcldygxid(String qcphcldygxid){ 
		this.qcphcldygxid = qcphcldygxid;
	}
	/**
	 * @Description qcphcldygxid的中文含义是： 产品和材料对应关系id
	 */
	public String getQcphcldygxid(){
		return qcphcldygxid;
	}
	/**
	 * @Description proid的中文含义是： 产品id
	 */
	public void setProid(String proid){ 
		this.proid = proid;
	}
	/**
	 * @Description proid的中文含义是： 产品id
	 */
	public String getProid(){
		return proid;
	}
	/**
	 * @Description cpclid的中文含义是： 产品材料ID
	 */
	public void setCpclid(String cpclid){ 
		this.cpclid = cpclid;
	}
	/**
	 * @Description cpclid的中文含义是： 产品材料ID
	 */
	public String getCpclid(){
		return cpclid;
	}

	
}