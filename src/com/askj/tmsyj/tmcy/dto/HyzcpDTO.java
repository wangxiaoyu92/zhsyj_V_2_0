package com.askj.tmsyj.tmcy.dto;


import java.sql.Date;
import java.sql.Timestamp;

/**
 * @Description  HyzcpDTO 的中文含义是: 一周菜谱表
 * @Creation     2017/03/21 17:46:13
 * @Written      Create Tool By zjf 
 **/
public class HyzcpDTO {
	/**
	 * @Description hyzcpid的中文含义是： 一周菜谱表id
	 */
	private String hyzcpid;

	/**
	 * @Description cprq的中文含义是： 菜谱日期
	 */
	private Date cprq;

	/**
	 * @Description cpxq的中文含义是： 菜谱星期
	 */
	private String cpxq;

	/**
	 * @Description jccc的中文含义是： 就餐餐次aaa100=jccc
	 */
	private String jccc;
	private String jcccinfo;

	/**
	 * @Description cpmc的中文含义是： 菜谱名称
	 */
	private String cpmc;

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
	 * @Description hyzcpid的中文含义是： 一周菜谱表id
	 */
	public void setHyzcpid(String hyzcpid){ 
		this.hyzcpid = hyzcpid;
	}
	/**
	 * @Description hyzcpid的中文含义是： 一周菜谱表id
	 */
	public String getHyzcpid(){
		return hyzcpid;
	}
	/**
	 * @Description cprq的中文含义是： 菜谱日期
	 */
	public void setCprq(Date cprq){ 
		this.cprq = cprq;
	}
	/**
	 * @Description cprq的中文含义是： 菜谱日期
	 */
	public Date getCprq(){
		return cprq;
	}
	/**
	 * @Description cpxq的中文含义是： 菜谱星期
	 */
	public void setCpxq(String cpxq){ 
		this.cpxq = cpxq;
	}
	/**
	 * @Description cpxq的中文含义是： 菜谱星期
	 */
	public String getCpxq(){
		return cpxq;
	}
	/**
	 * @Description jccc的中文含义是： 就餐餐次aaa100=jccc
	 */
	public void setJccc(String jccc){ 
		this.jccc = jccc;
	}
	/**
	 * @Description jccc的中文含义是： 就餐餐次aaa100=jccc
	 */
	public String getJccc(){
		return jccc;
	}
	/**
	 * @Description cpmc的中文含义是： 菜谱名称
	 */
	public void setCpmc(String cpmc){ 
		this.cpmc = cpmc;
	}
	/**
	 * @Description cpmc的中文含义是： 菜谱名称
	 */
	public String getCpmc(){
		return cpmc;
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
	 * @Description comid的中文含义是： comid
	 */
	public void setComid(String comid){ 
		this.comid = comid;
	}
	/**
	 * @Description comid的中文含义是： comid
	 */
	public String getComid(){
		return comid;
	}
	
}