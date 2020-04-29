package com.askj.spsy.dto;

import java.math.BigDecimal;

/**
 * @Description  QLEDGERSTOCK的中文含义是: 进货电子台账; InnoDB free: 2715648 kBDTO
 * @Creation     2016/07/03 10:33:29
 * @Written      Create Tool By zjf 
 **/
public class QledgerstockDTO {
	private String probcxhlGridStr;
	
	/**
	 * @Description lgcomfwnfww的中文含义是：企业范围内范围外类型，手动添加
	 */
	private String lgcomfwnfww;
	public String getLgcomfwnfww() {
		return lgcomfwnfww;
	}
	public void setLgcomfwnfww(String lgcomfwnfww) {
		this.lgcomfwnfww = lgcomfwnfww;
	}
	/**
	 * @Description procomid的中文含义是： 
	 */
	private String procomid;
	
	/**
	 * @Description proid的中文含义是： 
	 */
	private String proid;	
	
	/**
	 * @Description cppcid的中文含义是： 
	 */
	private String cppcid;	
	
	/**
	 * @Description probcxhl的中文含义是： 本次消耗量
	 */
	private BigDecimal probcxhl;	
	
	/**
	 * @Description proghsl的中文含义是： 产品供货数量，手动添加
	 */
	private String proghsl;
	/**
	 * @Description projysl的中文含义是： 产品结余数量
	 */
	private String projysl;
	/**
	 * @Description comdz的中文含义是： 企业地址，对应pcompany表comdz字段
	 */
	private String comdz;
	/**
	 * @Description comyddh的中文含义是： 移动电话，对应pcompany表comyddh字段
	 */
	private String comyddh;
	/**
	 * @Description comfrhyz的中文含义是： 企业法人或业主，对应pcompany表comfrhyz字段
	 */
	private String comfrhyz;
	/**
	 * @Description comzzzmbh的中文含义是： 资质证明编号，对应pcompany表comzzzmbh字段
	 */
	private String comzzzmbh;
	/**
	 * @Description commc的中文含义是： 卖方公司名称，对应pcompany表commc字段
	 */
	private String commc;
	/**
	 * @Description mfcommc的中文含义是： 买方公司名称，对应pcompany表commc字段
	 */
	private String mfcommc;
	/**
	 * @Description qledgerstockid的中文含义是： 
	 */
	private String qledgerstockid;

	/**
	 * @Description lgfromcomid的中文含义是： 卖方公司ID
	 */
	private String lgfromcomid;

	/**
	 * @Description lgtocomid的中文含义是： 买方公司ID
	 */
	private String lgtocomid;

	/**
	 * @Description lgproid的中文含义是： 交易商品ID
	 */
	private String lgproid;

	/**
	 * @Description lgprojysl的中文含义是： 交易商品数量
	 */
	private BigDecimal lgprojysl;

	/**
	 * @Description lgprojydwcode的中文含义是： 食品包装计量单位
	 */
	private String lgprojydwcode;

	/**
	 * @Description lgproscrq的中文含义是： 生产日期
	 */
	private String lgproscrq;

	/**
	 * @Description lgprobzq的中文含义是： 保质期
	 */
	private int lgprobzq;

	/**
	 * @Description lgprojyrq的中文含义是： 商品交易日期
	 */
	private String lgprojyrq;

	/**
	 * @Description lgprocode的中文含义是： 交易商品溯源码(范围外交易时 此字段为空)
	 */
	private String lgprocode;

	/**
	 * @Description lgprojyyf的中文含义是： 商品交易月份
	 */
	private String lgprojyyf;

	/**
	 * @Description lgpropc的中文含义是： 商品批次(范围外交易时 此字段为空)
	 */
	private String lgpropc;

	/**
	 * @Description lgjylx的中文含义是： 交易类型1 范围内交易  2范围外交易
	 */
	private String lgjylx;

	/**
	 * @Description lgprojydwmc的中文含义是： 交易商品单位名称(如公斤等)
	 */
	private String lgprojydwmc;

