package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  ZFWSZDGXTZS43的中文含义是: 指定管辖通知书43; InnoDB free: 2669568 kB
 * @Creation     2016/09/09 15:13:38
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSZDGXTZS43")
public class Zfwszdgxtzs43 {
	/**
	 * @Description zdgxtzsid的中文含义是： id
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_zdgxtzsid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_zdgxtzsid.nextval from dual"))
	private String zdgxtzsid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记id
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description zfwsbh的中文含义是： 执法文书编号
	 */
	@Column
	private String zfwsbh;

	/**
	 * @Description tzdwmc的中文含义是： 通知单位名称
	 */
	@Column
	private String tzdwmc;

	/**
	 * @Description gyaj的中文含义是： 关于案件
	 */
	@Column
	private String gyaj;

	/**
	 * @Description zdgxdw的中文含义是： 指定管辖单位
	 */
	@Column
	private String zdgxdw;

	/**
	 * @Description xzjgmc的中文含义是： 行政机关名称
	 */
	@Column
	private String xzjgmc;

	/**
	 * @Description gzrq的中文含义是： 盖章日期
	 */
	@Column
	private String gzrq;

	
		/**
	 * @Description zdgxtzsid的中文含义是： id
	 */
	public void setZdgxtzsid(String zdgxtzsid){ 
		this.zdgxtzsid = zdgxtzsid;
	}
	/**
	 * @Description zdgxtzsid的中文含义是： id
	 */
	public String getZdgxtzsid(){
		return zdgxtzsid;
	}
	/**
	 * @Description ajdjid的中文含义是： 案件登记id
	 */
	public void setAjdjid(String ajdjid){ 
		this.ajdjid = ajdjid;
	}
	/**
	 * @Description ajdjid的中文含义是： 案件登记id
	 */
	public String getAjdjid(){
		return ajdjid;
	}
	/**
	 * @Description zfwsbh的中文含义是： 执法文书编号
	 */
	public void setZfwsbh(String zfwsbh){ 
		this.zfwsbh = zfwsbh;
	}
	/**
	 * @Description zfwsbh的中文含义是： 执法文书编号
	 */
	public String getZfwsbh(){
		return zfwsbh;
	}
	/**
	 * @Description tzdwmc的中文含义是： 通知单位名称
	 */
	public void setTzdwmc(String tzdwmc){ 
		this.tzdwmc = tzdwmc;
	}
	/**
	 * @Description tzdwmc的中文含义是： 通知单位名称
	 */
	public String getTzdwmc(){
		return tzdwmc;
	}
	/**
	 * @Description gyaj的中文含义是： 关于案件
	 */
	public void setGyaj(String gyaj){ 
		this.gyaj = gyaj;
	}
	/**
	 * @Description gyaj的中文含义是： 关于案件
	 */
	public String getGyaj(){
		return gyaj;
	}
	/**
	 * @Description zdgxdw的中文含义是： 指定管辖单位
	 */
	public void setZdgxdw(String zdgxdw){ 
		this.zdgxdw = zdgxdw;
	}
	/**
	 * @Description zdgxdw的中文含义是： 指定管辖单位
	 */
	public String getZdgxdw(){
		return zdgxdw;
	}
	/**
	 * @Description xzjgmc的中文含义是： 行政机关名称
	 */
	public void setXzjgmc(String xzjgmc){ 
		this.xzjgmc = xzjgmc;
	}
	/**
	 * @Description xzjgmc的中文含义是： 行政机关名称
	 */
	public String getXzjgmc(){
		return xzjgmc;
	}
	/**
	 * @Description gzrq的中文含义是： 盖章日期
	 */
	public void setGzrq(String gzrq){ 
		this.gzrq = gzrq;
	}
	/**
	 * @Description gzrq的中文含义是： 盖章日期
	 */
	public String getGzrq(){
		return gzrq;
	}

	
}