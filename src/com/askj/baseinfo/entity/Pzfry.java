package com.askj.baseinfo.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  PZFRY的中文含义是: 执法人员表; InnoDB free: 2757632 kB
 * @Creation     2016/04/16 09:02:35
 * @Written      Create Tool By zjf 
 **/
@Table(value = "PZFRY")
public class Pzfry {
	/**
	 * @Description zfryid的中文含义是： 执法人员ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_zfryid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_zfryid.nextval from dual"))
	private String zfryid;

	/**
	 * @Description zfrypym的中文含义是： 执法人员姓名拼音缩写
	 */
	@Column
	private String zfrypym;

	/**
	 * @Description zfryxb的中文含义是： 执法人员性别
	 */
	@Column
	private String zfryxb;

	/**
	 * @Description zfrycsrq的中文含义是： 执法人员出生日期
	 */
	@Column
	private String zfrycsrq;

	/**
	 * @Description zfrysfzh的中文含义是： 执法人员身份证号
	 */
	@Column
	private String zfrysfzh;

	/**
	 * @Description zfryzjhm的中文含义是： 执法人员证件号码
	 */
	@Column
	private String zfryzjhm;

	/**
	 * @Description zfryzflyid的中文含义是： 执法人员执法领域对应pzfryzfly表id
	 */
	@Column
	private String zfryzflyid;

	/**
	 * @Description zfrybz的中文含义是： 备注
	 */
	@Column
	private String zfrybz;

	/**
	 * @Description zfryczy的中文含义是： 操作员
	 */
	@Column
	private String zfryczy;

	/**
	 * @Description zfryczsj的中文含义是： 操作时间
	 */
	@Column
	private String zfryczsj;

	/**
	 * @Description zfryzw的中文含义是： 执法人员职务
	 */
	@Column
	private String zfryzw;

	
		/**
	 * @Description zfryid的中文含义是： 执法人员ID
	 */
	public void setZfryid(String zfryid){ 
		this.zfryid = zfryid;
	}
	/**
	 * @Description zfryid的中文含义是： 执法人员ID
	 */
	public String getZfryid(){
		return zfryid;
	}
	/**
	 * @Description zfrypym的中文含义是： 执法人员姓名拼音缩写
	 */
	public void setZfrypym(String zfrypym){ 
		this.zfrypym = zfrypym;
	}
	/**
	 * @Description zfrypym的中文含义是： 执法人员姓名拼音缩写
	 */
	public String getZfrypym(){
		return zfrypym;
	}
	/**
	 * @Description zfryxb的中文含义是： 执法人员性别
	 */
	public void setZfryxb(String zfryxb){ 
		this.zfryxb = zfryxb;
	}
	/**
	 * @Description zfryxb的中文含义是： 执法人员性别
	 */
	public String getZfryxb(){
		return zfryxb;
	}
	/**
	 * @Description zfrycsrq的中文含义是： 执法人员出生日期
	 */
	public void setZfrycsrq(String zfrycsrq){ 
		this.zfrycsrq = zfrycsrq;
	}
	/**
	 * @Description zfrycsrq的中文含义是： 执法人员出生日期
	 */
	public String getZfrycsrq(){
		return zfrycsrq;
	}
	/**
	 * @Description zfrysfzh的中文含义是： 执法人员身份证号
	 */
	public void setZfrysfzh(String zfrysfzh){ 
		this.zfrysfzh = zfrysfzh;
	}
	/**
	 * @Description zfrysfzh的中文含义是： 执法人员身份证号
	 */
	public String getZfrysfzh(){
		return zfrysfzh;
	}
	/**
	 * @Description zfryzjhm的中文含义是： 执法人员证件号码
	 */
	public void setZfryzjhm(String zfryzjhm){ 
		this.zfryzjhm = zfryzjhm;
	}
	/**
	 * @Description zfryzjhm的中文含义是： 执法人员证件号码
	 */
	public String getZfryzjhm(){
		return zfryzjhm;
	}
	/**
	 * @Description zfryzflyid的中文含义是： 执法人员执法领域对应pzfryzfly表id
	 */
	public void setZfryzflyid(String zfryzflyid){ 
		this.zfryzflyid = zfryzflyid;
	}
	/**
	 * @Description zfryzflyid的中文含义是： 执法人员执法领域对应pzfryzfly表id
	 */
	public String getZfryzflyid(){
		return zfryzflyid;
	}
	/**
	 * @Description zfrybz的中文含义是： 备注
	 */
	public void setZfrybz(String zfrybz){ 
		this.zfrybz = zfrybz;
	}
	/**
	 * @Description zfrybz的中文含义是： 备注
	 */
	public String getZfrybz(){
		return zfrybz;
	}
	/**
	 * @Description zfryczy的中文含义是： 操作员
	 */
	public void setZfryczy(String zfryczy){ 
		this.zfryczy = zfryczy;
	}
	/**
	 * @Description zfryczy的中文含义是： 操作员
	 */
	public String getZfryczy(){
		return zfryczy;
	}
	/**
	 * @Description zfryczsj的中文含义是： 操作时间
	 */
	public void setZfryczsj(String zfryczsj){ 
		this.zfryczsj = zfryczsj;
	}
	/**
	 * @Description zfryczsj的中文含义是： 操作时间
	 */
	public String getZfryczsj(){
		return zfryczsj;
	}
	/**
	 * @Description zfryzw的中文含义是： 执法人员职务
	 */
	public void setZfryzw(String zfryzw){ 
		this.zfryzw = zfryzw;
	}
	/**
	 * @Description zfryzw的中文含义是： 执法人员职务
	 */
	public String getZfryzw(){
		return zfryzw;
	}

	
}