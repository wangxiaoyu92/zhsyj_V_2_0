package com.zzhdsoft.siweb.dto.sysmanager;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  SYSUSERORG的中文含义是: 操作员有权操作的机构DTO
 * @Creation     2016/08/15 18:30:35
 * @Written      Create Tool By zjf 
 **/
public class SysuserorgDTO {
	/**
	 * @Description sysuserorgid的中文含义是： 操作员有权操作的机构ID
	 */
	private String sysuserorgid;

	/**
	 * @Description userid的中文含义是： 操作员ID
	 */
	private String userid;

	/**
	 * @Description orgid的中文含义是： 机构ID
	 */
	private String orgid;

	
		/**
	 * @Description sysuserorgid的中文含义是： 操作员有权操作的机构ID
	 */
	public void setSysuserorgid(String sysuserorgid){ 
		this.sysuserorgid = sysuserorgid;
	}
	/**
	 * @Description sysuserorgid的中文含义是： 操作员有权操作的机构ID
	 */
	public String getSysuserorgid(){
		return sysuserorgid;
	}
	/**
	 * @Description userid的中文含义是： 操作员ID
	 */
	public void setUserid(String userid){ 
		this.userid = userid;
	}
	/**
	 * @Description userid的中文含义是： 操作员ID
	 */
	public String getUserid(){
		return userid;
	}
	/**
	 * @Description orgid的中文含义是： 机构ID
	 */
	public void setOrgid(String orgid){ 
		this.orgid = orgid;
	}
	/**
	 * @Description orgid的中文含义是： 机构ID
	 */
	public String getOrgid(){
		return orgid;
	}

	
}