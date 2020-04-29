package com.askj.spsy.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  QCPHCLDYGX的中文含义是: 产品和材料对应关系; InnoDB free: 2713600 kB
 * @Creation     2016/07/06 17:50:55
 * @Written      Create Tool By zjf 
 **/
@Table(value = "QCPHCLDYGX")
public class Qcphcldygx {
	/**
	 * @Description qcphcldygxid的中文含义是： 产品和材料对应关系id
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_qcphcldygxid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_qcphcldygxid.nextval from dual"))
	private String qcphcldygxid;

	/**
	 * @Description proid的中文含义是： 产品id
	 */
	@Column
	private String proid;

	/**
	 * @Description cpclid的中文含义是： 产品材料ID
	 */
	@Column
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