package com.askj.zx.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;

import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZXPDJG的中文含义是: 征信评定结果; InnoDB free: 10240 kB
 * @Creation     2016/02/24 14:18:41
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZXPDJG")
public class Zxpdjg {
	/**
	 * @Description pdjgid的中文含义是： 评定结果ID
	 */
	@Column
	@Name
	private String pdjgid;

	/**
	 * @Description comid的中文含义是： 企业代码
	 */
	@Column
	private String comid;

	/**
	 * @Description djcsbm的中文含义是： 等级参数编码
	 */
	@Column
	private String djcsbm;

	/**
	 * @Description djcshh的中文含义是： 等级参数红黑
	 */
	@Column
	private String djcshh;

	/**
	 * @Description niandu的中文含义是： 年度
	 */
	@Column
	private String niandu;

	/**
	 * @Description pdjgscfs的中文含义是： 生产方式0自动生成1手动生成
	 */
	@Column
	private String pdjgscfs;

	/**
	 * @Description beizhu的中文含义是： 备注
	 */
	@Column
	private String beizhu;

	/**
	 * @Description czyxm的中文含义是： 操作员姓名
	 */
	@Column
	private String czyxm;

	/**
	 * @Description czsj的中文含义是： 操作时间
	 */
	@Column
	private String czsj;

	/**
	 * @Description pdjgdf的中文含义是： 得分
	 */
	@Column
	private Integer pdjgdf;

	/**
	 * @Description commc的中文含义是： 企业名称
	 */
	@Column
	private String commc;

	/**
	 * @Description reason的中文含义是： 救济原因
	 */
	@Column
	private String reason;

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	/**
	 * @Description pdjgid的中文含义是： 评定结果ID
	 */
	public void setPdjgid(String pdjgid){ 
		this.pdjgid = pdjgid;
	}
	/**
	 * @Description pdjgid的中文含义是： 评定结果ID
	 */
	public String getPdjgid(){
		return pdjgid;
	}
	/**
	 * @Description djcsbm的中文含义是： 等级参数编码
	 */
	public void setDjcsbm(String djcsbm){ 
		this.djcsbm = djcsbm;
	}
	/**
	 * @Description djcsbm的中文含义是： 等级参数编码
	 */
	public String getDjcsbm(){
		return djcsbm;
	}
	/**
	 * @Description djcshh的中文含义是： 等级参数红黑
	 */
	public void setDjcshh(String djcshh){ 
		this.djcshh = djcshh;
	}
	/**
	 * @Description djcshh的中文含义是： 等级参数红黑
	 */
	public String getDjcshh(){
		return djcshh;
	}
	/**
	 * @Description niandu的中文含义是： 年度
	 */
	public void setNiandu(String niandu){ 
		this.niandu = niandu;
	}
	/**
	 * @Description niandu的中文含义是： 年度
	 */
	public String getNiandu(){
		return niandu;
	}
	/**
	 * @Description pdjgscfs的中文含义是： 生产方式0自动生成1手动生成
	 */
	public void setPdjgscfs(String pdjgscfs){ 
		this.pdjgscfs = pdjgscfs;
	}
	/**
	 * @Description pdjgscfs的中文含义是： 生产方式0自动生成1手动生成
	 */
	public String getPdjgscfs(){
		return pdjgscfs;
	}
	/**
	 * @Description beizhu的中文含义是： 备注
	 */
	public void setBeizhu(String beizhu){ 
		this.beizhu = beizhu;
	}
	/**
	 * @Description beizhu的中文含义是： 备注
	 */
	public String getBeizhu(){
		return beizhu;
	}
	/**
	 * @Description czyxm的中文含义是： 操作员姓名
	 */
	public void setCzyxm(String czyxm){ 
		this.czyxm = czyxm;
	}
	/**
	 * @Description czyxm的中文含义是： 操作员姓名
	 */
	public String getCzyxm(){
		return czyxm;
	}
	/**
	 * @Description czsj的中文含义是： 操作时间
	 */
	public void setCzsj(String czsj){ 
		this.czsj = czsj;
	}
	/**
	 * @Description czsj的中文含义是： 操作时间
	 */
	public String getCzsj(){
		return czsj;
	}
	/**
	 * @Description pdjgdf的中文含义是： 得分
	 */
	public void setPdjgdf(Integer pdjgdf){ 
		this.pdjgdf = pdjgdf;
	}
	/**
	 * @Description pdjgdf的中文含义是： 得分
	 */
	public Integer getPdjgdf(){
		return pdjgdf;
	}
	/**
	 * @Description commc的中文含义是： 企业名称
	 */
	public void setCommc(String commc){ 
		this.commc = commc;
	}
	/**
	 * @Description commc的中文含义是： 企业名称
	 */
	public String getCommc(){
		return commc;
	}
	public String getComid() {
		return comid;
	}
	public void setComid(String comid) {
		this.comid = comid;
	}

	
}