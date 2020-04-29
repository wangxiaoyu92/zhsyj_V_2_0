package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSZLGZTZS20的中文含义是: 责令改正通知书; InnoDB free: 2723840 kB
 * @Creation     2016/06/07 15:37:15
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSZLGZTZS20")
public class Zfwszlgztzs20 {
	/**
	 * @Description zlgztzsid的中文含义是： 责令改正通知书ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_zlgztzsid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_zlgztzsid.nextval from dual"))
	private String zlgztzsid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description zlgzwsbh的中文含义是： 文书编号
	 */
	@Column
	private String zlgzwsbh;

	/**
	 * @Description zlgzwfxw的中文含义是： 违法行为
	 */
	@Column
	private String zlgzwfxw;

	/**
	 * @Description zlgzwfgd的中文含义是： 违反规定
	 */
	@Column
	private String zlgzwfgd;

	/**
	 * @Description zlgzcfgj的中文含义是： 处罚根据
	 */
	@Column
	private String zlgzcfgj;

	/**
	 * @Description zlgzcfgjt的中文含义是： 处罚根据条
	 */
	@Column
	private String zlgzcfgjt;

	/**
	 * @Description zlgzcfgjk的中文含义是： 处罚根据款
	 */
	@Column
	private String zlgzcfgjk;

	/**
	 * @Description zlgzcfgjx的中文含义是： 处罚根据项
	 */
	@Column
	private String zlgzcfgjx;

	/**
	 * @Description zlgzgzrq的中文含义是： 盖章日期
	 */
	@Column
	private String zlgzgzrq;

	/**
	 * @Description zlgzgznr的中文含义是： 改正内容
	 */
	@Column
	private String zlgzgznr;

	/**
	 * @Description zlgzdsr的中文含义是： 当事人
	 */
	@Column
	private String zlgzdsr;
	/**
	 * @Description zlgzdsrqz的中文含义是： 当事人签字
	 */
	@Column
	private String zlgzdsrqz;
	/**
	 * @Description zlgzdsrqzrq的中文含义是： 当事人签字日期
	 */
	@Column
	private String zlgzdsrqzrq;
	/**
	 * @Description zlgzwfxwjzrq的中文含义是： 改正违法行为截止日期
	 */
	@Column
	private String zlgzwfxwjzrq;

	
	public String getZlgzwfxwjzrq() {
		return zlgzwfxwjzrq;
	}
	public void setZlgzwfxwjzrq(String zlgzwfxwjzrq) {
		this.zlgzwfxwjzrq = zlgzwfxwjzrq;
	}
	public String getZlgzdsrqz() {
		return zlgzdsrqz;
	}
	public String getZlgzdsrqzrq() {
		return zlgzdsrqzrq;
	}
	public void setZlgzdsrqz(String zlgzdsrqz) {
		this.zlgzdsrqz = zlgzdsrqz;
	}
	public void setZlgzdsrqzrq(String zlgzdsrqzrq) {
		this.zlgzdsrqzrq = zlgzdsrqzrq;
	}
		/**
	 * @Description zlgztzsid的中文含义是： 责令改正通知书ID
	 */
	public void setZlgztzsid(String zlgztzsid){ 
		this.zlgztzsid = zlgztzsid;
	}
	/**
	 * @Description zlgztzsid的中文含义是： 责令改正通知书ID
	 */
	public String getZlgztzsid(){
		return zlgztzsid;
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
	 * @Description zlgzwsbh的中文含义是： 文书编号
	 */
	public void setZlgzwsbh(String zlgzwsbh){ 
		this.zlgzwsbh = zlgzwsbh;
	}
	/**
	 * @Description zlgzwsbh的中文含义是： 文书编号
	 */
	public String getZlgzwsbh(){
		return zlgzwsbh;
	}
	/**
	 * @Description zlgzwfxw的中文含义是： 违法行为
	 */
	public void setZlgzwfxw(String zlgzwfxw){ 
		this.zlgzwfxw = zlgzwfxw;
	}
	/**
	 * @Description zlgzwfxw的中文含义是： 违法行为
	 */
	public String getZlgzwfxw(){
		return zlgzwfxw;
	}
	/**
	 * @Description zlgzwfgd的中文含义是： 违反规定
	 */
	public void setZlgzwfgd(String zlgzwfgd){ 
		this.zlgzwfgd = zlgzwfgd;
	}
	/**
	 * @Description zlgzwfgd的中文含义是： 违反规定
	 */
	public String getZlgzwfgd(){
		return zlgzwfgd;
	}
	/**
	 * @Description zlgzcfgj的中文含义是： 处罚根据
	 */
	public void setZlgzcfgj(String zlgzcfgj){ 
		this.zlgzcfgj = zlgzcfgj;
	}
	/**
	 * @Description zlgzcfgj的中文含义是： 处罚根据
	 */
	public String getZlgzcfgj(){
		return zlgzcfgj;
	}
	/**
	 * @Description zlgzcfgjt的中文含义是： 处罚根据条
	 */
	public void setZlgzcfgjt(String zlgzcfgjt){ 
		this.zlgzcfgjt = zlgzcfgjt;
	}
	/**
	 * @Description zlgzcfgjt的中文含义是： 处罚根据条
	 */
	public String getZlgzcfgjt(){
		return zlgzcfgjt;
	}
	/**
	 * @Description zlgzcfgjk的中文含义是： 处罚根据款
	 */
	public void setZlgzcfgjk(String zlgzcfgjk){ 
		this.zlgzcfgjk = zlgzcfgjk;
	}
	/**
	 * @Description zlgzcfgjk的中文含义是： 处罚根据款
	 */
	public String getZlgzcfgjk(){
		return zlgzcfgjk;
	}
	/**
	 * @Description zlgzcfgjx的中文含义是： 处罚根据项
	 */
	public void setZlgzcfgjx(String zlgzcfgjx){ 
		this.zlgzcfgjx = zlgzcfgjx;
	}
	/**
	 * @Description zlgzcfgjx的中文含义是： 处罚根据项
	 */
	public String getZlgzcfgjx(){
		return zlgzcfgjx;
	}
	/**
	 * @Description zlgzgzrq的中文含义是： 盖章日期
	 */
	public void setZlgzgzrq(String zlgzgzrq){ 
		this.zlgzgzrq = zlgzgzrq;
	}
	/**
	 * @Description zlgzgzrq的中文含义是： 盖章日期
	 */
	public String getZlgzgzrq(){
		return zlgzgzrq;
	}
	/**
	 * @Description zlgzgznr的中文含义是： 改正内容
	 */
	public void setZlgzgznr(String zlgzgznr){ 
		this.zlgzgznr = zlgzgznr;
	}
	/**
	 * @Description zlgzgznr的中文含义是： 改正内容
	 */
	public String getZlgzgznr(){
		return zlgzgznr;
	}
	/**
	 * @Description zlgzdsr的中文含义是： 当事人
	 */
	public void setZlgzdsr(String zlgzdsr){ 
		this.zlgzdsr = zlgzdsr;
	}
	/**
	 * @Description zlgzdsr的中文含义是： 当事人
	 */
	public String getZlgzdsr(){
		return zlgzdsr;
	}

	
}