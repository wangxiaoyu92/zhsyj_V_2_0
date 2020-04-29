package com.askj.tmsyj.tmsyj.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class HjdjccybgDTO {
/** 监督检查抽样报告; InnoDB free: 51200 kB  */
	//扩展开始
	//开始操作时间
    private Timestamp aae036start;	
	//结束操作时间
    private Timestamp aae036end;
	//检测样品名称
    private String jcypmc;	
	//监管主体名称
    private String jgztmc;	 
	//抽样报告图片上传标志
    private String cybgtpscbz;     
    
	//扩展结束
    
    
	/** hjdjccybgid 的中文含义是：监督检查抽样报告id*/
	private String hjdjccybgid;

	/** hviewjgztid 的中文含义是：监管主体表主键*/
	private String hviewjgztid;

	/** jcypid 的中文含义是：商品ID*/
	private String jcypid;

	/** rwly 的中文含义是：任务来源*/
	private String rwly;

	/** jdcysj 的中文含义是：监督抽样时间*/
	private Timestamp jdcysj;

	/** cyr 的中文含义是：抽样人*/
	private String cyr;

	/** cydw 的中文含义是：抽样单位*/
	private String cydw;

	/** aae011 的中文含义是：操作员*/
	private String aae011;

	/** aae036 的中文含义是：操作时间*/
	private Timestamp aae036;


	public void setHjdjccybgid(String hjdjccybgid){
		this.hjdjccybgid=hjdjccybgid;
	}

	public String getHjdjccybgid(){
		return hjdjccybgid;
	}

	public void setHviewjgztid(String hviewjgztid){
		this.hviewjgztid=hviewjgztid;
	}

	public String getHviewjgztid(){
		return hviewjgztid;
	}

	public void setJcypid(String jcypid){
		this.jcypid=jcypid;
	}

	public String getJcypid(){
		return jcypid;
	}

	public void setRwly(String rwly){
		this.rwly=rwly;
	}

	public String getRwly(){
		return rwly;
	}

	public Timestamp getJdcysj() {
		return jdcysj;
	}

	public void setJdcysj(Timestamp jdcysj) {
		this.jdcysj = jdcysj;
	}

	public void setCyr(String cyr){
		this.cyr=cyr;
	}

	public String getCyr(){
		return cyr;
	}

	public void setCydw(String cydw){
		this.cydw=cydw;
	}

	public String getCydw(){
		return cydw;
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

	public String getCybgtpscbz() {
		return cybgtpscbz;
	}

	public void setCybgtpscbz(String cybgtpscbz) {
		this.cybgtpscbz = cybgtpscbz;
	}
	
	

}

