package com.askj.tmsyj.tmsyj.entity;

import java.math.BigDecimal;
import java.sql.Timestamp;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

@Table(value = "Hxhb")
public class Hxhb {
/** 销货表; InnoDB free: 60416 kB  */
	/** hxhbid 的中文含义是：销货表id*/
	@Name
	@Column
	private String hxhbid;

	/** jcypid 的中文含义是：商品id*/
	@Column
	private String jcypid;

	/** xhsl 的中文含义是：销货数量*/
	@Column
	private BigDecimal xhsl;

	/** xhspjldw 的中文含义是：销货计量单位aaa100=spjldw，首次进货记录有*/
	@Column
	private String xhspjldw;

	/** xhprice 的中文含义是：单价*/
	@Column
	private BigDecimal xhprice;

	/** xhtotal 的中文含义是：合计*/
	@Column
	private BigDecimal xhtotal;

	/** hviewjgztid 的中文含义是：监管主体表id*/
	@Column
	private String hviewjgztid;

	/** hjhbid 的中文含义是：对应的进货表id*/
	@Column
	private String hjhbid;

	/** hjhbidnew 的中文含义是：新生成的进货表id*/
	@Column
	private String hjhbidnew;

	/** eptbh 的中文含义是：e票通编号*/
	@Column
	private String eptbh;

	/** aae011 的中文含义是：操作员*/
	@Column
	private String aae011;

	/** aae036 的中文含义是：操作时间*/
	@Column
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

}

