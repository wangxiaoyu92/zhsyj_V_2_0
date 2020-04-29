package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  ZFWSJYJCJYJDGZS14的中文含义是: 检验（检测、检疫、鉴定）告知书; InnoDB free: 76800 kB
 * @Creation     2016/03/16 14:10:27
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSJYJCJYJDGZS14")
public class Zfwsjyjcjyjdgzs14 {
	/**
	 * 当事人/企业名称
	 */
	@Column
	private String jygzdsr;

	/**
	 * @Description jygzsid的中文含义是： 检验告知书ID
	 */
	@Column
	@Name
	private String jygzsid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description jygzwsbh的中文含义是： 文书编号
	 */
	@Column
	private String jygzwsbh;

	/**
	 * @Description jygzjzwsbh的中文含义是： 记载文书编号
	 */
	@Column
	private String jygzjzwsbh;

	/**
	 * @Description jygzjzwsmc的中文含义是： 记载文书名称
	 */
	@Column
	private String jygzjzwsmc;

	/**
	 * @Description jygzksrq的中文含义是： 开始年月日
	 */
	@Column
	private String jygzksrq;

	/**
	 * @Description jygzjsrq的中文含义是： 结束年月日
	 */
	@Column
	private String jygzjsrq;

	/**
	 * @Description jygzgzrq的中文含义是： 盖章日期 
	 */
	@Column
	private String jygzgzrq;
	
	/**
	 * @Description jygzdsrqz的中文含义是：当事人签字
	 */
	@Column
	private String jygzdsrqz;
	
	/**
	 * @Description jygzdsrqzrq的中文含义是： 当事人日期
	 */
	@Column
	private String jygzdsrqzrq;
	/**
	 * @Description jygzqzcsjdsmcjbh的中文含义是： 强制措施决定书名称及编号
	 */
	@Column
	private String jygzqzcsjdsmcjbh;
	/**
	 * @Description jygzqzcsqxsyrq的中文含义是：强制措施期限顺延日期
	 */
	@Column
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

	public String getJygzdsr() {
		return jygzdsr;
	}

	public void setJygzdsr(String jygzdsr) {
		this.jygzdsr = jygzdsr;
	}
}