package com.askj.tmsyj.tmsyj.dto;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class HxhbDTO {
/** 销货表; InnoDB free: 60416 kB  */
	//扩展开始
	//开始操作时间
    private Timestamp aae036start;	
	//结束操作时间
    private Timestamp aae036end;	
	//监管主体名称
    private String jgztmc;    
	//商品名称
    private String jcypmc; 
	//购货商名称
    private String ghsmc; 
	//购货商id
    private String ghsid;  
	//购货商进货确认标志
    private String ghsjhqrbz;     
    
    
	
    //进货表字段开始
	/** jhsjfxid 的中文含义是：上级分销id，根据这个号，能知道是有那条记录分销过来的*/
	private String jhsjfxid;
	/** jhkcl 的中文含义是：进货库存量*/
	private BigDecimal jhkcl;	
	/** jhspjldw 的中文含义是：进货计量单位aaa100=spjldw，首次进货记录有*/
	private String jhspjldw;
	/** jhprice 的中文含义是：单价*/
	private BigDecimal jhprice;
	/** jhscd 的中文含义是：生产地，首次进货记录有*/
	private String jhscd;
	/** jhscrq 的中文含义是：生产日期，首次进货记录有*/
	private Timestamp jhscrq;
	/** jhgysid 的中文含义是：供应商id，对应客户关系表主键，首次进货记录有*/
	private String jhgysid;
	/** jhgysmc 的中文含义是：进出货供应商名称*/
	private String jhgysmc;
	/** jhscsid 的中文含义是：生产商id，对应客户关系表主键，首次进货记录有*/
	private String jhscsid;
	/** jhscsmc 的中文含义是：进出货生产商名称*/
	private String jhscsmc;	
	/** jhsptm 的中文含义是：商品条码，首次进货记录有*/
	private String jhsptm;
	/** jhscpcm 的中文含义是：生产批次码，首次进货记录有*/
	private String jhscpcm;	
    //进货表字段结束
	//扩展结束
    
    
	
	/** hxhbid 的中文含义是：销货表id*/
	private String hxhbid;

	/** jcypid 的中文含义是：商品id*/
	private String jcypid;

	/** xhsl 的中文含义是：销货数量*/
	private BigDecimal xhsl;

	/** xhspjldw 的中文含义是：销货计量单位aaa100=spjldw，首次进货记录有*/
	private String xhspjldw;

	/** xhprice 的中文含义是：单价*/
	private BigDecimal xhprice;

	/** xhtotal 的中文含义是：合计*/
	private BigDecimal xhtotal;

	/** hviewjgztid 的中文含义是：监管主体表id*/
	private String hviewjgztid;

	/** hjhbid 的中文含义是：对应的进货表id*/
	private String hjhbid;

	/** hjhbidnew 的中文含义是：新生成的进货表id*/
	private String hjhbidnew;

	/** eptbh 的中文含义是：e票通编号*/
	private String eptbh;

	/** aae011 的中文含义是：操作员*/
	private String aae011;

	/** aae036 的中文含义是：操作时间*/
	private Timestamp aae036;


	public void setHxhbid(String hxhbid){
		this.hxhbid=hxhbid;
	}

	public String getHxhbid(){
		return hxhbid;
	}

	public void setJcypid(String jcypid){
		this.jcypid=jcypid;
	}

	public String getJcypid(){
		return jcypid;
	}

	public void setXhsl(BigDecimal xhsl){
		this.xhsl=xhsl;
	}

	public BigDecimal getXhsl(){
		return xhsl;
	}

	public void setXhspjldw(String xhspjldw){
		this.xhspjldw=xhspjldw;
	}

	public String getXhspjldw(){
		return xhspjldw;
	}

	public void setXhprice(BigDecimal xhprice){
		this.xhprice=xhprice;
	}

	public BigDecimal getXhprice(){
		return xhprice;
	}

	public void setXhtotal(BigDecimal xhtotal){
		this.xhtotal=xhtotal;
	}

	public BigDecimal getXhtotal(){
		return xhtotal;
	}

	public void setHviewjgztid(String hviewjgztid){
		this.hviewjgztid=hviewjgztid;
	}

	public String getHviewjgztid(){
		return hviewjgztid;
	}

	public void setHjhbid(String hjhbid){
		this.hjhbid=hjhbid;
	}

	public String getHjhbid(){
		return hjhbid;
	}

	public void setHjhbidnew(String hjhbidnew){
		this.hjhbidnew=hjhbidnew;
	}

	public String getHjhbidnew(){
		return hjhbidnew;
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

	public String getJgztmc() {
		return jgztmc;
	}

	public void setJgztmc(String jgztmc) {
		this.jgztmc = jgztmc;
	}

	public String getJcypmc() {
		return jcypmc;
	}

	public void setJcypmc(String jcypmc) {
		this.jcypmc = jcypmc;
	}

	public String getJhsjfxid() {
		return jhsjfxid;
	}

	public void setJhsjfxid(String jhsjfxid) {
		this.jhsjfxid = jhsjfxid;
	}

	public BigDecimal getJhkcl() {
		return jhkcl;
	}

	public void setJhkcl(BigDecimal jhkcl) {
		this.jhkcl = jhkcl;
	}

	public String getJhspjldw() {
		return jhspjldw;
	}

	public void setJhspjldw(String jhspjldw) {
		this.jhspjldw = jhspjldw;
	}

	public BigDecimal getJhprice() {
		return jhprice;
	}

	public void setJhprice(BigDecimal jhprice) {
		this.jhprice = jhprice;
	}

	public String getJhscd() {
		return jhscd;
	}

	public void setJhscd(String jhscd) {
		this.jhscd = jhscd;
	}

	public Timestamp getJhscrq() {
		return jhscrq;
	}

	public void setJhscrq(Timestamp jhscrq) {
		this.jhscrq = jhscrq;
	}

	public String getJhgysid() {
		return jhgysid;
	}

	public void setJhgysid(String jhgysid) {
		this.jhgysid = jhgysid;
	}

	public String getJhgysmc() {
		return jhgysmc;
	}

	public void setJhgysmc(String jhgysmc) {
		this.jhgysmc = jhgysmc;
	}

	public String getJhscsid() {
		return jhscsid;
	}

	public void setJhscsid(String jhscsid) {
		this.jhscsid = jhscsid;
	}

	public String getJhscsmc() {
		return jhscsmc;
	}

	public void setJhscsmc(String jhscsmc) {
		this.jhscsmc = jhscsmc;
	}

	public String getJhsptm() {
		return jhsptm;
	}

	public void setJhsptm(String jhsptm) {
		this.jhsptm = jhsptm;
	}

	public String getJhscpcm() {
		return jhscpcm;
	}

	public void setJhscpcm(String jhscpcm) {
		this.jhscpcm = jhscpcm;
	}

	public String getGhsmc() {
		return ghsmc;
	}

	public void setGhsmc(String ghsmc) {
		this.ghsmc = ghsmc;
	}

	public String getGhsid() {
		return ghsid;
	}

	public void setGhsid(String ghsid) {
		this.ghsid = ghsid;
	}

	public String getGhsjhqrbz() {
		return ghsjhqrbz;
	}

	public void setGhsjhqrbz(String ghsjhqrbz) {
		this.ghsjhqrbz = ghsjhqrbz;
	}


	
	

}

