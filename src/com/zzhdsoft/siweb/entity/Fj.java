package com.zzhdsoft.siweb.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "Fj")
public class Fj {
/** 附件表; InnoDB free: 7168 kB  */
	/** FJID 的中文含义是：附件ID*/
	@Name
	@Column(value="FJID")
	private String fjid;

	/** FJWID 的中文含义是：附件所属表ID*/
	@Column(value="FJWID")
	private String fjwid;

	/** FJPATH 的中文含义是：附件保存路径*/
	@Column(value="FJPATH")
	private String fjpath;

	/** FJCONTENT 的中文含义是：附件内容*/
	@Column(value="FJCONTENT")
	private String fjcontent;

	/** FJTYPE 的中文含义是：附件类型 1图片 2文档 */
	@Column(value="FJTYPE")
	private String fjtype;

	/** FJNAME 的中文含义是：附件名称*/
	@Column(value="FJNAME")
	private String fjname;

	/** FJCSDMZ 的中文含义是：对应PFJCS表字段*/
	@Column(value="FJCSDMZ")
	private String fjcsdmz;

	/** fjuserid 的中文含义是：附件userid*/
	@Column
	private String fjuserid;

	/** fjczyxm 的中文含义是：操作员姓名*/
	@Column
	private String fjczyxm;

	/** fjczsj 的中文含义是：操作时间*/
	@Column
	private Timestamp fjczsj;


	public void setFjid(String fjid){
		this.fjid=fjid;
	}

	public String getFjid(){
		return fjid;
	}

	public void setFjwid(String fjwid){
		this.fjwid=fjwid;
	}

	public String getFjwid(){
		return fjwid;
	}

	public void setFjpath(String fjpath){
		this.fjpath=fjpath;
	}

	public String getFjpath(){
		return fjpath;
	}

	public void setFjcontent(String fjcontent){
		this.fjcontent=fjcontent;
	}

	public String getFjcontent(){
		return fjcontent;
	}

	public void setFjtype(String fjtype){
		this.fjtype=fjtype;
	}

	public String getFjtype(){
		return fjtype;
	}

	public void setFjname(String fjname){
		this.fjname=fjname;
	}

	public String getFjname(){
		return fjname;
	}

	public void setFjcsdmz(String fjcsdmz){
		this.fjcsdmz=fjcsdmz;
	}

	public String getFjcsdmz(){
		return fjcsdmz;
	}

	public void setFjuserid(String fjuserid){
		this.fjuserid=fjuserid;
	}

	public String getFjuserid(){
		return fjuserid;
	}

	public void setFjczyxm(String fjczyxm){
		this.fjczyxm=fjczyxm;
	}

	public String getFjczyxm(){
		return fjczyxm;
	}

	public void setFjczsj(Timestamp fjczsj){
		this.fjczsj=fjczsj;
	}

	public Timestamp getFjczsj(){
		return fjczsj;
	}

}

