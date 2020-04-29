package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSCSSBBL34的中文含义是: 陈述申辩笔录; InnoDB free: 2725888 kB
 * @Creation     2016/06/24 11:03:33
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSCSSBBL34")
public class Zfwscssbbl34 {
	/**
	 * @Description cssbblid的中文含义是： 陈述申辩笔录ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_cssbblid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_cssbblid.nextval from dual"))
	private String cssbblid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description cssbr的中文含义是： 陈述申辩人
	 */
	@Column
	private String cssbr;

	/**
	 * @Description cssbrlxfs的中文含义是： 陈述申辩人联系方式
	 */
	@Column
	private String cssbrlxfs;

	/**
	 * @Description cssbwtdlr的中文含义是： 委托代理人
	 */
	@Column
	private String cssbwtdlr;

	/**
	 * @Description cssbwtdlrzw的中文含义是： 委托代理人职务
	 */
	@Column
	private String cssbwtdlrzw;

	/**
	 * @Description cssbwtdlrsfzh的中文含义是： 身份证号
	 */
	@Column
	private String cssbwtdlrsfzh;

	/**
	 * @Description cssbcbr的中文含义是： 承办人
	 */
	@Column
	private String cssbcbr;

	/**
	 * @Description cssbjlr的中文含义是： 记录人
	 */
	@Column
	private String cssbjlr;

	/**
	 * @Description cssbdd的中文含义是： 陈述申辩地点
	 */
	@Column
	private String cssbdd;

	/**
	 * @Description cssbsj的中文含义是： 陈述申辩时间
	 */
	@Column
	private String cssbsj;

	/**
	 * @Description cssbjzsj的中文含义是： 陈述申辩截止日期
	 */
	@Column
	private String cssbjzsj;

	/**
	 * @Description cssbnr的中文含义是： 陈述申辩内容
	 */
	@Column
	private String cssbnr;

	/**
	 * @Description cssbrqz的中文含义是： 陈述申辩人签字
	 */
	@Column
	private String cssbrqz;

	/**
	 * @Description cssbrqzrq的中文含义是： 陈述申辩人签字日期
	 */
	@Column
	private String cssbrqzrq;

	/**
	 * @Description cssbcbrqz的中文含义是： 承办人签字1
	 */
	@Column
	private String cssbcbrqz;

	/**
	 * @Description cssbcbrqzrq的中文含义是： 承办人签字日期
	 */
	@Column
	private String cssbcbrqzrq;

	/**
	 * @Description cssbjlrqz的中文含义是： 记录人签字
	 */
	@Column
	private String cssbjlrqz;

	/**
	 * @Description cssbjlrqzrq的中文含义是： 记录人签字日期
	 */
	@Column
	private String cssbjlrqzrq;

	/**
	 * @Description ajdjay的中文含义是： 案由
	 */
	@Column
	private String ajdjay;

	/**
	 * @Description cssbdsr的中文含义是： 当事人
	 */
	@Column
	private String cssbdsr;

