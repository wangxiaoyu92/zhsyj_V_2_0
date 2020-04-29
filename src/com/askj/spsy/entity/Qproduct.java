package com.askj.spsy.entity;

import java.math.BigDecimal;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

/**
 * @Description  QPRODUCT的中文含义是: 商品表; InnoDB free: 2724864 kB
 * @Creation     2016/06/29 10:43:36
 * @Written      Create Tool By zjf 
 **/
@Table(value = "QPRODUCT")
public class Qproduct {
	
	/**
	 * @Description proid的中文含义是： 商品ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_proid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_proid.nextval from dual"))
	private String proid;
	/**
	 * @Description procjdh的中文含义是： 厂家电话
	 */ 
	@Column
	private String procjdh;		
	
	/**
	 * @Description procjdh的中文含义是： 厂家电话
	 */ 
	@Column
	private String procjdz;	

	/**
	 * @Description procomid的中文含义是： 商品所属公司ID
	 */
	@Column
	private String procomid;

	/**
	 * @Description proname的中文含义是： 商品名称
	 */
	@Column
	private String proname;

	/**
	 * @Description prosb的中文含义是： 商标
	 */
	@Column
	private String prosb;

	/**
	 * @Description prosptm的中文含义是： 商品条码
	 */
	@Column
	private String prosptm;

	/**
	 * @Description progg的中文含义是： 规格型号
	 */
	@Column
	private String progg;

	/**
	 * @Description prosccj的中文含义是： 生产厂家
	 */
	@Column
	private String prosccj;

	/**
	 * @Description propm的中文含义是： 品名
	 */
	@Column
	private String propm;

	/**
	 * @Description probzq的中文含义是： 保质期
	 */
	@Column
	private String probzq;

	/**
	 * @Description procdjd的中文含义是： 产地/基地名称
	 */
	@Column
	private String procdjd;

	/**
	 * @Description proplxx的中文含义是： 配料信息
	 */
	@Column
	private String proplxx;

	/**
	 * @Description procpbzh的中文含义是： 产品标准号
	 */
	@Column
	private String procpbzh;

	/**
	 * @Description prozl的中文含义是： 产品种类 1一般产品  2养殖业有耳标脚环类产品aaa100=PROZL
	 */
	@Column
	private String prozl;

	/**
	 * @Description progtin14的中文含义是： 产品溯源码。包装符为1
	 */
	@Column
	private String progtin14;

	/**
	 * @Description bzgtin14的中文含义是： 包装溯源码。 包装符为2
	 */
	@Column
	private String bzgtin14;

	/**
	 * @Description probzqdwcode的中文含义是： 保质期单位代码aaa100=BZQDWMC 
	 */
	@Column
	private String probzqdwcode;

	/**
	 * @Description probzqdwmc的中文含义是： 保质期单位名称
	 */
	@Column
	private String probzqdwmc;

	/**
	 * @Description probzgg的中文含义是： 包装规格
	 */
	@Column
	private String probzgg;
	
	/**
	 * @Description cphyclbz的中文含义是：产品或原材料标志1产品2原材料
	 */
	@Column
	private String cphyclbz;
	
	/**
	 * @Description projysl的中文含义是：剩余数量
	 */
	@Column
	private BigDecimal projysl;
	
	/**
	 * @Description projj的中文含义是：产品简介
	 */
	@Column
	private String projj;	
	
	/**
	 * @Description proprice的中文含义是：产品价格
	 */
	@Column
	private String proprice;		
	 
