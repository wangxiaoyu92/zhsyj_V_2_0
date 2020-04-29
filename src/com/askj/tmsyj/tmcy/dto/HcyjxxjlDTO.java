package com.askj.tmsyj.tmcy.dto; 

import java.sql.Timestamp;

/**
 * @Description  HcyjxxjlDTO 的中文含义是: 餐饮具洗消记录
 * @Creation     2017/03/22 09:33:16
 * @Written      Create Tool By zjf 
 **/
public class HcyjxxjlDTO {
	/**
	 * @Description hcyjxxjlid的中文含义是： 餐饮具洗消记录id
	 */
	private String hcyjxxjlid;

	/**
	 * @Description cjmc的中文含义是： 餐具名称
	 */
	private String cjmc;

	/**
	 * @Description xdfs的中文含义是： 消毒方式aaa100=xdfs
	 */
	private String xdfs;
	private String xdfsinfo;

	/**
	 * @Description wnd的中文含义是： 温/浓度
	 */
	private String wnd;

	/**
	 * @Description xdkssj的中文含义是： 消毒开始时间
	 */
	private Timestamp xdkssj;

	/**
	 * @Description xdjssj的中文含义是： 消毒结束时间
	 */
	private Timestamp xdjssj;

	/**
	 * @Description aae011的中文含义是： 操作员
	 */
	private String aae011;

	/**
	 * @Description aae036的中文含义是： 操作时间
	 */
	private Timestamp aae036;

	/**
	 * @Description comid的中文含义是： 企业id
	 */
	private String comid;
	private String commc;
	private String fjpath;
	 
	public String getFjpath() {
		return fjpath;
	}
	public void setFjpath(String fjpath) {
		this.fjpath = fjpath;
	}
	public String getCommc() {
		return commc;
	}
	public void setCommc(String commc) {
		this.commc = commc;
	}
	public String getXdfsinfo() {
		return xdfsinfo;
	}
	public void setXdfsinfo(String xdfsinfo) {
		this.xdfsinfo = xdfsinfo;
	}
		/**
	 * @Description hcyjxxjlid的中文含义是： 餐饮具洗消记录id
	 */
	public void setHcyjxxjlid(String hcyjxxjlid){ 
		this.hcyjxxjlid = hcyjxxjlid;
	}
	/**
	 * @Description hcyjxxjlid的中文含义是： 餐饮具洗消记录id
	 */
	public String getHcyjxxjlid(){
		return hcyjxxjlid;
	}
	/**
	 * @Description cjmc的中文含义是： 餐具名称
	 */
	public void setCjmc(String cjmc){ 
		this.cjmc = cjmc;
	}
	/**
	 * @Description cjmc的中文含义是： 餐具名称
	 */
	public String getCjmc(){
		return cjmc;
	}
	/**
	 * @Description xdfs的中文含义是： 消毒方式aaa100=xdfs
	 */
	public void setXdfs(String xdfs){ 
		this.xdfs = xdfs;
	}
	/**
	 * @Description xdfs的中文含义是： 消毒方式aaa100=xdfs
	 */
	public String getXdfs(){
		return xdfs;
	}
	/**
	 * @Description wnd的中文含义是： 温/浓度
	 */
	public void setWnd(String wnd){ 
		this.wnd = wnd;
	}
	/**
	 * @Description wnd的中文含义是： 温/浓度
	 */
	public String getWnd(){
		return wnd;
	}
	/**
	 * @Description xdkssj的中文含义是： 消毒开始时间
	 */
	public void setXdkssj(Timestamp xdkssj){ 
		this.xdkssj = xdkssj;
	}
	/**
	 * @Description xdkssj的中文含义是： 消毒开始时间
	 */
	public Timestamp getXdkssj(){
		return xdkssj;
	}
	/**
	 * @Description xdjssj的中文含义是： 消毒结束时间
	 */
	public void setXdjssj(Timestamp xdjssj){ 
		this.xdjssj = xdjssj;
	}
	/**
	 * @Description xdjssj的中文含义是： 消毒结束时间
	 */
	public Timestamp getXdjssj(){
		return xdjssj;
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
	/**
	 * @Description comid的中文含义是： 企业id
	 */
	public void setComid(String comid){ 
		this.comid = comid;
	}
	/**
	 * @Description comid的中文含义是： 企业id
	 */
	public String getComid(){
		return comid;
	}

	
}