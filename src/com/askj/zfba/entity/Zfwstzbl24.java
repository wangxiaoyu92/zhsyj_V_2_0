package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  ZFWSTZBL24的中文含义是: 听证笔录24; InnoDB free: 2726912 kB
 * @Creation     2016/06/12 15:20:43
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSTZBL24")
public class Zfwstzbl24 {
	/**
	 * @Description tzblid的中文含义是： 听证笔录ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_tzblid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_tzblid.nextval from dual"))
	private String tzblid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description tzblfddbrxb的中文含义是： 法定代表人性别
	 */
	@Column
	private String tzblfddbrxb;

	/**
	 * @Description tzblfddbrnl的中文含义是： 法定代表人年龄
	 */
	@Column
	private Integer tzblfddbrnl;

	/**
	 * @Description tzblfddbrlxfs的中文含义是： 法定代表人联系方式
	 */
	@Column
	private String tzblfddbrlxfs;

	/**
	 * @Description tzbldz的中文含义是： 地址
	 */
	@Column
	private String tzbldz;

	/**
	 * @Description tzblwtdlr的中文含义是： 委托代理人
	 */
	@Column
	private String tzblwtdlr;

	/**
	 * @Description tzblwtdlrxb的中文含义是： 委托代理人性别
	 */
	@Column
	private String tzblwtdlrxb;

	/**
	 * @Description tzblwtdlrnl的中文含义是： 委托代理人年龄
	 */
	@Column
	private Integer tzblwtdlrnl;

	/**
	 * @Description tzblwtdlrzw的中文含义是： 委托代理人职务
	 */
	@Column
	private String tzblwtdlrzw;

	/**
	 * @Description tzblwtdlrlxfs的中文含义是： 委托代理人联系方式
	 */
	@Column
	private String tzblwtdlrlxfs;

	/**
	 * @Description tzblwtdlrgzdw的中文含义是： 工作单位
	 */
	@Column
	private String tzblwtdlrgzdw;

	/**
	 * @Description tzblwtdlrdz的中文含义是： 地址
	 */
	@Column
	private String tzblwtdlrdz;

	/**
	 * @Description tzblajcbr1的中文含义是： 案件承办人1
	 */
	@Column
	private String tzblajcbr1;

	/**
	 * @Description tzblajcbr1bm的中文含义是： 案件承办人1部门
	 */
	@Column
	private String tzblajcbr1bm;

	/**
	 * @Description tzblajcbr1zw的中文含义是： 案件承办人1职务
	 */
	@Column
	private String tzblajcbr1zw;

	/**
	 * @Description tzblajcbr2的中文含义是： 案件承办人2
	 */
	@Column
	private String tzblajcbr2;

	/**
	 * @Description tzblajcbr2bm的中文含义是： 案件承办人2部门
	 */
	@Column
	private String tzblajcbr2bm;

	/**
	 * @Description tzblajcbr2zw的中文含义是： 案件承办人2职务
	 */
	@Column
	private String tzblajcbr2zw;

	/**
	 * @Description tzbltzzcr的中文含义是： 听证主持人
	 */
	@Column
	private String tzbltzzcr;

	/**
	 * @Description tzbljlr的中文含义是： 记录人
	 */
	@Column
	private String tzbljlr;

	/**
	 * @Description tzbltzkssj的中文含义是： 听证开始时间
	 */
	@Column
	private String tzbltzkssj;

	/**
	 * @Description tzbltzjssj的中文含义是： 听证结束时间
	 */
	@Column
	private String tzbltzjssj;

	/**
	 * @Description tzbltzfs的中文含义是： 听证方式
	 */
	@Column
	private String tzbltzfs;

	/**
	 * @Description tzbljl的中文含义是： 记录
	 */
	@Column
	private String tzbljl;

	/**
	 * @Description tzbldsrqz的中文含义是： 当事人或委托代理人签字
	 */
	@Column
	private String tzbldsrqz;

