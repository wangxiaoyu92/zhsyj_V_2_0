package com.zzhdsoft.siweb.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  AA01的中文含义是: 综合参数
 * @Creation     2015/08/24 15:32:11
 * @Written      Create Tool By zjf 
 **/
@Table(value = "AA01")
public class Aa01 {
	/**
	 * @Description aaa001的中文含义是： 参数类别代码
	 */
	@Column
	private String aaa001;

	/**
	 * @Description aaa002的中文含义是： 参数类别名称
	 */
	@Column
	private String aaa002;

	/**
	 * @Description aaa005的中文含义是： 参数值
	 */
	@Column
	private String aaa005;

	/**
	 * @Description aaa104的中文含义是： 代码可维护标志
	 */
	@Column
	private String aaa104;

	/**
	 * @Description aaa105的中文含义是： 参数值域说明
	 */
	@Column
	private String aaa105;

	/**
	 * @Description aaz499的中文含义是： 综合参数ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_aaz499')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_aaz499.nextval from dual"))
	private String aaz499;

	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	@Column
	private String aaa027;

	
		/**
	 * @Description aaa001的中文含义是： 参数类别代码
	 */
	public void setAaa001(String aaa001){ 
		this.aaa001 = aaa001;
	}
	/**
	 * @Description aaa001的中文含义是： 参数类别代码
	 */
	public String getAaa001(){
		return aaa001;
	}
	/**
	 * @Description aaa002的中文含义是： 参数类别名称
	 */
	public void setAaa002(String aaa002){ 
		this.aaa002 = aaa002;
	}
	/**
	 * @Description aaa002的中文含义是： 参数类别名称
	 */
	public String getAaa002(){
		return aaa002;
	}
	/**
	 * @Description aaa005的中文含义是： 参数值
	 */
	public void setAaa005(String aaa005){ 
		this.aaa005 = aaa005;
	}
	/**
	 * @Description aaa005的中文含义是： 参数值
	 */
	public String getAaa005(){
		return aaa005;
	}
	/**
	 * @Description aaa104的中文含义是： 代码可维护标志
	 */
	public void setAaa104(String aaa104){ 
		this.aaa104 = aaa104;
	}
	/**
	 * @Description aaa104的中文含义是： 代码可维护标志
	 */
	public String getAaa104(){
		return aaa104;
	}
	/**
	 * @Description aaa105的中文含义是： 参数值域说明
	 */
	public void setAaa105(String aaa105){ 
		this.aaa105 = aaa105;
	}
	/**
	 * @Description aaa105的中文含义是： 参数值域说明
	 */
	public String getAaa105(){
		return aaa105;
	}
	/**
	 * @Description aaz499的中文含义是： 综合参数ID
	 */
	public void setAaz499(String aaz499){ 
		this.aaz499 = aaz499;
	}
	/**
	 * @Description aaz499的中文含义是： 综合参数ID
	 */
	public String getAaz499(){
		return aaz499;
	}
	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	public void setAaa027(String aaa027){ 
		this.aaa027 = aaa027;
	}
	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	public String getAaa027(){
		return aaa027;
	}

	
}