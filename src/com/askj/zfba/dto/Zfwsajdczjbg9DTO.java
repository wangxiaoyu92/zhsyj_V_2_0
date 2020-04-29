package com.askj.zfba.dto;

import org.nutz.dao.entity.annotation.*; 
/**
 * @Description  ZFWSAJDCZJBG9的中文含义是: 案件调查终结报告; InnoDB free: 75776 kBDTO
 * @Creation     2016/03/15 09:52:18
 * @Written      Create Tool By wanghao 
 **/
public class Zfwsajdczjbg9DTO {

	//扩展开始
	/**
	 * 一个方法被多个地方调用，这个表示是那个地方用，以区别处理
	 */
	private String operatetype;
	/**
	 * comid
	 */
	private String comid;

	//扩展结束

	/**
	 * @Description ajdczjbgid的中文含义是： 案件调查终结报告ID
	 */
	
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_ajdczjbgid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_ajdczjbgid.nextval from dual"))
	private String ajdczjbgid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	
	private String ajdjid;

	/**
	 * @Description dczjdsrjbqk的中文含义是： 当事人基本情况
	 */
	
	private String dczjdsrjbqk;

	/**
	 * @Description dczjwfss的中文含义是： 违法事实
	 */
	
	private String dczjwfss;

	/**
	 * @Description dczjzjcl的中文含义是： 证据材料
	 */
	
	private String dczjzjcl;

	/**
	 * @Description dczjcfyj的中文含义是： 处罚依据
	 */
	
	private String dczjcfyj;

	/**
	 * @Description dczjcfjy的中文含义是： 处罚建议
	 */
	
	private String dczjcfjy;

	/**
	 * @Description dczjajcbrqz的中文含义是： 案件承办人签字1
	 */
	
	private String dczjajcbrqz;

	/**
	 * @Description dczjajcbrqzrq的中文含义是： 案件承办人签字日期
	 */
	
	private String dczjajcbrqzrq;

	/**
	 * @Description dczjwfflfgtk的中文含义是： 违法法律法规条款
	 */
	
	private String dczjwfflfgtk;

	/**
	 * @Description dczjwfxwdc的中文含义是： 违法行为等次
	 */
	
	private String dczjwfxwdc;

	/**
	 * @Description dczjysxzcfdyjhzl的中文含义是： 应受行政处罚的依据和种类
	 */
	
	private String dczjysxzcfdyjhzl;

	/**
	 * @Description ajdjay的中文含义是： 案由
	 */
	
	private String ajdjay;

	/**
	 * @Description dczjajcbrqz2的中文含义是： 案件承办人签字2
	 */
	
	private String dczjajcbrqz2;
	/**
	 * @Description zfwsdmz的中文含义是： 
	 */
	
