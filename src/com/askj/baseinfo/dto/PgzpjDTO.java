package com.askj.baseinfo.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class PgzpjDTO {
	/** 公众评价表  */
	/** pgzpjid 的中文含义是：公众评价表id*/
	private String pgzpjid;

	/** pjztid 的中文含义是：评价主体id*/
	private String pjztid;

	/** pjztmc 的中文含义是：评价主体名称*/
	private String pjztmc;

	/** pjr 的中文含义是：评价人*/
	private String pjr;

	/** pjsj 的中文含义是：评价时间*/
	private Timestamp pjsj;

	/** pjbt 的中文含义是：评价标题*/
	private String pjbt;

	/** pjnr 的中文含义是：评价内容*/
	private String pjnr;

	/** pjdj 的中文含义是：评价等级aaa100=pjdj*/
	private String pjdj;

	/** pjrmobile 的中文含义是：评价人手机号*/
	private String pjrmobile;

	/** hfdpjid 的中文含义是：回复的评价id*/
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
	
	/** 公众评价明细表  */
	/** pgzpjmxid 的中文含义是：公众评价明细表*/
	private String pgzpjmxid;


	/** pjcs 的中文含义是：aa10表aaa100=pjcs*/
	private String pjcs;

	/** pjxj 的中文含义是：评价星级aaa100=pjxj*/
	private String pjxj;


	public void setPgzpjmxid(String pgzpjmxid){
		this.pgzpjmxid=pgzpjmxid;
	}

	public String getPgzpjmxid(){
		return pgzpjmxid;
	}

	
	public void setPjcs(String pjcs){
		this.pjcs=pjcs;
	}

	public String getPjcs(){
		return pjcs;
	}

	public void setPjxj(String pjxj){
		this.pjxj=pjxj;
	}

	public String getPjxj(){
		return pjxj;
	}
}

