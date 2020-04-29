package com.askj.tmsyj.tmsyj.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class HjgztxgpicDTO {
	//扩展开始
	/** uploadflag 的中文含义是：上传标志0未上传1已上传*/
	private String uploadflag;
	//开始操作时间
    private String aae036start;	
	//结束操作时间
    private String aae036end;	
	//附件路径
    private String fjpath;
    
	//扩展结束
/** 监管主体相关图片上传; InnoDB free: 6144 kB  */
	/** hjgztxgpicid 的中文含义是：监管主体相关图片上传id*/
	private String hjgztxgpicid;

	/** hviewjgztid 的中文含义是：监管主体id*/
	private String hviewjgztid;

	/** jgztpickind 的中文含义是：图片类别1自查表图片2检验检测报告图片AAA100=JGZTPICKIND*/
	private String jgztpickind;

	/** zcry 的中文含义是：自查人员或检测员*/
	private String zcry;

	/** jcdw 的中文含义是：检测单位*/
	private String jcdw;
	
	/** zcsj 的中文含义是：自查时间*/
	private String zcsj;	

	/** aae011 的中文含义是：操作员*/
	private String aae011;

	/** aae036 的中文含义是：操作时间*/
	private Timestamp aae036;

	/** lxdh 的中文含义是：联系电话*/
	private String lxdh;	
	

	public void setHjgztxgpicid(String hjgztxgpicid){
		this.hjgztxgpicid=hjgztxgpicid;
	}

	public String getHjgztxgpicid(){
		return hjgztxgpicid;
	}

	public void setHviewjgztid(String hviewjgztid){
		this.hviewjgztid=hviewjgztid;
	}

	public String getHviewjgztid(){
		return hviewjgztid;
	}

	public void setJgztpickind(String jgztpickind){
		this.jgztpickind=jgztpickind;
	}

	public String getJgztpickind(){
		return jgztpickind;
	}

	public void setZcry(String zcry){
		this.zcry=zcry;
	}

	public String getZcry(){
		return zcry;
	}

	public void setJcdw(String jcdw){
		this.jcdw=jcdw;
	}

	public String getJcdw(){
		return jcdw;
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

	public String getLxdh() {
		return lxdh;
	}

	public void setLxdh(String lxdh) {
		this.lxdh = lxdh;
	}

	public String getZcsj() {
		return zcsj;
	}

	public void setZcsj(String zcsj) {
		this.zcsj = zcsj;
	}

	public String getUploadflag() {
		return uploadflag;
	}

	public void setUploadflag(String uploadflag) {
		this.uploadflag = uploadflag;
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

	public String getFjpath() {
		return fjpath;
	}

	public void setFjpath(String fjpath) {
		this.fjpath = fjpath;
	}
	
	
}

