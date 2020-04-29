package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSSXFZAJYSS5的中文含义是: 涉嫌犯罪案件移送书; InnoDB free: 75776 kB
 * @Creation     2016/03/14 16:32:00
 * @Written      Create Tool By wanghao 
 **/
@Table(value = "ZFWSSXFZAJYSS5")
public class Zfwssxfzajyss5 {
	/**
	 * @Description sxfzysid的中文含义是： 
	 */
	@Name
	@Column
	private String sxfzysid;

	/**
	 * @Description ajdjid的中文含义是： 
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description wsbh的中文含义是： 
	 */
	@Column
	private String wsbh;

	/**
	 * @Description sysbmmc的中文含义是： 
	 */
	@Column
	private String sysbmmc;

	/**
	 * @Description sxfzxw的中文含义是： 
	 */
	@Column
	private String sxfzxw;

	/**
	 * @Description fujian的中文含义是： 
	 */
	@Column
	private String fujian;

	/**
	 * @Description ysrq的中文含义是： 
	 */
	@Column
	private String ysrq;
	/**
	 * @Description dsr的中文含义是： 
	 */
	@Column
	private String dsr;
	/**
	 * @Description lxr的中文含义是： 
	 */
	@Column
	private String lxr;
	/**
	 * @Description lxdh的中文含义是： 
	 */
	@Column
	private String lxdh;

	
	
	public String getLxr() {
		return lxr;
	}
	public void setLxr(String lxr) {
		this.lxr = lxr;
	}
	public String getLxdh() {
		return lxdh;
	}
	public void setLxdh(String lxdh) {
		this.lxdh = lxdh;
	}
	public String getDsr() {
		return dsr;
	}
	public void setDsr(String dsr) {
		this.dsr = dsr;
	}
		/**
	 * @Description sxfzysid的中文含义是： 
	 */
	public void setSxfzysid(String sxfzysid){ 
		this.sxfzysid = sxfzysid;
	}
	/**
	 * @Description sxfzysid的中文含义是： 
	 */
	public String getSxfzysid(){
		return sxfzysid;
	}
	/**
	 * @Description ajdjid的中文含义是： 
	 */
	public void setAjdjid(String ajdjid){ 
		this.ajdjid = ajdjid;
	}
	/**
	 * @Description ajdjid的中文含义是： 
	 */
	public String getAjdjid(){
		return ajdjid;
	}
	/**
	 * @Description wsbh的中文含义是： 
	 */
	public void setWsbh(String wsbh){ 
		this.wsbh = wsbh;
	}
	/**
	 * @Description wsbh的中文含义是： 
	 */
	public String getWsbh(){
		return wsbh;
	}
	/**
	 * @Description sysbmmc的中文含义是： 
	 */
	public void setSysbmmc(String sysbmmc){ 
		this.sysbmmc = sysbmmc;
	}
	/**
	 * @Description sysbmmc的中文含义是： 
	 */
	public String getSysbmmc(){
		return sysbmmc;
	}
	/**
	 * @Description sxfzxw的中文含义是： 
	 */
	public void setSxfzxw(String sxfzxw){ 
		this.sxfzxw = sxfzxw;
	}
	/**
	 * @Description sxfzxw的中文含义是： 
	 */
	public String getSxfzxw(){
		return sxfzxw;
	}
	/**
	 * @Description fujian的中文含义是： 
	 */
	public void setFujian(String fujian){ 
		this.fujian = fujian;
	}
	/**
	 * @Description fujian的中文含义是： 
	 */
	public String getFujian(){
		return fujian;
	}
	/**
	 * @Description ysrq的中文含义是： 
	 */
	public void setYsrq(String ysrq){ 
		this.ysrq = ysrq;
	}
	/**
	 * @Description ysrq的中文含义是： 
	 */
	public String getYsrq(){
		return ysrq;
	}

	
}