package com.askj.spsy.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  QPRODUCTSZGCXX的中文含义是: 产品生长生产过程信息表DTO
 * @Creation     2016/07/20 18:29:09
 * @Written      Create Tool By zjf 
 **/
public class QproductszgcxxDTO {
	/**
	 * @Description szgcid的中文含义是： 产品生长生产过程信息表ID
	 */
	private String szgcid;

	/**
	 * @Description proid的中文含义是： 产品ID
	 */
	private String proid;

	/**
	 * @Description szgcczr的中文含义是： 操作人
	 */
	private String szgcczr;

	/**
	 * @Description szgccznr的中文含义是： 操作内容
	 */
	private String szgccznr;

	/**
	 * @Description szgcczrq的中文含义是： 操作日期
	 */
	private String szgcczrq;

	/**
	 * @Description szgcbz的中文含义是： 备注
	 */
	private String szgcbz;

	/**
	 * @Description cppcpch的中文含义是： 批次号
	 */
	private String cppcpch;

	
		/**
	 * @Description szgcid的中文含义是： 产品生长生产过程信息表ID
	 */
	public void setSzgcid(String szgcid){ 
		this.szgcid = szgcid;
	}
	/**
	 * @Description szgcid的中文含义是： 产品生长生产过程信息表ID
	 */
	public String getSzgcid(){
		return szgcid;
	}
	/**
	 * @Description proid的中文含义是： 产品ID
	 */
	public void setProid(String proid){ 
		this.proid = proid;
	}
	/**
	 * @Description proid的中文含义是： 产品ID
	 */
	public String getProid(){
		return proid;
	}
	/**
	 * @Description szgcczr的中文含义是： 操作人
	 */
	public void setSzgcczr(String szgcczr){ 
		this.szgcczr = szgcczr;
	}
	/**
	 * @Description szgcczr的中文含义是： 操作人
	 */
	public String getSzgcczr(){
		return szgcczr;
	}
	/**
	 * @Description szgccznr的中文含义是： 操作内容
	 */
	public void setSzgccznr(String szgccznr){ 
		this.szgccznr = szgccznr;
	}
	/**
	 * @Description szgccznr的中文含义是： 操作内容
	 */
	public String getSzgccznr(){
		return szgccznr;
	}
	/**
	 * @Description szgcczrq的中文含义是： 操作日期
	 */
	public void setSzgcczrq(String szgcczrq){ 
		this.szgcczrq = szgcczrq;
	}
	/**
	 * @Description szgcczrq的中文含义是： 操作日期
	 */
	public String getSzgcczrq(){
		return szgcczrq;
	}
	/**
	 * @Description szgcbz的中文含义是： 备注
	 */
	public void setSzgcbz(String szgcbz){ 
		this.szgcbz = szgcbz;
	}
	/**
	 * @Description szgcbz的中文含义是： 备注
	 */
	public String getSzgcbz(){
		return szgcbz;
	}
	/**
	 * @Description cppcpch的中文含义是： 批次号
	 */
	public void setCppcpch(String cppcpch){ 
		this.cppcpch = cppcpch;
	}
	/**
	 * @Description cppcpch的中文含义是： 批次号
	 */
	public String getCppcpch(){
		return cppcpch;
	}

	
}