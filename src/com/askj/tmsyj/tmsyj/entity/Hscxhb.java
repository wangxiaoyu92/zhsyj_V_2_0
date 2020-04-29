package com.askj.tmsyj.tmsyj.entity;

import java.math.BigDecimal;
import java.sql.Timestamp;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

@Table(value = "Hscxhb")
public class Hscxhb {
/** 生产企业销货表; InnoDB free: 53248 kB  */
	/** hscxhbid 的中文含义是：生产销货表id*/
	@Name
	@Column
	private String hscxhbid;
	
	/** hviewjgztid 的中文含义是：监管主体表主键*/
	@Column
	private String hviewjgztid;	

	/** hscpcbid 的中文含义是：生产批次表id*/
	@Column
	private String hscpcbid;

	/** jcypid 的中文含义是：商品id*/
	@Column
	private String jcypid;

	/** jxsid 的中文含义是：经销商id*/
	@Column
	private String jxsid;

	/** xssj 的中文含义是：销售时间*/
	@Column
	private Timestamp xssj;

	/** xssl 的中文含义是：销售数量*/
	@Column
	private BigDecimal xssl;

	/** xhspjldw 的中文含义是：计量单位*/
	@Column
	private String xhspjldw;

	/** aae011 的中文含义是：操作员*/
	@Column
	private String aae011;

	/** aae036 的中文含义是：操作时间*/
	@Column
	private Timestamp aae036;
	
	public void setHscxhbid(String hscxhbid){
		this.hscxhbid=hscxhbid;
	}

	public String getHscxhbid(){
		return hscxhbid;
	}

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

	public void setJxsid(String jxsid){
		this.jxsid=jxsid;
	}

	public String getJxsid(){
		return jxsid;
	}

	public void setXssj(Timestamp xssj){
		this.xssj=xssj;
	}

	public Timestamp getXssj(){
		return xssj;
	}

	public void setXssl(BigDecimal xssl){
		this.xssl=xssl;
	}

	public BigDecimal getXssl(){
		return xssl;
	}



	public String getXhspjldw() {
		return xhspjldw;
	}

	public void setXhspjldw(String xhspjldw) {
		this.xhspjldw = xhspjldw;
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