		/**
	 * @Description proid的中文含义是： 商品ID
	 */
	public void setProid(String proid){ 
		this.proid = proid;
	}
	/**
	 * @Description proid的中文含义是： 商品ID
	 */
	public String getProid(){
		return proid;
	}
	/**
	 * @Description procomid的中文含义是： 商品所属公司ID
	 */
	public void setProcomid(String procomid){ 
		this.procomid = procomid;
	}
	/**
	 * @Description procomid的中文含义是： 商品所属公司ID
	 */
	public String getProcomid(){
		return procomid;
	}
	/**
	 * @Description proname的中文含义是： 商品名称
	 */
	public void setProname(String proname){ 
		this.proname = proname;
	}
	/**
	 * @Description proname的中文含义是： 商品名称
	 */
	public String getProname(){
		return proname;
	}
	/**
	 * @Description prosb的中文含义是： 商标
	 */
	public void setProsb(String prosb){ 
		this.prosb = prosb;
	}
	/**
	 * @Description prosb的中文含义是： 商标
	 */
	public String getProsb(){
		return prosb;
	}
	/**
	 * @Description prosptm的中文含义是： 商品条码
	 */
	public void setProsptm(String prosptm){ 
		this.prosptm = prosptm;
	}
	/**
	 * @Description prosptm的中文含义是： 商品条码
	 */
	public String getProsptm(){
		return prosptm;
	}
	/**
	 * @Description progg的中文含义是： 规格型号
	 */
	public void setProgg(String progg){ 
		this.progg = progg;
	}
	/**
	 * @Description progg的中文含义是： 规格型号
	 */
	public String getProgg(){
		return progg;
	}
	/**
	 * @Description prosccj的中文含义是： 生产厂家
	 */
	public void setProsccj(String prosccj){ 
		this.prosccj = prosccj;
	}
	/**
	 * @Description prosccj的中文含义是： 生产厂家
	 */
	public String getProsccj(){
		return prosccj;
	}
	/**
	 * @Description propm的中文含义是： 品名
	 */
	public void setPropm(String propm){ 
		this.propm = propm;
	}
	/**
	 * @Description propm的中文含义是： 品名
	 */
	public String getPropm(){
		return propm;
	}
	/**
	 * @Description probzq的中文含义是： 保质期
	 */
	public void setProbzq(String probzq){ 
		this.probzq = probzq;
	}
	/**
	 * @Description probzq的中文含义是： 保质期
	 */
	public String getProbzq(){
		return probzq;
	}
	/**
	 * @Description procdjd的中文含义是： 产地/基地名称
	 */
	public void setProcdjd(String procdjd){ 
		this.procdjd = procdjd;
	}
	/**
	 * @Description procdjd的中文含义是： 产地/基地名称
	 */
	public String getProcdjd(){
		return procdjd;
	}
	/**
	 * @Description proplxx的中文含义是： 配料信息
	 */
	public void setProplxx(String proplxx){ 
		this.proplxx = proplxx;
	}
	/**
	 * @Description proplxx的中文含义是： 配料信息
	 */
	public String getProplxx(){
		return proplxx;
	}
	/**
	 * @Description procpbzh的中文含义是： 产品标准号
	 */
	public void setProcpbzh(String procpbzh){ 
		this.procpbzh = procpbzh;
	}
	/**
	 * @Description procpbzh的中文含义是： 产品标准号
	 */
	public String getProcpbzh(){
		return procpbzh;
	}
	/**
	 * @Description prozl的中文含义是： 产品种类 1一般产品  2养殖业有耳标脚环类产品aaa100=PROZL
	 */
	public void setProzl(String prozl){ 
		this.prozl = prozl;
	}
	/**
	 * @Description prozl的中文含义是： 产品种类 1一般产品  2养殖业有耳标脚环类产品aaa100=PROZL
	 */
	public String getProzl(){
		return prozl;
	}
	/**
	 * @Description progtin14的中文含义是： 产品溯源码。包装符为1
	 */
	public void setProgtin14(String progtin14){ 
		this.progtin14 = progtin14;
	}
	/**
	 * @Description progtin14的中文含义是： 产品溯源码。包装符为1
	 */
	public String getProgtin14(){
		return progtin14;
	}
	/**
	 * @Description bzgtin14的中文含义是： 包装溯源码。 包装符为2
	 */
	public void setBzgtin14(String bzgtin14){ 
		this.bzgtin14 = bzgtin14;
	}
	/**
	 * @Description bzgtin14的中文含义是： 包装溯源码。 包装符为2
	 */
	public String getBzgtin14(){
		return bzgtin14;
	}
	/**
	 * @Description probzqdwcode的中文含义是： 保质期单位代码aaa100=BZQDWMC 
	 */
	public void setProbzqdwcode(String probzqdwcode){ 
		this.probzqdwcode = probzqdwcode;
	}
	/**
	 * @Description probzqdwcode的中文含义是： 保质期单位代码aaa100=BZQDWMC 
	 */
	public String getProbzqdwcode(){
		return probzqdwcode;
	}
	/**
	 * @Description probzqdwmc的中文含义是： 保质期单位名称
	 */
	public void setProbzqdwmc(String probzqdwmc){ 
		this.probzqdwmc = probzqdwmc;
	}
	/**
	 * @Description probzqdwmc的中文含义是： 保质期单位名称
	 */
	public String getProbzqdwmc(){
		return probzqdwmc;
	}
	/**
	 * @Description probzgg的中文含义是： 包装规格
	 */
	public void setProbzgg(String probzgg){ 
		this.probzgg = probzgg;
	}
	/**
	 * @Description probzgg的中文含义是： 包装规格
	 */
	public String getProbzgg(){
		return probzgg;
	}
	public String getProcjdh() {
		return procjdh;
	}
	public void setProcjdh(String procjdh) {
		this.procjdh = procjdh;
	}
	public String getProcjdz() {
		return procjdz;
	}
	public void setProcjdz(String procjdz) {
		this.procjdz = procjdz;
	}
	public String getCphyclbz() {
		return cphyclbz;
	}
	public void setCphyclbz(String cphyclbz) {
		this.cphyclbz = cphyclbz;
	}
	public BigDecimal getProjysl() {
		return projysl;
	}
	public void setProjysl(BigDecimal projysl) {
		this.projysl = projysl;
	}
	public String getProjj() {
		return projj;
	}
	public void setProjj(String projj) {
		this.projj = projj;
	}
	public String getProprice() {
		return proprice;
	}
	public void setProprice(String proprice) {
		this.proprice = proprice;
	}
	

	
}