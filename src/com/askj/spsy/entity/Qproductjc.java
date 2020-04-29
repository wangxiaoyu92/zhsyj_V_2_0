package com.askj.spsy.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  QPRODUCTJC的中文含义是: 产品检测信息表
 * @Creation     2016/07/21 11:43:03
 * @Written      Create Tool By zjf 
 **/
@Table(value = "QPRODUCTJC")
public class Qproductjc {
	/**
	 * @Description qproductjcid的中文含义是： 产品检测信息表id
	 */
	@Column
	@Name
	private String qproductjcid;

	/**
	 * @Description proid的中文含义是： 产品ID
	 */
	@Column
	private String proid;

	/**
	 * @Description jcitem的中文含义是： 检测项目
	 */
	@Column
	private String jcitem;

	/**
	 * @Description jcjg的中文含义是： 检测结果
	 */
	@Column
	private String jcjg;

	/**
	 * @Description jcdw的中文含义是： 检测单位
	 */
	@Column
	private String jcdw;

	/**
	 * @Description jcsj的中文含义是： 检测时间
	 */
	@Column
	private String jcsj;

	/**
	 * @Description jcpc的中文含义是： 检测批次
	 */
	@Column
	private String jcpc;

	/**
	 * @Description jcjcy的中文含义是： 检验员
	 */
	@Column
	private String jcjcy;

	
		/**
	 * @Description qproductjcid的中文含义是： 产品检测信息表id
	 */
	public void setQproductjcid(String qproductjcid){ 
		this.qproductjcid = qproductjcid;
	}
	/**
	 * @Description qproductjcid的中文含义是： 产品检测信息表id
	 */
	public String getQproductjcid(){
		return qproductjcid;
	}
	/**
	 * @Description proid的中文含义是： 产品ID
	 */
	public void setProid(String proid){ 
		this.proid = proid;
	}
	/**
	 * @Description proid的中文含义是： 产品ID
	 */
	public String getProid(){
		return proid;
	}
	/**
	 * @Description jcitem的中文含义是： 检测项目
	 */
	public void setJcitem(String jcitem){ 
		this.jcitem = jcitem;
	}
	/**
	 * @Description jcitem的中文含义是： 检测项目
	 */
	public String getJcitem(){
		return jcitem;
	}
	/**
	 * @Description jcjg的中文含义是： 检测结果
	 */
	public void setJcjg(String jcjg){ 
		this.jcjg = jcjg;
	}
	/**
	 * @Description jcjg的中文含义是： 检测结果
	 */
	public String getJcjg(){
		return jcjg;
	}
	/**
	 * @Description jcdw的中文含义是： 检测单位
	 */
	public void setJcdw(String jcdw){ 
		this.jcdw = jcdw;
	}
	/**
	 * @Description jcdw的中文含义是： 检测单位
	 */
	public String getJcdw(){
		return jcdw;
	}
	/**
	 * @Description jcsj的中文含义是： 检测时间
	 */
	public void setJcsj(String jcsj){ 
		this.jcsj = jcsj;
	}
	/**
	 * @Description jcsj的中文含义是： 检测时间
	 */
	public String getJcsj(){
		return jcsj;
	}
	/**
	 * @Description jcpc的中文含义是： 检测批次
	 */
	public void setJcpc(String jcpc){ 
		this.jcpc = jcpc;
	}
	/**
	 * @Description jcpc的中文含义是： 检测批次
	 */
	public String getJcpc(){
		return jcpc;
	}
	/**
	 * @Description jcjcy的中文含义是： 检验员
	 */
	public void setJcjcy(String jcjcy){ 
		this.jcjcy = jcjcy;
	}
	/**
	 * @Description jcjcy的中文含义是： 检验员
	 */
	public String getJcjcy(){
		return jcjcy;
	}

	
}