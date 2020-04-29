package com.askj.jyjc.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  JYJCCYBGB的中文含义是: 检验检测抽样报告表
 * @Creation     2017/01/11 08:57:29
 * @Written      Create Tool By zjf 
 **/
@Table(value = "JYJCCYBGB")
public class Jyjccybgb {
	/**
	 * @Description bgid的中文含义是： 报告ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_bgid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_bgid.nextval from dual"))
	private String bgid;

	/**
	 * @Description cydjid的中文含义是： 抽样登记ID
	 */
	@Column
	private String cydjid;

	/**
	 * @Description bgbh的中文含义是： 报告编号
	 */
	@Column
	private String bgbh;

	/**
	 * @Description jsbgrq的中文含义是： 收到报告日期
	 */
	@Column
	private String jsbgrq;

	/**
	 * @Description bgsdrq的中文含义是： 报告送达日期
	 */
	@Column
	private String bgsdrq;

	/**
	 * @Description jcrqks的中文含义是： 检测日期开始
	 */
	@Column
	private String jcrqks;

	/**
	 * @Description jcrqjs的中文含义是： 检测日期结束
	 */
	@Column
	private String jcrqjs;

	/**
	 * @Description jcdwid的中文含义是： 检测单位ID
	 */
	@Column
	private String jcdwid;

	/**
	 * @Description jcdwmc的中文含义是： 检测单位名称
	 */
	@Column
	private String jcdwmc;

	/**
	 * @Description lah的中文含义是： 立案号
	 */
	@Column
	private String lah;

	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	@Column
	private String aae011;

	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	@Column
	private String aae036;

	
		/**
	 * @Description bgid的中文含义是： 报告ID
	 */
	public void setBgid(String bgid){ 
		this.bgid = bgid;
	}
	/**
	 * @Description bgid的中文含义是： 报告ID
	 */
	public String getBgid(){
		return bgid;
	}
	/**
	 * @Description cydjid的中文含义是： 抽样登记ID
	 */
	public void setCydjid(String cydjid){ 
		this.cydjid = cydjid;
	}
	/**
	 * @Description cydjid的中文含义是： 抽样登记ID
	 */
	public String getCydjid(){
		return cydjid;
	}
	/**
	 * @Description bgbh的中文含义是： 报告编号
	 */
	public void setBgbh(String bgbh){ 
		this.bgbh = bgbh;
	}
	/**
	 * @Description bgbh的中文含义是： 报告编号
	 */
	public String getBgbh(){
		return bgbh;
	}
	/**
	 * @Description jsbgrq的中文含义是： 收到报告日期
	 */
	public void setJsbgrq(String jsbgrq){ 
		this.jsbgrq = jsbgrq;
	}
	/**
	 * @Description jsbgrq的中文含义是： 收到报告日期
	 */
	public String getJsbgrq(){
		return jsbgrq;
	}
	/**
	 * @Description bgsdrq的中文含义是： 报告送达日期
	 */
	public void setBgsdrq(String bgsdrq){ 
		this.bgsdrq = bgsdrq;
	}
	/**
	 * @Description bgsdrq的中文含义是： 报告送达日期
	 */
	public String getBgsdrq(){
		return bgsdrq;
	}
	/**
	 * @Description jcrqks的中文含义是： 检测日期开始
	 */
	public void setJcrqks(String jcrqks){ 
		this.jcrqks = jcrqks;
	}
	/**
	 * @Description jcrqks的中文含义是： 检测日期开始
	 */
	public String getJcrqks(){
		return jcrqks;
	}
	/**
	 * @Description jcrqjs的中文含义是： 检测日期结束
	 */
	public void setJcrqjs(String jcrqjs){ 
		this.jcrqjs = jcrqjs;
	}
	/**
	 * @Description jcrqjs的中文含义是： 检测日期结束
	 */
	public String getJcrqjs(){
		return jcrqjs;
	}
	/**
	 * @Description jcdwid的中文含义是： 检测单位ID
	 */
	public void setJcdwid(String jcdwid){ 
		this.jcdwid = jcdwid;
	}
	/**
	 * @Description jcdwid的中文含义是： 检测单位ID
	 */
	public String getJcdwid(){
		return jcdwid;
	}
	/**
	 * @Description jcdwmc的中文含义是： 检测单位名称
	 */
	public void setJcdwmc(String jcdwmc){ 
		this.jcdwmc = jcdwmc;
	}
	/**
	 * @Description jcdwmc的中文含义是： 检测单位名称
	 */
	public String getJcdwmc(){
		return jcdwmc;
	}
	/**
	 * @Description lah的中文含义是： 立案号
	 */
	public void setLah(String lah){ 
		this.lah = lah;
	}
	/**
	 * @Description lah的中文含义是： 立案号
	 */
	public String getLah(){
		return lah;
	}
	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	public void setAae011(String aae011){ 
		this.aae011 = aae011;
	}
	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	public String getAae011(){
		return aae011;
	}
	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	public void setAae036(String aae036){ 
		this.aae036 = aae036;
	}
	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	public String getAae036(){
		return aae036;
	}

	
}