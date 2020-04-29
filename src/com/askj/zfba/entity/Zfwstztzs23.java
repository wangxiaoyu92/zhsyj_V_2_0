package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  ZFWSTZTZS23的中文含义是: 听证通知书23; InnoDB free: 2732032 kB
 * @Creation     2016/06/07 18:25:03
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSTZTZS23")
public class Zfwstztzs23 {
	/**
	 * @Description tztzsid的中文含义是： 听证通知书ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_tztzsid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_tztzsid.nextval from dual"))
	private String tztzsid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description tztzwsbh的中文含义是： 文书编号
	 */
	@Column
	private String tztzwsbh;

	/**
	 * @Description tztzsqrq的中文含义是： 听证申请日期
	 */
	@Column
	private String tztzsqrq;

	/**
	 * @Description tztzjxrq的中文含义是： 举行听证日期
	 */
	@Column
	private String tztzjxrq;

	/**
	 * @Description tztzdd的中文含义是： 举行听证地点
	 */
	@Column
	private String tztzdd;

	/**
	 * @Description tztzzcr的中文含义是： 本案听证主持人
	 */
	@Column
	private String tztzzcr;

	/**
	 * @Description tztzjly的中文含义是： 记录员
	 */
	@Column
	private String tztzjly;

	/**
	 * @Description tztzgzrq的中文含义是： 盖章日期
	 */
	@Column
	private String tztzgzrq;

	/**
	 * @Description tztzdsr的中文含义是： 当事人
	 */
	@Column
	private String tztzdsr;

	/**
	 * @Description tztzdz的中文含义是： 地址
	 */
	@Column
	private String tztzdz;

	/**
	 * @Description tztzyzbm的中文含义是： 邮政编码
	 */
	@Column
	private String tztzyzbm;

	/**
	 * @Description tztzlxdh的中文含义是： 联系电话
	 */
	@Column
	private String tztzlxdh;

	/**
	 * @Description tztzlxr的中文含义是： 联系人
	 */
	@Column
	private String tztzlxr;

	/**
	 * @Description tztzsay的中文含义是： 案由
	 */
	@Column
	private String tztzsay;
	
	/**
	 * @Description tztzsyqrq的中文含义是： 申请听证延期日期
	 */
	@Column
	private String tztzsyqrq;
	
	/**
	 * @Description tztzstzsqr的中文含义是： 听证申请人签字
	 */
	@Column
	private String tztzstzsqr;
	
	/**
	 * @Description tztzstzsqrrq的中文含义是： 听证申请人签字或盖章日期
	 */
	@Column
	private String tztzstzsqrrq;
	
	/**
	 * @Description xzjgmc的中文含义是：行政机关名称
	 */
	@Column
	private String xzjgmc;
	
