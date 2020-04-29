package com.askj.zfba.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;

import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSXXDJBCWPCLJDS11的中文含义是: 先行登记保存物品处理决定书; InnoDB free: 2723840 kBDTO
 * @Creation     2016/06/02 15:26:57
 * @Written      Create Tool By zjf 
 **/
public class Zfwsxxdjbcwpcljds11DTO {


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
	 * @Description xxcljdsid的中文含义是： 先行登记处理决定书ID
	 */
	private String xxcljdsid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	private String ajdjid;

	/**
	 * @Description xxclgzrq的中文含义是： 盖章日期
	 */
	private String xxclgzrq;

	/**
	 * @Description xxclwsbh的中文含义是： 文书编号
	 */
	private String xxclwsbh;

	/**
	 * @Description xxcldsr的中文含义是： 当事人
	 */
	private String xxcldsr;

	/**
	 * @Description xxcltzsnyr的中文含义是： 通知书年月日
	 */
	private String xxcltzsnyr;

	/**
	 * @Description xxcltzswsbh的中文含义是： 先行登记保存物品通知书文书编号
	 */
	private String xxcltzswsbh;

	/**
	 * @Description xxclfjxx的中文含义是： 附件
	 */
	private String xxclfjxx;

	/**
	 * @Description xxclwbnr的中文含义是： 文本内容
	 */
	private String xxclwbnr;

	/**
	 * @Description xxcldsrqz的中文含义是：当事人签字
	 */
	private String xxcldsrqz;
	
	/**
	 * @Description xxcldsrqzrq的中文含义是： 当事人签字日期
	 */
	private String xxcldsrqzrq;
	
	/**
	 * @Description xxclzfry1的中文含义是： 执法人员1
	 */
	private String xxclzfry1;
	
	/**
	 * @Description xxclzfry2的中文含义是： 执法人员2
	 */
	private String xxclzfry2;
	
	/**
	 * @Description xxclzfzh1的中文含义是： 执法证号1
	 */
	private String xxclzfzh1;
	
	/**
	 * @Description xxclzfzh2的中文含义是： 执法证号2
	 */
	private String xxclzfzh2;
	
	/**
	 * @Description xxclzfryqzrq的中文含义是： 执法人员签字日期
	 */
	private String xxclzfryqzrq;
	 
	 
	public String getXxcldsrqz() {
		return xxcldsrqz;
	}
	public String getXxcldsrqzrq() {
		return xxcldsrqzrq;
	}
	public String getXxclzfry1() {
		return xxclzfry1;
	}
	public String getXxclzfry2() {
		return xxclzfry2;
	}
	public String getXxclzfzh1() {
		return xxclzfzh1;
	}
	public String getXxclzfzh2() {
		return xxclzfzh2;
	}
	public String getXxclzfryqzrq() {
		return xxclzfryqzrq;
	}
	public void setXxcldsrqz(String xxcldsrqz) {
		this.xxcldsrqz = xxcldsrqz;
	}
	public void setXxcldsrqzrq(String xxcldsrqzrq) {
		this.xxcldsrqzrq = xxcldsrqzrq;
	}
	public void setXxclzfry1(String xxclzfry1) {
		this.xxclzfry1 = xxclzfry1;
	}
	public void setXxclzfry2(String xxclzfry2) {
		this.xxclzfry2 = xxclzfry2;
	}
	public void setXxclzfzh1(String xxclzfzh1) {
		this.xxclzfzh1 = xxclzfzh1;
	}
	public void setXxclzfzh2(String xxclzfzh2) {
		this.xxclzfzh2 = xxclzfzh2;
	}
	public void setXxclzfryqzrq(String xxclzfryqzrq) {
		this.xxclzfryqzrq = xxclzfryqzrq;
	}
	/**
	 * @Description xxclwbnr的中文含义是： 文本内容
	 */
	public void setXxclwbnr(String xxclwbnr){ 
		this.xxclwbnr = xxclwbnr;
	}
	/**
	 * @Description xxclwbnr的中文含义是： 文本内容
	 */
	public String getXxclwbnr(){
		return xxclwbnr;
	}
	
	/**
	 * @Description xxcljdsid的中文含义是： 先行登记处理决定书ID
	 */
	public void setXxcljdsid(String xxcljdsid){ 
		this.xxcljdsid = xxcljdsid;
	}
	/**
	 * @Description xxcljdsid的中文含义是： 先行登记处理决定书ID
	 */
	public String getXxcljdsid(){
		return xxcljdsid;
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
	 * @Description xxclgzrq的中文含义是： 盖章日期
	 */
	public void setXxclgzrq(String xxclgzrq){ 
		this.xxclgzrq = xxclgzrq;
	}
	/**
	 * @Description xxclgzrq的中文含义是： 盖章日期
	 */
	public String getXxclgzrq(){
		return xxclgzrq;
	}
	/**
	 * @Description xxclwsbh的中文含义是： 文书编号
	 */
	public void setXxclwsbh(String xxclwsbh){ 
		this.xxclwsbh = xxclwsbh;
	}
	/**
	 * @Description xxclwsbh的中文含义是： 文书编号
	 */
	public String getXxclwsbh(){
		return xxclwsbh;
	}
	/**
	 * @Description xxcldsr的中文含义是： 当事人
	 */
	public void setXxcldsr(String xxcldsr){ 
		this.xxcldsr = xxcldsr;
	}
	/**
	 * @Description xxcldsr的中文含义是： 当事人
	 */
	public String getXxcldsr(){
		return xxcldsr;
	}
	/**
	 * @Description xxcltzsnyr的中文含义是： 通知书年月日
	 */
	public void setXxcltzsnyr(String xxcltzsnyr){ 
		this.xxcltzsnyr = xxcltzsnyr;
	}
	/**
	 * @Description xxcltzsnyr的中文含义是： 通知书年月日
	 */
	public String getXxcltzsnyr(){
		return xxcltzsnyr;
	}
	/**
	 * @Description xxcltzswsbh的中文含义是： 先行登记保存物品通知书文书编号
	 */
	public void setXxcltzswsbh(String xxcltzswsbh){ 
		this.xxcltzswsbh = xxcltzswsbh;
	}
	/**
	 * @Description xxcltzswsbh的中文含义是： 先行登记保存物品通知书文书编号
	 */
	public String getXxcltzswsbh(){
		return xxcltzswsbh;
	}
	/**
	 * @Description xxclfjxx的中文含义是： 附件
	 */
	public void setXxclfjxx(String xxclfjxx){ 
		this.xxclfjxx = xxclfjxx;
	}
	/**
	 * @Description xxclfjxx的中文含义是： 附件
	 */
	public String getXxclfjxx(){
		return xxclfjxx;
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