package com.askj.tmsyj.tmsyj.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "Hjgztxgpic")
public class Hjgztxgpic {
/** 监管主体相关图片上传; InnoDB free: 6144 kB  */
	/** hjgztxgpicid 的中文含义是：监管主体相关图片上传id*/
	@Name
	@Column
	private String hjgztxgpicid;

	/** hviewjgztid 的中文含义是：监管主体id*/
	@Column
	private String hviewjgztid;

	/** jgztpickind 的中文含义是：图片类别1自查表图片2检验检测报告图片AAA100=JGZTPICKIND*/
	@Column
	private String jgztpickind;

	/** zcry 的中文含义是：自查人员或检测员*/
	@Column
	private String zcry;

	/** jcdw 的中文含义是：检测单位*/
	@Column
	private String jcdw;
	
	/** zcsj 的中文含义是：自查时间*/
	@Column
	private String zcsj;	

	/** aae011 的中文含义是：操作员*/
	@Column
	private String aae011;

	/** aae036 的中文含义是：操作时间*/
	@Column
	private Timestamp aae036;

	/** lxdh 的中文含义是：联系电话*/
	@Column
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

}

