package com.askj.spsy.dto;

/**
 * @Description  QJHKCHZB的中文含义是: 进货库存汇总表; InnoDB free: 2713600 kBDTO
 * @Creation     2016/07/11 16:15:45
 * @Written      Create Tool By zjf 
 **/
public class QjhkchzbDTO {
	
	/**
	 * @Description cphyclbz的中文含义是： 材料或原材料标志，手动添加
	 */
	private String cphyclbz;
	/**
	 * @Description proname的中文含义是： 商品名，手动添加
	 */
	private String proname;
	
	public String getProname() {
		return proname;
	}
	public void setProname(String proname) {
		this.proname = proname;
	}
	public String getCphyclbz() {
		return cphyclbz;
	}
	public void setCphyclbz(String cphyclbz) {
		this.cphyclbz = cphyclbz;
	}
	/**
	 * @Description qjhkchzb的中文含义是： 
	 */
	private String qjhkchzb;

	/**
	 * @Description comid的中文含义是： 企业ID
	 */
	private String comid;

	/**
	 * @Description proid的中文含义是： 产品id
	 */
	private String proid;

	/**
	 * @Description jhkcjhsl的中文含义是： 进货数量
	 */
	private String jhkcjhsl;

	/**
	 * @Description jhkcchsl的中文含义是： 出库数量
	 */
	private String jhkcchsl;

	/**
	 * @Description jhkcjysl的中文含义是： 结余数量
	 */
	private String jhkcjysl;

	/**
	 * @Description projldw的中文含义是： 产品计量单位
	 */
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