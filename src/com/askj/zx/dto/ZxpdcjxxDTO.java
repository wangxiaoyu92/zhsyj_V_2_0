package com.askj.zx.dto;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  ZXPDCJXX的中文含义是: 征信采集信息表; InnoDB free: 11264 kB
 * @Creation     2016/02/19 15:50:54
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZXPDCJXX")
public class ZxpdcjxxDTO {
	/**
	 * @Description cjid的中文含义是： 
	 */
	private String cjid;
	/**
	 * @Description comid的中文含义是： 企业表主键
	 */
	private String comid;
	/**
	 * @Description xmcsdm的中文含义是： 评定项目表项目代码
	 */
	private String xmcsdm;

	/**
	 * @Description cjdf的中文含义是： 得分
	 */

	private Integer cjdf;

	/**
	 * @Description czyxm的中文含义是： 操作员姓名
	 */

	private String czyxm;

	/**
	 * @Description czsj的中文含义是： 操作时间
	 */
	private String czsj;
	/**
	 * @Description beizhu的中文含义是： 备注
	 */
	private String beizhu;
	/**
	 * @Description niandu的中文含义是： 年度
	 */
	private String niandu;
	/**
	 * @Description sjly的中文含义是： 0系统产生1手工产生
	 */
	private String sjly;
	/**
	 * @Description commc的中文含义是 
	 */
	private String commc;
	private String xmcsmc ;
	private String xmcsbm;
	private Integer xmcsfz;
	private String xmcsid;  
	private String xmcszxt;

	public String getXmcszxt() {
		return xmcszxt;
	}
	public void setXmcszxt(String xmcszxt) {
		this.xmcszxt = xmcszxt;
	}
	public String getSystemcode() {
		return systemcode;
	}
	public void setSystemcode(String systemcode) {
		this.systemcode = systemcode;
	}
	/**
	 * @Description systemcode的中文含义是： 对应子系统,aa10中aaa100=SYSTEMCODE
	 */
	@Column
	private String systemcode;
	/**
	 * @Description xmcsksrq的中文含义是： 开始日期yyyymmdd
	 */
	@Column
	private String xmcsksrq;

	/**
	 * @Description xmcsjsrq的中文含义是： 结束日期yyyymmdd
	 */
	@Column
	private String xmcsjsrq;
	/**
	 * @Description cssyzt的中文含义是： 参数使用状态 0表示不禁用 1表示使用
	 */
	@Column
	private String cssyzt;
 
	
		public String getCssyzt() {
		return cssyzt;
	}
	public void setCssyzt(String cssyzt) {
		this.cssyzt = cssyzt;
	}
		public String getXmcsid() {
		return xmcsid;
	}
	public void setXmcsid(String xmcsid) {
		this.xmcsid = xmcsid;
	}
	public String getXmcsksrq() {
		return xmcsksrq;
	}
	public void setXmcsksrq(String xmcsksrq) {
		this.xmcsksrq = xmcsksrq;
	}
	public String getXmcsjsrq() {
		return xmcsjsrq;
	}
	public void setXmcsjsrq(String xmcsjsrq) {
		this.xmcsjsrq = xmcsjsrq;
	}
		public Integer getXmcsfz() {
		return xmcsfz;
	}
	public void setXmcsfz(Integer xmcsfz) {
		this.xmcsfz = xmcsfz;
	}
		public String getXmcsmc() {
		return xmcsmc;
	}
	public void setXmcsmc(String xmcsmc) {
		this.xmcsmc = xmcsmc;
	}
	public String getXmcsbm() {
		return xmcsbm;
	}
	public void setXmcsbm(String xmcsbm) {
		this.xmcsbm = xmcsbm;
	}
		public String getCommc() {
		return commc;
	}
	public void setCommc(String commc) {
		this.commc = commc;
	}
		/**
	 * @Description cjid的中文含义是： 
	 */
	public void setCjid(String cjid){ 
		this.cjid = cjid;
	}
	/**
	 * @Description cjid的中文含义是： 
	 */
	public String getCjid(){
		return cjid;
	}
	/**
	 * @Description xmcsdm的中文含义是： 评定项目表项目代码
	 */
	public void setXmcsdm(String xmcsdm){ 
		this.xmcsdm = xmcsdm;
	}
	/**
	 * @Description xmcsdm的中文含义是： 评定项目表项目代码
	 */
	public String getXmcsdm(){
		return xmcsdm;
	}
	/**
	 * @Description cjdf的中文含义是： 得分
	 */
	public void setCjdf(Integer cjdf){ 
		this.cjdf = cjdf;
	}
	/**
	 * @Description cjdf的中文含义是： 得分
	 */
	public Integer getCjdf(){
		return cjdf;
	}
	/**
	 * @Description czyxm的中文含义是： 操作员姓名
	 */
	public void setCzyxm(String czyxm){ 
		this.czyxm = czyxm;
	}
	/**
	 * @Description czyxm的中文含义是： 操作员姓名
	 */
	public String getCzyxm(){
		return czyxm;
	}
	/**
	 * @Description czsj的中文含义是： 操作时间
	 */
	public void setCzsj(String czsj){ 
		this.czsj = czsj;
	}
	/**
	 * @Description czsj的中文含义是： 操作时间
	 */
	public String getCzsj(){
		return czsj;
	}
	/**
	 * @Description beizhu的中文含义是： 备注
	 */
	public void setBeizhu(String beizhu){ 
		this.beizhu = beizhu;
	}
	/**
	 * @Description beizhu的中文含义是： 备注
	 */
	public String getBeizhu(){
		return beizhu;
	}
	/**
	 * @Description niandu的中文含义是： 年度
	 */
	public void setNiandu(String niandu){ 
		this.niandu = niandu;
	}
	/**
	 * @Description niandu的中文含义是： 年度
	 */
	public String getNiandu(){
		return niandu;
	}
	/**
	 * @Description sjly的中文含义是： 0系统产生1手工产生
	 */
	public void setSjly(String sjly){ 
		this.sjly = sjly;
	}
	/**
	 * @Description sjly的中文含义是： 0系统产生1手工产生
	 */
	public String getSjly(){
		return sjly;
	}
	public String getComid() {
		return comid;
	}
	public void setComid(String comid) {
		this.comid = comid;
	}

	
}