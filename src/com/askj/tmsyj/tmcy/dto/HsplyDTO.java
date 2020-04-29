package com.askj.tmsyj.tmcy.dto;

import java.sql.Timestamp;

/**
 * @Description  HsplyDTO 的中文含义是: 食品留样表
 * @Creation     2017/03/21 16:18:55
 * @Written      Create Tool By zjf 
 **/
public class HsplyDTO {
	/**
	 * @Description hsplyid的中文含义是： 企业食品留样表id
	 */
	private String hsplyid;

	/**
	 * @Description jccc的中文含义是： 留样餐次aaa100=jccc
	 */
	private String jccc;
	private String jcccinfo;

	/**
	 * @Description splysj的中文含义是： 留样时间
	 */
	private Timestamp splysj;

	/**
	 * @Description splypz的中文含义是： 留样品种
	 */
	private String splypz;

	/**
	 * @Description splyry的中文含义是： 留样人
	 */
	private String splyry;

	/**
	 * @Description aae011的中文含义是： 操作员
	 */
	private String aae011;

	/**
	 * @Description aae036的中文含义是： 操作时间
	 */
	private Timestamp aae036;
	/**
	 * @Description comid的中文含义是： comid
	 */ 
	private String comid;
	private String fjpath;
	
	public String getComid() {
		return comid;
	}
	public void setComid(String comid) {
		this.comid = comid;
	}
	public String getFjpath() {
		return fjpath;
	}
	public void setFjpath(String fjpath) {
		this.fjpath = fjpath;
	}
	public String getJcccinfo() {
		return jcccinfo;
	}
	public void setJcccinfo(String jcccinfo) {
		this.jcccinfo = jcccinfo;
	}
		/**
	 * @Description hsplyid的中文含义是： 企业食品留样表id
	 */
	public void setHsplyid(String hsplyid){ 
		this.hsplyid = hsplyid;
	}
	/**
	 * @Description hsplyid的中文含义是： 企业食品留样表id
	 */
	public String getHsplyid(){
		return hsplyid;
	}
	/**
	 * @Description jccc的中文含义是： 留样餐次aaa100=jccc
	 */
	public void setJccc(String jccc){ 
		this.jccc = jccc;
	}
	/**
	 * @Description jccc的中文含义是： 留样餐次aaa100=jccc
	 */
	public String getJccc(){
		return jccc;
	}
	/**
	 * @Description splysj的中文含义是： 留样时间
	 */
	public void setSplysj(Timestamp splysj){ 
		this.splysj = splysj;
	}
	/**
	 * @Description splysj的中文含义是： 留样时间
	 */
	public Timestamp getSplysj(){
		return splysj;
	}
	/**
	 * @Description splypz的中文含义是： 留样品种
	 */
	public void setSplypz(String splypz){ 
		this.splypz = splypz;
	}
	/**
	 * @Description splypz的中文含义是： 留样品种
	 */
	public String getSplypz(){
		return splypz;
	}
	/**
	 * @Description splyry的中文含义是： 留样人
	 */
	public void setSplyry(String splyry){ 
		this.splyry = splyry;
	}
	/**
	 * @Description splyry的中文含义是： 留样人
	 */
	public String getSplyry(){
		return splyry;
	}
	/**
	 * @Description aae011的中文含义是： 操作员
	 */
	public void setAae011(String aae011){ 
		this.aae011 = aae011;
	}
	/**
	 * @Description aae011的中文含义是： 操作员
	 */
	public String getAae011(){
		return aae011;
	}
	/**
	 * @Description aae036的中文含义是： 操作时间
	 */
	public void setAae036(Timestamp aae036){ 
		this.aae036 = aae036;
	}
	/**
	 * @Description aae036的中文含义是： 操作时间
	 */
	public Timestamp getAae036(){
		return aae036;
	}

	
}