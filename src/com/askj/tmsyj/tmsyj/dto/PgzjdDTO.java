package com.askj.tmsyj.tmsyj.dto;

import java.sql.Timestamp;
import java.util.List;

import com.zzhdsoft.siweb.entity.Fj;

public class PgzjdDTO {
/** 公众监督表  */
	/** pgzjdid 的中文含义是：公众监督表id*/
	private String pgzjdid;

	/** pjdr 的中文含义是：监督人*/
	private String pjdr;

	/** pjdsj 的中文含义是：监督时间*/
	private Timestamp pjdsj;

	/** pjdbt 的中文含义是：监督标题*/
	private String pjdbt;

	/** pmobile 的中文含义是：监督人手机号*/
	private String pmobile;

	/** pjdnr 的中文含义是：内容*/
	private String pjdnr;
	
	/** pjdtppath 的中文含义是：监督图片路径 手动添加*/
	private String pjdtppath;
	
	/** pjdtpname 的中文含义是：监督图片名称 手动添加*/
	private String pjdtpname;
	
	/** pjdrname 的中文含义是：监督人名称 手动添加*/
	private String pjdrname;
	
	/** pjdrname 的中文含义是：监督人名称 手动添加*/
	private List<Fj> fjlist;

	public void setPgzjdid(String pgzjdid){
		this.pgzjdid=pgzjdid;
	}

	public String getPgzjdid(){
		return pgzjdid;
	}

	public void setPjdr(String pjdr){
		this.pjdr=pjdr;
	}

	public String getPjdr(){
		return pjdr;
	}

	public void setPjdsj(Timestamp pjdsj){
		this.pjdsj=pjdsj;
	}

	public Timestamp getPjdsj(){
		return pjdsj;
	}

	public void setPjdbt(String pjdbt){
		this.pjdbt=pjdbt;
	}

	public String getPjdbt(){
		return pjdbt;
	}

	public void setPmobile(String pmobile){
		this.pmobile=pmobile;
	}

	public String getPmobile(){
		return pmobile;
	}

	public void setPjdnr(String pjdnr){
		this.pjdnr=pjdnr;
	}

	public String getPjdnr(){
		return pjdnr;
	}

	public String getPjdtppath() {
		return pjdtppath;
	}

	public void setPjdtppath(String pjdtppath) {
		this.pjdtppath = pjdtppath;
	}

	public String getPjdtpname() {
		return pjdtpname;
	}

	public void setPjdtpname(String pjdtpname) {
		this.pjdtpname = pjdtpname;
	}

	public String getPjdrname() {
		return pjdrname;
	}

	public void setPjdrname(String pjdrname) {
		this.pjdrname = pjdrname;
	}

	public List<Fj> getFjlist() {
		return fjlist;
	}

	public void setFjlist(List<Fj> fjlist) {
		this.fjlist = fjlist;
	}

}