	/**
	 * @Description tzbldsrqzrq的中文含义是： 当事人或委托代理人签字日期
	 */
	@Column
	private String tzbldsrqzrq;

	/**
	 * @Description tzblajcbrqz的中文含义是： 案件承办人1签字
	 */
	@Column
	private String tzblajcbrqz;

	/**
	 * @Description tzblajcbrrq的中文含义是： 案件承办人签字日期
	 */
	@Column
	private String tzblajcbrrq;

	/**
	 * @Description tzbltzzcrqz的中文含义是： 听证主持人签字
	 */
	@Column
	private String tzbltzzcrqz;

	/**
	 * @Description tzbltzzcrqzrq的中文含义是： 听证主持人签字日期
	 */
	@Column
	private String tzbltzzcrqzrq;

	/**
	 * @Description ajdjay的中文含义是： 案由
	 */
	@Column
	private String ajdjay;

	/**
	 * @Description tzbldsr的中文含义是： 当事人
	 */
	@Column
	private String tzbldsr;

	/**
	 * @Description tzblajcbr2qz的中文含义是： 案件承办人2签字
	 */
	@Column
	private String tzblajcbr2qz;

	/**
	 * @Description tzblfddbr的中文含义是： 法定代表人（负责人）
	 */
	@Column
	private String tzblfddbr;

	/**
	 * @Description tzbljlrqz的中文含义是： 记录人签字
	 */
	@Column
	private String tzbljlrqz;

	/**
	 * @Description tzbljlrqzrq的中文含义是： 记录人签字日期
	 */
	@Column
	private String tzbljlrqzrq;
	
