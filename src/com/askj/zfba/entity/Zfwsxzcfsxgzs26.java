package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  ZFWSXZCFSXGZS26的中文含义是: 行政处罚事先告知书26; InnoDB free: 2726912 kB
 * @Creation     2016/06/12 10:14:33
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSXZCFSXGZS26")
public class Zfwsxzcfsxgzs26 {
	/**
	 * @Description xzcfsxgzsid的中文含义是： 行政处罚事先告知书ID
	 */
	@Column
	@Name
	private String xzcfsxgzsid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description sxgzwsbh的中文含义是： 事先告知文书编号
	 */
	@Column
	private String sxgzwsbh;

	/**
	 * @Description sxgzwfxw的中文含义是： 违法行为
	 */
	@Column
	private String sxgzwfxw;

	/**
	 * @Description sxgzwfgd的中文含义是： 依据规定
	 */
	@Column
	private String sxgzwfgd;

	/**
	 * @Description sxgzxzcf的中文含义是： 行政处罚1
	 */
	@Column
	private String sxgzxzcf;

	/**
	 * @Description sxgzcxdd的中文含义是： 陈述地点
	 */
	@Column
	private String sxgzcxdd;

	/**
	 * @Description sxgzgzrq的中文含义是： 盖章日期
	 */
	@Column
	private String sxgzgzrq;

	/**
	 * @Description sxgzyjgd的中文含义是： 依据规定
	 */
	@Column
	private String sxgzyjgd;

	/**
	 * @Description sxgzdsr的中文含义是： 当事人
	 */
	@Column
	private String sxgzdsr;

	/**
	 * @Description wfxwdc的中文含义是： 违法行为等次见aaa100='WFXWDC'
	 */
	@Column
	private String wfxwdc;

	/**
	 * @Description sxgzlasj的中文含义是： 立案时间
	 */
	@Column
	private String sxgzlasj;
	/**
	 * @Description sxgzay的中文含义是： 案由
	 */
	@Column
	private String sxgzay;
	/**
	 * @Description sxgzzmnr的中文含义是： 证据所要证明内容
	 */
	@Column
	private String sxgzzmnr;
	/**
	 * @Description sxgzxzcfclbz的中文含义是： 行政处罚才俩裁量标准
	 */
	@Column
	private String sxgzxzcfclbz;
	/**
	 * @Description sxgzxzjgdz的中文含义是： 行政机关地址
	 */
	@Column
	private String sxgzxzjgdz;
	/**
	 * @Description sxgzyzbm的中文含义是： 邮政编码
	 */
	@Column
	private String sxgzyzbm;
	/**
	 * @Description sxgzxzjglxr的中文含义是： 行政机关联系人
	 */
	@Column
	private String sxgzxzjglxr;
	/**
	 * @Description sxgzlxdh的中文含义是：联系电话
	 */
	@Column
	private String sxgzlxdh;
	
	/**
	 * @Description xzjgmc的中文含义是：行政机关名称
	 */
	@Column
	private String xzjgmc;
	
