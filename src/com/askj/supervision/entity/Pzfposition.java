package com.askj.supervision.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  PZFPOSITION的中文含义是: 
 * @Creation     2016/06/21 18:04:43
 * @Written      Create Tool By zjf 
 **/
@Table(value = "PZFPOSITION")
public class Pzfposition {
	/**
	 * @Description id的中文含义是： 
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_id')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_id.nextval from dual"))
	private String id;

	/**
	 * @Description userid的中文含义是： 用户id
	 */
	@Column
	private String userid;

	/**
	 * @Description position的中文含义是： 位置信息
	 */
	@Column
	private String position;

	/**
	 * @Description reporttime的中文含义是： 上报时间
	 */
	@Column
	private Timestamp reporttime;

	/**
	 * @Description longitude的中文含义是： 经度坐标
	 */
	@Column
	private String longitude;

	/**
	 * @Description latitude的中文含义是： 纬度
	 */
	@Column
	private String latitude;

	
		/**
	 * @Description id的中文含义是： 
	 */
	public void setId(String id){ 
		this.id = id;
	}
	/**
	 * @Description id的中文含义是： 
	 */
	public String getId(){
		return id;
	}
	/**
	 * @Description userid的中文含义是： 用户id
	 */
	public void setUserid(String userid){ 
		this.userid = userid;
	}
	/**
	 * @Description userid的中文含义是： 用户id
	 */
	public String getUserid(){
		return userid;
	}
	/**
	 * @Description position的中文含义是： 位置信息
	 */
	public void setPosition(String position){ 
		this.position = position;
	}
	/**
	 * @Description position的中文含义是： 位置信息
	 */
	public String getPosition(){
		return position;
	}
	/**
	 * @Description reporttime的中文含义是： 上报时间
	 */
	public void setReporttime(Timestamp reporttime){ 
		this.reporttime = reporttime;
	}
	/**
	 * @Description reporttime的中文含义是： 上报时间
	 */
	public Timestamp getReporttime(){
		return reporttime;
	}
	/**
	 * @Description longitude的中文含义是： 经度坐标
	 */
	public void setLongitude(String longitude){ 
		this.longitude = longitude;
	}
	/**
	 * @Description longitude的中文含义是： 经度坐标
	 */
	public String getLongitude(){
		return longitude;
	}
	/**
	 * @Description latitude的中文含义是： 纬度
	 */
	public void setLatitude(String latitude){ 
		this.latitude = latitude;
	}
	/**
	 * @Description latitude的中文含义是： 纬度
	 */
	public String getLatitude(){
		return latitude;
	}

	
}