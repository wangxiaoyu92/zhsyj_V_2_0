package com.askj.tmsyj.tmsyj.dto;

import java.math.BigDecimal;
import java.sql.Timestamp;

import org.nutz.dao.entity.annotation.Column;

public class HjhbDTO {
/** 进货表; InnoDB free: 60416 kB  */
	//扩展开始
	/** jhgysmc 的中文含义是：进出货供应商名称*/
	private String jhgysmc;
	/** jhscsmc 的中文含义是：进出货生产商名称*/
	private String jhscsmc;	
	/** jhspjldwmc 的中文含义是：进货计量单位名称*/
	private String jhspjldwmc;
	/** jhhgzmlxmc 的中文含义是：进货合格证明类型名称*/
	private String jhhgzmlxmc;
	/** jhscjyjlmc 的中文含义是：生产检验结论名称*/
	private String jhscjyjlmc;
	/** jhqycyjlmc 的中文含义是：企业查验结论名称*/
	private String jhqycyjlmc;
	//企业索证索票图片路径
    private String szsppath;
	//企业索证索票图片名称
    private String szspname;
	//企业检测图片路径
    private String jchhgzmpath;
	//企业检测图片名称
    private String jchhgzmname;	
	//开始操作时间
    private String aae036start;	
	//结束操作时间
    private String aae036end;
	//检测样品名称
    private String jcypmc;	
	//监管主体名称
    private String jgztmc;	 
	//进货检测情况
    private String jhjcqk;   
	//进货索证索票标志
    private String jhszspbz;     
    
	/** jcypsspp 的中文含义是：所属品牌*/
	private String jcypsspp;

	/** impcpgg 的中文含义是：规格*/
	private String impcpgg;

	/** spsb 的中文含义是：商品商标*/
	private String spsb;

	/** spggxh 的中文含义是：商品规格型号*/
	private String spggxh;

	/** spzxbzh 的中文含义是：商品执行标准号*/
	private String spzxbzh;

	/** spbzq 的中文含义是：商品保质期*/
	private String spbzq;
	/** jcypgl 的中文含义是：商品类别*/
	private String jcypgl;
	/** querymaxjhjl 的中文含义是：是否是根据样品id查询最大的进货记录 0或空不是 1是*/
	private String querymaxjhjl;
	/** querybatchjinhuo 的中文含义是：是否是 批量进货新增 0或空不是 1是*/
	private String querybatchjinhuo;	
	/** querybatchhisdays 的中文含义是：是否是 如果是批量进货查询 查前几天的进货记录*/
	private String querybatchhisdays;	
	/** batchjinhuoinsertrows 的中文含义是：批量进货插入记录*/
	private String batchjinhuoinsertrows;	
	/** batchjinhuoupdaterows 的中文含义是：批量进货更新记录*/
	private String batchjinhuoupdaterows;	
	
	/** btnxzsp 的中文含义是：选择商品按钮*/
	private String btnxzsp;
	/** batchjinhuoupdaterows 的中文含义是：选择供应商按钮*/
	private String btnxzgys;
	/** btnxzscs 的中文含义是：选择生产商按钮*/
	private String btnxzscs;
	/** jhpch 的中文含义是：jhpch 进货批次号*/
	private String jhplh;
	/** jhjldwmc 的中文含义是：进货计量单位名称*/
	private String jhjldwmc;
	//追溯url
	private String trace;
	//扩展结束


	public String getTrace() {
		return trace;
	}

	public void setTrace(String trace) {
		this.trace = trace;
	}

	/** hjhbid 的中文含义是：进货表id*/
	private String hjhbid;

	/** jcypid 的中文含义是：商品id*/
	private String jcypid;

	/** jhsl 的中文含义是：进货数量*/
	private BigDecimal jhsl;

	/** jhspjldw 的中文含义是：进货计量单位aaa100=spjldw，首次进货记录有*/
	private String jhspjldw;

	/** jhscd 的中文含义是：生产地，首次进货记录有*/
	private String jhscd;

