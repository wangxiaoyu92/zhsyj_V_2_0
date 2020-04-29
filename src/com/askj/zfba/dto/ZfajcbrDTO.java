package com.askj.zfba.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFAJCBR的中文含义是: 立案表对应的执法人员信息; InnoDB free: 6144 kBDTO
 * @Creation     2016/09/27 13:26:14
 * @Written      Create Tool By zjf 
 **/
public class ZfajcbrDTO {
	/**
	 * @Description ajcbr_table_rows的中文含义是： 承办人
	 */	  
	  private String ajcbr_table_rows;
	  
	/**
	 * @Description ajcbr_table_rows的中文含义是： 承办人
	 */	  
	  private String ajxbr_table_rows;
  
	/**
	 * @Description ajcbr_table_rows的中文含义是： 承办人
	 */	  
	  private String ajqtry_table_rows;		  
	  
	/**
	 * @Description ajcbrid的中文含义是： 
	 */
	private String ajcbrid;

	/**
	 * @Description ajdjid的中文含义是： 
	 */
	private String ajdjid;

	/**
	 * @Description userid的中文含义是： 
	 */
	private String userid;

	/**
	 * @Description zfryxm的中文含义是： 
	 */
	private String zfryxm;

	/**
	 * @Description zfrysflx的中文含义是： 
	 */
	private String zfrysflx;

	/**
	 * @Description zfryzjhm的中文含义是： 
	 */
	private String zfryzjhm;

	/**
	 * @Description zfrybmmc的中文含义是： 
	 */
	private String zfrybmmc;

	/**
	 * @Description zfryzw的中文含义是： 
	 */
	private String zfryzw;

	
		/**
	 * @Description ajcbrid的中文含义是： 
	 */
	public void setAjcbrid(String ajcbrid){ 
		this.ajcbrid = ajcbrid;
	}
	/**
	 * @Description ajcbrid的中文含义是： 
	 */
	public String getAjcbrid(){
		return ajcbrid;
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
	 * @Description userid的中文含义是： 
	 */
	public void setUserid(String userid){ 
		this.userid = userid;
	}
	/**
	 * @Description userid的中文含义是： 
	 */
	public String getUserid(){
		return userid;
	}
	/**
	 * @Description zfryxm的中文含义是： 
	 */
	public void setZfryxm(String zfryxm){ 
		this.zfryxm = zfryxm;
	}
	/**
	 * @Description zfryxm的中文含义是： 
	 */
	public String getZfryxm(){
		return zfryxm;
	}
	/**
	 * @Description zfrysflx的中文含义是： 
	 */
	public void setZfrysflx(String zfrysflx){ 
		this.zfrysflx = zfrysflx;
	}
	/**
	 * @Description zfrysflx的中文含义是： 
	 */
	public String getZfrysflx(){
		return zfrysflx;
	}
	/**
	 * @Description zfryzjhm的中文含义是： 
	 */
	public void setZfryzjhm(String zfryzjhm){ 
		this.zfryzjhm = zfryzjhm;
	}
	/**
	 * @Description zfryzjhm的中文含义是： 
	 */
	public String getZfryzjhm(){
		return zfryzjhm;
	}
	/**
	 * @Description zfrybmmc的中文含义是： 
	 */
	public void setZfrybmmc(String zfrybmmc){ 
		this.zfrybmmc = zfrybmmc;
	}
	/**
	 * @Description zfrybmmc的中文含义是： 
	 */
	public String getZfrybmmc(){
		return zfrybmmc;
	}
	/**
	 * @Description zfryzw的中文含义是： 
	 */
	public void setZfryzw(String zfryzw){ 
		this.zfryzw = zfryzw;
	}
	/**
	 * @Description zfryzw的中文含义是： 
	 */
	public String getZfryzw(){
		return zfryzw;
	}
	public String getAjcbr_table_rows() {
		return ajcbr_table_rows;
	}
	public void setAjcbr_table_rows(String ajcbr_table_rows) {
		this.ajcbr_table_rows = ajcbr_table_rows;
	}
	public String getAjxbr_table_rows() {
		return ajxbr_table_rows;
	}
	public void setAjxbr_table_rows(String ajxbr_table_rows) {
		this.ajxbr_table_rows = ajxbr_table_rows;
	}
	public String getAjqtry_table_rows() {
		return ajqtry_table_rows;
	}
	public void setAjqtry_table_rows(String ajqtry_table_rows) {
		this.ajqtry_table_rows = ajqtry_table_rows;
	}
	
	
}