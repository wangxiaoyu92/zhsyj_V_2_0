package com.askj.tmsyj.tmsyj.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Timestamp;

@Table(value = "Pgzjd")
public class Pgzjd {
/** 公众监督表  */
	/** pgzjdid 的中文含义是：公众监督表id*/
	@Name
	@Column
	private String pgzjdid;

	/** pjdr 的中文含义是：监督人*/
	@Column
	private String pjdr;

	/** pjdsj 的中文含义是：监督时间*/
	@Column
	private Timestamp pjdsj;

	/** pjdbt 的中文含义是：监督标题*/
	@Column
	private String pjdbt;

	/** pmobile 的中文含义是：监督人手机号*/
	@Column
	private String pmobile;

	/** pjdnr 的中文含义是：内容*/
	@Column
	private String pjdnr;


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

}