	/**
	 * @Description lgprobzqdwcode的中文含义是： 保质期单位ID
	 */
	private String lgprobzqdwcode;

	/**
	 * @Description lgprobzqdwmc的中文含义是： 保质期单位名称
	 */
	private String lgprobzqdwmc;

	/**
	 * @Description lgprosptm的中文含义是： 商品条码
	 */
	private String lgprosptm;

	/**
	 * @Description lgprodqrq的中文含义是： 到期日期
	 */
	private String lgprodqrq;

	/**
	 * @Description lgproname的中文含义是： 商品名称
	 */
	private String lgproname;

	/**
	 * @Description lgprogg的中文含义是： 规格
	 */
	private String lgprogg;

	/**
	 * @Description lgprobzgg的中文含义是： 包装规格
	 */
	private String lgprobzgg;

	/**
	 * @Description lgprosccj的中文含义是： 生产厂家
	 */
	private String lgprosccj;

	/**
	 * @Description lgprocjdz的中文含义是： 厂家地址
	 */
	private String lgprocjdz;

	/**
	 * @Description lgprosfyx的中文含义是： 是否有效：1有效，2无效
	 */
	private String lgprosfyx;

	/**
	 * @Description sphyclid的中文含义是： 商品或原材料ID
	 */
	private String sphyclid;
	
	/**
	 * @Description lgprosysl的中文含义是：剩余数量
	 */
	private String lgprosysl;	
	
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
	public void setLgprojysl(BigDecimal lgprojysl){ 
		this.lgprojysl = lgprojysl;
	}
	/**
	 * @Description lgprojysl的中文含义是： 交易商品数量
	 */
	public BigDecimal getLgprojysl(){
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
	public void setLgprobzq(int lgprobzq){
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
	public String getCommc() {
		return commc;
	}
	public void setCommc(String commc) {
		this.commc = commc;
	}
	public String getComzzzmbh() {
		return comzzzmbh;
	}
	public void setComzzzmbh(String comzzzmbh) {
		this.comzzzmbh = comzzzmbh;
	}
	public String getComdz() {
		return comdz;
	}
	public void setComdz(String comdz) {
		this.comdz = comdz;
	}
	public String getComyddh() {
		return comyddh;
	}
	public void setComyddh(String comyddh) {
		this.comyddh = comyddh;
	}
	public String getComfrhyz() {
		return comfrhyz;
	}
	public void setComfrhyz(String comfrhyz) {
		this.comfrhyz = comfrhyz;
	}
	public String getProghsl() {
		return proghsl;
	}
	public void setProghsl(String proghsl) {
		this.proghsl = proghsl;
	}
	public String getProjysl() {
		return projysl;
	}
	public void setProjysl(String projysl) {
		this.projysl = projysl;
	}
	public String getLgprosysl() {
		return lgprosysl;
	}
	public void setLgprosysl(String lgprosysl) {
		this.lgprosysl = lgprosysl;
	}
	public BigDecimal getProbcxhl() {
		return probcxhl;
	}
	public void setProbcxhl(BigDecimal probcxhl) {
		this.probcxhl = probcxhl;
	}
	public String getProbcxhlGridStr() {
		return probcxhlGridStr;
	}
	public void setProbcxhlGridStr(String probcxhlGridStr) {
		this.probcxhlGridStr = probcxhlGridStr;
	}
	public String getProcomid() {
		return procomid;
	}
	public void setProcomid(String procomid) {
		this.procomid = procomid;
	}
	public String getProid() {
		return proid;
	}
	public void setProid(String proid) {
		this.proid = proid;
	}
	public String getCppcid() {
		return cppcid;
	}
	public void setCppcid(String cppcid) {
		this.cppcid = cppcid;
	}
	public String getMfcommc() {
		return mfcommc;
	}
	public void setMfcommc(String mfcommc) {
		this.mfcommc = mfcommc;
	}
	
}