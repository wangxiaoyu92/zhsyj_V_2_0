package com.askj.supervision.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  Pcompanynddtpj的中文含义是: 企业年度动态评级表; InnoDB free: 578560 kB
 * @Creation     2017/03/13 20:57:20
 * @Written      Create Tool By zjf 
 **/
@Table(value = "pcompanynddtpj")
public class Pcompanynddtpj {
	/**
	 * @Description pcompanynddtpjid的中文含义是： 企业年度动态评级表ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_pcompanynddtpjid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_pcompanynddtpjid.nextval from dual"))
	private String pcompanynddtpjid;

	/**
	 * @Description comid的中文含义是： 企业ID
	 */
	@Column
	private String comid;

	/**
	 * @Description pdyear的中文含义是： 评定年度
	 */
	@Column
	private String pdyear;

	/**
	 * @Description lhfjndpddj的中文含义是： 量化分级年度评定等级
	 */
	@Column
	private String lhfjndpddj;

	/**
	 * @Description aae011的中文含义是： 操作员
	 */
	@Column
	private String aae011;

	/**
	 * @Description aae036的中文含义是： 操作时间
	 */
	@Column
	private String aae036;

	/**
	 * @Description aae013的中文含义是： 备注
	 */
	@Column
	private String aae013;
	/**
	 * @Description pdjgscfs的中文含义是： 评定结果生产方式0自动1手动
	 */
	@Column
	private String pdjgscfs;

	/**
	 * @Description pdjgscfs的中文含义是： 静态分
	 */
	@Column
	private String jingtaifen;

	/**
	 * @Description pdjgscfs的中文含义是： 动态分
	 */
	@Column
	private String dongtaifen;

	/**
	 * @Description defen： 得分
	 */
	@Column
	private String defen;


	/**
	 * @Description pcompanynddtpjid的中文含义是： 企业年度动态评级表ID
	 */
	public void setPcompanynddtpjid(String pcompanynddtpjid){ 
		this.pcompanynddtpjid = pcompanynddtpjid;
	}
	/**
	 * @Description pcompanynddtpjid的中文含义是： 企业年度动态评级表ID
	 */
	public String getPcompanynddtpjid(){
		return pcompanynddtpjid;
	}
	/**
	 * @Description comid的中文含义是： 企业ID
	 */
	public void setComid(String comid){ 
		this.comid = comid;
	}
	/**
	 * @Description comid的中文含义是： 企业ID
	 */
	public String getComid(){
		return comid;
	}
	/**
	 * @Description pdyear的中文含义是： 评定年度
	 */
	public void setPdyear(String pdyear){ 
		this.pdyear = pdyear;
	}
	/**
	 * @Description pdyear的中文含义是： 评定年度
	 */
	public String getPdyear(){
		return pdyear;
	}
	/**
	 * @Description lhfjndpddj的中文含义是： 量化分级年度评定等级
	 */
	public void setLhfjndpddj(String lhfjndpddj){ 
		this.lhfjndpddj = lhfjndpddj;
	}
	/**
	 * @Description lhfjndpddj的中文含义是： 量化分级年度评定等级
	 */
	public String getLhfjndpddj(){
		return lhfjndpddj;
	}
	/**
	 * @Description aae011的中文含义是： 操作员
	 */
	public void setAae011(String aae011){ 
		this.aae011 = aae011;
	}
	/**
	 * @Description aae011的中文含义是： 操作员
	 */
	public String getAae011(){
		return aae011;
	}
	/**
	 * @Description aae036的中文含义是： 操作时间
	 */
	public void setAae036(String aae036){ 
		this.aae036 = aae036;
	}
	/**
	 * @Description aae036的中文含义是： 操作时间
	 */
	public String getAae036(){
		return aae036;
	}
	/**
	 * @Description aae013的中文含义是： 备注
	 */
	public void setAae013(String aae013){ 
		this.aae013 = aae013;
	}
	/**
	 * @Description aae013的中文含义是： 备注
	 */
	public String getAae013(){
		return aae013;
	}
	public String getPdjgscfs() {
		return pdjgscfs;
	}
	public void setPdjgscfs(String pdjgscfs) {
		this.pdjgscfs = pdjgscfs;
	}

	public String getJingtaifen() {
		return jingtaifen;
	}

	public void setJingtaifen(String jingtaifen) {
		this.jingtaifen = jingtaifen;
	}

	public String getDongtaifen() {
		return dongtaifen;
	}

	public void setDongtaifen(String dongtaifen) {
		this.dongtaifen = dongtaifen;
	}

	public String getDefen() {
		return defen;
	}

	public void setDefen(String defen) {
		this.defen = defen;
	}
}