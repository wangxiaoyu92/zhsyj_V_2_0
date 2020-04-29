package com.askj.jyjc.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "Jyjcyp")
public class Jyjcyp {
/** 商品表  */
	/** jcypid 的中文含义是：商品ID*/
	@Name
	@Column
	private String jcypid;

	/** jcyplb 的中文含义是：商品类别,如果是商品见bs_spsc_sq_xkml.ml_id*/
	@Column
	private String jcyplb;

	/** jcypbh 的中文含义是：商品编号*/
	@Column
	private String jcypbh;

	/** jcypmc 的中文含义是：商品名称*/
	@Column
	private String jcypmc;

	/** jcypjc 的中文含义是：商品简称*/
	@Column
	private String jcypjc;

	/** jcypczy 的中文含义是：操作员*/
	@Column
	private String jcypczy;

	/** jcypczsj 的中文含义是：操作时间*/
	@Column
	private Timestamp jcypczsj;

	/** jcypgl 的中文含义是：商品归类aaa100=jcypgl*/
	@Column
	private String jcypgl;

	/** jcypsspp 的中文含义是：所属品牌*/
	@Column
	private String jcypsspp;

	/** impcpgg 的中文含义是：规格*/
	@Column
	private String impcpgg;

	/** spsb 的中文含义是：商品商标*/
	@Column
	private String spsb;

	/** spggxh 的中文含义是：商品规格型号*/
	@Column
	private String spggxh;

	/** spjldw 的中文含义是：商品计量单位*/
	@Column
	private String spjldw;

	/** spzxbzh 的中文含义是：商品执行标准号*/
	@Column
	private String spzxbzh;

	/** spbzq 的中文含义是：商品保质期*/
	@Column
	private String spbzq;

	/** jcyptp 的中文含义是：检查样品图片*/
	@Column
	private String jcyptp;

	/** jcyptpwjm 的中文含义是：检查样品图片文件名*/
	@Column
	private String jcyptpwjm;

	/** spfenlei 的中文含义是：商品分类aaa100=spfenlei*/
	@Column
	private String spfenlei;

	/** spsjlx 的中文含义是：商品数据类型aaa100=spsjlx0商品1生产企业产品2生产企业原材料*/
	@Column
	private String spsjlx;

	/** hviewjgztid 的中文含义是：监管主体表主键,生产企业设置自己的产品或原料时用到*/
	@Column
	private String hviewjgztid;
	
	/** userid 的中文含义是：操作员id控制编辑和删除用*/
	@Column
	private String userid;	


	public void setJcypid(String jcypid){
		this.jcypid=jcypid;
	}

	public String getJcypid(){
		return jcypid;
	}

	public void setJcyplb(String jcyplb){
		this.jcyplb=jcyplb;
	}

	public String getJcyplb(){
		return jcyplb;
	}

	public void setJcypbh(String jcypbh){
		this.jcypbh=jcypbh;
	}

	public String getJcypbh(){
		return jcypbh;
	}

	public void setJcypmc(String jcypmc){
		this.jcypmc=jcypmc;
	}

	public String getJcypmc(){
		return jcypmc;
	}

	public void setJcypjc(String jcypjc){
		this.jcypjc=jcypjc;
	}

	public String getJcypjc(){
		return jcypjc;
	}

	public void setJcypczy(String jcypczy){
		this.jcypczy=jcypczy;
	}

	public String getJcypczy(){
		return jcypczy;
	}

	public void setJcypczsj(Timestamp jcypczsj){
		this.jcypczsj=jcypczsj;
	}

	public Timestamp getJcypczsj(){
		return jcypczsj;
	}

	public void setJcypgl(String jcypgl){
		this.jcypgl=jcypgl;
	}

	public String getJcypgl(){
		return jcypgl;
	}

	public void setJcypsspp(String jcypsspp){
		this.jcypsspp=jcypsspp;
	}

	public String getJcypsspp(){
		return jcypsspp;
	}

	public void setImpcpgg(String impcpgg){
		this.impcpgg=impcpgg;
	}

	public String getImpcpgg(){
		return impcpgg;
	}

	public void setSpsb(String spsb){
		this.spsb=spsb;
	}

	public String getSpsb(){
		return spsb;
	}

	public void setSpggxh(String spggxh){
		this.spggxh=spggxh;
	}

	public String getSpggxh(){
		return spggxh;
	}

	public void setSpjldw(String spjldw){
		this.spjldw=spjldw;
	}

	public String getSpjldw(){
		return spjldw;
	}

	public void setSpzxbzh(String spzxbzh){
		this.spzxbzh=spzxbzh;
	}

	public String getSpzxbzh(){
		return spzxbzh;
	}

	public void setSpbzq(String spbzq){
		this.spbzq=spbzq;
	}

	public String getSpbzq(){
		return spbzq;
	}

	public void setJcyptp(String jcyptp){
		this.jcyptp=jcyptp;
	}

	public String getJcyptp(){
		return jcyptp;
	}

	public void setJcyptpwjm(String jcyptpwjm){
		this.jcyptpwjm=jcyptpwjm;
	}

	public String getJcyptpwjm(){
		return jcyptpwjm;
	}

	public void setSpfenlei(String spfenlei){
		this.spfenlei=spfenlei;
	}

	public String getSpfenlei(){
		return spfenlei;
	}

	public void setSpsjlx(String spsjlx){
		this.spsjlx=spsjlx;
	}

	public String getSpsjlx(){
		return spsjlx;
	}

	public void setHviewjgztid(String hviewjgztid){
		this.hviewjgztid=hviewjgztid;
	}

	public String getHviewjgztid(){
		return hviewjgztid;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}
	
}

