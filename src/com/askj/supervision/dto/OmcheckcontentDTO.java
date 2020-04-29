package com.askj.supervision.dto;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

public class OmcheckcontentDTO {
	//扩展开始
	/** itemid 的中文含义是：项目名称*/
	private String itemname;
	//扩展结束
/** 检查内容表; InnoDB free: 14336 kB  */
	/** contentid 的中文含义是：内容ID*/
	private String contentid;

	/** itemid 的中文含义是：项目ID*/
	private String itemid;

	/** content 的中文含义是：内容*/
	private String content;

	/** contentcode 的中文含义是：内容编号*/
	private String contentcode;

	/** contentimpt 的中文含义是：内容重要性*/
	private String contentimpt;

	/** contentimptaaa103 的中文含义是：内容重要性*/
	private String contentimptaaa103;

	/** contentscore 的中文含义是：内容评级分值*/
	private String contentscore;

	/** contentoperatedate 的中文含义是：内容经办日期*/
	private Timestamp contentoperatedate;

	/** contentoperateperson 的中文含义是：内容经办人*/
	private String contentoperateperson;

	/** contentsortid 的中文含义是：内容排序号*/
	private String contentsortid;


	public void setContentid(String contentid){
		this.contentid=contentid;
	}

	public String getContentid(){
		return contentid;
	}

	public void setItemid(String itemid){
		this.itemid=itemid;
	}

	public String getItemid(){
		return itemid;
	}

	public void setContent(String content){
		this.content=content;
	}

	public String getContent(){
		return content;
	}

	public void setContentcode(String contentcode){
		this.contentcode=contentcode;
	}

	public String getContentcode(){
		return contentcode;
	}

	public void setContentimpt(String contentimpt){
		this.contentimpt=contentimpt;
	}

	public String getContentimpt(){
		return contentimpt;
	}

	public void setContentscore(String contentscore){
		this.contentscore=contentscore;
	}

	public String getContentscore(){
		return contentscore;
	}

	public void setContentoperatedate(Timestamp contentoperatedate){
		this.contentoperatedate=contentoperatedate;
	}

	public Timestamp getContentoperatedate(){
		return contentoperatedate;
	}

	public void setContentoperateperson(String contentoperateperson){
		this.contentoperateperson=contentoperateperson;
	}

	public String getContentoperateperson(){
		return contentoperateperson;
	}

	public void setContentsortid(String contentsortid){
		this.contentsortid=contentsortid;
	}

	public String getContentsortid(){
		return contentsortid;
	}

	public String getContentimptaaa103() {
		return contentimptaaa103;
	}

	public void setContentimptaaa103(String contentimptaaa103) {
		this.contentimptaaa103 = contentimptaaa103;
	}

	public String getItemname() {
		return itemname;
	}

	public void setItemname(String itemname) {
		this.itemname = itemname;
	}
}

