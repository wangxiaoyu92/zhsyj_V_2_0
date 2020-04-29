package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSXWDCTZS的中文含义是: 询问调查通知书
 * @Creation     2016/09/02 09:51:19
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSXWDCTZS")
public class Zfwsxwdctzs {
	/**
	 * @Description xwdctzsid的中文含义是： 询问调查通知书id
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_xwdctzsid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_xwdctzsid.nextval from dual"))
	private String xwdctzsid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记id
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description xwdcsbh的中文含义是： 询问调查通知书编号
	 */
	@Column
	private String xwdcsbh;

	/**
	 * @Description xwdcdsr的中文含义是： 询问调查通知书当事人
	 */
	@Column
	private String xwdcdsr;

	/**
	 * @Description xwdczynr的中文含义是： 询问调查通知书主要内容
	 */
	@Column
	private String xwdczynr;

	/**
	 * @Description xwdcjzrq的中文含义是： 询问调查通知书截止日期
	 */
	@Column
	private String xwdcjzrq;

	/**
	 * @Description xwdcxwdz的中文含义是： 询问调查通知书询问地址
	 */
	@Column
	private String xwdcxwdz;

	/**
	 * @Description xwdcxdzl的中文含义是： 询问调查通知书携带资料
	 */
	@Column
	private String xwdcxdzl;

	/**
	 * @Description xwdcqzrq的中文含义是： 询问调查通知书签字日期
	 */
	@Column
	private String xwdcqzrq;

	/**
	 * @Description xwdcdsrqz的中文含义是： 询问调查通知书当事人签字
	 */
	@Column
	private String xwdcdsrqz;

	/**
	 * @Description xwdcdsrqzrq的中文含义是： 询问调查通知书当事人签字日期
	 */
	@Column
	private String xwdcdsrqzrq;

	
		/**
	 * @Description xwdctzsid的中文含义是： 询问调查通知书id
	 */
	public void setXwdctzsid(String xwdctzsid){ 
		this.xwdctzsid = xwdctzsid;
	}
	/**
	 * @Description xwdctzsid的中文含义是： 询问调查通知书id
	 */
	public String getXwdctzsid(){
		return xwdctzsid;
	}
	/**
	 * @Description ajdjid的中文含义是： 案件登记id
	 */
	public void setAjdjid(String ajdjid){ 
		this.ajdjid = ajdjid;
	}
	/**
	 * @Description ajdjid的中文含义是： 案件登记id
	 */
	public String getAjdjid(){
		return ajdjid;
	}
	/**
	 * @Description xwdcsbh的中文含义是： 询问调查通知书编号
	 */
	public void setXwdcsbh(String xwdcsbh){ 
		this.xwdcsbh = xwdcsbh;
	}
	/**
	 * @Description xwdcsbh的中文含义是： 询问调查通知书编号
	 */
	public String getXwdcsbh(){
		return xwdcsbh;
	}
	/**
	 * @Description xwdcdsr的中文含义是： 询问调查通知书当事人
	 */
	public void setXwdcdsr(String xwdcdsr){ 
		this.xwdcdsr = xwdcdsr;
	}
	/**
	 * @Description xwdcdsr的中文含义是： 询问调查通知书当事人
	 */
	public String getXwdcdsr(){
		return xwdcdsr;
	}
	/**
	 * @Description xwdczynr的中文含义是： 询问调查通知书主要内容
	 */
	public void setXwdczynr(String xwdczynr){ 
		this.xwdczynr = xwdczynr;
	}
	/**
	 * @Description xwdczynr的中文含义是： 询问调查通知书主要内容
	 */
	public String getXwdczynr(){
		return xwdczynr;
	}
	/**
	 * @Description xwdcjzrq的中文含义是： 询问调查通知书截止日期
	 */
	public void setXwdcjzrq(String xwdcjzrq){ 
		this.xwdcjzrq = xwdcjzrq;
	}
	/**
	 * @Description xwdcjzrq的中文含义是： 询问调查通知书截止日期
	 */
	public String getXwdcjzrq(){
		return xwdcjzrq;
	}
	/**
	 * @Description xwdcxwdz的中文含义是： 询问调查通知书询问地址
	 */
	public void setXwdcxwdz(String xwdcxwdz){ 
		this.xwdcxwdz = xwdcxwdz;
	}
	/**
	 * @Description xwdcxwdz的中文含义是： 询问调查通知书询问地址
	 */
	public String getXwdcxwdz(){
		return xwdcxwdz;
	}
	/**
	 * @Description xwdcxdzl的中文含义是： 询问调查通知书携带资料
	 */
	public void setXwdcxdzl(String xwdcxdzl){ 
		this.xwdcxdzl = xwdcxdzl;
	}
	/**
	 * @Description xwdcxdzl的中文含义是： 询问调查通知书携带资料
	 */
	public String getXwdcxdzl(){
		return xwdcxdzl;
	}
	/**
	 * @Description xwdcqzrq的中文含义是： 询问调查通知书签字日期
	 */
	public void setXwdcqzrq(String xwdcqzrq){ 
		this.xwdcqzrq = xwdcqzrq;
	}
	/**
	 * @Description xwdcqzrq的中文含义是： 询问调查通知书签字日期
	 */
	public String getXwdcqzrq(){
		return xwdcqzrq;
	}
	/**
	 * @Description xwdcdsrqz的中文含义是： 询问调查通知书当事人签字
	 */
	public void setXwdcdsrqz(String xwdcdsrqz){ 
		this.xwdcdsrqz = xwdcdsrqz;
	}
	/**
	 * @Description xwdcdsrqz的中文含义是： 询问调查通知书当事人签字
	 */
	public String getXwdcdsrqz(){
		return xwdcdsrqz;
	}
	/**
	 * @Description xwdcdsrqzrq的中文含义是： 询问调查通知书当事人签字日期
	 */
	public void setXwdcdsrqzrq(String xwdcdsrqzrq){ 
		this.xwdcdsrqzrq = xwdcdsrqzrq;
	}
	/**
	 * @Description xwdcdsrqzrq的中文含义是： 询问调查通知书当事人签字日期
	 */
	public String getXwdcdsrqzrq(){
		return xwdcdsrqzrq;
	}

	
}