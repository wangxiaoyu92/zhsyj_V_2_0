package com.askj.zdhd.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZDHDDJ的中文含义是: 重大活动登记表; InnoDB free: 11264 kB
 * @Creation     2016/11/09 11:34:47
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZDHDDJ")
public class Zdhddj {
	/**
	 * @Description zdhddjid的中文含义是： 
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_zdhddjid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_zdhddjid.nextval from dual"))
	private String zdhddjid;

	/**
	 * @Description comid的中文含义是： 
	 */
	@Column
	private String comid;

	/**
	 * @Description zdhdlxr的中文含义是： 
	 */
	@Column
	private String zdhdlxr;

	/**
	 * @Description zdhdlxdh的中文含义是： 
	 */
	@Column
	private String zdhdlxdh;

	/**
	 * @Description zdhdmc的中文含义是： 
	 */
	@Column
	private String zdhdmc;

	/**
	 * @Description zdhdkssj的中文含义是： 
	 */
	@Column
	private String zdhdkssj;

	/**
	 * @Description zdhdjssj的中文含义是： 
	 */
	@Column
	private String zdhdjssj;

	/**
	 * @Description zdhdjckssj的中文含义是： 
	 */
	@Column
	private String zdhdjckssj;

	/**
	 * @Description zdhdjcryid的中文含义是： 
	 */
	@Column
	private String zdhdjcryid;

	/**
	 * @Description zdhddd的中文含义是： 
	 */
	@Column
	private String zdhddd;

	/**
	 * @Description zdhdjdzb的中文含义是： 
	 */
	@Column
	private String zdhdjdzb;

	/**
	 * @Description zdhdwdzb的中文含义是： 
	 */
	@Column
	private String zdhdwdzb;

	/**
	 * @Description zdhdbeizhu的中文含义是： 
	 */
	@Column
	private String zdhdbeizhu;

	/**
	 * @Description aae011的中文含义是： 
	 */
	@Column
	private String aae011;

	/**
	 * @Description aae036的中文含义是： 
	 */
	@Column
	private String aae036;
	
	/**
	 * @Description aaa027的中文含义是： 
	 */
	@Column
	private String aaa027;	
	
	/**
	 * @Description orgid的中文含义是： 
	 */
	@Column
	private String orgid;	
	
	/**
	 * @Description planid的中文含义是： 
	 */
	@Column
	private String planid;	

	
		/**
	 * @Description zdhddjid的中文含义是： 
	 */
	public void setZdhddjid(String zdhddjid){ 
		this.zdhddjid = zdhddjid;
	}
	/**
	 * @Description zdhddjid的中文含义是： 
	 */
	public String getZdhddjid(){
		return zdhddjid;
	}
	/**
	 * @Description comid的中文含义是： 
	 */
	public void setComid(String comid){ 
		this.comid = comid;
	}
	/**
	 * @Description comid的中文含义是： 
	 */
	public String getComid(){
		return comid;
	}
	/**
	 * @Description zdhdlxr的中文含义是： 
	 */
	public void setZdhdlxr(String zdhdlxr){ 
		this.zdhdlxr = zdhdlxr;
	}
	/**
	 * @Description zdhdlxr的中文含义是： 
	 */
	public String getZdhdlxr(){
		return zdhdlxr;
	}
	/**
	 * @Description zdhdlxdh的中文含义是： 
	 */
	public void setZdhdlxdh(String zdhdlxdh){ 
		this.zdhdlxdh = zdhdlxdh;
	}
	/**
	 * @Description zdhdlxdh的中文含义是： 
	 */
	public String getZdhdlxdh(){
		return zdhdlxdh;
	}
	/**
	 * @Description zdhdmc的中文含义是： 
	 */
	public void setZdhdmc(String zdhdmc){ 
		this.zdhdmc = zdhdmc;
	}
	/**
	 * @Description zdhdmc的中文含义是： 
	 */
	public String getZdhdmc(){
		return zdhdmc;
	}
	/**
	 * @Description zdhdkssj的中文含义是： 
	 */
	public void setZdhdkssj(String zdhdkssj){ 
		this.zdhdkssj = zdhdkssj;
	}
	/**
	 * @Description zdhdkssj的中文含义是： 
	 */
	public String getZdhdkssj(){
		return zdhdkssj;
	}
	/**
	 * @Description zdhdjssj的中文含义是： 
	 */
	public void setZdhdjssj(String zdhdjssj){ 
		this.zdhdjssj = zdhdjssj;
	}
	/**
	 * @Description zdhdjssj的中文含义是： 
	 */
	public String getZdhdjssj(){
		return zdhdjssj;
	}
	/**
	 * @Description zdhdjckssj的中文含义是： 
	 */
	public void setZdhdjckssj(String zdhdjckssj){ 
		this.zdhdjckssj = zdhdjckssj;
	}
	/**
	 * @Description zdhdjckssj的中文含义是： 
	 */
	public String getZdhdjckssj(){
		return zdhdjckssj;
	}
	/**
	 * @Description zdhdjcryid的中文含义是： 
	 */
	public void setZdhdjcryid(String zdhdjcryid){ 
		this.zdhdjcryid = zdhdjcryid;
	}
	/**
	 * @Description zdhdjcryid的中文含义是： 
	 */
	public String getZdhdjcryid(){
		return zdhdjcryid;
	}
	/**
	 * @Description zdhddd的中文含义是： 
	 */
	public void setZdhddd(String zdhddd){ 
		this.zdhddd = zdhddd;
	}
	/**
	 * @Description zdhddd的中文含义是： 
	 */
	public String getZdhddd(){
		return zdhddd;
	}

	public String getZdhdjdzb() {
		return zdhdjdzb;
	}
	public void setZdhdjdzb(String zdhdjdzb) {
		this.zdhdjdzb = zdhdjdzb;
	}
	public String getZdhdwdzb() {
		return zdhdwdzb;
	}
	public void setZdhdwdzb(String zdhdwdzb) {
		this.zdhdwdzb = zdhdwdzb;
	}
	/**
	 * @Description zdhdbeizhu的中文含义是： 
	 */
	public void setZdhdbeizhu(String zdhdbeizhu){ 
		this.zdhdbeizhu = zdhdbeizhu;
	}
	/**
	 * @Description zdhdbeizhu的中文含义是： 
	 */
	public String getZdhdbeizhu(){
		return zdhdbeizhu;
	}
	/**
	 * @Description aae011的中文含义是： 
	 */
	public void setAae011(String aae011){ 
		this.aae011 = aae011;
	}
	/**
	 * @Description aae011的中文含义是： 
	 */
	public String getAae011(){
		return aae011;
	}
	/**
	 * @Description aae036的中文含义是： 
	 */
	public void setAae036(String aae036){ 
		this.aae036 = aae036;
	}
	/**
	 * @Description aae036的中文含义是： 
	 */
	public String getAae036(){
		return aae036;
	}
	public String getAaa027() {
		return aaa027;
	}
	public void setAaa027(String aaa027) {
		this.aaa027 = aaa027;
	}
	public String getOrgid() {
		return orgid;
	}
	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}
	public String getPlanid() {
		return planid;
	}
	public void setPlanid(String planid) {
		this.planid = planid;
	}

	
	
}