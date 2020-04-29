package com.askj.spsy.dto;

import java.math.BigDecimal;

/**
 * @Description  QPRODUCTCLSYJLB的中文含义是: 产品材料使用记录表; InnoDB free: 2713600 kBDTO
 * @Creation     2016/07/08 10:23:02
 * @Written      Create Tool By zjf 
 **/
public class QproductclsyjlbDTO {
	
	/**
	 * @Description 主键ID
	 */
	private String qproductclsyjlbid;	

	/**
	 * @Description procomid的中文含义是： 商品所属公司ID
	 */
	private String procomid;

	/**
	 * @Description proid的中文含义是： 商品ID对应产品表主键
	 */
	private String proid;

	/**
	 * @Description cppcid的中文含义是： 商品生产批次ID对应产品批次表主键
	 */
	private String cppcid;

	/**
	 * @Description cpclid的中文含义是： 产品材料ID对应产品材料表主键
	 */
	private String cpclid;

	/**
	 * @Description cpclname的中文含义是： 产品材料名称
	 */
	private String cpclname;

	/**
	 * @Description qledgerstockid的中文含义是： 产品材料进货台账ID，对应qledgerstock主键
	 */
	private String qledgerstockid;

	/**
	 * @Description cpclsysl的中文含义是： 产品材料消耗数量
	 */
	private String cpclsysl;
	
	/**
	 * @Description cpcldw的中文含义是： 产品材料单位
	 */
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
	public void setCpclsysl(String cpclsysl){ 
		this.cpclsysl = cpclsysl;
	}
	/**
	 * @Description cpclsysl的中文含义是： 产品材料消耗数量
	 */
	public String getCpclsysl(){
		return cpclsysl;
	}
	public String getQproductclsyjlbid() {
		return qproductclsyjlbid;
	}
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