package com.askj.zx.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZXPDXMCS的中文含义是: 征信评定项目参数; InnoDB free: 2759680 kB
 * @Creation     2016/04/01 17:17:57
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZXPDXMCS")
public class Zxpdxmcs {
	/**
	 * @Description xmcsid的中文含义是： 
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_xmcsid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_xmcsid.nextval from dual"))
	private String xmcsid;

	/**
	 * @Description xmcsbm的中文含义是： 项目编码
	 */
	@Column
	private String xmcsbm;

	/**
	 * @Description xmcsmc的中文含义是： 项目名称
	 */
	@Column
	private String xmcsmc;

	/**
	 * @Description xmcsfz的中文含义是： 项目分值
	 */
	@Column
	private Integer xmcsfz;

	/**
	 * @Description xmcsksrq的中文含义是： 开始日期yyyymmdd
	 */
	@Column
	private String xmcsksrq;

	/**
	 * @Description xmcsjsrq的中文含义是： 结束日期yyyymmdd
	 */
	@Column
	private String xmcsjsrq;

	/**
	 * @Description czyxm的中文含义是： 操作员姓名
	 */
	@Column
	private String czyxm;

	/**
	 * @Description czsj的中文含义是： 操作时间
	 */
	@Column
	private String czsj;

	/**
	 * @Description cssyzt的中文含义是： 参数使用状态 0表示不禁用 1表示使用
	 */
	@Column
	private String cssyzt;

	/**
	 * @Description xmcszxt的中文含义是： 
	 */
	@Column
	private String xmcszxt;

	/**
	 * @Description systemcode的中文含义是： 对应子系统,aa10中aaa100=SYSTEMCODE
	 */
	@Column
	private String systemcode;

	
		/**
	 * @Description xmcsid的中文含义是： 
	 */
	public void setXmcsid(String xmcsid){ 
		this.xmcsid = xmcsid;
	}
	/**
	 * @Description xmcsid的中文含义是： 
	 */
	public String getXmcsid(){
		return xmcsid;
	}
	/**
	 * @Description xmcsbm的中文含义是： 项目编码
	 */
	public void setXmcsbm(String xmcsbm){ 
		this.xmcsbm = xmcsbm;
	}
	/**
	 * @Description xmcsbm的中文含义是： 项目编码
	 */
	public String getXmcsbm(){
		return xmcsbm;
	}
	/**
	 * @Description xmcsmc的中文含义是： 项目名称
	 */
	public void setXmcsmc(String xmcsmc){ 
		this.xmcsmc = xmcsmc;
	}
	/**
	 * @Description xmcsmc的中文含义是： 项目名称
	 */
	public String getXmcsmc(){
		return xmcsmc;
	}
	/**
	 * @Description xmcsfz的中文含义是： 项目分值
	 */
	public void setXmcsfz(Integer xmcsfz){ 
		this.xmcsfz = xmcsfz;
	}
	/**
	 * @Description xmcsfz的中文含义是： 项目分值
	 */
	public Integer getXmcsfz(){
		return xmcsfz;
	}
	/**
	 * @Description xmcsksrq的中文含义是： 开始日期yyyymmdd
	 */
	public void setXmcsksrq(String xmcsksrq){ 
		this.xmcsksrq = xmcsksrq;
	}
	/**
	 * @Description xmcsksrq的中文含义是： 开始日期yyyymmdd
	 */
	public String getXmcsksrq(){
		return xmcsksrq;
	}
	/**
	 * @Description xmcsjsrq的中文含义是： 结束日期yyyymmdd
	 */
	public void setXmcsjsrq(String xmcsjsrq){ 
		this.xmcsjsrq = xmcsjsrq;
	}
	/**
	 * @Description xmcsjsrq的中文含义是： 结束日期yyyymmdd
	 */
	public String getXmcsjsrq(){
		return xmcsjsrq;
	}
	/**
	 * @Description czyxm的中文含义是： 操作员姓名
	 */
	public void setCzyxm(String czyxm){ 
		this.czyxm = czyxm;
	}
	/**
	 * @Description czyxm的中文含义是： 操作员姓名
	 */
	public String getCzyxm(){
		return czyxm;
	}
	/**
	 * @Description czsj的中文含义是： 操作时间
	 */
	public void setCzsj(String czsj){ 
		this.czsj = czsj;
	}
	/**
	 * @Description czsj的中文含义是： 操作时间
	 */
	public String getCzsj(){
		return czsj;
	}
	/**
	 * @Description cssyzt的中文含义是： 参数使用状态 0表示不禁用 1表示使用
	 */
	public void setCssyzt(String cssyzt){ 
		this.cssyzt = cssyzt;
	}
	/**
	 * @Description cssyzt的中文含义是： 参数使用状态 0表示不禁用 1表示使用
	 */
	public String getCssyzt(){
		return cssyzt;
	}
	/**
	 * @Description xmcszxt的中文含义是： 
	 */
	public void setXmcszxt(String xmcszxt){ 
		this.xmcszxt = xmcszxt;
	}
	/**
	 * @Description xmcszxt的中文含义是： 
	 */
	public String getXmcszxt(){
		return xmcszxt;
	}
	/**
	 * @Description systemcode的中文含义是： 对应子系统,aa10中aaa100=SYSTEMCODE
	 */
	public void setSystemcode(String systemcode){ 
		this.systemcode = systemcode;
	}
	/**
	 * @Description systemcode的中文含义是： 对应子系统,aa10中aaa100=SYSTEMCODE
	 */
	public String getSystemcode(){
		return systemcode;
	}

	
}