	/** jhsjfxid 的中文含义是：上级分销id，根据这个号，能知道是有那条记录分销过来的*/
	private String jhsjfxid;
	

	/** jcfs 的中文含义是：检测方式1自检2上游流转，首次进货记录有*/
	private String jcfs;

	/** jhprice 的中文含义是：单价*/
	private BigDecimal jhprice;

	/** jhtotal 的中文含义是：合计*/
	private BigDecimal jhtotal;

	/** jhscrq 的中文含义是：生产日期，首次进货记录有*/
	private Timestamp jhscrq;

	/** jhscpcm 的中文含义是：生产批次码，首次进货记录有*/
	private String jhscpcm;

	/** jhhgzmlx 的中文含义是：合格证明类型aaa100=jchhgzmlx，首次进货记录有*/
	private String jhhgzmlx;

	/** jhscjyjl 的中文含义是：生产检验结论aaa100=jchscjyjl，首次进货记录有*/
	private String jhscjyjl;

	/** jhqycyjl 的中文含义是：企业查验结论aaa100=jchqycyjl，首次进货记录有*/
	private String jhqycyjl;

	/** jhgysid 的中文含义是：供应商id，对应客户关系表主键，首次进货记录有*/
	private String jhgysid;

	/** jhscsid 的中文含义是：生产商id，对应客户关系表主键，首次进货记录有*/
	private String jhscsid;

	/** jhsptm 的中文含义是：商品条码，首次进货记录有*/
	private String jhsptm;

	/** hviewjgztid 的中文含义是：监管主体表id*/
	private String hviewjgztid;

	/** eptbh 的中文含义是：e票通编号，根据这个号能拉取所有的本次进货的分销信息*/
	private String eptbh;

	/** aae011 的中文含义是：操作员*/
	private String aae011;

	/** aae036 的中文含义是：操作时间*/
	private Timestamp aae036;

	/** jhkcl 的中文含义是：进货库存量*/
	private BigDecimal jhkcl;
	/** jhqrbz 的中文含义是：进货确认标志0未1已*/
	private String jhqrbz;	
	
	/** jhsjfxsztid 的中文含义是：上级分销商主体id*/
	private String jhsjfxsztid;	
	
	/** jhpch 的中文含义是：进货批次号*/
	private String jhpch;			

	public void setHjhbid(String hjhbid){
		this.hjhbid=hjhbid;
	}

	public String getHjhbid(){
		return hjhbid;
	}

	public void setJcypid(String jcypid){
		this.jcypid=jcypid;
	}

	public String getJcypid(){
		return jcypid;
	}

	public void setJhsl(BigDecimal jhsl){
		this.jhsl=jhsl;
	}

	public BigDecimal getJhsl(){
		return jhsl;
	}

	public void setJhspjldw(String jhspjldw){
		this.jhspjldw=jhspjldw;
	}

	public String getJhspjldw(){
		return jhspjldw;
	}

	public void setJhscd(String jhscd){
		this.jhscd=jhscd;
	}

	public String getJhscd(){
		return jhscd;
	}

	public void setJhsjfxid(String jhsjfxid){
		this.jhsjfxid=jhsjfxid;
	}

	public String getJhsjfxid(){
		return jhsjfxid;
	}

	public void setJcfs(String jcfs){
		this.jcfs=jcfs;
	}

	public String getJcfs(){
		return jcfs;
	}

	public void setJhprice(BigDecimal jhprice){
		this.jhprice=jhprice;
	}

	public BigDecimal getJhprice(){
		return jhprice;
	}

	public void setJhtotal(BigDecimal jhtotal){
		this.jhtotal=jhtotal;
	}

	public BigDecimal getJhtotal(){
		return jhtotal;
	}

	public void setJhscrq(Timestamp jhscrq){
		this.jhscrq=jhscrq;
	}

	public Timestamp getJhscrq(){
		return jhscrq;
	}

	public void setJhscpcm(String jhscpcm){
		this.jhscpcm=jhscpcm;
	}

