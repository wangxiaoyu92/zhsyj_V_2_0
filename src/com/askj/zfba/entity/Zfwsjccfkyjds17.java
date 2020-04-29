package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSJCCFKYJDS17的中文含义是: 解除查封扣押决定书; InnoDB free: 2723840 kB
 * @Creation     2016/06/06 11:28:26
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSJCCFKYJDS17")
public class Zfwsjccfkyjds17 {
	/**
	 * @Description jccfkyjdsid的中文含义是： 解除查封(扣押)决定书ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_jccfkyjdsid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_jccfkyjdsid.nextval from dual"))
	private String jccfkyjdsid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description jckydjx的中文含义是： 解除扣押第几项
	 */
	@Column
	private String jckydjx;

	/**
	 * @Description jckygzrq的中文含义是： 盖章日期
	 */
	@Column
	private String jckygzrq;

	/**
	 * @Description jckywsbh的中文含义是： 文书编号
	 */
	@Column
	private String jckywsbh;

	/**
	 * @Description jckydsr的中文含义是： 当事人
	 */
	@Column
	private String jckydsr;

	/**
	 * @Description jckykyrq的中文含义是： 扣押日期
	 */
	@Column
	private String jckykyrq;

	/**
	 * @Description jckykybh的中文含义是： 扣押决定书编号
	 */
	@Column
	private String jckykybh;

	/**
	 * @Description jckywpqdbh的中文含义是： 查封扣押物品清单编号
	 */
	@Column
	private String jckywpqdbh;

	/**
	 * @Description jckyfj的中文含义是： 附件
	 */
	@Column
	private String jckyfj;
	
	/**
	 * @Description jckydsrqz的中文含义是： 当事人签字
	 */
	@Column
	private String jckydsrqz;
	
	/**
	 * @Description jckyxzjglxr的中文含义是：行政机关联系人
	 */
	@Column
	private String jckyxzjglxr;
	
	/**
	 * @Description jckylxdh的中文含义是： 联系电话
	 */
	@Column
	private String jckylxdh;
	
	public String getJckyxzjglxr() {
		return jckyxzjglxr;
	}
	public String getJckylxdh() {
		return jckylxdh;
	}
	public void setJckyxzjglxr(String jckyxzjglxr) {
		this.jckyxzjglxr = jckyxzjglxr;
	}
	public void setJckylxdh(String jckylxdh) {
		this.jckylxdh = jckylxdh;
	}
	/**
	 * @Description jckydsrqzrq的中文含义是： 当事人签字日期
	 */
	@Column
	private String jckydsrqzrq;

	
	public String getJckydsrqz() {
		return jckydsrqz;
	}
	public String getJckydsrqzrq() {
		return jckydsrqzrq;
	}
	public void setJckydsrqz(String jckydsrqz) {
		this.jckydsrqz = jckydsrqz;
	}
	public void setJckydsrqzrq(String jckydsrqzrq) {
		this.jckydsrqzrq = jckydsrqzrq;
	}
		/**
	 * @Description jccfkyjdsid的中文含义是： 解除查封(扣押)决定书ID
	 */
	public void setJccfkyjdsid(String jccfkyjdsid){ 
		this.jccfkyjdsid = jccfkyjdsid;
	}
	/**
	 * @Description jccfkyjdsid的中文含义是： 解除查封(扣押)决定书ID
	 */
	public String getJccfkyjdsid(){
		return jccfkyjdsid;
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
	 * @Description jckydjx的中文含义是： 解除扣押第几项
	 */
	public void setJckydjx(String jckydjx){ 
		this.jckydjx = jckydjx;
	}
	/**
	 * @Description jckydjx的中文含义是： 解除扣押第几项
	 */
	public String getJckydjx(){
		return jckydjx;
	}
	/**
	 * @Description jckygzrq的中文含义是： 盖章日期
	 */
	public void setJckygzrq(String jckygzrq){ 
		this.jckygzrq = jckygzrq;
	}
	/**
	 * @Description jckygzrq的中文含义是： 盖章日期
	 */
	public String getJckygzrq(){
		return jckygzrq;
	}
	/**
	 * @Description jckywsbh的中文含义是： 文书编号
	 */
	public void setJckywsbh(String jckywsbh){ 
		this.jckywsbh = jckywsbh;
	}
	/**
	 * @Description jckywsbh的中文含义是： 文书编号
	 */
	public String getJckywsbh(){
		return jckywsbh;
	}
	/**
	 * @Description jckydsr的中文含义是： 当事人
	 */
	public void setJckydsr(String jckydsr){ 
		this.jckydsr = jckydsr;
	}
	/**
	 * @Description jckydsr的中文含义是： 当事人
	 */
	public String getJckydsr(){
		return jckydsr;
	}
	/**
	 * @Description jckykyrq的中文含义是： 扣押日期
	 */
	public void setJckykyrq(String jckykyrq){ 
		this.jckykyrq = jckykyrq;
	}
	/**
	 * @Description jckykyrq的中文含义是： 扣押日期
	 */
	public String getJckykyrq(){
		return jckykyrq;
	}
	/**
	 * @Description jckykybh的中文含义是： 扣押决定书编号
	 */
	public void setJckykybh(String jckykybh){ 
		this.jckykybh = jckykybh;
	}
	/**
	 * @Description jckykybh的中文含义是： 扣押决定书编号
	 */
	public String getJckykybh(){
		return jckykybh;
	}
	/**
	 * @Description jckywpqdbh的中文含义是： 查封扣押物品清单编号
	 */
	public void setJckywpqdbh(String jckywpqdbh){ 
		this.jckywpqdbh = jckywpqdbh;
	}
	/**
	 * @Description jckywpqdbh的中文含义是： 查封扣押物品清单编号
	 */
	public String getJckywpqdbh(){
		return jckywpqdbh;
	}
	/**
	 * @Description jckyfj的中文含义是： 附件
	 */
	public void setJckyfj(String jckyfj){ 
		this.jckyfj = jckyfj;
	}
	/**
	 * @Description jckyfj的中文含义是： 附件
	 */
	public String getJckyfj(){
		return jckyfj;
	}

	
}