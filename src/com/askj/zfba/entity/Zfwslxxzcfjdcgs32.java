package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*; 

/**
 * @Description  ZFWSLXXZCFJDCGS32的中文含义是: 履行行政处罚决定催告书; InnoDB free: 2721792 kB
 * @Creation     2016/06/21 16:54:36
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSLXXZCFJDCGS32")
public class Zfwslxxzcfjdcgs32 {
	
	/**
	 * @Description dsrqz的中文含义是： 当事人签字
	 */
	@Column
	private String dsrqz;
	/**
	 * @Description dsrqzrq的中文含义是： 当事人签字日期
	 */
	@Column
	private String dsrqzrq;
	/**
	 * @Description qzzzrmfy的中文含义是： 强制执行人民法院aaa100=QZZZRMFY
	 */
	@Column
	private String qzzzrmfy;
	/**
	 * @Description dsrqz的中文含义是： 当事人签字
	 */
	public String getDsrqz() {
		return dsrqz;
	}
	/**
	 * @Description dsrqz的中文含义是： 当事人签字
	 */
	public void setDsrqz(String dsrqz) {
		this.dsrqz = dsrqz;
	}
	/**
	 * @Description dsrqzrq的中文含义是： 当事人签字日期
	 */
	public String getDsrqzrq() {
		return dsrqzrq;
	}
	/**
	 * @Description dsrqzrq的中文含义是： 当事人签字日期
	 */
	public void setDsrqzrq(String dsrqzrq) {
		this.dsrqzrq = dsrqzrq;
	}
	/**
	 * @Description qzzzrmfy的中文含义是： 强制执行人民法院aaa100=QZZZRMFY
	 */
	public String getQzzzrmfy() {
		return qzzzrmfy;
	}
	/**
	 * @Description qzzzrmfy的中文含义是： 强制执行人民法院aaa100=QZZZRMFY
	 */
	public void setQzzzrmfy(String qzzzrmfy) {
		this.qzzzrmfy = qzzzrmfy;
	}
	
	/**
	 * @Description xzjgmc的中文含义是： 行政机关名称
	 */
	@Column
	private String xzjgmc;

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
	 * @Description lxxzcfjdcgsid的中文含义是： 履行行政处罚决定催告书ID
	 */
	@Column
	@Name
	private String lxxzcfjdcgsid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description lxcgwsbh的中文含义是： 文书编号
	 */
	@Column
	private String lxcgwsbh;

	/**
	 * @Description lxcgjcfk的中文含义是： 加处罚款
	 */
	@Column
	private String lxcgjcfk;

	/**
	 * @Description lxcgcssbrq的中文含义是： 陈述申辩日期
	 */
	@Column
	private String lxcgcssbrq;

	/**
	 * @Description lxcggzrq的中文含义是： 盖章日期
	 */
	@Column
	private String lxcggzrq;

	/**
	 * @Description lxcgdsr的中文含义是： 当事人
	 */
	@Column
	private String lxcgdsr;

	/**
	 * @Description lxcgxzcfjdsrq的中文含义是： 行政处罚决定书日期
	 */
	@Column
	private String lxcgxzcfjdsrq;

	/**
	 * @Description lxcgxzcfjdsbh的中文含义是： 行政处罚决定书编号
	 */
	@Column
	private String lxcgxzcfjdsbh;

	/**
	 * @Description lxcgxzcfnr的中文含义是： 行政处罚内容
	 */
	@Column
	private String lxcgxzcfnr;

	/**
	 * @Description lxcgjfkjzrq的中文含义是： 缴罚款截止日
	 */
	@Column
	private String lxcgjfkjzrq;

	/**
	 * @Description fmkjkyh的中文含义是： 罚没款银行
	 */
	@Column
	private String fmkjkyh;

	/**
	 * @Description lxcgjcfksrq的中文含义是： 加处罚开始日期
	 */
	@Column
	private String lxcgjcfksrq;

	/**
	 * @Description lxcgxjfkyh的中文含义是： 现交罚款银行，默认和上面的银行一样
	 */
	@Column
	private String lxcgxjfkyh; 
	
		/**
	 * @Description lxxzcfjdcgsid的中文含义是： 履行行政处罚决定催告书ID
	 */
	public void setLxxzcfjdcgsid(String lxxzcfjdcgsid){ 
		this.lxxzcfjdcgsid = lxxzcfjdcgsid;
	}
	/**
	 * @Description lxxzcfjdcgsid的中文含义是： 履行行政处罚决定催告书ID
	 */
	public String getLxxzcfjdcgsid(){
		return lxxzcfjdcgsid;
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
	 * @Description lxcgwsbh的中文含义是： 文书编号
	 */
	public void setLxcgwsbh(String lxcgwsbh){ 
		this.lxcgwsbh = lxcgwsbh;
	}
	/**
	 * @Description lxcgwsbh的中文含义是： 文书编号
	 */
	public String getLxcgwsbh(){
		return lxcgwsbh;
	}
	/**
	 * @Description lxcgjcfk的中文含义是： 加处罚款
	 */
	public void setLxcgjcfk(String lxcgjcfk){ 
		this.lxcgjcfk = lxcgjcfk;
	}
	/**
	 * @Description lxcgjcfk的中文含义是： 加处罚款
	 */
	public String getLxcgjcfk(){
		return lxcgjcfk;
	}
	/**
	 * @Description lxcgcssbrq的中文含义是： 陈述申辩日期
	 */
	public void setLxcgcssbrq(String lxcgcssbrq){ 
		this.lxcgcssbrq = lxcgcssbrq;
	}
	/**
	 * @Description lxcgcssbrq的中文含义是： 陈述申辩日期
	 */
	public String getLxcgcssbrq(){
		return lxcgcssbrq;
	}
	/**
	 * @Description lxcggzrq的中文含义是： 盖章日期
	 */
	public void setLxcggzrq(String lxcggzrq){ 
		this.lxcggzrq = lxcggzrq;
	}
	/**
	 * @Description lxcggzrq的中文含义是： 盖章日期
	 */
	public String getLxcggzrq(){
		return lxcggzrq;
	}
	/**
	 * @Description lxcgdsr的中文含义是： 当事人
	 */
	public void setLxcgdsr(String lxcgdsr){ 
		this.lxcgdsr = lxcgdsr;
	}
	/**
	 * @Description lxcgdsr的中文含义是： 当事人
	 */
	public String getLxcgdsr(){
		return lxcgdsr;
	}
	/**
	 * @Description lxcgxzcfjdsrq的中文含义是： 行政处罚决定书日期
	 */
	public void setLxcgxzcfjdsrq(String lxcgxzcfjdsrq){ 
		this.lxcgxzcfjdsrq = lxcgxzcfjdsrq;
	}
	/**
	 * @Description lxcgxzcfjdsrq的中文含义是： 行政处罚决定书日期
	 */
	public String getLxcgxzcfjdsrq(){
		return lxcgxzcfjdsrq;
	}
	/**
	 * @Description lxcgxzcfjdsbh的中文含义是： 行政处罚决定书编号
	 */
	public void setLxcgxzcfjdsbh(String lxcgxzcfjdsbh){ 
		this.lxcgxzcfjdsbh = lxcgxzcfjdsbh;
	}
	/**
	 * @Description lxcgxzcfjdsbh的中文含义是： 行政处罚决定书编号
	 */
	public String getLxcgxzcfjdsbh(){
		return lxcgxzcfjdsbh;
	}
	/**
	 * @Description lxcgxzcfnr的中文含义是： 行政处罚内容
	 */
	public void setLxcgxzcfnr(String lxcgxzcfnr){ 
		this.lxcgxzcfnr = lxcgxzcfnr;
	}
	/**
	 * @Description lxcgxzcfnr的中文含义是： 行政处罚内容
	 */
	public String getLxcgxzcfnr(){
		return lxcgxzcfnr;
	}
	/**
	 * @Description lxcgjfkjzrq的中文含义是： 缴罚款截止日
	 */
	public void setLxcgjfkjzrq(String lxcgjfkjzrq){ 
		this.lxcgjfkjzrq = lxcgjfkjzrq;
	}
	/**
	 * @Description lxcgjfkjzrq的中文含义是： 缴罚款截止日
	 */
	public String getLxcgjfkjzrq(){
		return lxcgjfkjzrq;
	}
	/**
	 * @Description fmkjkyh的中文含义是： 罚没款银行
	 */
	public void setFmkjkyh(String fmkjkyh){ 
		this.fmkjkyh = fmkjkyh;
	}
	/**
	 * @Description fmkjkyh的中文含义是： 罚没款银行
	 */
	public String getFmkjkyh(){
		return fmkjkyh;
	}
	/**
	 * @Description lxcgjcfksrq的中文含义是： 加处罚开始日期
	 */
	public void setLxcgjcfksrq(String lxcgjcfksrq){ 
		this.lxcgjcfksrq = lxcgjcfksrq;
	}
	/**
	 * @Description lxcgjcfksrq的中文含义是： 加处罚开始日期
	 */
	public String getLxcgjcfksrq(){
		return lxcgjcfksrq;
	}
	/**
	 * @Description lxcgxjfkyh的中文含义是： 现交罚款银行，默认和上面的银行一样
	 */
	public void setLxcgxjfkyh(String lxcgxjfkyh){ 
		this.lxcgxjfkyh = lxcgxjfkyh;
	}
	/**
	 * @Description lxcgxjfkyh的中文含义是： 现交罚款银行，默认和上面的银行一样
	 */
	public String getLxcgxjfkyh(){
		return lxcgxjfkyh;
	}  
}