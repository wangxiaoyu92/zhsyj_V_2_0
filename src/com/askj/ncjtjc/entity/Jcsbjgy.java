package com.askj.ncjtjc.entity;

import org.nutz.dao.entity.annotation.*;
import java.sql.Timestamp;

/**
 * @Description  JCSBJGY的中文含义是: 聚餐申报指派监管员表; InnoDB free: 2731008 kB
 * @Creation     2016/05/26 15:25:59
 * @Written      Create Tool By zjf 
 **/
@Table(value = "JCSBJGY")
public class Jcsbjgy {
	/**
	 * @Description jcsbjgyid的中文含义是： 聚餐申报指派监管员表id
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_jcsbjgyid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_jcsbjgyid.nextval from dual"))
	private String jcsbjgyid;

	/**
	 * @Description jcsbid的中文含义是： 聚餐申报id
	 */
	@Column
	private String jcsbid;

	/**
	 * @Description userid的中文含义是： 监管员id
	 */
	@Column
	private String userid;

	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	@Column
	private String aae011;

	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	@Column
	private Timestamp aae036;

	/**
	 * @Description aae013的中文含义是： 备注
	 */
	@Column
	private String aae013;

	
		/**
	 * @Description jcsbjgyid的中文含义是： 聚餐申报指派监管员表id
	 */
	public void setJcsbjgyid(String jcsbjgyid){ 
		this.jcsbjgyid = jcsbjgyid;
	}
	/**
	 * @Description jcsbjgyid的中文含义是： 聚餐申报指派监管员表id
	 */
	public String getJcsbjgyid(){
		return jcsbjgyid;
	}
	/**
	 * @Description jcsbid的中文含义是： 聚餐申报id
	 */
	public void setJcsbid(String jcsbid){ 
		this.jcsbid = jcsbid;
	}
	/**
	 * @Description jcsbid的中文含义是： 聚餐申报id
	 */
	public String getJcsbid(){
		return jcsbid;
	}
	/**
	 * @Description userid的中文含义是： 监管员id
	 */
	public void setUserid(String userid){ 
		this.userid = userid;
	}
	/**
	 * @Description userid的中文含义是： 监管员id
	 */
	public String getUserid(){
		return userid;
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
	public void setAae036(Timestamp aae036){ 
		this.aae036 = aae036;
	}
	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	public Timestamp getAae036(){
		return aae036;
	}
	/**
	 * @Description aae013的中文含义是： 备注
	 */
	public void setAae013(String aae013){ 
		this.aae013 = aae013;
	}
	/**
	 * @Description aae013的中文含义是： 备注
	 */
	public String getAae013(){
		return aae013;
	}

	
}