package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

/**
 * @Description  ZFAJZFWS的中文含义是: 案件对应的执法文书; InnoDB free: 2754560 kB
 * @Creation     2016/04/21 15:34:31
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFAJZFWS")
public class Zfajzfws {
	/**
	 * @Description ajzfwsid的中文含义是： 
	 */
	@Column
	@Name
	private String ajzfwsid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description zfwsdmz的中文含义是： 执法文书编号，代码表中的编号
	 */
	@Column
	private String zfwsdmz;

	/**
	 * @Description zfwsqtbid的中文含义是： 执法文书所在表ID
	 */
	@Column
	private String zfwsqtbid;

	/**
	 * @Description zfwstzbz的中文含义是： 执法文书填写标志0未1已
	 */
	@Column
	private String zfwstzbz;

	/**
	 * @Description zfwsuserid的中文含义是： 操作员ID
	 */
	@Column
	private String zfwsuserid;

	/**
	 * @Description zfwsczyxm的中文含义是： 操作员姓名
	 */
	@Column
	private String zfwsczyxm;

	/**
	 * @Description zfwsczsj的中文含义是： 操作时间
	 */
	@Column
	private String zfwsczsj;

	/**
	 * @Description psbh的中文含义是： 流程编码
	 */
	@Column
	private String psbh;

	/**
	 * @Description nodeid的中文含义是： 流程节点ID
	 */
	@Column
	private String nodeid;
	
	/**
	 * @Description nodename的中文含义是： 流程节点名称
	 */
	@Column
	private String nodename;
	@Column
	private String fytzbz;

	public String getFytzbz() {
		return fytzbz;
	}

	public void setFytzbz(String fytzbz) {
		this.fytzbz = fytzbz;
	}

	/**
	 * @Description ajzfwsid的中文含义是： 
	 */
	public void setAjzfwsid(String ajzfwsid){ 
		this.ajzfwsid = ajzfwsid;
	}
	/**
	 * @Description ajzfwsid的中文含义是： 
	 */
	public String getAjzfwsid(){
		return ajzfwsid;
	}
	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	public void setAjdjid(String ajdjid){ 
		this.ajdjid = ajdjid;
	}
	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	public String getAjdjid(){
		return ajdjid;
	}
	/**
	 * @Description zfwsdmz的中文含义是： 执法文书编号，代码表中的编号
	 */
	public void setZfwsdmz(String zfwsdmz){ 
		this.zfwsdmz = zfwsdmz;
	}
	/**
	 * @Description zfwsdmz的中文含义是： 执法文书编号，代码表中的编号
	 */
	public String getZfwsdmz(){
		return zfwsdmz;
	}
	/**
	 * @Description zfwsqtbid的中文含义是： 执法文书所在表ID
	 */
	public void setZfwsqtbid(String zfwsqtbid){ 
		this.zfwsqtbid = zfwsqtbid;
	}
	/**
	 * @Description zfwsqtbid的中文含义是： 执法文书所在表ID
	 */
	public String getZfwsqtbid(){
		return zfwsqtbid;
	}
	/**
	 * @Description zfwstzbz的中文含义是： 执法文书填写标志0未1已
	 */
	public void setZfwstzbz(String zfwstzbz){ 
		this.zfwstzbz = zfwstzbz;
	}
	/**
	 * @Description zfwstzbz的中文含义是： 执法文书填写标志0未1已
	 */
	public String getZfwstzbz(){
		return zfwstzbz;
	}
	/**
	 * @Description zfwsuserid的中文含义是： 操作员ID
	 */
	public void setZfwsuserid(String zfwsuserid){ 
		this.zfwsuserid = zfwsuserid;
	}
	/**
	 * @Description zfwsuserid的中文含义是： 操作员ID
	 */
	public String getZfwsuserid(){
		return zfwsuserid;
	}
	/**
	 * @Description zfwsczyxm的中文含义是： 操作员姓名
	 */
	public void setZfwsczyxm(String zfwsczyxm){ 
		this.zfwsczyxm = zfwsczyxm;
	}
	/**
	 * @Description zfwsczyxm的中文含义是： 操作员姓名
	 */
	public String getZfwsczyxm(){
		return zfwsczyxm;
	}
	/**
	 * @Description zfwsczsj的中文含义是： 操作时间
	 */
	public void setZfwsczsj(String zfwsczsj){ 
		this.zfwsczsj = zfwsczsj;
	}
	/**
	 * @Description zfwsczsj的中文含义是： 操作时间
	 */
	public String getZfwsczsj(){
		return zfwsczsj;
	}
	/**
	 * @Description psbh的中文含义是： 流程编码
	 */
	public void setPsbh(String psbh){ 
		this.psbh = psbh;
	}
	/**
	 * @Description psbh的中文含义是： 流程编码
	 */
	public String getPsbh(){
		return psbh;
	}
	/**
	 * @Description nodeid的中文含义是： 流程节点ID
	 */
	public void setNodeid(String nodeid){ 
		this.nodeid = nodeid;
	}
	/**
	 * @Description nodeid的中文含义是： 流程节点ID
	 */
	public String getNodeid(){
		return nodeid;
	}
	public String getNodename() {
		return nodename;
	}
	public void setNodename(String nodename) {
		this.nodename = nodename;
	}

}