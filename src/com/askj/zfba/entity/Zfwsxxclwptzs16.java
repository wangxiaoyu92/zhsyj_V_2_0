package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSXXCLWPTZS16的中文含义是: 先行处理物品通知书; InnoDB free: 2723840 kB
 * @Creation     2016/06/06 09:47:44
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSXXCLWPTZS16")
public class Zfwsxxclwptzs16 {
	/**
	 * @Description xxclwptzsid的中文含义是： 先行处理物品通知书ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_xxclwptzsid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_xxclwptzsid.nextval from dual"))
	private String xxclwptzsid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description xxclwplb的中文含义是： 物品类别
	 */
	@Column
	private String xxclwplb;

	/**
	 * @Description xxclclfs的中文含义是： 处理方式
	 */
	@Column
	private String xxclclfs;

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
	 * @Description xxclcfkyrq的中文含义是： 查封扣押日期
	 */
	@Column
	private String xxclcfkyrq;

	/**
	 * @Description xxclcfkyjdsbh的中文含义是： 查封扣押决定书编号
	 */
	@Column
	private String xxclcfkyjdsbh;

	/**
	 * @Description xxclfj的中文含义是： 附件
	 */
	@Column
	private String xxclfj;
	/**
	 * @Description xxcldsrqzrq的中文含义是： 当事人签字
	 */
	@Column
	private String xxcldsrqz;
	/**
	 * @Description xxcldsrqzrq的中文含义是： 当事人签字日期
	 */
	@Column
	private String xxcldsrqzrq;

	
	public String getXxcldsrqz() {
		return xxcldsrqz;
	}
	public String getXxcldsrqzrq() {
		return xxcldsrqzrq;
	}
	public void setXxcldsrqz(String xxcldsrqz) {
		this.xxcldsrqz = xxcldsrqz;
	}
	public void setXxcldsrqzrq(String xxcldsrqzrq) {
		this.xxcldsrqzrq = xxcldsrqzrq;
	}
		/**
	 * @Description xxclwptzsid的中文含义是： 先行处理物品通知书ID
	 */
	public void setXxclwptzsid(String xxclwptzsid){ 
		this.xxclwptzsid = xxclwptzsid;
	}
	/**
	 * @Description xxclwptzsid的中文含义是： 先行处理物品通知书ID
	 */
	public String getXxclwptzsid(){
		return xxclwptzsid;
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
	 * @Description xxclwplb的中文含义是： 物品类别
	 */
	public void setXxclwplb(String xxclwplb){ 
		this.xxclwplb = xxclwplb;
	}
	/**
	 * @Description xxclwplb的中文含义是： 物品类别
	 */
	public String getXxclwplb(){
		return xxclwplb;
	}
	/**
	 * @Description xxclclfs的中文含义是： 处理方式
	 */
	public void setXxclclfs(String xxclclfs){ 
		this.xxclclfs = xxclclfs;
	}
	/**
	 * @Description xxclclfs的中文含义是： 处理方式
	 */
	public String getXxclclfs(){
		return xxclclfs;
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
	 * @Description xxclcfkyrq的中文含义是： 查封扣押日期
	 */
	public void setXxclcfkyrq(String xxclcfkyrq){ 
		this.xxclcfkyrq = xxclcfkyrq;
	}
	/**
	 * @Description xxclcfkyrq的中文含义是： 查封扣押日期
	 */
	public String getXxclcfkyrq(){
		return xxclcfkyrq;
	}
	/**
	 * @Description xxclcfkyjdsbh的中文含义是： 查封扣押决定书编号
	 */
	public void setXxclcfkyjdsbh(String xxclcfkyjdsbh){ 
		this.xxclcfkyjdsbh = xxclcfkyjdsbh;
	}
	/**
	 * @Description xxclcfkyjdsbh的中文含义是： 查封扣押决定书编号
	 */
	public String getXxclcfkyjdsbh(){
		return xxclcfkyjdsbh;
	}
	/**
	 * @Description xxclfj的中文含义是： 附件
	 */
	public void setXxclfj(String xxclfj){ 
		this.xxclfj = xxclfj;
	}
	/**
	 * @Description xxclfj的中文含义是： 附件
	 */
	public String getXxclfj(){
		return xxclfj;
	}

	
}