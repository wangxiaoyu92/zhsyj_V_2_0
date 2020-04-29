package com.askj.spsy.entity;

import org.nutz.dao.entity.annotation.*;
import java.math.BigDecimal;

/**
 * @Description  QPRODUCTCLSYJLB的中文含义是: 产品材料使用记录表; InnoDB free: 2713600 kB
 * @Creation     2016/07/08 10:18:18
 * @Written      Create Tool By zjf 
 **/
@Table(value = "QPRODUCTCLSYJLB")
public class Qproductclsyjlb {
	/**
	 * @Description 主键ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_cpclpcid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_cpclpcid.nextval from dual"))
	private String qproductclsyjlbid;
	

	/**
	 * @Description procomid的中文含义是： 商品所属公司ID
	 */
	@Column
	private String procomid;

	/**
	 * @Description proid的中文含义是： 商品ID对应产品表主键
	 */
	@Column
	private String proid;

	/**
	 * @Description cppcid的中文含义是： 商品生产批次ID对应产品批次表主键
	 */
	@Column
	private String cppcid;

	/**
	 * @Description cpclid的中文含义是： 产品材料ID对应产品材料表主键
	 */
	@Column
	private String cpclid;

	/**
	 * @Description cpclname的中文含义是： 产品材料名称
	 */
	@Column
	private String cpclname;

	/**
	 * @Description qledgerstockid的中文含义是： 产品材料进货台账ID，对应qledgerstock主键
	 */
	@Column
	private String qledgerstockid;

	/**
	 * @Description cpclsysl的中文含义是： 产品材料消耗数量
	 */
	@Column
	private BigDecimal cpclsysl;
	
	/**
	 * @Description cpcldw的中文含义是： 产品材料单位
	 */
	@Column
	private String cpcldw;
	/**
	 * @Description procomid的中文含义是： 商品所属公司ID
	 */
	public void setProcomid(String procomid){ 
		this.procomid = procomid;
	}
	/**
	 * @Description procomid的中文含义是： 商品所属公司ID
	 */
	public String getProcomid(){
		return procomid;
	}
	/**
	 * @Description proid的中文含义是： 商品ID对应产品表主键
	 */
	public void setProid(String proid){ 
		this.proid = proid;
	}
	/**
	 * @Description proid的中文含义是： 商品ID对应产品表主键
	 */
	public String getProid(){
		return proid;
	}
	/**
	 * @Description cppcid的中文含义是： 商品生产批次ID对应产品批次表主键
	 */
	public void setCppcid(String cppcid){ 
		this.cppcid = cppcid;
	}
	/**
	 * @Description cppcid的中文含义是： 商品生产批次ID对应产品批次表主键
	 */
	public String getCppcid(){
		return cppcid;
	}
	/**
	 * @Description cpclid的中文含义是： 产品材料ID对应产品材料表主键
	 */
	public void setCpclid(String cpclid){ 
		this.cpclid = cpclid;
	}
	/**
	 * @Description cpclid的中文含义是： 产品材料ID对应产品材料表主键
	 */
	public String getCpclid(){
		return cpclid;
	}
	/**
	 * @Description cpclname的中文含义是： 产品材料名称
	 */
	public void setCpclname(String cpclname){ 
		this.cpclname = cpclname;
	}
	/**
	 * @Description cpclname的中文含义是： 产品材料名称
	 */
	public String getCpclname(){
		return cpclname;
	}
	/**
	 * @Description qledgerstockid的中文含义是： 产品材料进货台账ID，对应qledgerstock主键
	 */
	public void setQledgerstockid(String qledgerstockid){ 
		this.qledgerstockid = qledgerstockid;
	}
	/**
	 * @Description qledgerstockid的中文含义是： 产品材料进货台账ID，对应qledgerstock主键
	 */
	public String getQledgerstockid(){
		return qledgerstockid;
	}
	/**
	 * @Description cpclsysl的中文含义是： 产品材料消耗数量
	 */
	public void setCpclsysl(BigDecimal cpclsysl){ 
		this.cpclsysl = cpclsysl;
	}
	/**
	 * @Description cpclsysl的中文含义是： 产品材料消耗数量
	 */
	public BigDecimal getCpclsysl(){
		return cpclsysl;
	}
	/**
	 * @Description 主键ID
	 */
	public String getQproductclsyjlbid() {
		return qproductclsyjlbid;
	}
	/**
	 * @Description 主键ID
	 */
	public void setQproductclsyjlbid(String qproductclsyjlbid) {
		this.qproductclsyjlbid = qproductclsyjlbid;
	}
	public String getCpcldw() {
		return cpcldw;
	}
	public void setCpcldw(String cpcldw) {
		this.cpcldw = cpcldw;
	}


	
}