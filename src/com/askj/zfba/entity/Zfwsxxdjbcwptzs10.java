package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSXXDJBCWPTZS10的中文含义是: 先行登记保存物品通知书; InnoDB free: 2723840 kB
 * @Creation     2016/06/02 09:44:32
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSXXDJBCWPTZS10")
public class Zfwsxxdjbcwptzs10 {
	/**
	 * @Description xxdjbcwptzsid的中文含义是： 先行登记保存物品通知书ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_xxdjbcwptzsid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_xxdjbcwptzsid.nextval from dual"))
	private String xxdjbcwptzsid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description xztzwsbh的中文含义是： 文书编号
	 */
	@Column
	private String xztzwsbh;

	/**
	 * @Description xztzbcdd的中文含义是： 保存地点
	 */
	@Column
	private String xztzbcdd;

	/**
	 * @Description xztzbctj的中文含义是： 保存条件
	 */
	@Column
	private String xztzbctj;

	/**
	 * @Description xztzbcqx的中文含义是： 保存期限
	 */
	@Column
	private String xztzbcqx;

	/**
	 * @Description xztzgzrq的中文含义是： 盖章日期
	 */
	@Column
	private String xztzgzrq;

	/**
	 * @Description xztzdsr的中文含义是： 当事人
	 */
	@Column
	private String xztzdsr;

	/**
	 * @Description xztzwpqdwsbh的中文含义是： 先行登记保存物品清单文书编号
	 */
	@Column
	private String xztzwpqdwsbh;

	/**
	 * @Description xztzfjxx的中文含义是： 附件信息
	 */
	@Column
	private String xztzfjxx;
	
	/**
	 * @Description xztzdsrqz的中文含义是：当事人签字
	 */
	@Column
	private String xztzdsrqz;
	
	/**
	 * @Description xztzdsrqzrq的中文含义是： 当事人签字日期
	 */
	@Column
	private String xztzdsrqzrq;
	
	/**
	 * @Description xztzzfryqz1的中文含义是： 执法人员1
	 */
	@Column
	private String xztzzfryqz1;
	
	/**
	 * @Description xztzzfryqz2的中文含义是： 执法人员2
	 */
	@Column
	private String xztzzfryqz2;
	
	/**
	 * @Description xztzzfzh1的中文含义是：执法证号1
	 */
	@Column
	private String xztzzfzh1;
	
	/**
	 * @Description xztzzfzh2的中文含义是： 执法证号2
	 */
	@Column
	private String xztzzfzh2;
	
	/**
	 * @Description xztzzfryqzrq的中文含义是：执法人员签字日期
	 */
	@Column
	private String xztzzfryqzrq;
	/**
	 * @Description xztzbcqxksrq的中文含义是：保存期限开始日期
	 */
	@Column
	private String xztzbcqxksrq;
	 
