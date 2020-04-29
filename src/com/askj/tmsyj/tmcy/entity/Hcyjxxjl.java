package com.askj.tmsyj.tmcy.entity;

import java.sql.Timestamp;

import org.nutz.dao.entity.annotation.*;
/**
 * @Description  Hcyjxxjl的中文含义是: 餐饮具洗消记录
 * @Creation     2017/03/22 09:33:06
 * @Written      Create Tool By zjf 
 **/
@Table(value = "hcyjxxjl")
public class Hcyjxxjl {
	/**
	 * @Description hcyjxxjlid的中文含义是： 餐饮具洗消记录id
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_hcyjxxjlid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_hcyjxxjlid.nextval from dual"))
	private String hcyjxxjlid;

	/**
	 * @Description cjmc的中文含义是： 餐具名称
	 */
	@Column
	private String cjmc;

	/**
	 * @Description xdfs的中文含义是： 消毒方式aaa100=xdfs
	 */
	@Column
	private String xdfs;

	/**
	 * @Description wnd的中文含义是： 温/浓度
	 */
	@Column
	private String wnd;

	/**
	 * @Description xdkssj的中文含义是： 消毒开始时间
	 */
	@Column
	private Timestamp xdkssj;

	/**
	 * @Description xdjssj的中文含义是： 消毒结束时间
	 */
	@Column
	private Timestamp xdjssj;

	/**
	 * @Description aae011的中文含义是： 操作员
	 */
	@Column
	private String aae011;

	/**
	 * @Description aae036的中文含义是： 操作时间
	 */
	@Column
	private Timestamp aae036;

	/**
	 * @Description comid的中文含义是： 企业id
	 */
	@Column
	private String comid;

	
		/**
	 * @Description hcyjxxjlid的中文含义是： 餐饮具洗消记录id
	 */
	public void setHcyjxxjlid(String hcyjxxjlid){ 
		this.hcyjxxjlid = hcyjxxjlid;
	}
	/**
	 * @Description hcyjxxjlid的中文含义是： 餐饮具洗消记录id
	 */
	public String getHcyjxxjlid(){
		return hcyjxxjlid;
	}
	/**
	 * @Description cjmc的中文含义是： 餐具名称
	 */
	public void setCjmc(String cjmc){ 
		this.cjmc = cjmc;
	}
	/**
	 * @Description cjmc的中文含义是： 餐具名称
	 */
	public String getCjmc(){
		return cjmc;
	}
	/**
	 * @Description xdfs的中文含义是： 消毒方式aaa100=xdfs
	 */
	public void setXdfs(String xdfs){ 
		this.xdfs = xdfs;
	}
	/**
	 * @Description xdfs的中文含义是： 消毒方式aaa100=xdfs
	 */
	public String getXdfs(){
		return xdfs;
	}
	/**
	 * @Description wnd的中文含义是： 温/浓度
	 */
	public void setWnd(String wnd){ 
		this.wnd = wnd;
	}
	/**
	 * @Description wnd的中文含义是： 温/浓度
	 */
	public String getWnd(){
		return wnd;
	}
	/**
	 * @Description xdkssj的中文含义是： 消毒开始时间
	 */
	public void setXdkssj(Timestamp xdkssj){ 
		this.xdkssj = xdkssj;
	}
	/**
	 * @Description xdkssj的中文含义是： 消毒开始时间
	 */
	public Timestamp getXdkssj(){
		return xdkssj;
	}
	/**
	 * @Description xdjssj的中文含义是： 消毒结束时间
	 */
	public void setXdjssj(Timestamp xdjssj){ 
		this.xdjssj = xdjssj;
	}
	/**
	 * @Description xdjssj的中文含义是： 消毒结束时间
	 */
	public Timestamp getXdjssj(){
		return xdjssj;
	}
	/**
	 * @Description aae011的中文含义是： 操作员
	 */
	public void setAae011(String aae011){ 
		this.aae011 = aae011;
	}
	/**
	 * @Description aae011的中文含义是： 操作员
	 */
	public String getAae011(){
		return aae011;
	}
	/**
	 * @Description aae036的中文含义是： 操作时间
	 */
	public void setAae036(Timestamp aae036){ 
		this.aae036 = aae036;
	}
	/**
	 * @Description aae036的中文含义是： 操作时间
	 */
	public Timestamp getAae036(){
		return aae036;
	}
	/**
	 * @Description comid的中文含义是： 企业id
	 */
	public void setComid(String comid){ 
		this.comid = comid;
	}
	/**
	 * @Description comid的中文含义是： 企业id
	 */
	public String getComid(){
		return comid;
	}

	
}