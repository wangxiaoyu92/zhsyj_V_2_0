package com.askj.spsy.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  QJHKCHZB的中文含义是: 进货库存汇总表; InnoDB free: 2713600 kB
 * @Creation     2016/07/11 16:15:56
 * @Written      Create Tool By zjf 
 **/
@Table(value = "QJHKCHZB")
public class Qjhkchzb {
	/**
	 * @Description qjhkchzb的中文含义是： 
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_qjhkchzb')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_qjhkchzb.nextval from dual"))
	private String qjhkchzb;

	/**
	 * @Description comid的中文含义是： 企业ID
	 */
	@Column
	private String comid;

	/**
	 * @Description proid的中文含义是： 产品id
	 */
	@Column
	private String proid;

	/**
	 * @Description jhkcjhsl的中文含义是： 进货数量
	 */
	@Column
	private String jhkcjhsl;

	/**
	 * @Description jhkcchsl的中文含义是： 出库数量
	 */
	@Column
	private String jhkcchsl;

	/**
	 * @Description jhkcjysl的中文含义是： 结余数量
	 */
	@Column
	private String jhkcjysl;
	
	/**
	 * @Description projldw的中文含义是： 产品计量单位
	 */
	@Column
	private String projldw;

	
	/**
	 * @Description qjhkchzb的中文含义是： 
	 */
	public void setQjhkchzb(String qjhkchzb){ 
		this.qjhkchzb = qjhkchzb;
	}
	/**
	 * @Description qjhkchzb的中文含义是： 
	 */
	public String getQjhkchzb(){
		return qjhkchzb;
	}
	/**
	 * @Description comid的中文含义是： 企业ID
	 */
	public void setComid(String comid){ 
		this.comid = comid;
	}
	/**
	 * @Description comid的中文含义是： 企业ID
	 */
	public String getComid(){
		return comid;
	}
	/**
	 * @Description proid的中文含义是： 产品id
	 */
	public void setProid(String proid){ 
		this.proid = proid;
	}
	/**
	 * @Description proid的中文含义是： 产品id
	 */
	public String getProid(){
		return proid;
	}
	/**
	 * @Description jhkcjhsl的中文含义是： 进货数量
	 */
	public void setJhkcjhsl(String jhkcjhsl){ 
		this.jhkcjhsl = jhkcjhsl;
	}
	/**
	 * @Description jhkcjhsl的中文含义是： 进货数量
	 */
	public String getJhkcjhsl(){
		return jhkcjhsl;
	}
	/**
	 * @Description jhkcchsl的中文含义是： 出库数量
	 */
	public void setJhkcchsl(String jhkcchsl){ 
		this.jhkcchsl = jhkcchsl;
	}
	/**
	 * @Description jhkcchsl的中文含义是： 出库数量
	 */
	public String getJhkcchsl(){
		return jhkcchsl;
	}
	/**
	 * @Description jhkcjysl的中文含义是： 结余数量
	 */
	public void setJhkcjysl(String jhkcjysl){ 
		this.jhkcjysl = jhkcjysl;
	}
	/**
	 * @Description jhkcjysl的中文含义是： 结余数量
	 */
	public String getJhkcjysl(){
		return jhkcjysl;
	}
	/**
	 * @Description projldw的中文含义是： 产品计量单位
	 */
	public String getProjldw() {
		return projldw;
	}
	/**
	 * @Description projldw的中文含义是： 产品计量单位
	 */
	public void setProjldw(String projldw) {
		this.projldw = projldw;
	}

	
}