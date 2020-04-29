package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSXXDJBCWPCLJDS11的中文含义是: 先行登记保存物品处理决定书; InnoDB free: 2723840 kB
 * @Creation     2016/06/02 15:26:41
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSXXDJBCWPCLJDS11")
public class Zfwsxxdjbcwpcljds11 {
	/**
	 * @Description xxcljdsid的中文含义是： 先行登记处理决定书ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_xxcljdsid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_xxcljdsid.nextval from dual"))
	private String xxcljdsid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description xxclgzrq的中文含义是： 盖章日期
	 */
	@Column
	private String xxclgzrq;

	/**
	 * @Description xxclwsbh的中文含义是： 文书编号
	 */
	@Column
	private String xxclwsbh;

	/**
	 * @Description xxcldsr的中文含义是： 当事人
	 */
	@Column
	private String xxcldsr;

	/**
	 * @Description xxcltzsnyr的中文含义是： 通知书年月日
	 */
	@Column
	private String xxcltzsnyr;

	/**
	 * @Description xxcltzswsbh的中文含义是： 先行登记保存物品通知书文书编号
	 */
	@Column
	private String xxcltzswsbh;

	/**
	 * @Description xxclfjxx的中文含义是： 附件
	 */
	@Column
	private String xxclfjxx;
	
	/**
	 * @Description xxclwbnr的中文含义是： 文本内容
	 */
	@Column
	private String xxclwbnr;
	
	/**
	 * @Description xxcldsrqz的中文含义是：当事人签字
	 */
	@Column
	private String xxcldsrqz;
	
	/**
	 * @Description xxcldsrqzrq的中文含义是： 当事人签字日期
	 */
	@Column
	private String xxcldsrqzrq;
	
	/**
	 * @Description xxclzfry1的中文含义是： 执法人员1
	 */
	@Column
	private String xxclzfry1;
	
	/**
	 * @Description xxclzfry2的中文含义是： 执法人员2
	 */
	@Column
	private String xxclzfry2;
	
	/**
	 * @Description xxclzfzh1的中文含义是： 执法证号1
	 */
	@Column
	private String xxclzfzh1;
	
	/**
	 * @Description xxclzfzh2的中文含义是： 执法证号2
	 */
	@Column
	private String xxclzfzh2;
	
	/**
	 * @Description xxclzfryqzrq的中文含义是： 执法人员签字日期
	 */
	@Column
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

	
}