	/**
	 * @Description sxgzlasj的中文含义是： 立案时间
	 */
	public String getSxgzlasj() {
		return sxgzlasj;
	}
	/**
	 * @Description sxgzlasj的中文含义是： 立案时间
	 */
	public void setSxgzlasj(String sxgzlasj) {
		this.sxgzlasj = sxgzlasj;
	}
	/**
	 * @Description sxgzay的中文含义是： 案由
	 */
	public String getSxgzay() {
		return sxgzay;
	}
	/**
	 * @Description sxgzay的中文含义是： 案由
	 */
	public void setSxgzay(String sxgzay) {
		this.sxgzay = sxgzay;
	}
	/**
	 * @Description sxgzzmnr的中文含义是： 证据所要证明内容
	 */
	public String getSxgzzmnr() {
		return sxgzzmnr;
	}
	/**
	 * @Description sxgzzmnr的中文含义是： 证据所要证明内容
	 */
	public void setSxgzzmnr(String sxgzzmnr) {
		this.sxgzzmnr = sxgzzmnr;
	}
	/**
	 * @Description sxgzxzcfclbz的中文含义是： 行政处罚才俩裁量标准
	 */
	public String getSxgzxzcfclbz() {
		return sxgzxzcfclbz;
	}
	/**
	 * @Description sxgzxzcfclbz的中文含义是： 行政处罚才俩裁量标准
	 */
	public void setSxgzxzcfclbz(String sxgzxzcfclbz) {
		this.sxgzxzcfclbz = sxgzxzcfclbz;
	}
	/**
	 * @Description sxgzxzjgdz的中文含义是： 行政机关地址
	 */
	public String getSxgzxzjgdz() {
		return sxgzxzjgdz;
	}
	/**
	 * @Description sxgzxzjgdz的中文含义是： 行政机关地址
	 */
	public void setSxgzxzjgdz(String sxgzxzjgdz) {
		this.sxgzxzjgdz = sxgzxzjgdz;
	}
	/**
	 * @Description sxgzyzbm的中文含义是： 邮政编码
	 */
	public String getSxgzyzbm() {
		return sxgzyzbm;
	}
	/**
	 * @Description sxgzyzbm的中文含义是： 邮政编码
	 */
	public void setSxgzyzbm(String sxgzyzbm) {
		this.sxgzyzbm = sxgzyzbm;
	}
	/**
	 * @Description sxgzxzjglxr的中文含义是： 行政机关联系人
	 */
	public String getSxgzxzjglxr() {
		return sxgzxzjglxr;
	}
	/**
	 * @Description sxgzxzjglxr的中文含义是： 行政机关联系人
	 */
	public void setSxgzxzjglxr(String sxgzxzjglxr) {
		this.sxgzxzjglxr = sxgzxzjglxr;
	}
	/**
	 * @Description sxgzlxdh的中文含义是：联系电话
	 */
	public String getSxgzlxdh() {
		return sxgzlxdh;
	}
	/**
	 * @Description sxgzlxdh的中文含义是：联系电话
	 */
	public void setSxgzlxdh(String sxgzlxdh) {
		this.sxgzlxdh = sxgzlxdh;
	}
	/**
	 * @Description xzcfsxgzsid的中文含义是： 行政处罚事先告知书ID
	 */
	public void setXzcfsxgzsid(String xzcfsxgzsid){ 
		this.xzcfsxgzsid = xzcfsxgzsid;
	}
	/**
	 * @Description xzcfsxgzsid的中文含义是： 行政处罚事先告知书ID
	 */
	public String getXzcfsxgzsid(){
		return xzcfsxgzsid;
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
	 * @Description sxgzwsbh的中文含义是： 事先告知文书编号
	 */
	public void setSxgzwsbh(String sxgzwsbh){ 
		this.sxgzwsbh = sxgzwsbh;
	}
	/**
	 * @Description sxgzwsbh的中文含义是： 事先告知文书编号
	 */
	public String getSxgzwsbh(){
		return sxgzwsbh;
	}
	/**
	 * @Description sxgzwfxw的中文含义是： 违法行为
	 */
	public void setSxgzwfxw(String sxgzwfxw){ 
		this.sxgzwfxw = sxgzwfxw;
	}
	/**
	 * @Description sxgzwfxw的中文含义是： 违法行为
	 */
	public String getSxgzwfxw(){
		return sxgzwfxw;
	}
	/**
	 * @Description sxgzwfgd的中文含义是： 依据规定
	 */
	public void setSxgzwfgd(String sxgzwfgd){ 
		this.sxgzwfgd = sxgzwfgd;
	}
	/**
	 * @Description sxgzwfgd的中文含义是： 依据规定
	 */
	public String getSxgzwfgd(){
		return sxgzwfgd;
	}
	/**
	 * @Description sxgzxzcf的中文含义是： 行政处罚1
	 */
	public void setSxgzxzcf(String sxgzxzcf){ 
		this.sxgzxzcf = sxgzxzcf;
	}
	/**
	 * @Description sxgzxzcf的中文含义是： 行政处罚1
	 */
	public String getSxgzxzcf(){
		return sxgzxzcf;
	}
	/**
	 * @Description sxgzcxdd的中文含义是： 陈述地点
	 */
	public void setSxgzcxdd(String sxgzcxdd){ 
		this.sxgzcxdd = sxgzcxdd;
	}
	/**
	 * @Description sxgzcxdd的中文含义是： 陈述地点
	 */
	public String getSxgzcxdd(){
		return sxgzcxdd;
	}
	/**
	 * @Description sxgzgzrq的中文含义是： 盖章日期
	 */
	public void setSxgzgzrq(String sxgzgzrq){ 
		this.sxgzgzrq = sxgzgzrq;
	}
	/**
	 * @Description sxgzgzrq的中文含义是： 盖章日期
	 */
	public String getSxgzgzrq(){
		return sxgzgzrq;
	}
	/**
	 * @Description sxgzyjgd的中文含义是： 依据规定
	 */
	public void setSxgzyjgd(String sxgzyjgd){ 
		this.sxgzyjgd = sxgzyjgd;
	}
	/**
	 * @Description sxgzyjgd的中文含义是： 依据规定
	 */
	public String getSxgzyjgd(){
		return sxgzyjgd;
	}
	/**
	 * @Description sxgzdsr的中文含义是： 当事人
	 */
	public void setSxgzdsr(String sxgzdsr){ 
		this.sxgzdsr = sxgzdsr;
	}
	/**
	 * @Description sxgzdsr的中文含义是： 当事人
	 */
	public String getSxgzdsr(){
		return sxgzdsr;
	}
	/**
	 * @Description wfxwdc的中文含义是： 违法行为等次见aaa100='WFXWDC'
	 */
	public void setWfxwdc(String wfxwdc){ 
		this.wfxwdc = wfxwdc;
	}
	/**
	 * @Description wfxwdc的中文含义是： 违法行为等次见aaa100='WFXWDC'
	 */
	public String getWfxwdc(){
		return wfxwdc;
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