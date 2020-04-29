package com.askj.supervision.dto;

import java.sql.Timestamp;
import java.util.Date;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
/**
 * 上报位置信息dto
 * @author askj
 *
 */
public class PzfpositionDTO {

	/**
	 * @Description userid的中文含义是： 用户id
	 */
	 
	private String userid;

	/**
	 * @Description position的中文含义是： 位置信息
	 */
	 
	private String position;

	/**
	 * @Description longitude的中文含义是： 经度坐标
	 */
	 
	private String longitude;

	/**
	 * @Description latitude的中文含义是： 纬度
	 */
	 
	private String latitude;
	/**
	 * @Description reporttime的中文含义是： 上报时间
	 */
	private Timestamp reporttime;
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public Timestamp getReporttime() {
		return reporttime;
	}
	public void setReporttime(Timestamp reporttime) {
		this.reporttime = reporttime;
	}
	
}
