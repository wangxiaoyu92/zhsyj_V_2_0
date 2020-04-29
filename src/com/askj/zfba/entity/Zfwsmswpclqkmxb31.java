package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSMSWPCLQKMXB31的中文含义是: 没收物品处理情况明细表; InnoDB free: 76800 kB
 * @Creation     2016/03/21 11:25:34
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSMSWPCLQKMXB31")
public class Zfwsmswpclqkmxb31 {
	/**
	 * @Description mswpmxbid的中文含义是： 没收物品明细表ID
	 */
	@Column
	@Name
	private String mswpmxbid;

	/**
	 * @Description mswpclqdid的中文含义是： 没收物品处理清单ID
	 */
	@Column
	private String mswpclqdid;

	/**
	 * @Description msmxwpmc的中文含义是： 物品名称
	 */
	@Column
	private String msmxwpmc;

	/**
	 * @Description msmxgg的中文含义是： 规格
	 */
	@Column
	private String msmxgg;

	/**
	 * @Description msmxdw的中文含义是： 单位
	 */
	@Column
	private String msmxdw;

	/**
	 * @Description msmxsl的中文含义是： 数量
	 */
	@Column
	private String msmxsl;

	/**
	 * @Description msmxclfs的中文含义是： 处理方式
	 */
	@Column
	private String msmxclfs;

	/**
	 * @Description msmxdd的中文含义是： 地点
	 */
	@Column
	private String msmxdd;

	/**
	 * @Description msmxjbr的中文含义是： 经办人
	 */
	@Column
	private String msmxjbr;

	/**
	 * @Description msmxbz的中文含义是： 备注
	 */
	@Column
	private String msmxbz;

	
		/**
	 * @Description mswpmxbid的中文含义是： 没收物品明细表ID
	 */
	public void setMswpmxbid(String mswpmxbid){ 
		this.mswpmxbid = mswpmxbid;
	}
	/**
	 * @Description mswpmxbid的中文含义是： 没收物品明细表ID
	 */
	public String getMswpmxbid(){
		return mswpmxbid;
	}
	/**
	 * @Description mswpclqdid的中文含义是： 没收物品处理清单ID
	 */
	public void setMswpclqdid(String mswpclqdid){ 
		this.mswpclqdid = mswpclqdid;
	}
	/**
	 * @Description mswpclqdid的中文含义是： 没收物品处理清单ID
	 */
	public String getMswpclqdid(){
		return mswpclqdid;
	}
	/**
	 * @Description msmxwpmc的中文含义是： 物品名称
	 */
	public void setMsmxwpmc(String msmxwpmc){ 
		this.msmxwpmc = msmxwpmc;
	}
	/**
	 * @Description msmxwpmc的中文含义是： 物品名称
	 */
	public String getMsmxwpmc(){
		return msmxwpmc;
	}
	/**
	 * @Description msmxgg的中文含义是： 规格
	 */
	public void setMsmxgg(String msmxgg){ 
		this.msmxgg = msmxgg;
	}
	/**
	 * @Description msmxgg的中文含义是： 规格
	 */
	public String getMsmxgg(){
		return msmxgg;
	}
	/**
	 * @Description msmxdw的中文含义是： 单位
	 */
	public void setMsmxdw(String msmxdw){ 
		this.msmxdw = msmxdw;
	}
	/**
	 * @Description msmxdw的中文含义是： 单位
	 */
	public String getMsmxdw(){
		return msmxdw;
	}
	/**
	 * @Description msmxsl的中文含义是： 数量
	 */
	public void setMsmxsl(String msmxsl){ 
		this.msmxsl = msmxsl;
	}
	/**
	 * @Description msmxsl的中文含义是： 数量
	 */
	public String getMsmxsl(){
		return msmxsl;
	}
	/**
	 * @Description msmxclfs的中文含义是： 处理方式
	 */
	public void setMsmxclfs(String msmxclfs){ 
		this.msmxclfs = msmxclfs;
	}
	/**
	 * @Description msmxclfs的中文含义是： 处理方式
	 */
	public String getMsmxclfs(){
		return msmxclfs;
	}
	/**
	 * @Description msmxdd的中文含义是： 地点
	 */
	public void setMsmxdd(String msmxdd){ 
		this.msmxdd = msmxdd;
	}
	/**
	 * @Description msmxdd的中文含义是： 地点
	 */
	public String getMsmxdd(){
		return msmxdd;
	}
	/**
	 * @Description msmxjbr的中文含义是： 经办人
	 */
	public void setMsmxjbr(String msmxjbr){ 
		this.msmxjbr = msmxjbr;
	}
	/**
	 * @Description msmxjbr的中文含义是： 经办人
	 */
	public String getMsmxjbr(){
		return msmxjbr;
	}
	/**
	 * @Description msmxbz的中文含义是： 备注
	 */
	public void setMsmxbz(String msmxbz){ 
		this.msmxbz = msmxbz;
	}
	/**
	 * @Description msmxbz的中文含义是： 备注
	 */
	public String getMsmxbz(){
		return msmxbz;
	}

	
}