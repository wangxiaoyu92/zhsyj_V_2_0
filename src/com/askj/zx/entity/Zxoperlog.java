package com.askj.zx.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Table;

/**
 * @Description  ZXOPERLOG的中文含义是: 操作日志表
 * @Creation     2016/01/20 16:51:59
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZXOPERLOG")
public class Zxoperlog {
	/**
	 * @Description logid的中文含义是： 操作日志ID
	 */
	@Column
	private Integer logid;

	/**
	 * @Description logtime的中文含义是： 操作时间
	 */
	@Column
	private String logtime;

	/**
	 * @Description userid的中文含义是： 操作人员ID
	 */
	@Column
	private Integer userid;

	/**
	 * @Description logip的中文含义是： 操作人IP
	 */
	@Column
	private String logip;

	/**
	 * @Description logtype的中文含义是： 操作类型  1:增加 ；2：修改数据；3：启用操作；4：禁用操作
	 */
	@Column
	private String logtype;

	/**
	 * @Description logmodule的中文含义是： 操作模块
	 */
	@Column
	private String logmodule;

	
		/**
	 * @Description logid的中文含义是： 操作日志ID
	 */
	public void setLogid(Integer logid){ 
		this.logid = logid;
	}
	/**
	 * @Description logid的中文含义是： 操作日志ID
	 */
	public Integer getLogid(){
		return logid;
	}
	/**
	 * @Description logtime的中文含义是： 操作时间
	 */
	public void setLogtime(String logtime){ 
		this.logtime = logtime;
	}
	/**
	 * @Description logtime的中文含义是： 操作时间
	 */
	public String getLogtime(){
		return logtime;
	}
	/**
	 * @Description userid的中文含义是： 操作人员ID
	 */
	public void setUserid(Integer userid){ 
		this.userid = userid;
	}
	/**
	 * @Description userid的中文含义是： 操作人员ID
	 */
	public Integer getUserid(){
		return userid;
	}
	/**
	 * @Description logip的中文含义是： 操作人IP
	 */
	public void setLogip(String logip){ 
		this.logip = logip;
	}
	/**
	 * @Description logip的中文含义是： 操作人IP
	 */
	public String getLogip(){
		return logip;
	}
	/**
	 * @Description logtype的中文含义是： 操作类型  1:增加 ；2：修改数据；3：启用操作；4：禁用操作
	 */
	public void setLogtype(String logtype){ 
		this.logtype = logtype;
	}
	/**
	 * @Description logtype的中文含义是： 操作类型  1:增加 ；2：修改数据；3：启用操作；4：禁用操作
	 */
	public String getLogtype(){
		return logtype;
	}
	/**
	 * @Description logmodule的中文含义是： 操作模块
	 */
	public void setLogmodule(String logmodule){ 
		this.logmodule = logmodule;
	}
	/**
	 * @Description logmodule的中文含义是： 操作模块
	 */
	public String getLogmodule(){
		return logmodule;
	}

	
}