package com.askj.baseinfo.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "Pgzpj")
public class Pgzpj {
/** 公众评价表  */
	/** pgzpjid 的中文含义是：公众评价表id*/
	@Name
	@Column
	private String pgzpjid;

	/** pjztid 的中文含义是：评价主体id*/
	@Column
	private String pjztid;

	/** pjztmc 的中文含义是：评价主体名称*/
	@Column
	private String pjztmc;

	/** pjr 的中文含义是：评价人*/
	@Column
	private String pjr;

	/** pjsj 的中文含义是：评价时间*/
	@Column
	private Timestamp pjsj;

	/** pjbt 的中文含义是：评价标题*/
	@Column
	private String pjbt;

	/** pjnr 的中文含义是：评价内容*/
	@Column
	private String pjnr;

	/** pjdj 的中文含义是：评价等级aaa100=pjdj*/
	@Column
	private String pjdj;

	/** pjrmobile 的中文含义是：评价人手机号*/
	@Column
	private String pjrmobile;

	/** hfdpjid 的中文含义是：回复的评价id*/
	@Column
	private String hfdpjid;


	public void setPgzpjid(String pgzpjid){
		this.pgzpjid=pgzpjid;
	}

	public String getPgzpjid(){
		return pgzpjid;
	}

	public void setPjztid(String pjztid){
		this.pjztid=pjztid;
	}

	public String getPjztid(){
		return pjztid;
	}

	public void setPjztmc(String pjztmc){
		this.pjztmc=pjztmc;
	}

	public String getPjztmc(){
		return pjztmc;
	}

	public void setPjr(String pjr){
		this.pjr=pjr;
	}

	public String getPjr(){
		return pjr;
	}

	public void setPjsj(Timestamp pjsj){
		this.pjsj=pjsj;
	}

	public Timestamp getPjsj(){
		return pjsj;
	}

	public void setPjbt(String pjbt){
		this.pjbt=pjbt;
	}

	public String getPjbt(){
		return pjbt;
	}

	public void setPjnr(String pjnr){
		this.pjnr=pjnr;
	}

	public String getPjnr(){
		return pjnr;
	}

	public void setPjdj(String pjdj){
		this.pjdj=pjdj;
	}

	public String getPjdj(){
		return pjdj;
	}

	public void setPjrmobile(String pjrmobile){
		this.pjrmobile=pjrmobile;
	}

	public String getPjrmobile(){
		return pjrmobile;
	}

	public void setHfdpjid(String hfdpjid){
		this.hfdpjid=hfdpjid;
	}

	public String getHfdpjid(){
		return hfdpjid;
	}

}

