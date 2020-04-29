package com.askj.jk.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  JK的中文含义是：监控表 
 * @Creation     2016/02/25 11:39:11
 * @Written      Create Tool By zjf 
 **/
@Table(value = "JK")
public class Jk {
	/**
	 * @Description jkid的中文含义是： 监控ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_jkid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_jkid.nextval from dual"))
	private String jkid;

	/**
	 * @Description jkymc的中文含义是： 监控源名称
	 */
	@Column
	private String jkymc;

	/**
	 * @Description jkybh的中文含义是： 监控源编号
	 */
	@Column
	private String jkybh;

	/**
	 * @Description jkqybh的中文含义是： 监控企业编号
	 */
	@Column
	private String jkqybh;

	/**
	 * @Description jkqymc的中文含义是： 监控企业名称
	 */
	@Column
	private String jkqymc;

	/**
	 * @Description jklx的中文含义是： 监控类型
	 */
	@Column
	private String jklx;
	
	/**
	 * @Description jksppath的中文含义是： 离线监控视频文件路径
	 */
	@Column
	private String jksppath;
	
	/**
	 * @Description orderno的中文含义是：排序
	 */
	@Column
	private Integer orderno;
	
	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	@Column
	private String aaa027;

	/**
	 * @Description aaa027的中文含义是： 明厨亮灶监控对象id
	 */
	@Column
	private String camorgid;
	
		/**
	 * @Description jkid的中文含义是： 监控ID
	 */
	public void setJkid(String jkid){ 
		this.jkid = jkid;
	}
	/**
	 * @Description jkid的中文含义是： 监控ID
	 */
	public String getJkid(){
		return jkid;
	}
	/**
	 * @Description jkymc的中文含义是： 监控源名称
	 */
	public void setJkymc(String jkymc){ 
		this.jkymc = jkymc;
	}
	/**
	 * @Description jkymc的中文含义是： 监控源名称
	 */
	public String getJkymc(){
		return jkymc;
	}
	/**
	 * @Description jkybh的中文含义是： 监控源编号
	 */
	public void setJkybh(String jkybh){ 
		this.jkybh = jkybh;
	}
	/**
	 * @Description jkybh的中文含义是： 监控源编号
	 */
	public String getJkybh(){
		return jkybh;
	}
	/**
	 * @Description jkqybh的中文含义是： 监控企业编号
	 */
	public void setJkqybh(String jkqybh){ 
		this.jkqybh = jkqybh;
	}
	/**
	 * @Description jkqybh的中文含义是： 监控企业编号
	 */
	public String getJkqybh(){
		return jkqybh;
	}
	/**
	 * @Description jkqymc的中文含义是： 监控企业名称
	 */
	public void setJkqymc(String jkqymc){ 
		this.jkqymc = jkqymc;
	}
	/**
	 * @Description jkqymc的中文含义是： 监控企业名称
	 */
	public String getJkqymc(){
		return jkqymc;
	}
	/**
	 * @Description jklx的中文含义是： 监控类型
	 */
	public String getJklx() {
		return jklx;
	}
	/**
	 * @Description jklx的中文含义是： 监控类型
	 */
	public void setJklx(String jklx) {
		this.jklx = jklx;
	}
	/**
	 * @Description jksppath的中文含义是： 离线监控视频文件路径
	 */
	public String getJksppath() {
		return jksppath;
	}
	/**
	 * @Description jksppath的中文含义是： 离线监控视频文件路径
	 */
	public void setJksppath(String jksppath) {
		this.jksppath = jksppath;
	}
	/**
	 * @Description orderno的中文含义是：排序
	 */
	public Integer getOrderno() {
		return orderno;
	}
	/**
	 * @Description orderno的中文含义是：排序
	 */
	public void setOrderno(Integer orderno) {
		this.orderno = orderno;
	}
	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	public void setAaa027(String aaa027){ 
		this.aaa027 = aaa027;
	}
	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	public String getAaa027(){
		return aaa027;
	}
	/**
	 * @Description aaa027的中文含义是： 明厨亮灶监控对象id
	 */
	public String getCamorgid() {
		return camorgid;
	}
	/**
	 * @Description aaa027的中文含义是： 明厨亮灶监控对象id
	 */
	public void setCamorgid(String camorgid) {
		this.camorgid = camorgid;
	}

	
}