	/**
	 * @Description xztzbcqxjsrq的中文含义是：保存期限结束日期
	 */
	@Column
	private String xztzbcqxjsrq;
	/**
	 * @Description xztzwfxw的中文含义是：违法行为
	 */
	@Column
	private String xztzwfxw;
	/**
	 * @Description xztzwfflfg的中文含义是：违反的法律法规
	 */
	@Column
	private String xztzwfflfg;
	

	
	public String getXztzwfxw() {
		return xztzwfxw;
	}
	public String getXztzwfflfg() {
		return xztzwfflfg;
	}
	public void setXztzwfxw(String xztzwfxw) {
		this.xztzwfxw = xztzwfxw;
	}
	public void setXztzwfflfg(String xztzwfflfg) {
		this.xztzwfflfg = xztzwfflfg;
	}
	public String getXztzbcqxksrq() {
		return xztzbcqxksrq;
	}
	public String getXztzbcqxjsrq() {
		return xztzbcqxjsrq;
	}
	public void setXztzbcqxksrq(String xztzbcqxksrq) {
		this.xztzbcqxksrq = xztzbcqxksrq;
	}
	public void setXztzbcqxjsrq(String xztzbcqxjsrq) {
		this.xztzbcqxjsrq = xztzbcqxjsrq;
	}
	public String getXztzzfzh2() {
		return xztzzfzh2;
	}
	public void setXztzzfzh2(String xztzzfzh2) {
		this.xztzzfzh2 = xztzzfzh2;
	}
	public String getXztzdsrqz() {
		return xztzdsrqz;
	}
	public String getXztzdsrqzrq() {
		return xztzdsrqzrq;
	}
	public String getXztzzfryqz1() {
		return xztzzfryqz1;
	}
	public String getXztzzfryqz2() {
		return xztzzfryqz2;
	}
	public String getXztzzfzh1() {
		return xztzzfzh1;
	} 
	public String getXztzzfryqzrq() {
		return xztzzfryqzrq;
	}
	public void setXztzdsrqz(String xztzdsrqz) {
		this.xztzdsrqz = xztzdsrqz;
	}
	public void setXztzdsrqzrq(String xztzdsrqzrq) {
		this.xztzdsrqzrq = xztzdsrqzrq;
	}
	public void setXztzzfryqz1(String xztzzfryqz1) {
		this.xztzzfryqz1 = xztzzfryqz1;
	}
	public void setXztzzfryqz2(String xztzzfryqz2) {
		this.xztzzfryqz2 = xztzzfryqz2;
	}
	public void setXztzzfzh1(String xztzzfzh1) {
		this.xztzzfzh1 = xztzzfzh1;
	} 
	public void setXztzzfryqzrq(String xztzzfryqzrq) {
		this.xztzzfryqzrq = xztzzfryqzrq;
	}
		/**
	 * @Description xxdjbcwptzsid的中文含义是： 先行登记保存物品通知书ID
	 */
	public void setXxdjbcwptzsid(String xxdjbcwptzsid){ 
		this.xxdjbcwptzsid = xxdjbcwptzsid;
	}
	/**
	 * @Description xxdjbcwptzsid的中文含义是： 先行登记保存物品通知书ID
	 */
	public String getXxdjbcwptzsid(){
		return xxdjbcwptzsid;
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
	 * @Description xztzwsbh的中文含义是： 文书编号
	 */
	public void setXztzwsbh(String xztzwsbh){ 
		this.xztzwsbh = xztzwsbh;
	}
	/**
	 * @Description xztzwsbh的中文含义是： 文书编号
	 */
	public String getXztzwsbh(){
		return xztzwsbh;
	}
	/**
	 * @Description xztzbcdd的中文含义是： 保存地点
	 */
	public void setXztzbcdd(String xztzbcdd){ 
		this.xztzbcdd = xztzbcdd;
	}
	/**
	 * @Description xztzbcdd的中文含义是： 保存地点
	 */
	public String getXztzbcdd(){
		return xztzbcdd;
	}
	/**
	 * @Description xztzbctj的中文含义是： 保存条件
	 */
	public void setXztzbctj(String xztzbctj){ 
		this.xztzbctj = xztzbctj;
	}
	/**
	 * @Description xztzbctj的中文含义是： 保存条件
	 */
	public String getXztzbctj(){
		return xztzbctj;
	}
	/**
	 * @Description xztzbcqx的中文含义是： 保存期限
	 */
	public void setXztzbcqx(String xztzbcqx){ 
		this.xztzbcqx = xztzbcqx;
	}
	/**
	 * @Description xztzbcqx的中文含义是： 保存期限
	 */
	public String getXztzbcqx(){
		return xztzbcqx;
	}
	/**
	 * @Description xztzgzrq的中文含义是： 盖章日期
	 */
	public void setXztzgzrq(String xztzgzrq){ 
		this.xztzgzrq = xztzgzrq;
	}
	/**
	 * @Description xztzgzrq的中文含义是： 盖章日期
	 */
	public String getXztzgzrq(){
		return xztzgzrq;
	}
	/**
	 * @Description xztzdsr的中文含义是： 当事人
	 */
	public void setXztzdsr(String xztzdsr){ 
		this.xztzdsr = xztzdsr;
	}
	/**
	 * @Description xztzdsr的中文含义是： 当事人
	 */
	public String getXztzdsr(){
		return xztzdsr;
	}
	/**
	 * @Description xztzwpqdwsbh的中文含义是： 先行登记保存物品清单文书编号
	 */
	public void setXztzwpqdwsbh(String xztzwpqdwsbh){ 
		this.xztzwpqdwsbh = xztzwpqdwsbh;
	}
	/**
	 * @Description xztzwpqdwsbh的中文含义是： 先行登记保存物品清单文书编号
	 */
	public String getXztzwpqdwsbh(){
		return xztzwpqdwsbh;
	}
	/**
	 * @Description xztzfjxx的中文含义是： 附件信息
	 */
	public void setXztzfjxx(String xztzfjxx){ 
		this.xztzfjxx = xztzfjxx;
	}
	/**
	 * @Description xztzfjxx的中文含义是： 附件信息
	 */
	public String getXztzfjxx(){
		return xztzfjxx;
	}

	
}