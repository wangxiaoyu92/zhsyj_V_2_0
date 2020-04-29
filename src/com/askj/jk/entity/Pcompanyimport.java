package com.askj.jk.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  PCOMPANYIMPORT的中文含义是: 外系统企业信息
 * @Creation     2016/12/05 13:54:49
 * @Written      Create By sunyifeng
 *
 **/
@Table(value = "PCOMPANYIMPORT")
public class Pcompanyimport {
	/**
	 * @Description outercomid的中文含义是： 系统外企业id
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_outercomid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_outercomid.nextval from dual"))
	private String outercomid;

	/**
	 * @Description comid的中文含义是： 系统内企业id
	 */
	@Column
	private String comid;

	/**
	 * @Description outercomname的中文含义是： 系统外企业名称
	 */
	@Column
	private String outercomname;

	/**
	 * @Description state的中文含义是： 摄像头状态
	 */
	@Column
	private String state;

	/**
	 * @Description imgurl的中文含义是： 企业图片路径
	 */
	@Column
	private String imgurl;

	/**
	 * @Description createtime的中文含义是： 对方系统企业创建时间
	 */
	@Column
	private String createtime;

	/**
	 * @Description synchtime的中文含义是： 对方系统企业同步时间
	 */
	@Column
	private String synchtime;

	/**
	 * @Description viewlasttime的中文含义是： 对方系统最后一次查看时间
	 */
	@Column
	private String viewlasttime;

	/**
	 * @Description orgsimpletext的中文含义是： 公司简介
	 */
	@Column
	private String orgsimpletext;

	
		/**
	 * @Description outercomid的中文含义是： 系统外企业id
	 */
	public void setOutercomid(String outercomid){ 
		this.outercomid = outercomid;
	}
	/**
	 * @Description outercomid的中文含义是： 系统外企业id
	 */
	public String getOutercomid(){
		return outercomid;
	}
	/**
	 * @Description comid的中文含义是： 系统内企业id
	 */
	public void setComid(String comid){ 
		this.comid = comid;
	}
	/**
	 * @Description comid的中文含义是： 系统内企业id
	 */
	public String getComid(){
		return comid;
	}
	/**
	 * @Description outercomname的中文含义是： 系统外企业名称
	 */
	public void setOutercomname(String outercomname){ 
		this.outercomname = outercomname;
	}
	/**
	 * @Description outercomname的中文含义是： 系统外企业名称
	 */
	public String getOutercomname(){
		return outercomname;
	}
	/**
	 * @Description state的中文含义是： 摄像头状态
	 */
	public void setState(String state){ 
		this.state = state;
	}
	/**
	 * @Description state的中文含义是： 摄像头状态
	 */
	public String getState(){
		return state;
	}
	/**
	 * @Description imgurl的中文含义是： 企业图片路径
	 */
	public void setImgurl(String imgurl){ 
		this.imgurl = imgurl;
	}
	/**
	 * @Description imgurl的中文含义是： 企业图片路径
	 */
	public String getImgurl(){
		return imgurl;
	}
	/**
	 * @Description createtime的中文含义是： 对方系统企业创建时间
	 */
	public void setCreatetime(String createtime){ 
		this.createtime = createtime;
	}
	/**
	 * @Description createtime的中文含义是： 对方系统企业创建时间
	 */
	public String getCreatetime(){
		return createtime;
	}
	/**
	 * @Description synchtime的中文含义是： 对方系统企业同步时间
	 */
	public void setSynchtime(String synchtime){ 
		this.synchtime = synchtime;
	}
	/**
	 * @Description synchtime的中文含义是： 对方系统企业同步时间
	 */
	public String getSynchtime(){
		return synchtime;
	}
	/**
	 * @Description viewlasttime的中文含义是： 对方系统最后一次查看时间
	 */
	public void setViewlasttime(String viewlasttime){ 
		this.viewlasttime = viewlasttime;
	}
	/**
	 * @Description viewlasttime的中文含义是： 对方系统最后一次查看时间
	 */
	public String getViewlasttime(){
		return viewlasttime;
	}
	/**
	 * @Description orgsimpletext的中文含义是： 公司简介
	 */
	public void setOrgsimpletext(String orgsimpletext){ 
		this.orgsimpletext = orgsimpletext;
	}
	/**
	 * @Description orgsimpletext的中文含义是： 公司简介
	 */
	public String getOrgsimpletext(){
		return orgsimpletext;
	}

	
}