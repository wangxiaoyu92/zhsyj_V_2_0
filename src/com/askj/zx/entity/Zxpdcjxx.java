package com.askj.zx.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;

import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZXPDCJXX的中文含义是: 征信采集信息表; InnoDB free: 11264 kB
 * @Creation     2016/02/19 15:50:54
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZXPDCJXX")
public class Zxpdcjxx {
	/**
	 * @Description cjid的中文含义是： 
	 */
	@Name 
	@Column
	private String cjid;

	/**
	 * @Description comid的中文含义是： 企业表主键
	 */
	@Column
	private String comid;

	/**
	 * @Description xmcsdm的中文含义是： 评定项目表项目代码
	 */
	@Column
	private String xmcsdm;

	/**
	 * @Description cjdf的中文含义是： 得分
	 */
	@Column
	private Integer cjdf;

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
	 * @Description beizhu的中文含义是： 备注
	 */
	@Column
	private String beizhu;

	/**
	 * @Description niandu的中文含义是： 年度
	 */
	@Column
	private String niandu;

	/**
	 * @Description sjly的中文含义是： 0系统产生1手工产生
	 */
	@Column
	private String sjly;

	
		/**
	 * @Description cjid的中文含义是： 
	 */
	public void setCjid(String cjid){ 
		this.cjid = cjid;
	}
	/**
	 * @Description cjid的中文含义是： 
	 */
	public String getCjid(){
		return cjid;
	}

	/**
	 * @Description xmcsdm的中文含义是： 评定项目表项目代码
	 */
	public void setXmcsdm(String xmcsdm){ 
		this.xmcsdm = xmcsdm;
	}
	/**
	 * @Description xmcsdm的中文含义是： 评定项目表项目代码
	 */
	public String getXmcsdm(){
		return xmcsdm;
	}
	/**
	 * @Description cjdf的中文含义是： 得分
	 */
	public void setCjdf(Integer cjdf){ 
		this.cjdf = cjdf;
	}
	/**
	 * @Description cjdf的中文含义是： 得分
	 */
	public Integer getCjdf(){
		return cjdf;
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
	 * @Description sjly的中文含义是： 0系统产生1手工产生
	 */
	public void setSjly(String sjly){ 
		this.sjly = sjly;
	}
	/**
	 * @Description sjly的中文含义是： 0系统产生1手工产生
	 */
	public String getSjly(){
		return sjly;
	}
	public String getComid() {
		return comid;
	}
	public void setComid(String comid) {
		this.comid = comid;
	}

	
}