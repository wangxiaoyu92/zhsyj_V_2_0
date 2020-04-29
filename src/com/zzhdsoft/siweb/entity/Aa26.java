package com.zzhdsoft.siweb.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;
/**
 * @Description  AA26 的中文含义是 行政区划
 * @Creation     2014/10/13 10:50:41
 * @Written      Create Tool By ZhengZhou HuaDong Software 
 **/
@Table(value = "AA26")
public class Aa26 {
	//子节点数量,非映射字段
	@Column
	@Readonly
	private int childnum;
	//是否父节点,非映射字段
	@Column
	@Readonly
	private boolean isparent;
	//是否展开,非映射字段
	@Column
	@Readonly
	private boolean isopen;
	/**
	 * @Description aab301的中文含义是： 行政区划代码
	 */
	@Column
	@Id(auto=false)
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_aab301')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_aab301.nextval from dual"))
	private String aab301;

	/**
	 * @Description aaa146的中文含义是： 行政区划名称
	 */
	@Column
	private String aaa146;

	/**
	 * @Description aaa148的中文含义是： 上级行政区划代码
	 */
	@Column
	private String aaa148;

	/**
	 * @Description aae383的中文含义是： 行政区划版本号
	 */
	@Column
	private Long aae383;

	/**
	 * @Description baz001的中文含义是： 记录编号
	 */
	@Column
	private String baz001;

	/**
	 * @Description baz002的中文含义是： 操作序号
	 */
	@Column
	private Long baz002;
	
	/**
	 * @Description aae007的中文含义是： 邮政编码
	 */
	@Column
	private String aae007;	

	public int getChildnum() {
		return childnum;
	}
	public void setChildnum(int childnum) {
		this.childnum = childnum;
	}
	
	public boolean getIsparent() {
		return isparent;
	}
	public void setIsparent(boolean isparent) {
		this.isparent = isparent;
	}
	public boolean getIsopen() {
		return isopen;
	}
	public void setIsopen(boolean isopen) {
		this.isopen = isopen;
	}
		/**
	 * @Description aab301的中文含义是： 行政区划代码
	 */
	public void setAab301(String aab301){ 
		this.aab301 = aab301;
	}
	/**
	 * @Description aab301的中文含义是： 行政区划代码
	 */
	public String getAab301(){
		return aab301;
	}
	/**
	 * @Description aaa146的中文含义是： 行政区划名称
	 */
	public void setAaa146(String aaa146){ 
		this.aaa146 = aaa146;
	}
	/**
	 * @Description aaa146的中文含义是： 行政区划名称
	 */
	public String getAaa146(){
		return aaa146;
	}
	/**
	 * @Description aaa148的中文含义是： 上级行政区划代码
	 */
	public void setAaa148(String aaa148){ 
		this.aaa148 = aaa148;
	}
	/**
	 * @Description aaa148的中文含义是： 上级行政区划代码
	 */
	public String getAaa148(){
		return aaa148;
	}
	/**
	 * @Description aae383的中文含义是： 行政区划版本号
	 */
	public void setAae383(Long aae383){ 
		this.aae383 = aae383;
	}
	/**
	 * @Description aae383的中文含义是： 行政区划版本号
	 */
	public Long getAae383(){
		return aae383;
	}
	/**
	 * @Description baz001的中文含义是： 记录编号
	 */
	public void setBaz001(String baz001){ 
		this.baz001 = baz001;
	}
	/**
	 * @Description baz001的中文含义是： 记录编号
	 */
	public String getBaz001(){
		return baz001;
	}
	/**
	 * @Description baz002的中文含义是： 操作序号
	 */
	public void setBaz002(Long baz002){ 
		this.baz002 = baz002;
	}
	/**
	 * @Description baz002的中文含义是： 操作序号
	 */
	public Long getBaz002(){
		return baz002;
	}
	public String getAae007() {
		return aae007;
	}
	public void setAae007(String aae007) {
		this.aae007 = aae007;
	}

	
}