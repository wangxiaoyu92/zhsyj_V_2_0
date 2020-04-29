package com.askj.supervision.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  BSTBODYINFO的中文含义是: 
 * @Creation     2016/07/14 18:17:00
 * @Written      Create Tool By zjf 
 **/
@Table(value = "BSTBODYINFO")
public class Bstbodyinfo {
	/**
	 * @Description tbodyid的中文含义是： 主键
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_tbodyid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_tbodyid.nextval from dual"))
	private String tbodyid;
	/**
	 * @Description aaa027的中文含义是：统筹区
	 */
	@Column
	private String aaa027;
	/**
	 * @Description tbodytype的中文含义是： 表头类别
	 */
	@Column
	private String tbodytype;

	/**
	 * @Description tbodycode的中文含义是： 表头编码
	 */
	@Column
	private String tbodycode;

	/**
	 * @Description tbbodyid的中文含义是： 页面元素id
	 */
	@Column
	private String tbbodyid;

	/**
	 * @Description tbodyinfo的中文含义是： 表头信息
	 */
	@Column
	private String tbodyinfo;

	/**
	 * @Description tbody的中文含义是： 
	 */
	@Column
	private String tbody;

	/**
	 * @Description tfootinfo的中文含义是： 表底部
	 */
	@Column
	private String tfootinfo;

	
		/**
	 * @Description tbodyid的中文含义是： 主键
	 */
	public void setTbodyid(String tbodyid){ 
		this.tbodyid = tbodyid;
	}
	/**
	 * @Description tbodyid的中文含义是： 主键
	 */
	public String getTbodyid(){
		return tbodyid;
	}
	/**
	 * @Description tbodytype的中文含义是： 表头类别
	 */
	public void setTbodytype(String tbodytype){ 
		this.tbodytype = tbodytype;
	}
	/**
	 * @Description tbodytype的中文含义是： 表头类别
	 */
	public String getTbodytype(){
		return tbodytype;
	}
	/**
	 * @Description tbodycode的中文含义是： 表头编码
	 */
	public void setTbodycode(String tbodycode){ 
		this.tbodycode = tbodycode;
	}
	/**
	 * @Description tbodycode的中文含义是： 表头编码
	 */
	public String getTbodycode(){
		return tbodycode;
	}
	/**
	 * @Description tbbodyid的中文含义是： 页面元素id
	 */
	public void setTbbodyid(String tbbodyid){ 
		this.tbbodyid = tbbodyid;
	}
	/**
	 * @Description tbbodyid的中文含义是： 页面元素id
	 */
	public String getTbbodyid(){
		return tbbodyid;
	}
	/**
	 * @Description tbodyinfo的中文含义是： 表头信息
	 */
	public void setTbodyinfo(String tbodyinfo){ 
		this.tbodyinfo = tbodyinfo;
	}
	/**
	 * @Description tbodyinfo的中文含义是： 表头信息
	 */
	public String getTbodyinfo(){
		return tbodyinfo;
	}
	/**
	 * @Description tbody的中文含义是： 
	 */
	public void setTbody(String tbody){ 
		this.tbody = tbody;
	}
	/**
	 * @Description tbody的中文含义是： 
	 */
	public String getTbody(){
		return tbody;
	}
	/**
	 * @Description tfootinfo的中文含义是： 表底部
	 */
	public void setTfootinfo(String tfootinfo){ 
		this.tfootinfo = tfootinfo;
	}
	/**
	 * @Description tfootinfo的中文含义是： 表底部
	 */
	public String getTfootinfo(){
		return tfootinfo;
	}
	public String getAaa027() {
		return aaa027;
	}
	public void setAaa027(String aaa027) {
		this.aaa027 = aaa027;
	}
	

	
}