package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSCFKYYQTZS15的中文含义是: 查封（扣押）延期通知书; InnoDB free: 2723840 kB
 * @Creation     2016/06/03 18:24:28
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSCFKYYQTZS15")
public class Zfwscfkyyqtzs15 {
	/**
	 * @Description cfkyyqtzsid的中文含义是： 查封扣押延期通知书ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_cfkyyqtzsid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_cfkyyqtzsid.nextval from dual"))
	private String cfkyyqtzsid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description cfyqwsbh的中文含义是： 文书编号
	 */
	@Column
	private String cfyqwsbh;

	/**
	 * @Description cfyqyy的中文含义是： 原因
	 */
	@Column
	private String cfyqyy;

	/**
	 * @Description cfyqksrq的中文含义是： 开始日期
	 */
	@Column
	private String cfyqksrq;

	/**
	 * @Description cfyqjsrq的中文含义是： 结束日期
	 */
	@Column
	private String cfyqjsrq;

	/**
	 * @Description cfyqgzrq的中文含义是： 盖章日期
	 */
	@Column
	private String cfyqgzrq;

	/**
	 * @Description cfyqdsr的中文含义是： 当事人
	 */
	@Column
	private String cfyqdsr;

	/**
	 * @Description cfyqfddbr的中文含义是： 法定代表人（负责人）
	 */
	@Column
	private String cfyqfddbr;

	/**
	 * @Description cfyqdz的中文含义是： 地址
	 */
	@Column
	private String cfyqdz;

	/**
	 * @Description cfyqlxfs的中文含义是： 联系方式
	 */
	@Column
	private String cfyqlxfs;

	/**
	 * @Description cfyqcfkyjdsbh的中文含义是： 查封扣押决定书编号
	 */
	@Column
	private String cfyqcfkyjdsbh;

	/**
	 * @Description cfyqsyjsjy的中文含义是： 上一级食药监局
	 */
	@Column
	private String cfyqsyjsjy;

	/**
	 * @Description cfyqrmzf的中文含义是： 人民政府
	 */
	@Column
	private String cfyqrmzf;

	/**
	 * @Description cfyqrmfy的中文含义是： 人民法院
	 */
	@Column
	private String cfyqrmfy;
	
	/**
	 * @Description cfyqdsrqz的中文含义是：当事人签字
	 */
	@Column
	private String cfyqdsrqz;
	
