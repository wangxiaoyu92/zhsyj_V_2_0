package com.askj.tmsyj.tmsyj.entity;

import java.math.BigDecimal;
import java.sql.Timestamp;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

@Table(value = "Hjhb")
public class Hjhb {
/** 进货表; InnoDB free: 60416 kB  */
	/** hjhbid 的中文含义是：进货表id*/
	@Name
	@Column
	private String hjhbid;

	/** jcypid 的中文含义是：商品id*/
	@Column
	private String jcypid;

	/** jhsl 的中文含义是：进货数量*/
	@Column
	private BigDecimal jhsl;

	/** jhspjldw 的中文含义是：进货计量单位aaa100=spjldw，首次进货记录有*/
	@Column
	private String jhspjldw;

	/** jhscd 的中文含义是：生产地，首次进货记录有*/
	@Column
	private String jhscd;

	/** jhsjfxid 的中文含义是：上级分销id，根据这个号，能知道是有那条记录分销过来的*/
	@Column
	private String jhsjfxid;

	/** jcfs 的中文含义是：检测方式1自检2上游流转，首次进货记录有*/
	@Column
	private String jcfs;

	/** jhprice 的中文含义是：单价*/
	@Column
	private BigDecimal jhprice;

	/** jhtotal 的中文含义是：合计*/
	@Column
	private BigDecimal jhtotal;

	/** jhscrq 的中文含义是：生产日期，首次进货记录有*/
	@Column
	private Timestamp jhscrq;

	/** jhscpcm 的中文含义是：生产批次码，首次进货记录有*/
	@Column
	private String jhscpcm;

	/** jhhgzmlx 的中文含义是：合格证明类型aaa100=jchhgzmlx，首次进货记录有*/
	@Column
	private String jhhgzmlx;

	/** jhscjyjl 的中文含义是：生产检验结论aaa100=jchscjyjl，首次进货记录有*/
	@Column
	private String jhscjyjl;

	/** jhqycyjl 的中文含义是：企业查验结论aaa100=jchqycyjl，首次进货记录有*/
	@Column
	private String jhqycyjl;

	/** jhgysid 的中文含义是：供应商id，对应客户关系表主键，首次进货记录有*/
	@Column
	private String jhgysid;

	/** jhscsid 的中文含义是：生产商id，对应客户关系表主键，首次进货记录有*/
	@Column
	private String jhscsid;

	/** jhsptm 的中文含义是：商品条码，首次进货记录有*/
	@Column
	private String jhsptm;

	/** hviewjgztid 的中文含义是：监管主体表id*/
	@Column
	private String hviewjgztid;

	/** eptbh 的中文含义是：e票通编号，根据这个号能拉取所有的本次进货的分销信息*/
	@Column
	private String eptbh;

	/** aae011 的中文含义是：操作员*/
	@Column
	private String aae011;

	/** aae036 的中文含义是：操作时间*/
	@Column
	private Timestamp aae036;

	/** jhkcl 的中文含义是：进货库存量*/
	@Column
	private BigDecimal jhkcl;
	
	/** jhqrbz 的中文含义是：进货确认标志0未1已*/
	@Column
	private String jhqrbz;	
	
	/** jhsjfxsztid 的中文含义是：上级分销商主体id*/
	@Column
	private String jhsjfxsztid;	
	
	/** jhpch 的中文含义是：jhpch 进货批次号*/
	@Column
	private String jhplh;			
	

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

	public String getJhqrbz() {
		return jhqrbz;
	}

	public void setJhqrbz(String jhqrbz) {
		this.jhqrbz = jhqrbz;
	}

	public String getJhsjfxsztid() {
		return jhsjfxsztid;
	}

	public void setJhsjfxsztid(String jhsjfxsztid) {
		this.jhsjfxsztid = jhsjfxsztid;
	}

	public String getJhplh() {
		return jhplh;
	}

	public void setJhplh(String jhplh) {
		this.jhplh = jhplh;
	}



}

