package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSWPQDMX37的中文含义是: InnoDB free: 2759680 kB
 * @Creation     2016/03/30 11:42:56
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSWPQDMX37")
public class Zfwswpqdmx37 {
	/**
	 * @Description wpqdmxid的中文含义是： 物品清单明细ID
	 */
	@Column
	@Name
	private String wpqdmxid;

	/**
	 * @Description wpqdid的中文含义是： 表37主键物品清单ID
	 */
	@Column
	private String wpqdid;

	/**
	 * @Description wpmxpm的中文含义是： 品名
	 */
	@Column
	private String wpmxpm;

	/**
	 * @Description wpmxbsscqy的中文含义是： 标示生产企业或经营单位
	 */
	@Column
	private String wpmxbsscqy;

	/**
	 * @Description wpmxgg的中文含义是： 规格
	 */
	@Column
	private String wpmxgg;

	/**
	 * @Description wpmxscpc的中文含义是： 生产批号或生产日期
	 */
	@Column
	private String wpmxscpc;

	/**
	 * @Description wpmxsl的中文含义是： 数量
	 */
	@Column
	private String wpmxsl;

	/**
	 * @Description wpmxdj的中文含义是： 单价
	 */
	@Column
	private String wpmxdj;

	/**
	 * @Description wpmxbz的中文含义是： 包装
	 */
	@Column
	private String wpmxbz;

	/**
	 * @Description wpmxbeiz的中文含义是： 备注
	 */
	@Column
	private String wpmxbeiz;

	
		/**
	 * @Description wpqdmxid的中文含义是： 物品清单明细ID
	 */
	public void setWpqdmxid(String wpqdmxid){ 
		this.wpqdmxid = wpqdmxid;
	}
	/**
	 * @Description wpqdmxid的中文含义是： 物品清单明细ID
	 */
	public String getWpqdmxid(){
		return wpqdmxid;
	}
	/**
	 * @Description wpqdid的中文含义是： 表37主键物品清单ID
	 */
	public void setWpqdid(String wpqdid){ 
		this.wpqdid = wpqdid;
	}
	/**
	 * @Description wpqdid的中文含义是： 表37主键物品清单ID
	 */
	public String getWpqdid(){
		return wpqdid;
	}
	/**
	 * @Description wpmxpm的中文含义是： 品名
	 */
	public void setWpmxpm(String wpmxpm){ 
		this.wpmxpm = wpmxpm;
	}
	/**
	 * @Description wpmxpm的中文含义是： 品名
	 */
	public String getWpmxpm(){
		return wpmxpm;
	}
	/**
	 * @Description wpmxbsscqy的中文含义是： 标示生产企业或经营单位
	 */
	public void setWpmxbsscqy(String wpmxbsscqy){ 
		this.wpmxbsscqy = wpmxbsscqy;
	}
	/**
	 * @Description wpmxbsscqy的中文含义是： 标示生产企业或经营单位
	 */
	public String getWpmxbsscqy(){
		return wpmxbsscqy;
	}
	/**
	 * @Description wpmxgg的中文含义是： 规格
	 */
	public void setWpmxgg(String wpmxgg){ 
		this.wpmxgg = wpmxgg;
	}
	/**
	 * @Description wpmxgg的中文含义是： 规格
	 */
	public String getWpmxgg(){
		return wpmxgg;
	}
	/**
	 * @Description wpmxscpc的中文含义是： 生产批号或生产日期
	 */
	public void setWpmxscpc(String wpmxscpc){ 
		this.wpmxscpc = wpmxscpc;
	}
	/**
	 * @Description wpmxscpc的中文含义是： 生产批号或生产日期
	 */
	public String getWpmxscpc(){
		return wpmxscpc;
	}
	/**
	 * @Description wpmxsl的中文含义是： 数量
	 */
	public void setWpmxsl(String wpmxsl){ 
		this.wpmxsl = wpmxsl;
	}
	/**
	 * @Description wpmxsl的中文含义是： 数量
	 */
	public String getWpmxsl(){
		return wpmxsl;
	}
	/**
	 * @Description wpmxdj的中文含义是： 单价
	 */
	public void setWpmxdj(String wpmxdj){ 
		this.wpmxdj = wpmxdj;
	}
	/**
	 * @Description wpmxdj的中文含义是： 单价
	 */
	public String getWpmxdj(){
		return wpmxdj;
	}
	/**
	 * @Description wpmxbz的中文含义是： 包装
	 */
	public void setWpmxbz(String wpmxbz){ 
		this.wpmxbz = wpmxbz;
	}
	/**
	 * @Description wpmxbz的中文含义是： 包装
	 */
	public String getWpmxbz(){
		return wpmxbz;
	}
	/**
	 * @Description wpmxbeiz的中文含义是： 备注
	 */
	public void setWpmxbeiz(String wpmxbeiz){ 
		this.wpmxbeiz = wpmxbeiz;
	}
	/**
	 * @Description wpmxbeiz的中文含义是： 备注
	 */
	public String getWpmxbeiz(){
		return wpmxbeiz;
	}

	
}