	/**
	 * @Description tztzsid的中文含义是： 听证通知书ID
	 */
	public void setTztzsid(String tztzsid){ 
		this.tztzsid = tztzsid;
	}
	/**
	 * @Description tztzsid的中文含义是： 听证通知书ID
	 */
	public String getTztzsid(){
		return tztzsid;
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
	 * @Description tztzwsbh的中文含义是： 文书编号
	 */
	public void setTztzwsbh(String tztzwsbh){ 
		this.tztzwsbh = tztzwsbh;
	}
	/**
	 * @Description tztzwsbh的中文含义是： 文书编号
	 */
	public String getTztzwsbh(){
		return tztzwsbh;
	}
	/**
	 * @Description tztzsqrq的中文含义是： 听证申请日期
	 */
	public void setTztzsqrq(String tztzsqrq){ 
		this.tztzsqrq = tztzsqrq;
	}
	/**
	 * @Description tztzsqrq的中文含义是： 听证申请日期
	 */
	public String getTztzsqrq(){
		return tztzsqrq;
	}
	/**
	 * @Description tztzjxrq的中文含义是： 举行听证日期
	 */
	public void setTztzjxrq(String tztzjxrq){ 
		this.tztzjxrq = tztzjxrq;
	}
	/**
	 * @Description tztzjxrq的中文含义是： 举行听证日期
	 */
	public String getTztzjxrq(){
		return tztzjxrq;
	}
	/**
	 * @Description tztzdd的中文含义是： 举行听证地点
	 */
	public void setTztzdd(String tztzdd){ 
		this.tztzdd = tztzdd;
	}
	/**
	 * @Description tztzdd的中文含义是： 举行听证地点
	 */
	public String getTztzdd(){
		return tztzdd;
	}
	/**
	 * @Description tztzzcr的中文含义是： 本案听证主持人
	 */
	public void setTztzzcr(String tztzzcr){ 
		this.tztzzcr = tztzzcr;
	}
	/**
	 * @Description tztzzcr的中文含义是： 本案听证主持人
	 */
	public String getTztzzcr(){
		return tztzzcr;
	}
	/**
	 * @Description tztzjly的中文含义是： 记录员
	 */
	public void setTztzjly(String tztzjly){ 
		this.tztzjly = tztzjly;
	}
	/**
	 * @Description tztzjly的中文含义是： 记录员
	 */
	public String getTztzjly(){
		return tztzjly;
	}
	/**
	 * @Description tztzgzrq的中文含义是： 盖章日期
	 */
	public void setTztzgzrq(String tztzgzrq){ 
		this.tztzgzrq = tztzgzrq;
	}
	/**
	 * @Description tztzgzrq的中文含义是： 盖章日期
	 */
	public String getTztzgzrq(){
		return tztzgzrq;
	}
	/**
	 * @Description tztzdsr的中文含义是： 当事人
	 */
	public void setTztzdsr(String tztzdsr){ 
		this.tztzdsr = tztzdsr;
	}
	/**
	 * @Description tztzdsr的中文含义是： 当事人
	 */
	public String getTztzdsr(){
		return tztzdsr;
	}
	/**
	 * @Description tztzdz的中文含义是： 地址
	 */
	public void setTztzdz(String tztzdz){ 
		this.tztzdz = tztzdz;
	}
	/**
	 * @Description tztzdz的中文含义是： 地址
	 */
	public String getTztzdz(){
		return tztzdz;
	}
	/**
	 * @Description tztzyzbm的中文含义是： 邮政编码
	 */
	public void setTztzyzbm(String tztzyzbm){ 
		this.tztzyzbm = tztzyzbm;
	}
	/**
	 * @Description tztzyzbm的中文含义是： 邮政编码
	 */
	public String getTztzyzbm(){
		return tztzyzbm;
	}
	/**
	 * @Description tztzlxdh的中文含义是： 联系电话
	 */
	public void setTztzlxdh(String tztzlxdh){ 
		this.tztzlxdh = tztzlxdh;
	}
	/**
	 * @Description tztzlxdh的中文含义是： 联系电话
	 */
	public String getTztzlxdh(){
		return tztzlxdh;
	}
	/**
	 * @Description tztzlxr的中文含义是： 联系人
	 */
	public void setTztzlxr(String tztzlxr){ 
		this.tztzlxr = tztzlxr;
	}
	/**
	 * @Description tztzlxr的中文含义是： 联系人
	 */
	public String getTztzlxr(){
		return tztzlxr;
	}
	
	/**
	 * @Description tztzsay的中文含义是： 案由
	 */
	public String getTztzsay() {
		return tztzsay;
	}

	/**
	 * @Description tztzsay的中文含义是： 案由
	 */
	public void setTztzsay(String tztzsay) {
		this.tztzsay = tztzsay;
	}

	/**
	 * @Description tztzsyqrq的中文含义是： 申请听证延期日期
	 */
	public String getTztzsyqrq() {
		return tztzsyqrq;
	}

	/**
	 * @Description tztzsyqrq的中文含义是： 申请听证延期日期
	 */
	public void setTztzsyqrq(String tztzsyqrq) {
		this.tztzsyqrq = tztzsyqrq;
	}

	/**
	 * @Description tztzstzsqr的中文含义是： 听证申请人签字
	 */
	public String getTztzstzsqr() {
		return tztzstzsqr;
	}

	/**
	 * @Description tztzstzsqr的中文含义是： 听证申请人签字
	 */
	public void setTztzstzsqr(String tztzstzsqr) {
		this.tztzstzsqr = tztzstzsqr;
	}

	/**
	 * @Description tztzstzsqrrq的中文含义是： 听证申请人签字或盖章日期
	 */
	public String getTztzstzsqrrq() {
		return tztzstzsqrrq;
	}

	/**
	 * @Description tztzstzsqrrq的中文含义是： 听证申请人签字或盖章日期
	 */
	public void setTztzstzsqrrq(String tztzstzsqrrq) {
		this.tztzstzsqrrq = tztzstzsqrrq;
	}

	/**
	 * @Description xzjgmc的中文含义是：行政机关名称
	 */
	public String getXzjgmc() {
		return xzjgmc;
	}

	/**
	 * @Description xzjgmc的中文含义是：行政机关名称
	 */
	public void setXzjgmc(String xzjgmc) {
		this.xzjgmc = xzjgmc;
	} 
	

	
}