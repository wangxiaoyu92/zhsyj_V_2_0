package com.askj.tmsyj.tmsyj.dto;

import java.math.BigDecimal;
import java.sql.Timestamp;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;

public class HscpcbDTO {
/** 生产企业生产批次表; InnoDB free: 53248 kB  */
	//扩展开始
	/** jgztzzzmbh 的中文含义是：资质证明编号   生产许可证编号*/
	private String jgztzzzmbh;
	//进出库合格证明照路径
    private String jchhgzmpath;
	//进出库合格证明照名称
    private String jchhgzmname;		
	//开始操作时间
    private Timestamp aae036start;	
	//结束操作时间
    private Timestamp aae036end;
	//检测样品名称
    private String jcypmc;	
	//监管主体名称
    private String jgztmc;		
	//计量单位名称
    private String scspjldwmc;	    
    
	//扩展结束
	
	/** hscpcbid 的中文含义是：生产批次表id*/
	private String hscpcbid;
	
	/** hviewjgztid 的中文含义是：监管主体表主键*/
	private String hviewjgztid;	

	/** jcypid 的中文含义是：产品id*/
	private String jcypid;

	/** scpch 的中文含义是：生产批次号*/
	private String scpch;

	/** sptm 的中文含义是：商品条码*/
	private String sptm;

	/** scrq 的中文含义是：生产日期*/
	private Timestamp scrq;

	/** bzrq 的中文含义是：保质日期*/
	private Timestamp bzrq;

	/** spjybgbh 的中文含义是：产品检验报告编号*/
	private String spjybgbh;

	/** jyzxbzh 的中文含义是：检验执行标准号*/
	private String jyzxbzh;

	/** jyrq 的中文含义是：检验日期*/
	private Timestamp jyrq;

	/** cpscjyjl 的中文含义是：产品生产检验结论aaa100=cpscjyjl*/
	private String cpscjyjl;

	/** scsl 的中文含义是：生产数量*/
	private BigDecimal scsl;

	/** sysl 的中文含义是：剩余数量*/
	private BigDecimal sysl;

	/** scspjldw 的中文含义是：计量单位*/
	private String scspjldw;
	/** aae011 的中文含义是：操作员*/
	private String aae011;

	/** aae036 的中文含义是：操作时间*/
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

	public void setScsl(BigDecimal scsl){
		this.scsl=scsl;
	}

	public BigDecimal getScsl(){
		return scsl;
	}

	public void setSysl(BigDecimal sysl){
		this.sysl=sysl;
	}

	public BigDecimal getSysl(){
		return sysl;
	}

	public String getScspjldw() {
		return scspjldw;
	}

	public void setScspjldw(String scspjldw) {
		this.scspjldw = scspjldw;
	}

	public String getHviewjgztid() {
		return hviewjgztid;
	}

	public void setHviewjgztid(String hviewjgztid) {
		this.hviewjgztid = hviewjgztid;
	}

	public String getJgztzzzmbh() {
		return jgztzzzmbh;
	}

	public void setJgztzzzmbh(String jgztzzzmbh) {
		this.jgztzzzmbh = jgztzzzmbh;
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

	public String getJchhgzmpath() {
		return jchhgzmpath;
	}

	public void setJchhgzmpath(String jchhgzmpath) {
		this.jchhgzmpath = jchhgzmpath;
	}

	public String getJchhgzmname() {
		return jchhgzmname;
	}

	public void setJchhgzmname(String jchhgzmname) {
		this.jchhgzmname = jchhgzmname;
	}

	public Timestamp getAae036start() {
		return aae036start;
	}

	public void setAae036start(Timestamp aae036start) {
		this.aae036start = aae036start;
	}

	public Timestamp getAae036end() {
		return aae036end;
	}

	public void setAae036end(Timestamp aae036end) {
		this.aae036end = aae036end;
	}

	public String getJcypmc() {
		return jcypmc;
	}

	public void setJcypmc(String jcypmc) {
		this.jcypmc = jcypmc;
	}

	public String getJgztmc() {
		return jgztmc;
	}

	public void setJgztmc(String jgztmc) {
		this.jgztmc = jgztmc;
	}

	public String getScspjldwmc() {
		return scspjldwmc;
	}

	public void setScspjldwmc(String scspjldwmc) {
		this.scspjldwmc = scspjldwmc;
	}

}

