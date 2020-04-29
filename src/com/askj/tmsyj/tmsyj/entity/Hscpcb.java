package com.askj.tmsyj.tmsyj.entity;

import java.math.BigDecimal;
import java.sql.Timestamp;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

@Table(value = "Hscpcb")
public class Hscpcb {
/** 生产企业生产批次表; InnoDB free: 53248 kB  */
	/** hscpcbid 的中文含义是：生产批次表id*/
	@Name
	@Column
	private String hscpcbid;

	/** jcypid 的中文含义是：产品id*/
	@Column
	private String jcypid;

	/** hviewjgztid 的中文含义是：监管主体表主键*/
	@Column
	private String hviewjgztid;	

	/** scpch 的中文含义是：生产批次号*/
	@Column
	private String scpch;

	/** sptm 的中文含义是：商品条码*/
	@Column
	private String sptm;

	/** scrq 的中文含义是：生产日期*/
	@Column
	private Timestamp scrq;

	/** bzrq 的中文含义是：保质日期*/
	@Column
	private Timestamp bzrq;

	/** spjybgbh 的中文含义是：产品检验报告编号*/
	@Column
	private String spjybgbh;

	/** jyzxbzh 的中文含义是：检验执行标准号*/
	@Column
	private String jyzxbzh;

	/** jyrq 的中文含义是：检验日期*/
	@Column
	private Timestamp jyrq;

	/** cpscjyjl 的中文含义是：产品生产检验结论aaa100=cpscjyjl*/
	@Column
	private String cpscjyjl;

	/** scsl 的中文含义是：生产数量*/
	@Column
	private BigDecimal scsl;

	/** sysl 的中文含义是：剩余数量*/
	@Column
	private BigDecimal sysl;

	/** scspjldw 的中文含义是：计量单位*/
	@Column
	private String scspjldw;
	/** aae011 的中文含义是：操作员*/
	@Column
	private String aae011;

	/** aae036 的中文含义是：操作时间*/
	@Column
	private Timestamp aae036;

	public void setHscpcbid(String hscpcbid){
		this.hscpcbid=hscpcbid;
	}

	public String getHscpcbid(){
		return hscpcbid;
	}

	public void setJcypid(String jcypid){
		this.jcypid=jcypid;
	}

	public String getJcypid(){
		return jcypid;
	}

	public void setScpch(String scpch){
		this.scpch=scpch;
	}

	public String getScpch(){
		return scpch;
	}

	public void setSptm(String sptm){
		this.sptm=sptm;
	}

	public String getSptm(){
		return sptm;
	}

	public void setScrq(Timestamp scrq){
		this.scrq=scrq;
	}

	public Timestamp getScrq(){
		return scrq;
	}

	public void setBzrq(Timestamp bzrq){
		this.bzrq=bzrq;
	}

	public Timestamp getBzrq(){
		return bzrq;
	}

	public void setSpjybgbh(String spjybgbh){
		this.spjybgbh=spjybgbh;
	}

	public String getSpjybgbh(){
		return spjybgbh;
	}

	public void setJyzxbzh(String jyzxbzh){
		this.jyzxbzh=jyzxbzh;
	}

	public String getJyzxbzh(){
		return jyzxbzh;
	}

	public void setJyrq(Timestamp jyrq){
		this.jyrq=jyrq;
	}

	public Timestamp getJyrq(){
		return jyrq;
	}

	public void setCpscjyjl(String cpscjyjl){
		this.cpscjyjl=cpscjyjl;
	}

	public String getCpscjyjl(){
		return cpscjyjl;
	}

	public String getScspjldw() {
		return scspjldw;
	}

	public void setScspjldw(String scspjldw) {
		this.scspjldw = scspjldw;
	}

	public BigDecimal getScsl() {
		return scsl;
	}

	public void setScsl(BigDecimal scsl) {
		this.scsl = scsl;
	}

	public BigDecimal getSysl() {
		return sysl;
	}

	public void setSysl(BigDecimal sysl) {
		this.sysl = sysl;
	}

	public String getHviewjgztid() {
		return hviewjgztid;
	}

	public void setHviewjgztid(String hviewjgztid) {
		this.hviewjgztid = hviewjgztid;
	}

	public String getAae011() {
		return aae011;
	}

	public void setAae011(String aae011) {
		this.aae011 = aae011;
	}

	public Timestamp getAae036() {
		return aae036;
	}

	public void setAae036(Timestamp aae036) {
		this.aae036 = aae036;
	}

}