	/**
	 * @Description cfyqdsrqzrq的中文含义是： 当事人签字日期
	 */
	@Column
	private String cfyqdsrqzrq;
	/**
	 * @Description cfyqqs的中文含义是： 查封延期期限
	 */
	@Column
	private String cfyqqx;

	
	public String getCfyqqx() {
		return cfyqqx;
	}
	public void setCfyqqx(String cfyqqx) {
		this.cfyqqx = cfyqqx;
	}
	public String getCfyqdsrqz() {
		return cfyqdsrqz;
	}
	public String getCfyqdsrqzrq() {
		return cfyqdsrqzrq;
	}
	public void setCfyqdsrqz(String cfyqdsrqz) {
		this.cfyqdsrqz = cfyqdsrqz;
	}
	public void setCfyqdsrqzrq(String cfyqdsrqzrq) {
		this.cfyqdsrqzrq = cfyqdsrqzrq;
	}
		/**
	 * @Description cfkyyqtzsid的中文含义是： 查封扣押延期通知书ID
	 */
	public void setCfkyyqtzsid(String cfkyyqtzsid){ 
		this.cfkyyqtzsid = cfkyyqtzsid;
	}
	/**
	 * @Description cfkyyqtzsid的中文含义是： 查封扣押延期通知书ID
	 */
	public String getCfkyyqtzsid(){
		return cfkyyqtzsid;
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
	 * @Description cfyqwsbh的中文含义是： 文书编号
	 */
	public void setCfyqwsbh(String cfyqwsbh){ 
		this.cfyqwsbh = cfyqwsbh;
	}
	/**
	 * @Description cfyqwsbh的中文含义是： 文书编号
	 */
	public String getCfyqwsbh(){
		return cfyqwsbh;
	}
	/**
	 * @Description cfyqyy的中文含义是： 原因
	 */
	public void setCfyqyy(String cfyqyy){ 
		this.cfyqyy = cfyqyy;
	}
	/**
	 * @Description cfyqyy的中文含义是： 原因
	 */
	public String getCfyqyy(){
		return cfyqyy;
	}
	/**
	 * @Description cfyqksrq的中文含义是： 开始日期
	 */
	public void setCfyqksrq(String cfyqksrq){ 
		this.cfyqksrq = cfyqksrq;
	}
	/**
	 * @Description cfyqksrq的中文含义是： 开始日期
	 */
	public String getCfyqksrq(){
		return cfyqksrq;
	}
	/**
	 * @Description cfyqjsrq的中文含义是： 结束日期
	 */
	public void setCfyqjsrq(String cfyqjsrq){ 
		this.cfyqjsrq = cfyqjsrq;
	}
	/**
	 * @Description cfyqjsrq的中文含义是： 结束日期
	 */
	public String getCfyqjsrq(){
		return cfyqjsrq;
	}
	/**
	 * @Description cfyqgzrq的中文含义是： 盖章日期
	 */
	public void setCfyqgzrq(String cfyqgzrq){ 
		this.cfyqgzrq = cfyqgzrq;
	}
	/**
	 * @Description cfyqgzrq的中文含义是： 盖章日期
	 */
	public String getCfyqgzrq(){
		return cfyqgzrq;
	}
	/**
	 * @Description cfyqdsr的中文含义是： 当事人
	 */
	public void setCfyqdsr(String cfyqdsr){ 
		this.cfyqdsr = cfyqdsr;
	}
	/**
	 * @Description cfyqdsr的中文含义是： 当事人
	 */
	public String getCfyqdsr(){
		return cfyqdsr;
	}
	/**
	 * @Description cfyqfddbr的中文含义是： 法定代表人（负责人）
	 */
	public void setCfyqfddbr(String cfyqfddbr){ 
		this.cfyqfddbr = cfyqfddbr;
	}
	/**
	 * @Description cfyqfddbr的中文含义是： 法定代表人（负责人）
	 */
	public String getCfyqfddbr(){
		return cfyqfddbr;
	}
	/**
	 * @Description cfyqdz的中文含义是： 地址
	 */
	public void setCfyqdz(String cfyqdz){ 
		this.cfyqdz = cfyqdz;
	}
	/**
	 * @Description cfyqdz的中文含义是： 地址
	 */
	public String getCfyqdz(){
		return cfyqdz;
	}
	/**
	 * @Description cfyqlxfs的中文含义是： 联系方式
	 */
	public void setCfyqlxfs(String cfyqlxfs){ 
		this.cfyqlxfs = cfyqlxfs;
	}
	/**
	 * @Description cfyqlxfs的中文含义是： 联系方式
	 */
	public String getCfyqlxfs(){
		return cfyqlxfs;
	}
	/**
	 * @Description cfyqcfkyjdsbh的中文含义是： 查封扣押决定书编号
	 */
	public void setCfyqcfkyjdsbh(String cfyqcfkyjdsbh){ 
		this.cfyqcfkyjdsbh = cfyqcfkyjdsbh;
	}
	/**
	 * @Description cfyqcfkyjdsbh的中文含义是： 查封扣押决定书编号
	 */
	public String getCfyqcfkyjdsbh(){
		return cfyqcfkyjdsbh;
	}
	/**
	 * @Description cfyqsyjsjy的中文含义是： 上一级食药监局
	 */
	public void setCfyqsyjsjy(String cfyqsyjsjy){ 
		this.cfyqsyjsjy = cfyqsyjsjy;
	}
	/**
	 * @Description cfyqsyjsjy的中文含义是： 上一级食药监局
	 */
	public String getCfyqsyjsjy(){
		return cfyqsyjsjy;
	}
	/**
	 * @Description cfyqrmzf的中文含义是： 人民政府
	 */
	public void setCfyqrmzf(String cfyqrmzf){ 
		this.cfyqrmzf = cfyqrmzf;
	}
	/**
	 * @Description cfyqrmzf的中文含义是： 人民政府
	 */
	public String getCfyqrmzf(){
		return cfyqrmzf;
	}
	/**
	 * @Description cfyqrmfy的中文含义是： 人民法院
	 */
	public void setCfyqrmfy(String cfyqrmfy){ 
		this.cfyqrmfy = cfyqrmfy;
	}
	/**
	 * @Description cfyqrmfy的中文含义是： 人民法院
	 */
	public String getCfyqrmfy(){
		return cfyqrmfy;
	}

	
}