package com.askj.baseinfo.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  PDBSXJSR的中文含义是: 待办事项接收人表; InnoDB free: 9216 kB
 * @Creation     2016/10/09 17:28:34
 * @Written      Create Tool By zjf 
 **/
@Table(value = "PDBSXJSR")
public class Pdbsxjsr {
	/**
	 * @Description pdbsxjsrid的中文含义是： 
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_pdbsxjsrid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_pdbsxjsrid.nextval from dual"))
	private String pdbsxjsrid;

	/**
	 * @Description pdbsxid的中文含义是： 
	 */
	@Column
	private String pdbsxid;

	/**
	 * @Description jsuserid的中文含义是： 
	 */
	@Column
	private String jsuserid;

	/**
	 * @Description jsusername的中文含义是： 
	 */
	@Column
	private String jsusername;

	/**
	 * @Description jsclyj的中文含义是： 
	 */
	@Column
	private String jsclyj;

	/**
	 * @Description jssj的中文含义是： 
	 */
	@Column
	private String jssj;
	
	/**
	 * @Description jsorgid的中文含义是： 接收人所属机构id
	 */
	@Column
	private String jsorgid;
	
	/**
	 * @Description jsorgname的中文含义是： 接收人所属机构名称
	 */
	@Column
	private String jsorgname;	
	
	/**
	 * @Description jsbz的中文含义是：接收标志0未接收1已接收
	 */
	@Column
	private String jsbz;		

	
		/**
	 * @Description pdbsxjsrid的中文含义是： 
	 */
	public void setPdbsxjsrid(String pdbsxjsrid){ 
		this.pdbsxjsrid = pdbsxjsrid;
	}
	/**
	 * @Description pdbsxjsrid的中文含义是： 
	 */
	public String getPdbsxjsrid(){
		return pdbsxjsrid;
	}
	/**
	 * @Description pdbsxid的中文含义是： 
	 */
	public void setPdbsxid(String pdbsxid){ 
		this.pdbsxid = pdbsxid;
	}
	/**
	 * @Description pdbsxid的中文含义是： 
	 */
	public String getPdbsxid(){
		return pdbsxid;
	}
	/**
	 * @Description jsuserid的中文含义是： 
	 */
	public void setJsuserid(String jsuserid){ 
		this.jsuserid = jsuserid;
	}
	/**
	 * @Description jsuserid的中文含义是： 
	 */
	public String getJsuserid(){
		return jsuserid;
	}
	/**
	 * @Description jsusername的中文含义是： 
	 */
	public void setJsusername(String jsusername){ 
		this.jsusername = jsusername;
	}
	/**
	 * @Description jsusername的中文含义是： 
	 */
	public String getJsusername(){
		return jsusername;
	}
	/**
	 * @Description jsclyj的中文含义是： 
	 */
	public void setJsclyj(String jsclyj){ 
		this.jsclyj = jsclyj;
	}
	/**
	 * @Description jsclyj的中文含义是： 
	 */
	public String getJsclyj(){
		return jsclyj;
	}
	/**
	 * @Description jssj的中文含义是： 
	 */
	public void setJssj(String jssj){ 
		this.jssj = jssj;
	}
	/**
	 * @Description jssj的中文含义是： 
	 */
	public String getJssj(){
		return jssj;
	}
	public String getJsorgid() {
		return jsorgid;
	}
	public void setJsorgid(String jsorgid) {
		this.jsorgid = jsorgid;
	}
	public String getJsorgname() {
		return jsorgname;
	}
	public void setJsorgname(String jsorgname) {
		this.jsorgname = jsorgname;
	}
	public String getJsbz() {
		return jsbz;
	}
	public void setJsbz(String jsbz) {
		this.jsbz = jsbz;
	}

	
	
}