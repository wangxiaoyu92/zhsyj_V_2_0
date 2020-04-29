package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  ZFWSTZGZS22的中文含义是: 听证告知书22; InnoDB free: 2723840 kB
 * @Creation     2016/06/07 17:38:14
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSTZGZS22")
public class Zfwstzgzs22 {
	/**
	 * @Description tzgzsid的中文含义是： 听证告知书ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_tzgzsid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_tzgzsid.nextval from dual"))
	private String tzgzsid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description tzgzwsbh的中文含义是： 文书编号
	 */
	@Column
	private String tzgzwsbh;

	/**
	 * @Description tzgzwfxwms的中文含义是： 违法行为描述
	 */
	@Column
	private String tzgzwfxwms;

	/**
	 * @Description tzgzwfflfg的中文含义是： 违反的法律法规
	 */
	@Column
	private String tzgzwfflfg;

	/**
	 * @Description tzgzyjflfg的中文含义是： 依据法律法规
	 */
	@Column
	private String tzgzyjflfg;

	/**
	 * @Description tzgzxzcf的中文含义是： 行政处罚
	 */
	@Column
	private String tzgzxzcf;

	/**
	 * @Description gzgzgzrq的中文含义是： 盖章日期
	 */
	@Column
	private String gzgzgzrq;

	/**
	 * @Description gzgzdz的中文含义是： 地址
	 */
	@Column
	private String gzgzdz;

	/**
	 * @Description gzgzyzbm的中文含义是： 邮政编码
	 */
	@Column
	private String gzgzyzbm;

	/**
	 * @Description gzgzlxdh的中文含义是： 联系电话
	 */
	@Column
	private String gzgzlxdh;

	/**
	 * @Description gzgzlxr的中文含义是： 联系人
	 */
	@Column
	private String gzgzlxr;

	/**
	 * @Description tzgzdsr的中文含义是： 当事人
	 */
	@Column
	private String tzgzdsr;

	/**
	 * @Description tzgzqsrq的中文含义是： 开始日期(汤阴)
	 */
	@Column
	private String tzgzqsrq;

	/**
	 * @Description tzgzjsrq的中文含义是： 结束日期(汤阴)
	 */
	@Column
	private String tzgzjsrq;

	/**
	 * @Description tzgzwfxwdc的中文含义是： 违法行为等次，见aaa100=WFXWDC(汤阴)
	 */
	@Column
	private String tzgzwfxwdc;

	/**
	 * @Description tzgzcfyjyzgd的中文含义是： 处罚依据依照什么规定(汤阴)
	 */
	@Column
	private String tzgzcfyjyzgd;
	
	/**
	 * @Description tzgzslasj的中文含义是： 立案时间
	 */
	@Column
	private String tzgzslasj;
	
	/**
	 * @Description tzgzsay的中文含义是： 案由
	 */
	@Column
	private String tzgzsay;
	
	/**
	 * @Description tzgzszmnr的中文含义是： 证据所要证明内容
	 */
	@Column
	private String tzgzszmnr;
	
	/**
	 * @Description xzjgmc的中文含义是： 行政机关名称
	 */
	@Column
	private String xzjgmc;
	
	/**
	 * @Description czxzcfclbz的中文含义是： 参照行政处罚裁量标准
	 */
	@Column
	private String czxzcfclbz;