	public String getJhscpcm(){
		return jhscpcm;
	}

	public void setJhhgzmlx(String jhhgzmlx){
		this.jhhgzmlx=jhhgzmlx;
	}

	public String getJhhgzmlx(){
		return jhhgzmlx;
	}

	public void setJhscjyjl(String jhscjyjl){
		this.jhscjyjl=jhscjyjl;
	}

	public String getJhscjyjl(){
		return jhscjyjl;
	}

	public void setJhqycyjl(String jhqycyjl){
		this.jhqycyjl=jhqycyjl;
	}

	public String getJhqycyjl(){
		return jhqycyjl;
	}

	public void setJhgysid(String jhgysid){
		this.jhgysid=jhgysid;
	}

	public String getJhgysid(){
		return jhgysid;
	}

	public void setJhscsid(String jhscsid){
		this.jhscsid=jhscsid;
	}

	public String getJhscsid(){
		return jhscsid;
	}

	public void setJhsptm(String jhsptm){
		this.jhsptm=jhsptm;
	}

	public String getJhsptm(){
		return jhsptm;
	}

	public void setHviewjgztid(String hviewjgztid){
		this.hviewjgztid=hviewjgztid;
	}

	public String getHviewjgztid(){
		return hviewjgztid;
	}

	public void setEptbh(String eptbh){
		this.eptbh=eptbh;
	}

	public String getEptbh(){
		return eptbh;
	}

	public void setAae011(String aae011){
		this.aae011=aae011;
	}

	public String getAae011(){
		return aae011;
	}

	public void setAae036(Timestamp aae036){
		this.aae036=aae036;
	}

	public Timestamp getAae036(){
		return aae036;
	}

	public void setJhkcl(BigDecimal jhkcl){
		this.jhkcl=jhkcl;
	}

	public BigDecimal getJhkcl(){
		return jhkcl;
	}

	public String getJhgysmc() {
		return jhgysmc;
	}

	public void setJhgysmc(String jhgysmc) {
		this.jhgysmc = jhgysmc;
	}

	public String getJhscsmc() {
		return jhscsmc;
	}

