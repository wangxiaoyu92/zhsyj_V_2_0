package com.askj.zfba.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;

import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSJYJCJYJDGZS14的中文含义是: 检验（检测、检疫、鉴定）告知书; InnoDB free: 76800 kBDTO
 * @Creation     2016/03/16 14:11:06
 * @Written      Create Tool By zjf 
 **/
public class Zfwsjyjcjyjdgzs14DTO {

	//扩展开始
	/**
	 * 一个方法被多个地方调用，这个表示是那个地方用，以区别处理
	 */
	private String operatetype;
	/**
	 * comid
	 */
	private String comid;

	/**
	 * 当事人
	 */
	private String jygzdsr;
	//扩展结束

	/**
	 * @Description jygzsid的中文含义是： 检验告知书ID
	 */
	private String jygzsid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	private String ajdjid;

	/**
	 * @Description jygzwsbh的中文含义是： 文书编号
	 */
	private String jygzwsbh;

	/**
	 * @Description jygzjzwsbh的中文含义是： 记载文书编号
	 */
	private String jygzjzwsbh;

	/**
	 * @Description jygzjzwsmc的中文含义是： 记载文书名称
	 */
	private String jygzjzwsmc;

	/**
	 * @Description jygzksrq的中文含义是： 开始年月日
	 */
	private String jygzksrq;

	/**
	 * @Description jygzjsrq的中文含义是： 结束年月日
	 */
	private String jygzjsrq;

	/**
	 * @Description jygzgzrq的中文含义是： 盖章日期 
	 */
	private String jygzgzrq;
	
	/**
	 * @Description commc的中文含义是： 企业名称 手动添加
	 */
	private String commc;

	/**
	 * @Description zfwsdmz的中文含义是： 执法文书代码值
	 */
	private String zfwsdmz;
	
	/**
	 * @Description zfwsqtbid的中文含义是：执法文书所在表ID
	 */
	private String zfwsqtbid;
	/**
	 * @Description jygzdsrqz的中文含义是：当事人签字
	 */ 
	private String jygzdsrqz;
	
	/**
	 * @Description jygzdsrqzrq的中文含义是： 当事人日期
	 */ 
	private String jygzdsrqzrq;
	/**
	 * @Description jygzqzcsjdsmcjbh的中文含义是： 强制措施决定书名称及编号
	 */ 
	private String jygzqzcsjdsmcjbh;
	/**
	 * @Description jygzqzcsqxsyrq的中文含义是：强制措施期限顺延日期
	 */ 
	private String jygzqzcsqxsyrq;
	
	
	public String getJygzqzcsjdsmcjbh() {
		return jygzqzcsjdsmcjbh;
	}
	public String getJygzqzcsqxsyrq() {
		return jygzqzcsqxsyrq;
	}
	public void setJygzqzcsjdsmcjbh(String jygzqzcsjdsmcjbh) {
		this.jygzqzcsjdsmcjbh = jygzqzcsjdsmcjbh;
	}
	public void setJygzqzcsqxsyrq(String jygzqzcsqxsyrq) {
		this.jygzqzcsqxsyrq = jygzqzcsqxsyrq;
	}
	public String getJygzdsrqz() {
		return jygzdsrqz;
	}
	public String getJygzdsrqzrq() {
		return jygzdsrqzrq;
	}
	public void setJygzdsrqz(String jygzdsrqz) {
		this.jygzdsrqz = jygzdsrqz;
	}
	public void setJygzdsrqzrq(String jygzdsrqzrq) {
		this.jygzdsrqzrq = jygzdsrqzrq;
	}
	/**
	 * @Description zfwsdmz的中文含义是： 执法文书代码值
	 */
	public String getZfwsdmz() {
		return zfwsdmz;
	}
	/**
	 * @Description zfwsdmz的中文含义是： 执法文书代码值
	 */
	public void setZfwsdmz(String zfwsdmz) {
		this.zfwsdmz = zfwsdmz;
	}
	/**
	 * @Description zfwsqtbid的中文含义是： 执法文书所在表ID
	 */
	public String getZfwsqtbid() {
		return zfwsqtbid;
	}
	/**
	 * @Description zfwsqtbid的中文含义是：执法文书所在表ID
	 */
	public void setZfwsqtbid(String zfwsqtbid) {
		this.zfwsqtbid = zfwsqtbid;
	}
	
	public String getCommc() {
		return commc;
	}
	public void setCommc(String commc) {
		this.commc = commc;
	}
	/**
	 * @Description jygzsid的中文含义是： 检验告知书ID
	 */
	public void setJygzsid(String jygzsid){ 
		this.jygzsid = jygzsid;
	}
	/**
	 * @Description jygzsid的中文含义是： 检验告知书ID
	 */
	public String getJygzsid(){
		return jygzsid;
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
	 * @Description jygzwsbh的中文含义是： 文书编号
	 */
	public void setJygzwsbh(String jygzwsbh){ 
		this.jygzwsbh = jygzwsbh;
	}
	/**
	 * @Description jygzwsbh的中文含义是： 文书编号
	 */
	public String getJygzwsbh(){
		return jygzwsbh;
	}
	/**
	 * @Description jygzjzwsbh的中文含义是： 记载文书编号
	 */
	public void setJygzjzwsbh(String jygzjzwsbh){ 
		this.jygzjzwsbh = jygzjzwsbh;
	}
	/**
	 * @Description jygzjzwsbh的中文含义是： 记载文书编号
	 */
	public String getJygzjzwsbh(){
		return jygzjzwsbh;
	}
	/**
	 * @Description jygzjzwsmc的中文含义是： 记载文书名称
	 */
	public void setJygzjzwsmc(String jygzjzwsmc){ 
		this.jygzjzwsmc = jygzjzwsmc;
	}
	/**
	 * @Description jygzjzwsmc的中文含义是： 记载文书名称
	 */
	public String getJygzjzwsmc(){
		return jygzjzwsmc;
	}
	/**
	 * @Description jygzksrq的中文含义是： 开始年月日
	 */
	public void setJygzksrq(String jygzksrq){ 
		this.jygzksrq = jygzksrq;
	}
	/**
	 * @Description jygzksrq的中文含义是： 开始年月日
	 */
	public String getJygzksrq(){
		return jygzksrq;
	}
	/**
	 * @Description jygzjsrq的中文含义是： 结束年月日
	 */
	public void setJygzjsrq(String jygzjsrq){ 
		this.jygzjsrq = jygzjsrq;
	}
	/**
	 * @Description jygzjsrq的中文含义是： 结束年月日
	 */
	public String getJygzjsrq(){
		return jygzjsrq;
	}
	/**
	 * @Description jygzgzrq的中文含义是： 盖章日期 
	 */
	public void setJygzgzrq(String jygzgzrq){ 
		this.jygzgzrq = jygzgzrq;
	}
	/**
	 * @Description jygzgzrq的中文含义是： 盖章日期 
	 */
	public String getJygzgzrq(){
		return jygzgzrq;
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

	public String getJygzdsr() {
		return jygzdsr;
	}

	public void setJygzdsr(String jygzdsr) {
		this.jygzdsr = jygzdsr;
	}
}