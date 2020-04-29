package com.askj.baseinfo.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.io.InputStream;
import java.math.BigDecimal;

/**
 * @Description  PCOMPANYFJ的中文含义是: 企业附件表; InnoDB free: 2754560 kB
 * @Creation     2016/05/11 11:28:44
 * @Written      Create Tool By zjf 
 **/
@Table(value = "PCOMPANYFJ")
public class Pcompanyfj {
	/**
	 * @Description comfjid的中文含义是： ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_comfjid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_comfjid.nextval from dual"))
	private String comfjid;

	/**
	 * @Description comdm的中文含义是： 企业代码：企业类型字母+6位行政区域代码+9位序列号
	 */
	@Column
	private String comdm;

	/**
	 * @Description comfjpath的中文含义是： 附件保存路径
	 */
	@Column
	private String comfjpath;

	/**
	 * @Description comfjfile的中文含义是： 附件
	 */
	@Column
	private InputStream comfjfile;

	/**
	 * @Description comfjtype的中文含义是： 附件类型 1企业形象图片,附件表comfjtype
	 */
	@Column
	private String comfjtype;

	
		/**
	 * @Description comfjid的中文含义是： ID
	 */
	public void setComfjid(String comfjid){ 
		this.comfjid = comfjid;
	}
	/**
	 * @Description comfjid的中文含义是： ID
	 */
	public String getComfjid(){
		return comfjid;
	}
	/**
	 * @Description comdm的中文含义是： 企业代码：企业类型字母+6位行政区域代码+9位序列号
	 */
	public void setComdm(String comdm){ 
		this.comdm = comdm;
	}
	/**
	 * @Description comdm的中文含义是： 企业代码：企业类型字母+6位行政区域代码+9位序列号
	 */
	public String getComdm(){
		return comdm;
	}
	/**
	 * @Description comfjpath的中文含义是： 附件保存路径
	 */
	public void setComfjpath(String comfjpath){ 
		this.comfjpath = comfjpath;
	}
	/**
	 * @Description comfjpath的中文含义是： 附件保存路径
	 */
	public String getComfjpath(){
		return comfjpath;
	}
	/**
	 * @Description comfjfile的中文含义是： 附件
	 */
	public void setComfjfile(InputStream comfjfile){ 
		this.comfjfile = comfjfile;
	}
	/**
	 * @Description comfjfile的中文含义是： 附件
	 */
	public InputStream getComfjfile(){
		return comfjfile;
	}
	/**
	 * @Description comfjtype的中文含义是： 附件类型 1企业形象图片,附件表comfjtype
	 */
	public void setComfjtype(String comfjtype){ 
		this.comfjtype = comfjtype;
	}
	/**
	 * @Description comfjtype的中文含义是： 附件类型 1企业形象图片,附件表comfjtype
	 */
	public String getComfjtype(){
		return comfjtype;
	}

	
}