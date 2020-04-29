package com.askj.spsy.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  QLEDGERSALES的中文含义是: 销货电子台账; InnoDB free: 2713600 kBDTO
 * @Creation     2016/07/11 14:37:34
 * @Written      Create Tool By zjf 
 **/
public class QledgersalesDTO {
	
	/**
	 * @Description commc的中文含义是： 企业名称
	 */
	private String commc;
	
	/**
	 * @Description lqledgersalesid的中文含义是： 
	 */
	private String lqledgersalesid;

	/**
	 * @Description lgsfromcomid的中文含义是： 卖方公司ID
	 */
	private String lgsfromcomid;

	/**
	 * @Description lgstocomid的中文含义是： 买方公司ID
	 */
	private String lgstocomid;

	/**
	 * @Description lgsproid的中文含义是： 交易商品ID
	 */
	private String lgsproid;

	/**
	 * @Description lgsprojysl的中文含义是： 交易商品数量
	 */
	private String lgsprojysl;

	/**
	 * @Description lgsprojydwcode的中文含义是： 食品包装计量单位
	 */
	private String lgsprojydwcode;

	/**
	 * @Description lgsproscrq的中文含义是： 生产日期
	 */
	private String lgsproscrq;

	/**
	 * @Description lgsprobzq的中文含义是： 保质期
	 */
	private String lgsprobzq;

	/**
	 * @Description lgsprojyrq的中文含义是： 商品交易日期
	 */
	private String lgsprojyrq;

	/**
	 * @Description lgsprocode的中文含义是： 交易商品溯源码(范围外交易时 此字段为空)
	 */
	private String lgsprocode;

	/**
	 * @Description lgsprojyyf的中文含义是： 商品交易月份
	 */
	private String lgsprojyyf;

	/**
	 * @Description lgspropc的中文含义是： 商品批次(范围外交易时 此字段为空)
	 */
	private String lgspropc;

	/**
	 * @Description lgsjylx的中文含义是： 交易类型 1范围内交易 2范围外交易
	 */
	private String lgsjylx;

	/**
	 * @Description lgsprojydwmc的中文含义是： 交易商品单位名称(如公斤等)
	 */
	private String lgsprojydwmc;

	/**
	 * @Description lgsprobzqdwcode的中文含义是： 保质期单位ID
	 */
	private String lgsprobzqdwcode;

	/**
	 * @Description lgsprobzqdwmc的中文含义是： 保质期单位名称
	 */
	private String lgsprobzqdwmc;

	/**
	 * @Description lgsprosptm的中文含义是： 商品条码
	 */
	private String lgsprosptm;

	/**
	 * @Description lgsprodqrq的中文含义是： 到期日期
	 */
	private String lgsprodqrq;

	/**
	 * @Description lgsproname的中文含义是： 商品名称
	 */
	private String lgsproname;

	/**
	 * @Description lgsprogg的中文含义是： 规格
	 */
	private String lgsprogg;

	/**
	 * @Description lgsprobzgg的中文含义是： 包装规格
	 */
	private String lgsprobzgg;

	/**
	 * @Description lgsprosccj的中文含义是： 生产厂家
	 */
	private String lgsprosccj;

	/**
	 * @Description lgsprocjdz的中文含义是： 厂家地址
	 */
	private String lgsprocjdz;

	/**
	 * @Description lgstocommc的中文含义是： 企业名称
	 */
	private String lgstocommc;

	/**
	 * @Description lgstocomzjhm的中文含义是： 证件号码
	 */
	private String lgstocomzjhm;

