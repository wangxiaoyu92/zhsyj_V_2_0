package com.zzhdsoft.siweb.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;
/**
 * @Description  AA09 的中文含义是 代码类别
 * @Creation     2013/10/30 10:29:22
 * @Written      Create Tool By ZhengZhou HuaDong Software 
 **/
@Table(value = "AA09")
public class Aa09 {
	/**
	 * @Description aaa100的中文含义是： 代码类别
	 */
	@Column
	private String aaa100;

	/**
	 * @Description aaa101的中文含义是： 类别名称
	 */
	@Column
	private String aaa101;

	/**
	 * @Description aaa104的中文含义是： 代码可维护标志
	 */
	@Column
	private String aaa104;

	/**
	 * @Description aaz094的中文含义是： 代码类别ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_aaz094')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_aaz094.nextval from dual"))
	private String aaz094;

	
		/**
	 * @Description aaa100的中文含义是： 代码类别
	 */
	public void setAaa100(String aaa100){ 
		this.aaa100 = aaa100;
	}
	/**
	 * @Description aaa100的中文含义是： 代码类别
	 */
	public String getAaa100(){
		return aaa100;
	}
	/**
	 * @Description aaa101的中文含义是： 类别名称
	 */
	public void setAaa101(String aaa101){ 
		this.aaa101 = aaa101;
	}
	/**
	 * @Description aaa101的中文含义是： 类别名称
	 */
	public String getAaa101(){
		return aaa101;
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
	 * @Description aaz094的中文含义是： 代码类别ID
	 */
	public void setAaz094(String aaz094){ 
		this.aaz094 = aaz094;
	}
	/**
	 * @Description aaz094的中文含义是： 代码类别ID
	 */
	public String getAaz094(){
		return aaz094;
	}

	
}