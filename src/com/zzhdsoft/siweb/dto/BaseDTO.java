package com.zzhdsoft.siweb.dto;

import org.nutz.dao.entity.annotation.Column;

public class BaseDTO {
	/**
	 * aaa027 的中文名称：地区编码
	 */
	  
	private String aaa027;
	/**
	 * aae140 的中文名称：四品一械大类
	 */
	  
	private String aae140;
	/**
	 * userid 的中文名称：经办人id
	 */
	  
	private String userid;
	/**
	 * orgid 的中文名称：机构id
	 */
	  
	private String orgid;
	/**
	 * aae011 的中文名称：经办人姓名
	 */
	/**
	 * @Description comdalei的中文含义是：大类
	 */
	 
	private String comdalei;
	private String aae011;
	public String getAaa027() {
		return aaa027;
	}
	public void setAaa027(String aaa027) {
		this.aaa027 = aaa027;
	}
	public String getAae140() {
		return aae140;
	}
	public void setAae140(String aae140) {
		this.aae140 = aae140;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getOrgid() {
		return orgid;
	}
	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}
	public String getAae011() {
		return aae011;
	}
	public void setAae011(String aae011) {
		this.aae011 = aae011;
	}
	public String getComdalei() {
		return comdalei;
	}
	public void setComdalei(String comdalei) {
		this.comdalei = comdalei;
	}
	
}