	/**
	 * @Description tzgzsid的中文含义是： 听证告知书ID
	 */
	public void setTzgzsid(String tzgzsid){ 
		this.tzgzsid = tzgzsid;
	}
	/**
	 * @Description tzgzsid的中文含义是： 听证告知书ID
	 */
	public String getTzgzsid(){
		return tzgzsid;
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
	 * @Description tzgzwsbh的中文含义是： 文书编号
	 */
	public void setTzgzwsbh(String tzgzwsbh){ 
		this.tzgzwsbh = tzgzwsbh;
	}
	/**
	 * @Description tzgzwsbh的中文含义是： 文书编号
	 */
	public String getTzgzwsbh(){
		return tzgzwsbh;
	}
	/**
	 * @Description tzgzwfxwms的中文含义是： 违法行为描述
	 */
	public void setTzgzwfxwms(String tzgzwfxwms){ 
		this.tzgzwfxwms = tzgzwfxwms;
	}
	/**
	 * @Description tzgzwfxwms的中文含义是： 违法行为描述
	 */
	public String getTzgzwfxwms(){
		return tzgzwfxwms;
	}
	/**
	 * @Description tzgzwfflfg的中文含义是： 违反的法律法规
	 */
	public void setTzgzwfflfg(String tzgzwfflfg){ 
		this.tzgzwfflfg = tzgzwfflfg;
	}
	/**
	 * @Description tzgzwfflfg的中文含义是： 违反的法律法规
	 */
	public String getTzgzwfflfg(){
		return tzgzwfflfg;
	}
	/**
	 * @Description tzgzyjflfg的中文含义是： 依据法律法规
	 */
	public void setTzgzyjflfg(String tzgzyjflfg){ 
		this.tzgzyjflfg = tzgzyjflfg;
	}
	/**
	 * @Description tzgzyjflfg的中文含义是： 依据法律法规
	 */
	public String getTzgzyjflfg(){
		return tzgzyjflfg;
	}
	/**
	 * @Description tzgzxzcf的中文含义是： 行政处罚
	 */
	public void setTzgzxzcf(String tzgzxzcf){ 
		this.tzgzxzcf = tzgzxzcf;
	}
	/**
	 * @Description tzgzxzcf的中文含义是： 行政处罚
	 */
	public String getTzgzxzcf(){
		return tzgzxzcf;
	}
	/**
	 * @Description gzgzgzrq的中文含义是： 盖章日期
	 */
	public void setGzgzgzrq(String gzgzgzrq){ 
		this.gzgzgzrq = gzgzgzrq;
	}
	/**
	 * @Description gzgzgzrq的中文含义是： 盖章日期
	 */
	public String getGzgzgzrq(){
		return gzgzgzrq;
	}
	/**
	 * @Description gzgzdz的中文含义是： 地址
	 */
	public void setGzgzdz(String gzgzdz){ 
		this.gzgzdz = gzgzdz;
	}
	/**
	 * @Description gzgzdz的中文含义是： 地址
	 */
	public String getGzgzdz(){
		return gzgzdz;
	}
	/**
	 * @Description gzgzyzbm的中文含义是： 邮政编码
	 */
	public void setGzgzyzbm(String gzgzyzbm){ 
		this.gzgzyzbm = gzgzyzbm;
	}
	/**
	 * @Description gzgzyzbm的中文含义是： 邮政编码
	 */
	public String getGzgzyzbm(){
		return gzgzyzbm;
	}
	/**
	 * @Description gzgzlxdh的中文含义是： 联系电话
	 */
	public void setGzgzlxdh(String gzgzlxdh){ 
		this.gzgzlxdh = gzgzlxdh;
	}
	/**
	 * @Description gzgzlxdh的中文含义是： 联系电话
	 */
	public String getGzgzlxdh(){
		return gzgzlxdh;
	}
	/**
	 * @Description gzgzlxr的中文含义是： 联系人
	 */
	public void setGzgzlxr(String gzgzlxr){ 
		this.gzgzlxr = gzgzlxr;
	}
	/**
	 * @Description gzgzlxr的中文含义是： 联系人
	 */
	public String getGzgzlxr(){
		return gzgzlxr;
	}
	/**
	 * @Description tzgzdsr的中文含义是： 当事人
	 */
	public void setTzgzdsr(String tzgzdsr){ 
		this.tzgzdsr = tzgzdsr;
	}
	/**
	 * @Description tzgzdsr的中文含义是： 当事人
	 */
	public String getTzgzdsr(){
		return tzgzdsr;
	}
	/**
	 * @Description tzgzqsrq的中文含义是： 开始日期(汤阴)
	 */
	public void setTzgzqsrq(String tzgzqsrq){ 
		this.tzgzqsrq = tzgzqsrq;
	}
	/**
	 * @Description tzgzqsrq的中文含义是： 开始日期(汤阴)
	 */
	public String getTzgzqsrq(){
		return tzgzqsrq;
	}
	/**
	 * @Description tzgzjsrq的中文含义是： 结束日期(汤阴)
	 */
	public void setTzgzjsrq(String tzgzjsrq){ 
		this.tzgzjsrq = tzgzjsrq;
	}
	/**
	 * @Description tzgzjsrq的中文含义是： 结束日期(汤阴)
	 */
	public String getTzgzjsrq(){
		return tzgzjsrq;
	}
	/**
	 * @Description tzgzwfxwdc的中文含义是： 违法行为等次，见aaa100=WFXWDC(汤阴)
	 */
	public void setTzgzwfxwdc(String tzgzwfxwdc){ 
		this.tzgzwfxwdc = tzgzwfxwdc;
	}
	/**
	 * @Description tzgzwfxwdc的中文含义是： 违法行为等次，见aaa100=WFXWDC(汤阴)
	 */
	public String getTzgzwfxwdc(){
		return tzgzwfxwdc;
	}
	/**
	 * @Description tzgzcfyjyzgd的中文含义是： 处罚依据依照什么规定(汤阴)
	 */
	public void setTzgzcfyjyzgd(String tzgzcfyjyzgd){ 
		this.tzgzcfyjyzgd = tzgzcfyjyzgd;
	}
	/**
	 * @Description tzgzcfyjyzgd的中文含义是： 处罚依据依照什么规定(汤阴)
	 */
	public String getTzgzcfyjyzgd(){
		return tzgzcfyjyzgd;
	}
	/**
	 * @Description tzgzslasj的中文含义是： 立案时间
	 */
	public String getTzgzslasj() {
		return tzgzslasj;
	}
	/**
	 * @Description tzgzslasj的中文含义是： 立案时间
	 */
	public void setTzgzslasj(String tzgzslasj) {
		this.tzgzslasj = tzgzslasj;
	}
	/**
	 * @Description tzgzsay的中文含义是： 案由
	 */
	public String getTzgzsay() {
		return tzgzsay;
	}
	/**
	 * @Description tzgzsay的中文含义是： 案由
	 */
	public void setTzgzsay(String tzgzsay) {
		this.tzgzsay = tzgzsay;
	}
	/**
	 * @Description tzgzszmnr的中文含义是： 证据所要证明内容
	 */
	public String getTzgzszmnr() {
		return tzgzszmnr;
	}
	/**
	 * @Description tzgzszmnr的中文含义是： 证据所要证明内容
	 */
	public void setTzgzszmnr(String tzgzszmnr) {
		this.tzgzszmnr = tzgzszmnr;
	}
	/**
	 * @Description xzjgmc的中文含义是： 行政机关名称
	 */
	public String getXzjgmc() {
		return xzjgmc;
	}
	/**
	 * @Description xzjgmc的中文含义是： 行政机关名称
	 */
	public void setXzjgmc(String xzjgmc) {
		this.xzjgmc = xzjgmc;
	}
	/**
	 * @Description czxzcfclbz的中文含义是： 参照行政处罚裁量标准
	 */
	public String getCzxzcfclbz() {
		return czxzcfclbz;
	}
	/**
	 * @Description czxzcfclbz的中文含义是： 参照行政处罚裁量标准
	 */
	public void setCzxzcfclbz(String czxzcfclbz) {
		this.czxzcfclbz = czxzcfclbz;
	}

	
}