package com.askj.baseinfo.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  PCYZDSZDETAIL的中文含义是: 常用字段值明细设置; InnoDB free: 2726912 kB
 * @Creation     2016/06/08 15:46:22
 * @Written      Create Tool By zjf 
 **/
@Table(value = "PCYZDSZDETAIL")
public class Pcyzdszdetail {
	/**
	 * @Description pcyzdszmainid的中文含义是： 
	 */
	@Column
	
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_pcyzdszmainid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_pcyzdszmainid.nextval from dual"))
	private String pcyzdszmainid;

	/**
	 * @Description pcyzdszdetailid的中文含义是： 常用字段值明细设置id
	 */
	@Column
	@Name
	private String pcyzdszdetailid;

	/**
	 * @Description avalue的中文含义是： 值
	 */
	@Column
	private String avalue;

	/**
	 * @Description aae140的中文含义是： 大类
	 */
	@Column
	private String aae140;
	
	/**
	 * @Description czyxm的中文含义是： 操作员姓名
	 */
	@Column
	private String czyxm;
	
	/**
	 * @Description czsj的中文含义是： 操作时间
	 */
	@Column
	private String czsj;	

	
		/**
	 * @Description pcyzdszmainid的中文含义是： 
	 */
	public void setPcyzdszmainid(String pcyzdszmainid){ 
		this.pcyzdszmainid = pcyzdszmainid;
	}
	/**
	 * @Description pcyzdszmainid的中文含义是： 
	 */
	public String getPcyzdszmainid(){
		return pcyzdszmainid;
	}
	/**
	 * @Description pcyzdszdetailid的中文含义是： 常用字段值明细设置id
	 */
	public void setPcyzdszdetailid(String pcyzdszdetailid){ 
		this.pcyzdszdetailid = pcyzdszdetailid;
	}
	/**
	 * @Description pcyzdszdetailid的中文含义是： 常用字段值明细设置id
	 */
	public String getPcyzdszdetailid(){
		return pcyzdszdetailid;
	}
	/**
	 * @Description avalue的中文含义是： 值
	 */
	public void setAvalue(String avalue){ 
		this.avalue = avalue;
	}
	/**
	 * @Description avalue的中文含义是： 值
	 */
	public String getAvalue(){
		return avalue;
	}
	/**
	 * @Description aae140的中文含义是： 大类
	 */
	public void setAae140(String aae140){ 
		this.aae140 = aae140;
	}
	/**
	 * @Description aae140的中文含义是： 大类
	 */
	public String getAae140(){
		return aae140;
	}
	public String getCzyxm() {
		return czyxm;
	}
	public void setCzyxm(String czyxm) {
		this.czyxm = czyxm;
	}
	public String getCzsj() {
		return czsj;
	}
	public void setCzsj(String czsj) {
		this.czsj = czsj;
	}
	
	

	
}