	public void setJhscsmc(String jhscsmc) {
		this.jhscsmc = jhscsmc;
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



	public String getAae036start() {
		return aae036start;
	}

	public void setAae036start(String aae036start) {
		this.aae036start = aae036start;
	}

	public String getAae036end() {
		return aae036end;
	}

	public void setAae036end(String aae036end) {
		this.aae036end = aae036end;
	}

	public String getJcypmc() {
		return jcypmc;
	}

	public void setJcypmc(String jcypmc) {
		this.jcypmc = jcypmc;
	}

	public String getJhqrbz() {
		return jhqrbz;
	}

	public void setJhqrbz(String jhqrbz) {
		this.jhqrbz = jhqrbz;
	}

	public String getJgztmc() {
		return jgztmc;
	}

	public void setJgztmc(String jgztmc) {
		this.jgztmc = jgztmc;
	}

	public String getJhsjfxsztid() {
		return jhsjfxsztid;
	}

	public void setJhsjfxsztid(String jhsjfxsztid) {
		this.jhsjfxsztid = jhsjfxsztid;
	}

	public String getJhjcqk() {
		return jhjcqk;
	}

	public void setJhjcqk(String jhjcqk) {
		this.jhjcqk = jhjcqk;
	}

	public String getJhszspbz() {
		return jhszspbz;
	}

	public void setJhszspbz(String jhszspbz) {
		this.jhszspbz = jhszspbz;
	}

	public String getJcypsspp() {
		return jcypsspp;
	}

	public void setJcypsspp(String jcypsspp) {
		this.jcypsspp = jcypsspp;
	}

	public String getImpcpgg() {
		return impcpgg;
	}

	public void setImpcpgg(String impcpgg) {
		this.impcpgg = impcpgg;
	}

	public String getSpsb() {
		return spsb;
	}

	public void setSpsb(String spsb) {
		this.spsb = spsb;
	}

	public String getSpggxh() {
		return spggxh;
	}

	public void setSpggxh(String spggxh) {
		this.spggxh = spggxh;
	}

	public String getSpzxbzh() {
		return spzxbzh;
	}

	public void setSpzxbzh(String spzxbzh) {
		this.spzxbzh = spzxbzh;
	}

	public String getSpbzq() {
		return spbzq;
	}

	public void setSpbzq(String spbzq) {
		this.spbzq = spbzq;
	}

	public String getJcypgl() {
		return jcypgl;
	}

	public void setJcypgl(String jcypgl) {
		this.jcypgl = jcypgl;
	}

	public String getJhspjldwmc() {
		return jhspjldwmc;
	}

	public void setJhspjldwmc(String jhspjldwmc) {
		this.jhspjldwmc = jhspjldwmc;
	}

	public String getJhhgzmlxmc() {
		return jhhgzmlxmc;
	}

	public void setJhhgzmlxmc(String jhhgzmlxmc) {
		this.jhhgzmlxmc = jhhgzmlxmc;
	}

	public String getJhscjyjlmc() {
		return jhscjyjlmc;
	}

	public void setJhscjyjlmc(String jhscjyjlmc) {
		this.jhscjyjlmc = jhscjyjlmc;
	}

	public String getSzsppath() {
		return szsppath;
	}

	public void setSzsppath(String szsppath) {
		this.szsppath = szsppath;
	}

	public String getSzspname() {
		return szspname;
	}

	public void setSzspname(String szspname) {
		this.szspname = szspname;
	}

	public String getJhqycyjlmc() {
		return jhqycyjlmc;
	}

	public void setJhqycyjlmc(String jhqycyjlmc) {
		this.jhqycyjlmc = jhqycyjlmc;
	}

	public String getQuerymaxjhjl() {
		return querymaxjhjl;
	}

	public void setQuerymaxjhjl(String querymaxjhjl) {
		this.querymaxjhjl = querymaxjhjl;
	}

	public String getJhpch() {
		return jhpch;
	}

	public void setJhpch(String jhpch) {
		this.jhpch = jhpch;
	}

	public String getQuerybatchjinhuo() {
		return querybatchjinhuo;
	}

	public void setQuerybatchjinhuo(String querybatchjinhuo) {
		this.querybatchjinhuo = querybatchjinhuo;
	}

	public String getQuerybatchhisdays() {
		return querybatchhisdays;
	}

	public void setQuerybatchhisdays(String querybatchhisdays) {
		this.querybatchhisdays = querybatchhisdays;
	}

	public String getBatchjinhuoinsertrows() {
		return batchjinhuoinsertrows;
	}

	public void setBatchjinhuoinsertrows(String batchjinhuoinsertrows) {
		this.batchjinhuoinsertrows = batchjinhuoinsertrows;
	}

	public String getBatchjinhuoupdaterows() {
		return batchjinhuoupdaterows;
	}

	public void setBatchjinhuoupdaterows(String batchjinhuoupdaterows) {
		this.batchjinhuoupdaterows = batchjinhuoupdaterows;
	}

	public String getBtnxzsp() {
		return btnxzsp;
	}

	public void setBtnxzsp(String btnxzsp) {
		this.btnxzsp = btnxzsp;
	}

	public String getBtnxzgys() {
		return btnxzgys;
	}

	public void setBtnxzgys(String btnxzgys) {
		this.btnxzgys = btnxzgys;
	}

	public String getBtnxzscs() {
		return btnxzscs;
	}

	public void setBtnxzscs(String btnxzscs) {
		this.btnxzscs = btnxzscs;
	}

	public String getJhplh() {
		return jhplh;
	}

	public void setJhplh(String jhplh) {
		this.jhplh = jhplh;
	}

	public String getJhjldwmc() {
		return jhjldwmc;
	}

	public void setJhjldwmc(String jhjldwmc) {
		this.jhjldwmc = jhjldwmc;
	}
}