	/**
	 * @Description qledgerstockid的中文含义是： 销货台账ID
	 */
	private String qledgerstockid;

	
		/**
	 * @Description lqledgersalesid的中文含义是： 
	 */
	public void setLqledgersalesid(String lqledgersalesid){ 
		this.lqledgersalesid = lqledgersalesid;
	}
	/**
	 * @Description lqledgersalesid的中文含义是： 
	 */
	public String getLqledgersalesid(){
		return lqledgersalesid;
	}
	/**
	 * @Description lgsfromcomid的中文含义是： 卖方公司ID
	 */
	public void setLgsfromcomid(String lgsfromcomid){ 
		this.lgsfromcomid = lgsfromcomid;
	}
	/**
	 * @Description lgsfromcomid的中文含义是： 卖方公司ID
	 */
	public String getLgsfromcomid(){
		return lgsfromcomid;
	}
	/**
	 * @Description lgstocomid的中文含义是： 买方公司ID
	 */
	public void setLgstocomid(String lgstocomid){ 
		this.lgstocomid = lgstocomid;
	}
	/**
	 * @Description lgstocomid的中文含义是： 买方公司ID
	 */
	public String getLgstocomid(){
		return lgstocomid;
	}
	/**
	 * @Description lgsproid的中文含义是： 交易商品ID
	 */
	public void setLgsproid(String lgsproid){ 
		this.lgsproid = lgsproid;
	}
	/**
	 * @Description lgsproid的中文含义是： 交易商品ID
	 */
	public String getLgsproid(){
		return lgsproid;
	}
	/**
	 * @Description lgsprojysl的中文含义是： 交易商品数量
	 */
	public void setLgsprojysl(String lgsprojysl){ 
		this.lgsprojysl = lgsprojysl;
	}
	/**
	 * @Description lgsprojysl的中文含义是： 交易商品数量
	 */
	public String getLgsprojysl(){
		return lgsprojysl;
	}
	/**
	 * @Description lgsprojydwcode的中文含义是： 食品包装计量单位
	 */
	public void setLgsprojydwcode(String lgsprojydwcode){ 
		this.lgsprojydwcode = lgsprojydwcode;
	}
	/**
	 * @Description lgsprojydwcode的中文含义是： 食品包装计量单位
	 */
	public String getLgsprojydwcode(){
		return lgsprojydwcode;
	}
	/**
	 * @Description lgsproscrq的中文含义是： 生产日期
	 */
	public void setLgsproscrq(String lgsproscrq){ 
		this.lgsproscrq = lgsproscrq;
	}
	/**
	 * @Description lgsproscrq的中文含义是： 生产日期
	 */
	public String getLgsproscrq(){
		return lgsproscrq;
	}
	/**
	 * @Description lgsprobzq的中文含义是： 保质期
	 */
	public void setLgsprobzq(String lgsprobzq){ 
		this.lgsprobzq = lgsprobzq;
	}
	/**
	 * @Description lgsprobzq的中文含义是： 保质期
	 */
	public String getLgsprobzq(){
		return lgsprobzq;
	}
	/**
	 * @Description lgsprojyrq的中文含义是： 商品交易日期
	 */
	public void setLgsprojyrq(String lgsprojyrq){ 
		this.lgsprojyrq = lgsprojyrq;
	}
	/**
	 * @Description lgsprojyrq的中文含义是： 商品交易日期
	 */
	public String getLgsprojyrq(){
		return lgsprojyrq;
	}
	/**
	 * @Description lgsprocode的中文含义是： 交易商品溯源码(范围外交易时 此字段为空)
	 */
	public void setLgsprocode(String lgsprocode){ 
		this.lgsprocode = lgsprocode;
	}
	/**
	 * @Description lgsprocode的中文含义是： 交易商品溯源码(范围外交易时 此字段为空)
	 */
	public String getLgsprocode(){
		return lgsprocode;
	}
	/**
	 * @Description lgsprojyyf的中文含义是： 商品交易月份
	 */
	public void setLgsprojyyf(String lgsprojyyf){ 
		this.lgsprojyyf = lgsprojyyf;
	}
	/**
	 * @Description lgsprojyyf的中文含义是： 商品交易月份
	 */
	public String getLgsprojyyf(){
		return lgsprojyyf;
	}
	/**
	 * @Description lgspropc的中文含义是： 商品批次(范围外交易时 此字段为空)
	 */
	public void setLgspropc(String lgspropc){ 
		this.lgspropc = lgspropc;
	}
	/**
	 * @Description lgspropc的中文含义是： 商品批次(范围外交易时 此字段为空)
	 */
	public String getLgspropc(){
		return lgspropc;
	}
	/**
	 * @Description lgsjylx的中文含义是： 交易类型 1范围内交易 2范围外交易
	 */
	public void setLgsjylx(String lgsjylx){ 
		this.lgsjylx = lgsjylx;
	}
	/**
	 * @Description lgsjylx的中文含义是： 交易类型 1范围内交易 2范围外交易
	 */
	public String getLgsjylx(){
		return lgsjylx;
	}
	/**
	 * @Description lgsprojydwmc的中文含义是： 交易商品单位名称(如公斤等)
	 */
	public void setLgsprojydwmc(String lgsprojydwmc){ 
		this.lgsprojydwmc = lgsprojydwmc;
	}
	/**
	 * @Description lgsprojydwmc的中文含义是： 交易商品单位名称(如公斤等)
	 */
	public String getLgsprojydwmc(){
		return lgsprojydwmc;
	}
	/**
	 * @Description lgsprobzqdwcode的中文含义是： 保质期单位ID
	 */
	public void setLgsprobzqdwcode(String lgsprobzqdwcode){ 
		this.lgsprobzqdwcode = lgsprobzqdwcode;
	}
	/**
	 * @Description lgsprobzqdwcode的中文含义是： 保质期单位ID
	 */
	public String getLgsprobzqdwcode(){
		return lgsprobzqdwcode;
	}
	/**
	 * @Description lgsprobzqdwmc的中文含义是： 保质期单位名称
	 */
	public void setLgsprobzqdwmc(String lgsprobzqdwmc){ 
		this.lgsprobzqdwmc = lgsprobzqdwmc;
	}
	/**
	 * @Description lgsprobzqdwmc的中文含义是： 保质期单位名称
	 */
	public String getLgsprobzqdwmc(){
		return lgsprobzqdwmc;
	}
	/**
	 * @Description lgsprosptm的中文含义是： 商品条码
	 */
	public void setLgsprosptm(String lgsprosptm){ 
		this.lgsprosptm = lgsprosptm;
	}
	/**
	 * @Description lgsprosptm的中文含义是： 商品条码
	 */
	public String getLgsprosptm(){
		return lgsprosptm;
	}
	/**
	 * @Description lgsprodqrq的中文含义是： 到期日期
	 */
	public void setLgsprodqrq(String lgsprodqrq){ 
		this.lgsprodqrq = lgsprodqrq;
	}
	/**
	 * @Description lgsprodqrq的中文含义是： 到期日期
	 */
	public String getLgsprodqrq(){
		return lgsprodqrq;
	}
	/**
	 * @Description lgsproname的中文含义是： 商品名称
	 */
	public void setLgsproname(String lgsproname){ 
		this.lgsproname = lgsproname;
	}
	/**
	 * @Description lgsproname的中文含义是： 商品名称
	 */
	public String getLgsproname(){
		return lgsproname;
	}
	/**
	 * @Description lgsprogg的中文含义是： 规格
	 */
	public void setLgsprogg(String lgsprogg){ 
		this.lgsprogg = lgsprogg;
	}
	/**
	 * @Description lgsprogg的中文含义是： 规格
	 */
	public String getLgsprogg(){
		return lgsprogg;
	}
	/**
	 * @Description lgsprobzgg的中文含义是： 包装规格
	 */
	public void setLgsprobzgg(String lgsprobzgg){ 
		this.lgsprobzgg = lgsprobzgg;
	}
	/**
	 * @Description lgsprobzgg的中文含义是： 包装规格
	 */
	public String getLgsprobzgg(){
		return lgsprobzgg;
	}
	/**
	 * @Description lgsprosccj的中文含义是： 生产厂家
	 */
	public void setLgsprosccj(String lgsprosccj){ 
		this.lgsprosccj = lgsprosccj;
	}
	/**
	 * @Description lgsprosccj的中文含义是： 生产厂家
	 */
	public String getLgsprosccj(){
		return lgsprosccj;
	}
	/**
	 * @Description lgsprocjdz的中文含义是： 厂家地址
	 */
	public void setLgsprocjdz(String lgsprocjdz){ 
		this.lgsprocjdz = lgsprocjdz;
	}
	/**
	 * @Description lgsprocjdz的中文含义是： 厂家地址
	 */
	public String getLgsprocjdz(){
		return lgsprocjdz;
	}
	/**
	 * @Description lgstocommc的中文含义是： 企业名称
	 */
	public void setLgstocommc(String lgstocommc){ 
		this.lgstocommc = lgstocommc;
	}
	/**
	 * @Description lgstocommc的中文含义是： 企业名称
	 */
	public String getLgstocommc(){
		return lgstocommc;
	}
	/**
	 * @Description lgstocomzjhm的中文含义是： 证件号码
	 */
	public void setLgstocomzjhm(String lgstocomzjhm){ 
		this.lgstocomzjhm = lgstocomzjhm;
	}
	/**
	 * @Description lgstocomzjhm的中文含义是： 证件号码
	 */
	public String getLgstocomzjhm(){
		return lgstocomzjhm;
	}
	/**
	 * @Description qledgerstockid的中文含义是： 销货台账ID
	 */
	public void setQledgerstockid(String qledgerstockid){ 
		this.qledgerstockid = qledgerstockid;
	}
	/**
	 * @Description qledgerstockid的中文含义是： 销货台账ID
	 */
	public String getQledgerstockid(){
		return qledgerstockid;
	}

	
}