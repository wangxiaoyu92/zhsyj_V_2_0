package com.askj.jyjc.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "Jyjcxmjcbz")
public class Jyjcxmjcbz {
/** 检验检测项目和检测标准对照表; InnoDB free: 17408 kB  */
	/** jyjcxmjcbzid 的中文含义是：检验检测项目和检测标准对照表id*/
	@Name
	@Column
	private String jyjcxmjcbzid;

	/** jyjcxmid 的中文含义是：检验检测项目表id*/
	@Column
	private String jyjcxmid;

	/** jyjcjcbzbid 的中文含义是：检验检测检测标准表id*/
	@Column
	private String jyjcjcbzbid;

	/** aae011 的中文含义是：操作员*/
	@Column
	private String aae011;

	/** aae036 的中文含义是：操作时间*/
	@Column
	private String aae036;


	public void setJyjcxmjcbzid(String jyjcxmjcbzid){
		this.jyjcxmjcbzid=jyjcxmjcbzid;
	}

	public String getJyjcxmjcbzid(){
		return jyjcxmjcbzid;
	}

	public void setJyjcxmid(String jyjcxmid){
		this.jyjcxmid=jyjcxmid;
	}

	public String getJyjcxmid(){
		return jyjcxmid;
	}

	public void setJyjcjcbzbid(String jyjcjcbzbid){
		this.jyjcjcbzbid=jyjcjcbzbid;
	}

	public String getJyjcjcbzbid(){
		return jyjcjcbzbid;
	}

	public void setAae011(String aae011){
		this.aae011=aae011;
	}

	public String getAae011(){
		return aae011;
	}

	public void setAae036(String aae036){
		this.aae036=aae036;
	}

	public String getAae036(){
		return aae036;
	}

}

