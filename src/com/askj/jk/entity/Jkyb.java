package com.askj.jk.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "Jkyb")
public class Jkyb {
/** 名厨亮照原表信息  */
	/** camId 的中文含义是：*/
	@Name
	@Column
	private String camid;

	/** camImg 的中文含义是：*/
	
	@Column
	private String camimg;

	/** camOrgId 的中文含义是：*/
	
	@Column
	private String camorgid;

	/** camOrgName 的中文含义是：*/
	
	@Column
	private String camorgname;

	/** cameraTyp 的中文含义是：*/
	
	@Column
	private String cameratyp;

	/** camState 的中文含义是：*/
	
	@Column
	private String camstate;

	/** deviceIndexCode 的中文含义是：*/
	
	@Column
	private String deviceindexcode;

	/** ocxId 的中文含义是：*/
	
	@Column
	private String ocxid;

	/** page 的中文含义是：*/
	
	@Column
	private String page;

	/** pixel 的中文含义是：*/
	
	@Column
	private String pixel;

	/** playType 的中文含义是：*/
	
	@Column
	private String playtype;

	/** rows 的中文含义是：*/
	
	@Column
	private String rows;

	/** sound 的中文含义是：*/
	
	@Column
	private String sound;

	/** vagIP 的中文含义是：*/
	
	@Column
	private String vagip;

	/** camName 的中文含义是：*/
	
	@Column
	private String camname;

	/** playVal 的中文含义是：*/
	
	@Column
	private String playval;

	/** ptzType 的中文含义是：*/
	
	@Column
	private String ptztype;


	public void setCamid(String camid){
		this.camid=camid;
	}

	public String getCamid(){
		return camid;
	}

	public void setCamimg(String camimg){
		this.camimg=camimg;
	}

	public String getCamimg(){
		return camimg;
	}

	public void setCamorgid(String camorgid){
		this.camorgid=camorgid;
	}

	public String getCamorgid(){
		return camorgid;
	}

	public void setCamorgname(String camorgname){
		this.camorgname=camorgname;
	}

	public String getCamorgname(){
		return camorgname;
	}

	public void setCameratyp(String cameratyp){
		this.cameratyp=cameratyp;
	}

	public String getCameratyp(){
		return cameratyp;
	}

	public void setCamstate(String camstate){
		this.camstate=camstate;
	}

	public String getCamstate(){
		return camstate;
	}

	public void setDeviceindexcode(String deviceindexcode){
		this.deviceindexcode=deviceindexcode;
	}

	public String getDeviceindexcode(){
		return deviceindexcode;
	}

	public void setOcxid(String ocxid){
		this.ocxid=ocxid;
	}

	public String getOcxid(){
		return ocxid;
	}

	public void setPage(String page){
		this.page=page;
	}

	public String getPage(){
		return page;
	}

	public void setPixel(String pixel){
		this.pixel=pixel;
	}

	public String getPixel(){
		return pixel;
	}

	public void setPlaytype(String playtype){
		this.playtype=playtype;
	}

	public String getPlaytype(){
		return playtype;
	}

	public void setRows(String rows){
		this.rows=rows;
	}

	public String getRows(){
		return rows;
	}

	public void setSound(String sound){
		this.sound=sound;
	}

	public String getSound(){
		return sound;
	}

	public void setVagip(String vagip){
		this.vagip=vagip;
	}

	public String getVagip(){
		return vagip;
	}

	public void setCamname(String camname){
		this.camname=camname;
	}

	public String getCamname(){
		return camname;
	}

	public void setPlayval(String playval){
		this.playval=playval;
	}

	public String getPlayval(){
		return playval;
	}

	public void setPtztype(String ptztype){
		this.ptztype=ptztype;
	}

	public String getPtztype(){
		return ptztype;
	}

}

