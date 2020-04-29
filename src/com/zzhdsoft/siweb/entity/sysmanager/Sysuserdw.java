package com.zzhdsoft.siweb.entity.sysmanager;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  SYSUSERDW的中文含义是: 手机定位表
 * @Creation     2017/02/23 17:35:07
 * @Written      Create Tool By zjf 
 **/
@Table(value = "SYSUSERDW")
public class Sysuserdw {
	/**
	 * @Description dwid的中文含义是： 定位ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_dwid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_dwid.nextval from dual"))
	private String dwid;

	/**
	 * @Description userid的中文含义是： 用户ID
	 */
	@Column
	private String userid;

	/**
	 * @Description qddszid的中文含义是： 签到点id  
	 */
	@Column
	private String qddszid;

	/**
	 * @Description dwjdzb的中文含义是： 经度坐标
	 */
	@Column
	private String dwjdzb;

	/**
	 * @Description dwwdzb的中文含义是： 纬度坐标
	 */
	@Column
	private String dwwdzb;

	/**
	 * @Description dwdd的中文含义是： 定位地点
	 */
	@Column
	private String dwdd;

	/**
	 * @Description dwsj的中文含义是： 定位时间
	 */
	@Column
	private Timestamp dwsj;

	/**
	 * @Description dwfs的中文含义是： 定位方式
	 */
	@Column
	private String dwfs;

	/**
	 * @Description status的中文含义是： 默认没有打卡3, 迟到2,正常为1
	 */
	@Column
	private String status;

	
		/**
	 * @Description dwid的中文含义是： 定位ID
	 */
	public void setDwid(String dwid){ 
		this.dwid = dwid;
	}
	/**
	 * @Description dwid的中文含义是： 定位ID
	 */
	public String getDwid(){
		return dwid;
	}
	/**
	 * @Description userid的中文含义是： 用户ID
	 */
	public void setUserid(String userid){ 
		this.userid = userid;
	}
	/**
	 * @Description userid的中文含义是： 用户ID
	 */
	public String getUserid(){
		return userid;
	}
	/**
	 * @Description qddszid的中文含义是： 签到点id  
	 */
	public void setQddszid(String qddszid){ 
		this.qddszid = qddszid;
	}
	/**
	 * @Description qddszid的中文含义是： 签到点id  
	 */
	public String getQddszid(){
		return qddszid;
	}
	/**
	 * @Description dwjdzb的中文含义是： 经度坐标
	 */
	public void setDwjdzb(String dwjdzb){ 
		this.dwjdzb = dwjdzb;
	}
	/**
	 * @Description dwjdzb的中文含义是： 经度坐标
	 */
	public String getDwjdzb(){
		return dwjdzb;
	}
	/**
	 * @Description dwwdzb的中文含义是： 纬度坐标
	 */
	public void setDwwdzb(String dwwdzb){ 
		this.dwwdzb = dwwdzb;
	}
	/**
	 * @Description dwwdzb的中文含义是： 纬度坐标
	 */
	public String getDwwdzb(){
		return dwwdzb;
	}
	/**
	 * @Description dwdd的中文含义是： 定位地点
	 */
	public void setDwdd(String dwdd){ 
		this.dwdd = dwdd;
	}
	/**
	 * @Description dwdd的中文含义是： 定位地点
	 */
	public String getDwdd(){
		return dwdd;
	}
	/**
	 * @Description dwsj的中文含义是： 定位时间
	 */
	public void setDwsj(Timestamp dwsj){ 
		this.dwsj = dwsj;
	}
	/**
	 * @Description dwsj的中文含义是： 定位时间
	 */
	public Timestamp getDwsj(){
		return dwsj;
	}
	/**
	 * @Description dwfs的中文含义是： 定位方式
	 */
	public void setDwfs(String dwfs){ 
		this.dwfs = dwfs;
	}
	/**
	 * @Description dwfs的中文含义是： 定位方式
	 */
	public String getDwfs(){
		return dwfs;
	}
	/**
	 * @Description status的中文含义是： 默认没有打卡3, 迟到2,正常为1
	 */
	public void setStatus(String status){ 
		this.status = status;
	}
	/**
	 * @Description status的中文含义是： 默认没有打卡3, 迟到2,正常为1
	 */
	public String getStatus(){
		return status;
	}

	
}