	/**
	 * @Description cssbcbrqz2的中文含义是： 承办人签字2
	 */
	@Column
	private String cssbcbrqz2;

	
		/**
	 * @Description cssbblid的中文含义是： 陈述申辩笔录ID
	 */
	public void setCssbblid(String cssbblid){ 
		this.cssbblid = cssbblid;
	}
	/**
	 * @Description cssbblid的中文含义是： 陈述申辩笔录ID
	 */
	public String getCssbblid(){
		return cssbblid;
	}
	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	public void setAjdjid(String ajdjid){ 
		this.ajdjid = ajdjid;
	}
	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	public String getAjdjid(){
		return ajdjid;
	}
	/**
	 * @Description cssbr的中文含义是： 陈述申辩人
	 */
	public void setCssbr(String cssbr){ 
		this.cssbr = cssbr;
	}
	/**
	 * @Description cssbr的中文含义是： 陈述申辩人
	 */
	public String getCssbr(){
		return cssbr;
	}
	/**
	 * @Description cssbrlxfs的中文含义是： 陈述申辩人联系方式
	 */
	public void setCssbrlxfs(String cssbrlxfs){ 
		this.cssbrlxfs = cssbrlxfs;
	}
	/**
	 * @Description cssbrlxfs的中文含义是： 陈述申辩人联系方式
	 */
	public String getCssbrlxfs(){
		return cssbrlxfs;
	}
	/**
	 * @Description cssbwtdlr的中文含义是： 委托代理人
	 */
	public void setCssbwtdlr(String cssbwtdlr){ 
		this.cssbwtdlr = cssbwtdlr;
	}
	/**
	 * @Description cssbwtdlr的中文含义是： 委托代理人
	 */
	public String getCssbwtdlr(){
		return cssbwtdlr;
	}
	/**
	 * @Description cssbwtdlrzw的中文含义是： 委托代理人职务
	 */
	public void setCssbwtdlrzw(String cssbwtdlrzw){ 
		this.cssbwtdlrzw = cssbwtdlrzw;
	}
	/**
	 * @Description cssbwtdlrzw的中文含义是： 委托代理人职务
	 */
	public String getCssbwtdlrzw(){
		return cssbwtdlrzw;
	}
	/**
	 * @Description cssbwtdlrsfzh的中文含义是： 身份证号
	 */
	public void setCssbwtdlrsfzh(String cssbwtdlrsfzh){ 
		this.cssbwtdlrsfzh = cssbwtdlrsfzh;
	}
	/**
	 * @Description cssbwtdlrsfzh的中文含义是： 身份证号
	 */
	public String getCssbwtdlrsfzh(){
		return cssbwtdlrsfzh;
	}
	/**
	 * @Description cssbcbr的中文含义是： 承办人
	 */
	public void setCssbcbr(String cssbcbr){ 
		this.cssbcbr = cssbcbr;
	}
	/**
	 * @Description cssbcbr的中文含义是： 承办人
	 */
	public String getCssbcbr(){
		return cssbcbr;
	}
	/**
	 * @Description cssbjlr的中文含义是： 记录人
	 */
	public void setCssbjlr(String cssbjlr){ 
		this.cssbjlr = cssbjlr;
	}
	/**
	 * @Description cssbjlr的中文含义是： 记录人
	 */
	public String getCssbjlr(){
		return cssbjlr;
	}
	/**
	 * @Description cssbdd的中文含义是： 陈述申辩地点
	 */
	public void setCssbdd(String cssbdd){ 
		this.cssbdd = cssbdd;
	}
	/**
	 * @Description cssbdd的中文含义是： 陈述申辩地点
	 */
	public String getCssbdd(){
		return cssbdd;
	}
	/**
	 * @Description cssbsj的中文含义是： 陈述申辩时间
	 */
	public void setCssbsj(String cssbsj){ 
		this.cssbsj = cssbsj;
	}
	/**
	 * @Description cssbsj的中文含义是： 陈述申辩时间
	 */
	public String getCssbsj(){
		return cssbsj;
	}
	/**
	 * @Description cssbjzsj的中文含义是： 陈述申辩截止日期
	 */
	public void setCssbjzsj(String cssbjzsj){ 
		this.cssbjzsj = cssbjzsj;
	}
	/**
	 * @Description cssbjzsj的中文含义是： 陈述申辩截止日期
	 */
	public String getCssbjzsj(){
		return cssbjzsj;
	}
	/**
	 * @Description cssbnr的中文含义是： 陈述申辩内容
	 */
	public void setCssbnr(String cssbnr){ 
		this.cssbnr = cssbnr;
	}
	/**
	 * @Description cssbnr的中文含义是： 陈述申辩内容
	 */
	public String getCssbnr(){
		return cssbnr;
	}
	/**
	 * @Description cssbrqz的中文含义是： 陈述申辩人签字
	 */
	public void setCssbrqz(String cssbrqz){ 
		this.cssbrqz = cssbrqz;
	}
	/**
	 * @Description cssbrqz的中文含义是： 陈述申辩人签字
	 */
	public String getCssbrqz(){
		return cssbrqz;
	}
	/**
	 * @Description cssbrqzrq的中文含义是： 陈述申辩人签字日期
	 */
	public void setCssbrqzrq(String cssbrqzrq){ 
		this.cssbrqzrq = cssbrqzrq;
	}
	/**
	 * @Description cssbrqzrq的中文含义是： 陈述申辩人签字日期
	 */
	public String getCssbrqzrq(){
		return cssbrqzrq;
	}
	/**
	 * @Description cssbcbrqz的中文含义是： 承办人签字1
	 */
	public void setCssbcbrqz(String cssbcbrqz){ 
		this.cssbcbrqz = cssbcbrqz;
	}
	/**
	 * @Description cssbcbrqz的中文含义是： 承办人签字1
	 */
	public String getCssbcbrqz(){
		return cssbcbrqz;
	}
	/**
	 * @Description cssbcbrqzrq的中文含义是： 承办人签字日期
	 */
	public void setCssbcbrqzrq(String cssbcbrqzrq){ 
		this.cssbcbrqzrq = cssbcbrqzrq;
	}
	/**
	 * @Description cssbcbrqzrq的中文含义是： 承办人签字日期
	 */
	public String getCssbcbrqzrq(){
		return cssbcbrqzrq;
	}
	/**
	 * @Description cssbjlrqz的中文含义是： 记录人签字
	 */
	public void setCssbjlrqz(String cssbjlrqz){ 
		this.cssbjlrqz = cssbjlrqz;
	}
	/**
	 * @Description cssbjlrqz的中文含义是： 记录人签字
	 */
	public String getCssbjlrqz(){
		return cssbjlrqz;
	}
	/**
	 * @Description cssbjlrqzrq的中文含义是： 记录人签字日期
	 */
	public void setCssbjlrqzrq(String cssbjlrqzrq){ 
		this.cssbjlrqzrq = cssbjlrqzrq;
	}
	/**
	 * @Description cssbjlrqzrq的中文含义是： 记录人签字日期
	 */
	public String getCssbjlrqzrq(){
		return cssbjlrqzrq;
	}
	/**
	 * @Description ajdjay的中文含义是： 案由
	 */
	public void setAjdjay(String ajdjay){ 
		this.ajdjay = ajdjay;
	}
	/**
	 * @Description ajdjay的中文含义是： 案由
	 */
	public String getAjdjay(){
		return ajdjay;
	}
	/**
	 * @Description cssbdsr的中文含义是： 当事人
	 */
	public void setCssbdsr(String cssbdsr){ 
		this.cssbdsr = cssbdsr;
	}
	/**
	 * @Description cssbdsr的中文含义是： 当事人
	 */
	public String getCssbdsr(){
		return cssbdsr;
	}
	/**
	 * @Description cssbcbrqz2的中文含义是： 承办人签字2
	 */
	public void setCssbcbrqz2(String cssbcbrqz2){ 
		this.cssbcbrqz2 = cssbcbrqz2;
	}
	/**
	 * @Description cssbcbrqz2的中文含义是： 承办人签字2
	 */
	public String getCssbcbrqz2(){
		return cssbcbrqz2;
	}

	
}