package com.askj.baseinfo.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table; 
import java.sql.Timestamp;

@Table(value = "Pcomrcjdglry")
public class Pcomrcjdglry {
/** 日常监督管理人员; InnoDB free: 229376 kB  */
	/** pcomrcjdglryid 的中文含义是：日常监督管理人员id*/
	@Name
	@Column
	private String pcomrcjdglryid;

	/** comid 的中文含义是：企业id*/
	@Column
	private String comid;

	/** userid 的中文含义是：用户id*/
	@Column
	private String userid;

	/** aae011 的中文含义是：操作员*/
	@Column
	private String aae011;

	/** aae036 的中文含义是：操作时间*/
	@Column
	private Timestamp aae036;


	public void setPcomrcjdglryid(String pcomrcjdglryid){
		this.pcomrcjdglryid=pcomrcjdglryid;
	}

	public String getPcomrcjdglryid(){
		return pcomrcjdglryid;
	}

	public void setComid(String comid){
		this.comid=comid;
	}

	public String getComid(){
		return comid;
	}

	public void setUserid(String userid){
		this.userid=userid;
	}

	public String getUserid(){
		return userid;
	}

	public void setAae011(String aae011){
		this.aae011=aae011;
	}

	public String getAae011(){
		return aae011;
	}

	public void setAae036(Timestamp aae036){
		this.aae036=aae036;
	}

	public Timestamp getAae036(){
		return aae036;
	}

}