	/**
	 * @Description tzblid的中文含义是： 听证笔录ID
	 */
	public void setTzblid(String tzblid){ 
		this.tzblid = tzblid;
	}
	/**
	 * @Description tzblid的中文含义是： 听证笔录ID
	 */
	public String getTzblid(){
		return tzblid;
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
	 * @Description tzblfddbrxb的中文含义是： 法定代表人性别
	 */
	public void setTzblfddbrxb(String tzblfddbrxb){ 
		this.tzblfddbrxb = tzblfddbrxb;
	}
	/**
	 * @Description tzblfddbrxb的中文含义是： 法定代表人性别
	 */
	public String getTzblfddbrxb(){
		return tzblfddbrxb;
	}
	/**
	 * @Description tzblfddbrnl的中文含义是： 法定代表人年龄
	 */
	public void setTzblfddbrnl(Integer tzblfddbrnl){ 
		this.tzblfddbrnl = tzblfddbrnl;
	}
	/**
	 * @Description tzblfddbrnl的中文含义是： 法定代表人年龄
	 */
	public Integer getTzblfddbrnl(){
		return tzblfddbrnl;
	}
	/**
	 * @Description tzblfddbrlxfs的中文含义是： 法定代表人联系方式
	 */
	public void setTzblfddbrlxfs(String tzblfddbrlxfs){ 
		this.tzblfddbrlxfs = tzblfddbrlxfs;
	}
	/**
	 * @Description tzblfddbrlxfs的中文含义是： 法定代表人联系方式
	 */
	public String getTzblfddbrlxfs(){
		return tzblfddbrlxfs;
	}
	/**
	 * @Description tzbldz的中文含义是： 地址
	 */
	public void setTzbldz(String tzbldz){ 
		this.tzbldz = tzbldz;
	}
	/**
	 * @Description tzbldz的中文含义是： 地址
	 */
	public String getTzbldz(){
		return tzbldz;
	}
	/**
	 * @Description tzblwtdlr的中文含义是： 委托代理人
	 */
	public void setTzblwtdlr(String tzblwtdlr){ 
		this.tzblwtdlr = tzblwtdlr;
	}
	/**
	 * @Description tzblwtdlr的中文含义是： 委托代理人
	 */
	public String getTzblwtdlr(){
		return tzblwtdlr;
	}
	/**
	 * @Description tzblwtdlrxb的中文含义是： 委托代理人性别
	 */
	public void setTzblwtdlrxb(String tzblwtdlrxb){ 
		this.tzblwtdlrxb = tzblwtdlrxb;
	}
	/**
	 * @Description tzblwtdlrxb的中文含义是： 委托代理人性别
	 */
	public String getTzblwtdlrxb(){
		return tzblwtdlrxb;
	}
	/**
	 * @Description tzblwtdlrnl的中文含义是： 委托代理人年龄
	 */
	public void setTzblwtdlrnl(Integer tzblwtdlrnl){ 
		this.tzblwtdlrnl = tzblwtdlrnl;
	}
	/**
	 * @Description tzblwtdlrnl的中文含义是： 委托代理人年龄
	 */
	public Integer getTzblwtdlrnl(){
		return tzblwtdlrnl;
	}
	/**
	 * @Description tzblwtdlrzw的中文含义是： 委托代理人职务
	 */
	public void setTzblwtdlrzw(String tzblwtdlrzw){ 
		this.tzblwtdlrzw = tzblwtdlrzw;
	}
	/**
	 * @Description tzblwtdlrzw的中文含义是： 委托代理人职务
	 */
	public String getTzblwtdlrzw(){
		return tzblwtdlrzw;
	}
	/**
	 * @Description tzblwtdlrlxfs的中文含义是： 委托代理人联系方式
	 */
	public void setTzblwtdlrlxfs(String tzblwtdlrlxfs){ 
		this.tzblwtdlrlxfs = tzblwtdlrlxfs;
	}
	/**
	 * @Description tzblwtdlrlxfs的中文含义是： 委托代理人联系方式
	 */
	public String getTzblwtdlrlxfs(){
		return tzblwtdlrlxfs;
	}
	/**
	 * @Description tzblwtdlrgzdw的中文含义是： 工作单位
	 */
	public void setTzblwtdlrgzdw(String tzblwtdlrgzdw){ 
		this.tzblwtdlrgzdw = tzblwtdlrgzdw;
	}
	/**
	 * @Description tzblwtdlrgzdw的中文含义是： 工作单位
	 */
	public String getTzblwtdlrgzdw(){
		return tzblwtdlrgzdw;
	}
	/**
	 * @Description tzblwtdlrdz的中文含义是： 地址
	 */
	public void setTzblwtdlrdz(String tzblwtdlrdz){ 
		this.tzblwtdlrdz = tzblwtdlrdz;
	}
	/**
	 * @Description tzblwtdlrdz的中文含义是： 地址
	 */
	public String getTzblwtdlrdz(){
		return tzblwtdlrdz;
	}
	/**
	 * @Description tzblajcbr1的中文含义是： 案件承办人1
	 */
	public void setTzblajcbr1(String tzblajcbr1){ 
		this.tzblajcbr1 = tzblajcbr1;
	}
	/**
	 * @Description tzblajcbr1的中文含义是： 案件承办人1
	 */
	public String getTzblajcbr1(){
		return tzblajcbr1;
	}
	/**
	 * @Description tzblajcbr1bm的中文含义是： 案件承办人1部门
	 */
	public void setTzblajcbr1bm(String tzblajcbr1bm){ 
		this.tzblajcbr1bm = tzblajcbr1bm;
	}
	/**
	 * @Description tzblajcbr1bm的中文含义是： 案件承办人1部门
	 */
	public String getTzblajcbr1bm(){
		return tzblajcbr1bm;
	}
	/**
	 * @Description tzblajcbr1zw的中文含义是： 案件承办人1职务
	 */
	public void setTzblajcbr1zw(String tzblajcbr1zw){ 
		this.tzblajcbr1zw = tzblajcbr1zw;
	}
	/**
	 * @Description tzblajcbr1zw的中文含义是： 案件承办人1职务
	 */
	public String getTzblajcbr1zw(){
		return tzblajcbr1zw;
	}
	/**
	 * @Description tzblajcbr2的中文含义是： 案件承办人2
	 */
	public void setTzblajcbr2(String tzblajcbr2){ 
		this.tzblajcbr2 = tzblajcbr2;
	}
	/**
	 * @Description tzblajcbr2的中文含义是： 案件承办人2
	 */
	public String getTzblajcbr2(){
		return tzblajcbr2;
	}
	/**
	 * @Description tzblajcbr2bm的中文含义是： 案件承办人2部门
	 */
	public void setTzblajcbr2bm(String tzblajcbr2bm){ 
		this.tzblajcbr2bm = tzblajcbr2bm;
	}
	/**
	 * @Description tzblajcbr2bm的中文含义是： 案件承办人2部门
	 */
	public String getTzblajcbr2bm(){
		return tzblajcbr2bm;
	}
	/**
	 * @Description tzblajcbr2zw的中文含义是： 案件承办人2职务
	 */
	public void setTzblajcbr2zw(String tzblajcbr2zw){ 
		this.tzblajcbr2zw = tzblajcbr2zw;
	}
	/**
	 * @Description tzblajcbr2zw的中文含义是： 案件承办人2职务
	 */
	public String getTzblajcbr2zw(){
		return tzblajcbr2zw;
	}
	/**
	 * @Description tzbltzzcr的中文含义是： 听证主持人
	 */
	public void setTzbltzzcr(String tzbltzzcr){ 
		this.tzbltzzcr = tzbltzzcr;
	}
	/**
	 * @Description tzbltzzcr的中文含义是： 听证主持人
	 */
	public String getTzbltzzcr(){
		return tzbltzzcr;
	}
	/**
	 * @Description tzbljlr的中文含义是： 记录人
	 */
	public void setTzbljlr(String tzbljlr){ 
		this.tzbljlr = tzbljlr;
	}
	/**
	 * @Description tzbljlr的中文含义是： 记录人
	 */
	public String getTzbljlr(){
		return tzbljlr;
	}
	/**
	 * @Description tzbltzkssj的中文含义是： 听证开始时间
	 */
	public void setTzbltzkssj(String tzbltzkssj){ 
		this.tzbltzkssj = tzbltzkssj;
	}
	/**
	 * @Description tzbltzkssj的中文含义是： 听证开始时间
	 */
	public String getTzbltzkssj(){
		return tzbltzkssj;
	}
	/**
	 * @Description tzbltzjssj的中文含义是： 听证结束时间
	 */
	public void setTzbltzjssj(String tzbltzjssj){ 
		this.tzbltzjssj = tzbltzjssj;
	}
	/**
	 * @Description tzbltzjssj的中文含义是： 听证结束时间
	 */
	public String getTzbltzjssj(){
		return tzbltzjssj;
	}
	/**
	 * @Description tzbltzfs的中文含义是： 听证方式
	 */
	public void setTzbltzfs(String tzbltzfs){ 
		this.tzbltzfs = tzbltzfs;
	}
	/**
	 * @Description tzbltzfs的中文含义是： 听证方式
	 */
	public String getTzbltzfs(){
		return tzbltzfs;
	}
	/**
	 * @Description tzbljl的中文含义是： 记录
	 */
	public void setTzbljl(String tzbljl){ 
		this.tzbljl = tzbljl;
	}
	/**
	 * @Description tzbljl的中文含义是： 记录
	 */
	public String getTzbljl(){
		return tzbljl;
	}
	/**
	 * @Description tzbldsrqz的中文含义是： 当事人或委托代理人签字
	 */
	public void setTzbldsrqz(String tzbldsrqz){ 
		this.tzbldsrqz = tzbldsrqz;
	}
	/**
	 * @Description tzbldsrqz的中文含义是： 当事人或委托代理人签字
	 */
	public String getTzbldsrqz(){
		return tzbldsrqz;
	}
	/**
	 * @Description tzbldsrqzrq的中文含义是： 当事人或委托代理人签字日期
	 */
	public void setTzbldsrqzrq(String tzbldsrqzrq){ 
		this.tzbldsrqzrq = tzbldsrqzrq;
	}
	/**
	 * @Description tzbldsrqzrq的中文含义是： 当事人或委托代理人签字日期
	 */
	public String getTzbldsrqzrq(){
		return tzbldsrqzrq;
	}
	/**
	 * @Description tzblajcbrqz的中文含义是： 案件承办人1签字
	 */
	public void setTzblajcbrqz(String tzblajcbrqz){ 
		this.tzblajcbrqz = tzblajcbrqz;
	}
	/**
	 * @Description tzblajcbrqz的中文含义是： 案件承办人1签字
	 */
	public String getTzblajcbrqz(){
		return tzblajcbrqz;
	}
	/**
	 * @Description tzblajcbrrq的中文含义是： 案件承办人签字日期
	 */
	public void setTzblajcbrrq(String tzblajcbrrq){ 
		this.tzblajcbrrq = tzblajcbrrq;
	}
	/**
	 * @Description tzblajcbrrq的中文含义是： 案件承办人签字日期
	 */
	public String getTzblajcbrrq(){
		return tzblajcbrrq;
	}
	/**
	 * @Description tzbltzzcrqz的中文含义是： 听证主持人签字
	 */
	public void setTzbltzzcrqz(String tzbltzzcrqz){ 
		this.tzbltzzcrqz = tzbltzzcrqz;
	}
	/**
	 * @Description tzbltzzcrqz的中文含义是： 听证主持人签字
	 */
	public String getTzbltzzcrqz(){
		return tzbltzzcrqz;
	}
	/**
	 * @Description tzbltzzcrqzrq的中文含义是： 听证主持人签字日期
	 */
	public void setTzbltzzcrqzrq(String tzbltzzcrqzrq){ 
		this.tzbltzzcrqzrq = tzbltzzcrqzrq;
	}
	/**
	 * @Description tzbltzzcrqzrq的中文含义是： 听证主持人签字日期
	 */
	public String getTzbltzzcrqzrq(){
		return tzbltzzcrqzrq;
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
	 * @Description tzbldsr的中文含义是： 当事人
	 */
	public void setTzbldsr(String tzbldsr){ 
		this.tzbldsr = tzbldsr;
	}
	/**
	 * @Description tzbldsr的中文含义是： 当事人
	 */
	public String getTzbldsr(){
		return tzbldsr;
	}
	/**
	 * @Description tzblajcbr2qz的中文含义是： 案件承办人2签字
	 */
	public void setTzblajcbr2qz(String tzblajcbr2qz){ 
		this.tzblajcbr2qz = tzblajcbr2qz;
	}
	/**
	 * @Description tzblajcbr2qz的中文含义是： 案件承办人2签字
	 */
	public String getTzblajcbr2qz(){
		return tzblajcbr2qz;
	}
	/**
	 * @Description tzblfddbr的中文含义是： 法定代表人（负责人）
	 */
	public void setTzblfddbr(String tzblfddbr){ 
		this.tzblfddbr = tzblfddbr;
	}
	/**
	 * @Description tzblfddbr的中文含义是： 法定代表人（负责人）
	 */
	public String getTzblfddbr(){
		return tzblfddbr;
	}
	/**
	 * @Description tzbljlrqz的中文含义是： 记录人签字
	 */
	public String getTzbljlrqz() {
		return tzbljlrqz;
	}
	/**
	 * @Description tzbljlrqz的中文含义是： 记录人签字
	 */
	public void setTzbljlrqz(String tzbljlrqz) {
		this.tzbljlrqz = tzbljlrqz;
	}
	/**
	 * @Description tzbljlrqzrq的中文含义是： 记录人签字日期
	 */
	public String getTzbljlrqzrq() {
		return tzbljlrqzrq;
	}
	/**
	 * @Description tzbljlrqzrq的中文含义是： 记录人签字日期
	 */
	public void setTzbljlrqzrq(String tzbljlrqzrq) {
		this.tzbljlrqzrq = tzbljlrqzrq;
	}

	
}