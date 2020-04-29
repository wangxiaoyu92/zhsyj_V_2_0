package com.askj.tmsyj.tmsyj.dto;

import java.math.BigDecimal;
import java.sql.Timestamp;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;

public class HscxhbDTO {
/** 生产企业销货表; InnoDB free: 53248 kB  */
	//扩展开始
	/** jxsmc 的中文含义是：经销商名称*/
	private String jxsmc;
	//开始操作时间
    private Timestamp aae036start;	
	//结束操作时间
    private Timestamp aae036end;
	//检测样品名称
    private String jcypmc;	
	//监管主体名称
    private String jgztmc;	
	/** scspjldw 的中文含义是：计量单位*/
	private String scspjldw;    
	/** sysl 的中文含义是：剩余数量*/
	private BigDecimal sysl;
	/** scspjldwmc 的中文含义是：计量单位名称*/
	private String scspjldwmc; 	
	
	//扩展结束
    
	/** hscxhbid 的中文含义是：生产销货表id*/
	private String hscxhbid;
	
	/** hviewjgztid 的中文含义是：监管主体表主键*/
	private String hviewjgztid;	

	/** hscpcbid 的中文含义是：生产批次表id*/
	private String hscpcbid;

	/** jcypid 的中文含义是：商品id*/
	private String jcypid;

	/** jxsid 的中文含义是：经销商id*/
	private String jxsid;

	/** xssj 的中文含义是：销售时间*/
	private Timestamp xssj;

	/** xssl 的中文含义是：销售数量*/
	private BigDecimal xssl;

	/** xhspjldw 的中文含义是：计量单位*/
	private String xhspjldw;

	/** aae011 的中文含义是：操作员*/
	private String aae011;

	/** aae036 的中文含义是：操作时间*/
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

	public String getJxsmc() {
		return jxsmc;
	}

	public void setJxsmc(String jxsmc) {
		this.jxsmc = jxsmc;
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

	public String getScspjldw() {
		return scspjldw;
	}

	public void setScspjldw(String scspjldw) {
		this.scspjldw = scspjldw;
	}

	public BigDecimal getSysl() {
		return sysl;
	}

	public void setSysl(BigDecimal sysl) {
		this.sysl = sysl;
	}

	public String getScspjldwmc() {
		return scspjldwmc;
	}

	public void setScspjldwmc(String scspjldwmc) {
		this.scspjldwmc = scspjldwmc;
	}

}

