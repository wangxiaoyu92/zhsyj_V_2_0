package com.askj.zfba.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSTZYJS25的中文含义是: 听证意见书; InnoDB free: 2726912 kBDTO
 * @Creation     2016/06/08 15:48:21
 * @Written      Create Tool By zjf 
 **/
public class Zfwstzyjs25DTO {

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
	 * @Description zfwsdmz的中文含义是： 执法文书代码值
	 */
	private String zfwsdmz;
	public String getZfwsdmz() {
		return zfwsdmz;
	}
	public void setZfwsdmz(String zfwsdmz) {
		this.zfwsdmz = zfwsdmz;
	}
	/**
	 * @Description tzyjsid的中文含义是： 听证意见书ID
	 */
	private String tzyjsid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	private String ajdjid;

	/**
	 * @Description tzyjtzkssj的中文含义是： 听证开始时间
	 */
	private String tzyjtzkssj;

	/**
	 * @Description tzyjtzjssj的中文含义是： 听证结束时间
	 */
	private String tzyjtzjssj;

	/**
	 * @Description tzyjtzzcr的中文含义是： 听证主持人
	 */
	private String tzyjtzzcr;

	/**
	 * @Description tzyjtzfs的中文含义是： 听证方式
	 */
	private String tzyjtzfs;

	/**
	 * @Description tzyjajjbqk的中文含义是： 案件基本情况
	 */
	private String tzyjajjbqk;

	/**
	 * @Description tzyjsqrzyly的中文含义是： 申请人主要理由
	 */
	private String tzyjsqrzyly;

	/**
	 * @Description tzyj的中文含义是： 听证意见
	 */
	private String tzyj;

	/**
	 * @Description tzyjzcrqz的中文含义是： 听证主持人签字
	 */
	private String tzyjzcrqz;

	/**
	 * @Description tzyjzcrqzrq的中文含义是： 听证主持人签字日期
	 */
	private String tzyjzcrqzrq;

	/**
	 * @Description ajdjay的中文含义是： 案由
	 */
	private String ajdjay;

	/**
	 * @Description tzyjdsr的中文含义是： 当事人
	 */
	private String tzyjdsr;

	/**
	 * @Description tzyjfddbr的中文含义是： 法定代表人（负责人）
	 */
	private String tzyjfddbr;

	
		/**
	 * @Description tzyjsid的中文含义是： 听证意见书ID
	 */
	public void setTzyjsid(String tzyjsid){ 
		this.tzyjsid = tzyjsid;
	}
	/**
	 * @Description tzyjsid的中文含义是： 听证意见书ID
	 */
	public String getTzyjsid(){
		return tzyjsid;
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
	 * @Description tzyjtzkssj的中文含义是： 听证开始时间
	 */
	public void setTzyjtzkssj(String tzyjtzkssj){ 
		this.tzyjtzkssj = tzyjtzkssj;
	}
	/**
	 * @Description tzyjtzkssj的中文含义是： 听证开始时间
	 */
	public String getTzyjtzkssj(){
		return tzyjtzkssj;
	}
	/**
	 * @Description tzyjtzjssj的中文含义是： 听证结束时间
	 */
	public void setTzyjtzjssj(String tzyjtzjssj){ 
		this.tzyjtzjssj = tzyjtzjssj;
	}
	/**
	 * @Description tzyjtzjssj的中文含义是： 听证结束时间
	 */
	public String getTzyjtzjssj(){
		return tzyjtzjssj;
	}
	/**
	 * @Description tzyjtzzcr的中文含义是： 听证主持人
	 */
	public void setTzyjtzzcr(String tzyjtzzcr){ 
		this.tzyjtzzcr = tzyjtzzcr;
	}
	/**
	 * @Description tzyjtzzcr的中文含义是： 听证主持人
	 */
	public String getTzyjtzzcr(){
		return tzyjtzzcr;
	}
	/**
	 * @Description tzyjtzfs的中文含义是： 听证方式
	 */
	public void setTzyjtzfs(String tzyjtzfs){ 
		this.tzyjtzfs = tzyjtzfs;
	}
	/**
	 * @Description tzyjtzfs的中文含义是： 听证方式
	 */
	public String getTzyjtzfs(){
		return tzyjtzfs;
	}
	/**
	 * @Description tzyjajjbqk的中文含义是： 案件基本情况
	 */
	public void setTzyjajjbqk(String tzyjajjbqk){ 
		this.tzyjajjbqk = tzyjajjbqk;
	}
	/**
	 * @Description tzyjajjbqk的中文含义是： 案件基本情况
	 */
	public String getTzyjajjbqk(){
		return tzyjajjbqk;
	}
	/**
	 * @Description tzyjsqrzyly的中文含义是： 申请人主要理由
	 */
	public void setTzyjsqrzyly(String tzyjsqrzyly){ 
		this.tzyjsqrzyly = tzyjsqrzyly;
	}
	/**
	 * @Description tzyjsqrzyly的中文含义是： 申请人主要理由
	 */
	public String getTzyjsqrzyly(){
		return tzyjsqrzyly;
	}
	/**
	 * @Description tzyj的中文含义是： 听证意见
	 */
	public void setTzyj(String tzyj){ 
		this.tzyj = tzyj;
	}
	/**
	 * @Description tzyj的中文含义是： 听证意见
	 */
	public String getTzyj(){
		return tzyj;
	}
	/**
	 * @Description tzyjzcrqz的中文含义是： 听证主持人签字
	 */
	public void setTzyjzcrqz(String tzyjzcrqz){ 
		this.tzyjzcrqz = tzyjzcrqz;
	}
	/**
	 * @Description tzyjzcrqz的中文含义是： 听证主持人签字
	 */
	public String getTzyjzcrqz(){
		return tzyjzcrqz;
	}
	/**
	 * @Description tzyjzcrqzrq的中文含义是： 听证主持人签字日期
	 */
	public void setTzyjzcrqzrq(String tzyjzcrqzrq){ 
		this.tzyjzcrqzrq = tzyjzcrqzrq;
	}
	/**
	 * @Description tzyjzcrqzrq的中文含义是： 听证主持人签字日期
	 */
	public String getTzyjzcrqzrq(){
		return tzyjzcrqzrq;
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
	 * @Description tzyjdsr的中文含义是： 当事人
	 */
	public void setTzyjdsr(String tzyjdsr){ 
		this.tzyjdsr = tzyjdsr;
	}
	/**
	 * @Description tzyjdsr的中文含义是： 当事人
	 */
	public String getTzyjdsr(){
		return tzyjdsr;
	}
	/**
	 * @Description tzyjfddbr的中文含义是： 法定代表人（负责人）
	 */
	public void setTzyjfddbr(String tzyjfddbr){ 
		this.tzyjfddbr = tzyjfddbr;
	}
	/**
	 * @Description tzyjfddbr的中文含义是： 法定代表人（负责人）
	 */
	public String getTzyjfddbr(){
		return tzyjfddbr;
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