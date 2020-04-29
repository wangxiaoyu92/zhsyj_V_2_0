package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFAJZFWSMB的中文含义是: 案件对应的执法文书模板; InnoDB free: 2760704 kB
 * @Creation     2016/04/11 15:55:32
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFAJZFWSMB")
public class Zfajzfwsmb {
	/**
	 * @Description zfwsmbid的中文含义是： 
	 */
	@Column
	@Name
	private String zfwsmbid;

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
	 * @Description zfwsmbmc的中文含义是： 执法文书模板名称
	 */
	@Column
	private String zfwsmbmc;
	
	/**
	 * @Description zfwsmbczy的中文含义是： 执法文书模板操作员
	 */
	@Column
	private String zfwsmbczy;
	
	/**
	 * @Description zfwsmbczsj的中文含义是： 执法文书模板操作时间
	 */
	@Column
	private String zfwsmbczsj;	
	
	/**
	 * @Description aaa027的中文含义是： 地区编码
	 */
	@Column
	private String aaa027;		
	
	/**
	 * @Description userid的中文含义是： 操作员id，为了控制不是自动添加的模板不允许删除
	 */
	@Column
	private String userid;	
	
	/**
	 * @Description aaa146的中文含义是： 行政区划名称
	 */
	@Column
	private String aaa146;		

	
		/**
	 * @Description zfwsmbid的中文含义是： 
	 */
	public void setZfwsmbid(String zfwsmbid){ 
		this.zfwsmbid = zfwsmbid;
	}
	/**
	 * @Description zfwsmbid的中文含义是： 
	 */
	public String getZfwsmbid(){
		return zfwsmbid;
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
	 * @Description zfwsmbmc的中文含义是： 执法文书模板名称
	 */
	public void setZfwsmbmc(String zfwsmbmc){ 
		this.zfwsmbmc = zfwsmbmc;
	}
	/**
	 * @Description zfwsmbmc的中文含义是： 执法文书模板名称
	 */
	public String getZfwsmbmc(){
		return zfwsmbmc;
	}
	public String getZfwsmbczy() {
		return zfwsmbczy;
	}
	public void setZfwsmbczy(String zfwsmbczy) {
		this.zfwsmbczy = zfwsmbczy;
	}
	public String getZfwsmbczsj() {
		return zfwsmbczsj;
	}
	public void setZfwsmbczsj(String zfwsmbczsj) {
		this.zfwsmbczsj = zfwsmbczsj;
	}
	public String getAaa027() {
		return aaa027;
	}
	public void setAaa027(String aaa027) {
		this.aaa027 = aaa027;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getAaa146() {
		return aaa146;
	}
	public void setAaa146(String aaa146) {
		this.aaa146 = aaa146;
	}
	
	

	
}