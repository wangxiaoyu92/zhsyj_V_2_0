package com.askj.jyjc.dto;


import java.sql.Date;
import java.sql.Timestamp;

public class JyjcffbzbDTO {
/** 检验检测方法标准表; InnoDB free: 24576 kB  */
	/** jyjcffbzbid 的中文含义是：检验检测方法标准表id*/
	private String jyjcffbzbid;

	/** jcffbzbh 的中文含义是：检测方法标准编号*/
	private String jcffbzbh;

	/** jcffbzmc 的中文含义是：检测方法标准名称*/
	private String jcffbzmc;

	/** jcffbzlb 的中文含义是：检测方法标类别*/
	private String jcffbzlb;

	/** fbrq 的中文含义是：发布日期*/
	private Date fbrq;

	/** jyjcbzstate 的中文含义是：标准状态aaa100=jyjcbzstate*/
	private String jyjcbzstate;

	/** ssrq 的中文含义是：实施日期*/
	private Date ssrq;

	/** bfbm 的中文含义是：颁发部门*/
	private String bfbm;

	/** fzrq 的中文含义是：废止日期*/
	private Date fzrq;

	/** bztdqk 的中文含义是：标准替代情况*/
	private String bztdqk;

	/** bznr 的中文含义是：标准内容*/
	private String bznr;

	/** userid 的中文含义是：操作员id*/
	private String userid;

	/** username 的中文含义是：操作员姓名*/
	private String username;

	/** czsj 的中文含义是：操作时间*/
	private String czsj;

	/** sfyx 的中文含义是：是否有效aaa100=sfyx*/
	private String sfyx;


	public void setJyjcffbzbid(String jyjcffbzbid){
		this.jyjcffbzbid=jyjcffbzbid;
	}

	public String getJyjcffbzbid(){
		return jyjcffbzbid;
	}

	public void setJcffbzbh(String jcffbzbh){
		this.jcffbzbh=jcffbzbh;
	}

	public String getJcffbzbh(){
		return jcffbzbh;
	}

	public void setJcffbzmc(String jcffbzmc){
		this.jcffbzmc=jcffbzmc;
	}

	public String getJcffbzmc(){
		return jcffbzmc;
	}

	public void setJcffbzlb(String jcffbzlb){
		this.jcffbzlb=jcffbzlb;
	}

	public String getJcffbzlb(){
		return jcffbzlb;
	}

	public void setFbrq(Date fbrq){
		this.fbrq=fbrq;
	}

	public Date getFbrq(){
		return fbrq;
	}

	public void setJyjcbzstate(String jyjcbzstate){
		this.jyjcbzstate=jyjcbzstate;
	}

	public String getJyjcbzstate(){
		return jyjcbzstate;
	}

	public void setSsrq(Date ssrq){
		this.ssrq=ssrq;
	}

	public Date getSsrq(){
		return ssrq;
	}

	public void setBfbm(String bfbm){
		this.bfbm=bfbm;
	}

	public String getBfbm(){
		return bfbm;
	}

	public void setFzrq(Date fzrq){
		this.fzrq=fzrq;
	}

	public Date getFzrq(){
		return fzrq;
	}

	public void setBztdqk(String bztdqk){
		this.bztdqk=bztdqk;
	}

	public String getBztdqk(){
		return bztdqk;
	}

	public void setBznr(String bznr){
		this.bznr=bznr;
	}

	public String getBznr(){
		return bznr;
	}

	public void setUserid(String userid){
		this.userid=userid;
	}

	public String getUserid(){
		return userid;
	}

	public void setUsername(String username){
		this.username=username;
	}

	public String getUsername(){
		return username;
	}

	public void setCzsj(String czsj){
		this.czsj=czsj;
	}

	public String getCzsj(){
		return czsj;
	}

	public void setSfyx(String sfyx){
		this.sfyx=sfyx;
	}

	public String getSfyx(){
		return sfyx;
	}

}

