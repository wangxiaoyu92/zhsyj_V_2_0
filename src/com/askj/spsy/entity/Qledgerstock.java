package com.askj.spsy.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.math.BigDecimal;

/**
 * @Description  QLEDGERSTOCK的中文含义是: 进货电子台账; InnoDB free: 2715648 kB
 * @Creation     2016/07/03 10:32:49
 * @Written      Create Tool By zjf 
 **/
@Table(value = "QLEDGERSTOCK")
public class Qledgerstock {
	/**
	 * @Description qledgerstockid的中文含义是： 
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_qledgerstockid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_qledgerstockid.nextval from dual"))
	private String qledgerstockid;

	/**
	 * @Description lgfromcomid的中文含义是： 卖方公司ID
	 */
	@Column
	private String lgfromcomid;

	/**
	 * @Description lgtocomid的中文含义是： 买方公司ID
	 */
	@Column
	private String lgtocomid;

	/**
	 * @Description lgproid的中文含义是： 交易商品ID
	 */
	@Column
	private String lgproid;

	/**
	 * @Description lgprojysl的中文含义是： 交易商品数量
	 */
	@Column
	private String lgprojysl;

	/**
	 * @Description lgprojydwcode的中文含义是： 食品包装计量单位
	 */
	@Column
	private String lgprojydwcode;

	/**
	 * @Description lgproscrq的中文含义是： 生产日期
	 */
	@Column
	private String lgproscrq;

	/**
	 * @Description lgprobzq的中文含义是： 保质期
	 */
	@Column
	private int lgprobzq;

	/**
	 * @Description lgprojyrq的中文含义是： 商品交易日期
	 */
	@Column
	private String lgprojyrq;

	/**
	 * @Description lgprocode的中文含义是： 交易商品溯源码(范围外交易时 此字段为空)
	 */
	@Column
	private String lgprocode;

	/**
	 * @Description lgprojyyf的中文含义是： 商品交易月份
	 */
	@Column
	private String lgprojyyf;

	/**
	 * @Description lgpropc的中文含义是： 商品批次(范围外交易时 此字段为空)
	 */
	@Column
	private String lgpropc;

	/**
	 * @Description lgjylx的中文含义是： 交易类型1 范围内交易  2范围外交易
	 */
	@Column
	private String lgjylx;

	/**
	 * @Description lgprojydwmc的中文含义是： 交易商品单位名称(如公斤等)
	 */
	@Column
	private String lgprojydwmc;

	/**
	 * @Description lgprobzqdwcode的中文含义是： 保质期单位ID
	 */
	@Column
	private String lgprobzqdwcode;

	/**
	 * @Description lgprobzqdwmc的中文含义是： 保质期单位名称
	 */
	@Column
	private String lgprobzqdwmc;

	/**
	 * @Description lgprosptm的中文含义是： 商品条码
	 */
	@Column
	private String lgprosptm;

	/**
	 * @Description lgprodqrq的中文含义是： 到期日期
	 */
	@Column
	private String lgprodqrq;

	/**
	 * @Description lgproname的中文含义是： 商品名称
	 */
	@Column
	private String lgproname;

	/**
	 * @Description lgprogg的中文含义是： 规格
	 */
	@Column
	private String lgprogg;

	/**
	 * @Description lgprobzgg的中文含义是： 包装规格
	 */
	@Column
	private String lgprobzgg;

	/**
	 * @Description lgprosccj的中文含义是： 生产厂家
	 */
	@Column
	private String lgprosccj;

	/**
	 * @Description lgprocjdz的中文含义是： 厂家地址
	 */
	@Column
	private String lgprocjdz;

	/**
	 * @Description lgprosfyx的中文含义是： 是否有效：1有效，2无效
	 */
	@Column
	private String lgprosfyx;

	/**
	 * @Description sphyclid的中文含义是： 商品或原材料ID
	 */
	@Column
	private String sphyclid;
	
	/**
	 * @Description lgprosysl的中文含义是：剩余数量
	 */
	@Column
	private BigDecimal lgprosysl;	