	private String zfwsdmz;

	
		public String getZfwsdmz() {
		return zfwsdmz;
	}
	public void setZfwsdmz(String zfwsdmz) {
		this.zfwsdmz = zfwsdmz;
	}
		/**
	 * @Description ajdczjbgid的中文含义是： 案件调查终结报告ID
	 */
	public void setAjdczjbgid(String ajdczjbgid){ 
		this.ajdczjbgid = ajdczjbgid;
	}
	/**
	 * @Description ajdczjbgid的中文含义是： 案件调查终结报告ID
	 */
	public String getAjdczjbgid(){
		return ajdczjbgid;
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
	 * @Description dczjdsrjbqk的中文含义是： 当事人基本情况
	 */
	public void setDczjdsrjbqk(String dczjdsrjbqk){ 
		this.dczjdsrjbqk = dczjdsrjbqk;
	}
	/**
	 * @Description dczjdsrjbqk的中文含义是： 当事人基本情况
	 */
	public String getDczjdsrjbqk(){
		return dczjdsrjbqk;
	}
	/**
	 * @Description dczjwfss的中文含义是： 违法事实
	 */
	public void setDczjwfss(String dczjwfss){ 
		this.dczjwfss = dczjwfss;
	}
	/**
	 * @Description dczjwfss的中文含义是： 违法事实
	 */
	public String getDczjwfss(){
		return dczjwfss;
	}
	/**
	 * @Description dczjzjcl的中文含义是： 证据材料
	 */
	public void setDczjzjcl(String dczjzjcl){ 
		this.dczjzjcl = dczjzjcl;
	}
	/**
	 * @Description dczjzjcl的中文含义是： 证据材料
	 */
	public String getDczjzjcl(){
		return dczjzjcl;
	}
	/**
	 * @Description dczjcfyj的中文含义是： 处罚依据
	 */
	public void setDczjcfyj(String dczjcfyj){ 
		this.dczjcfyj = dczjcfyj;
	}
	/**
	 * @Description dczjcfyj的中文含义是： 处罚依据
	 */
	public String getDczjcfyj(){
		return dczjcfyj;
	}
	/**
	 * @Description dczjcfjy的中文含义是： 处罚建议
	 */
	public void setDczjcfjy(String dczjcfjy){ 
		this.dczjcfjy = dczjcfjy;
	}
	/**
	 * @Description dczjcfjy的中文含义是： 处罚建议
	 */
	public String getDczjcfjy(){
		return dczjcfjy;
	}
	/**
	 * @Description dczjajcbrqz的中文含义是： 案件承办人签字1
	 */
	public void setDczjajcbrqz(String dczjajcbrqz){ 
		this.dczjajcbrqz = dczjajcbrqz;
	}
	/**
	 * @Description dczjajcbrqz的中文含义是： 案件承办人签字1
	 */
	public String getDczjajcbrqz(){
		return dczjajcbrqz;
	}
	/**
	 * @Description dczjajcbrqzrq的中文含义是： 案件承办人签字日期
	 */
	public void setDczjajcbrqzrq(String dczjajcbrqzrq){ 
		this.dczjajcbrqzrq = dczjajcbrqzrq;
	}
	/**
	 * @Description dczjajcbrqzrq的中文含义是： 案件承办人签字日期
	 */
	public String getDczjajcbrqzrq(){
		return dczjajcbrqzrq;
	}
	/**
	 * @Description dczjwfflfgtk的中文含义是： 违法法律法规条款
	 */
	public void setDczjwfflfgtk(String dczjwfflfgtk){ 
		this.dczjwfflfgtk = dczjwfflfgtk;
	}
	/**
	 * @Description dczjwfflfgtk的中文含义是： 违法法律法规条款
	 */
	public String getDczjwfflfgtk(){
		return dczjwfflfgtk;
	}
	/**
	 * @Description dczjwfxwdc的中文含义是： 违法行为等次
	 */
	public void setDczjwfxwdc(String dczjwfxwdc){ 
		this.dczjwfxwdc = dczjwfxwdc;
	}
	/**
	 * @Description dczjwfxwdc的中文含义是： 违法行为等次
	 */
	public String getDczjwfxwdc(){
		return dczjwfxwdc;
	}
	/**
	 * @Description dczjysxzcfdyjhzl的中文含义是： 应受行政处罚的依据和种类
	 */
	public void setDczjysxzcfdyjhzl(String dczjysxzcfdyjhzl){ 
		this.dczjysxzcfdyjhzl = dczjysxzcfdyjhzl;
	}
	/**
	 * @Description dczjysxzcfdyjhzl的中文含义是： 应受行政处罚的依据和种类
	 */
	public String getDczjysxzcfdyjhzl(){
		return dczjysxzcfdyjhzl;
	}
	/**
	 * @Description ajdjay的中文含义是： 案由
	 */
	public void setAjdjay(String ajdjay){ 
		this.ajdjay = ajdjay;
	}
	/**
	 * @Description ajdjay的中文含义是： 案由
	 */
	public String getAjdjay(){
		return ajdjay;
	}
	/**
	 * @Description dczjajcbrqz2的中文含义是： 案件承办人签字2
	 */
	public void setDczjajcbrqz2(String dczjajcbrqz2){ 
		this.dczjajcbrqz2 = dczjajcbrqz2;
	}
	/**
	 * @Description dczjajcbrqz2的中文含义是： 案件承办人签字2
	 */
	public String getDczjajcbrqz2(){
		return dczjajcbrqz2;
	}

	public String getOperatetype() {
		return operatetype;
	}

	public void setOperatetype(String operatetype) {
		this.operatetype = operatetype;
	}

	public String getComid() {
		return comid;
	}

	public void setComid(String comid) {
		this.comid = comid;
	}
}