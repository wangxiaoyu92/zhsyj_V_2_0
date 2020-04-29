package com.askj.baseinfo.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;

import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  PCYZDSZMAIN的中文含义是: 常用字段值设置主表; InnoDB free: 2726912 kBDTO
 * @Creation     2016/06/08 16:04:05
 * @Written      Create Tool By zjf 
 **/
public class PcyzdszmainDTO {
	
	//表PCYZDSZDETAIL的中文含义是: 常用字段值明细设置; 
		/**
		 * @Description pcyzdszdetailid的中文含义是： 常用字段值明细设置id
		 */
		private String pcyzdszdetailid;

		/**
		 * @Description avalue的中文含义是： 值
		 */
		private String avalue;

		/**
		 * @Description aae140的中文含义是： 大类
		 */
		private String aae140;
		/**
		 * @Description czyxm的中文含义是： 操作员姓名
		 */
		private String czyxm;

		/**
		 * @Description czsj的中文含义是： 操作时间
		 */
		private String czsj;			
	
	
	
	/**
	 * @Description pcyzdszmainid的中文含义是： id
	 */
	private String pcyzdszmainid;

	/**
	 * @Description tabname的中文含义是： 表名
	 */
	private String tabname;

	/**
	 * @Description tabnamedesc的中文含义是： 表描述
	 */
	private String tabnamedesc;

	/**
	 * @Description colname的中文含义是： 列名
	 */
	private String colname;

	/**
	 * @Description colnamedesc的中文含义是： 列描述
	 */
	private String colnamedesc;

	
		/**
	 * @Description pcyzdszmainid的中文含义是： id
	 */
	public void setPcyzdszmainid(String pcyzdszmainid){ 
		this.pcyzdszmainid = pcyzdszmainid;
	}
	/**
	 * @Description pcyzdszmainid的中文含义是： id
	 */
	public String getPcyzdszmainid(){
		return pcyzdszmainid;
	}
	/**
	 * @Description tabname的中文含义是： 表名
	 */
	public void setTabname(String tabname){ 
		this.tabname = tabname;
	}
	/**
	 * @Description tabname的中文含义是： 表名
	 */
	public String getTabname(){
		return tabname;
	}
	/**
	 * @Description tabnamedesc的中文含义是： 表描述
	 */
	public void setTabnamedesc(String tabnamedesc){ 
		this.tabnamedesc = tabnamedesc;
	}
	/**
	 * @Description tabnamedesc的中文含义是： 表描述
	 */
	public String getTabnamedesc(){
		return tabnamedesc;
	}
	/**
	 * @Description colname的中文含义是： 列名
	 */
	public void setColname(String colname){ 
		this.colname = colname;
	}
	/**
	 * @Description colname的中文含义是： 列名
	 */
	public String getColname(){
		return colname;
	}
	/**
	 * @Description colnamedesc的中文含义是： 列描述
	 */
	public void setColnamedesc(String colnamedesc){ 
		this.colnamedesc = colnamedesc;
	}
	/**
	 * @Description colnamedesc的中文含义是： 列描述
	 */
	public String getColnamedesc(){
		return colnamedesc;
	}
	public String getPcyzdszdetailid() {
		return pcyzdszdetailid;
	}
	public void setPcyzdszdetailid(String pcyzdszdetailid) {
		this.pcyzdszdetailid = pcyzdszdetailid;
	}
	public String getAvalue() {
		return avalue;
	}
	public void setAvalue(String avalue) {
		this.avalue = avalue;
	}
	public String getAae140() {
		return aae140;
	}
	public void setAae140(String aae140) {
		this.aae140 = aae140;
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