	/**
	 * @Description qledgerstockid的中文含义是： 
	 */
	public void setQledgerstockid(String qledgerstockid){ 
		this.qledgerstockid = qledgerstockid;
	}
	/**
	 * @Description qledgerstockid的中文含义是： 
	 */
	public String getQledgerstockid(){
		return qledgerstockid;
	}
	/**
	 * @Description lgfromcomid的中文含义是： 卖方公司ID
	 */
	public void setLgfromcomid(String lgfromcomid){ 
		this.lgfromcomid = lgfromcomid;
	}
	/**
	 * @Description lgfromcomid的中文含义是： 卖方公司ID
	 */
	public String getLgfromcomid(){
		return lgfromcomid;
	}
	/**
	 * @Description lgtocomid的中文含义是： 买方公司ID
	 */
	public void setLgtocomid(String lgtocomid){ 
		this.lgtocomid = lgtocomid;
	}
	/**
	 * @Description lgtocomid的中文含义是： 买方公司ID
	 */
	public String getLgtocomid(){
		return lgtocomid;
	}
	/**
	 * @Description lgproid的中文含义是： 交易商品ID
	 */
	public void setLgproid(String lgproid){ 
		this.lgproid = lgproid;
	}
	/**
	 * @Description lgproid的中文含义是： 交易商品ID
	 */
	public String getLgproid(){
		return lgproid;
	}
	/**
	 * @Description lgprojysl的中文含义是： 交易商品数量
	 */
	public void setLgprojysl(String lgprojysl){ 
		this.lgprojysl = lgprojysl;
	}
	/**
	 * @Description lgprojysl的中文含义是： 交易商品数量
	 */
	public String getLgprojysl(){
		return lgprojysl;
	}
	/**
	 * @Description lgprojydwcode的中文含义是： 食品包装计量单位
	 */
	public void setLgprojydwcode(String lgprojydwcode){ 
		this.lgprojydwcode = lgprojydwcode;
	}
	/**
	 * @Description lgprojydwcode的中文含义是： 食品包装计量单位
	 */
	public String getLgprojydwcode(){
		return lgprojydwcode;
	}
	/**
	 * @Description lgproscrq的中文含义是： 生产日期
	 */
	public void setLgproscrq(String lgproscrq){ 
		this.lgproscrq = lgproscrq;
	}
	/**
	 * @Description lgproscrq的中文含义是： 生产日期
	 */
	public String getLgproscrq(){
		return lgproscrq;
	}
	/**
	 * @Description lgprobzq的中文含义是： 保质期
	 */
	public void setLgprobzq(int lgprq){
		this.lgprobzq = lgprobzq;
	}
	/**
	 * @Description lgprobzq的中文含义是： 保质期
	 */
	public int getLgprobzq(){
		return lgprobzq;
	}
	/**
	 * @Description lgprojyrq的中文含义是： 商品交易日期
	 */
	public void setLgprojyrq(String lgprojyrq){ 
		this.lgprojyrq = lgprojyrq;
	}
	/**
	 * @Description lgprojyrq的中文含义是： 商品交易日期
	 */
	public String getLgprojyrq(){
		return lgprojyrq;
	}
	/**
	 * @Description lgprocode的中文含义是： 交易商品溯源码(范围外交易时 此字段为空)
	 */
	public void setLgprocode(String lgprocode){ 
		this.lgprocode = lgprocode;
	}
	/**
	 * @Description lgprocode的中文含义是： 交易商品溯源码(范围外交易时 此字段为空)
	 */
	public String getLgprocode(){
		return lgprocode;
	}
	/**
	 * @Description lgprojyyf的中文含义是： 商品交易月份
	 */
	public void setLgprojyyf(String lgprojyyf){ 
		this.lgprojyyf = lgprojyyf;
	}
	/**
	 * @Description lgprojyyf的中文含义是： 商品交易月份
	 */
	public String getLgprojyyf(){
		return lgprojyyf;
	}
	/**
	 * @Description lgpropc的中文含义是： 商品批次(范围外交易时 此字段为空)
	 */
	public void setLgpropc(String lgpropc){ 
		this.lgpropc = lgpropc;
	}
	/**
	 * @Description lgpropc的中文含义是： 商品批次(范围外交易时 此字段为空)
	 */
	public String getLgpropc(){
		return lgpropc;
	}
	/**
	 * @Description lgjylx的中文含义是： 交易类型1 范围内交易  2范围外交易
	 */
	public void setLgjylx(String lgjylx){ 
		this.lgjylx = lgjylx;
	}
	/**
	 * @Description lgjylx的中文含义是： 交易类型1 范围内交易  2范围外交易
	 */
	public String getLgjylx(){
		return lgjylx;
	}
	/**
	 * @Description lgprojydwmc的中文含义是： 交易商品单位名称(如公斤等)
	 */
	public void setLgprojydwmc(String lgprojydwmc){ 
		this.lgprojydwmc = lgprojydwmc;
	}
	/**
	 * @Description lgprojydwmc的中文含义是： 交易商品单位名称(如公斤等)
	 */
	public String getLgprojydwmc(){
		return lgprojydwmc;
	}
	/**
	 * @Description lgprobzqdwcode的中文含义是： 保质期单位ID
	 */
	public void setLgprobzqdwcode(String lgprobzqdwcode){ 
		this.lgprobzqdwcode = lgprobzqdwcode;
	}
	/**
	 * @Description lgprobzqdwcode的中文含义是： 保质期单位ID
	 */
	public String getLgprobzqdwcode(){
		return lgprobzqdwcode;
	}
	/**
	 * @Description lgprobzqdwmc的中文含义是： 保质期单位名称
	 */
	public void setLgprobzqdwmc(String lgprobzqdwmc){ 
		this.lgprobzqdwmc = lgprobzqdwmc;
	}
	/**
	 * @Description lgprobzqdwmc的中文含义是： 保质期单位名称
	 */
	public String getLgprobzqdwmc(){
		return lgprobzqdwmc;
	}
	/**
	 * @Description lgprosptm的中文含义是： 商品条码
	 */
	public void setLgprosptm(String lgprosptm){ 
		this.lgprosptm = lgprosptm;
	}
	/**
	 * @Description lgprosptm的中文含义是： 商品条码
	 */
	public String getLgprosptm(){
		return lgprosptm;
	}
	/**
	 * @Description lgprodqrq的中文含义是： 到期日期
	 */
	public void setLgprodqrq(String lgprodqrq){ 
		this.lgprodqrq = lgprodqrq;
	}
	/**
	 * @Description lgprodqrq的中文含义是： 到期日期
	 */
	public String getLgprodqrq(){
		return lgprodqrq;
	}
	/**
	 * @Description lgproname的中文含义是： 商品名称
	 */
	public void setLgproname(String lgproname){ 
		this.lgproname = lgproname;
	}
	/**
	 * @Description lgproname的中文含义是： 商品名称
	 */
	public String getLgproname(){
		return lgproname;
	}
	/**
	 * @Description lgprogg的中文含义是： 规格
	 */
	public void setLgprogg(String lgprogg){ 
		this.lgprogg = lgprogg;
	}
	/**
	 * @Description lgprogg的中文含义是： 规格
	 */
	public String getLgprogg(){
		return lgprogg;
	}
	/**
	 * @Description lgprobzgg的中文含义是： 包装规格
	 */
	public void setLgprobzgg(String lgprobzgg){ 
		this.lgprobzgg = lgprobzgg;
	}
	/**
	 * @Description lgprobzgg的中文含义是： 包装规格
	 */
	public String getLgprobzgg(){
		return lgprobzgg;
	}
	/**
	 * @Description lgprosccj的中文含义是： 生产厂家
	 */
	public void setLgprosccj(String lgprosccj){ 
		this.lgprosccj = lgprosccj;
	}
	/**
	 * @Description lgprosccj的中文含义是： 生产厂家
	 */
	public String getLgprosccj(){
		return lgprosccj;
	}
	/**
	 * @Description lgprocjdz的中文含义是： 厂家地址
	 */
	public void setLgprocjdz(String lgprocjdz){ 
		this.lgprocjdz = lgprocjdz;
	}
	/**
	 * @Description lgprocjdz的中文含义是： 厂家地址
	 */
	public String getLgprocjdz(){
		return lgprocjdz;
	}
	/**
	 * @Description lgprosfyx的中文含义是： 是否有效：1有效，2无效
	 */
	public void setLgprosfyx(String lgprosfyx){ 
		this.lgprosfyx = lgprosfyx;
	}
	/**
	 * @Description lgprosfyx的中文含义是： 是否有效：1有效，2无效
	 */
	public String getLgprosfyx(){
		return lgprosfyx;
	}
	/**
	 * @Description sphyclid的中文含义是： 商品或原材料ID
	 */
	public void setSphyclid(String sphyclid){ 
		this.sphyclid = sphyclid;
	}
	/**
	 * @Description sphyclid的中文含义是： 商品或原材料ID
	 */
	public String getSphyclid(){
		return sphyclid;
	}
	/**
	 * @Description lgprosysl的中文含义是：剩余数量
	 */
	public BigDecimal getLgprosysl() {
		return lgprosysl;
	}
	/**
	 * @Description lgprosysl的中文含义是：剩余数量
	 */
	public void setLgprosysl(BigDecimal lgprosysl) {
		this.lgprosysl = lgprosysl;
	}
	

	
}