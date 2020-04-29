package com.askj.baseinfo.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  Pcomxiaolei的中文含义是: 企业小类表; InnoDB free: 485376 kB
 * @Creation     2017/03/25 10:12:46
 * @Written      Create Tool By zjf 
 **/
@Table(value = "pcomxiaolei")
public class Pcomxiaolei {
	//扩展开始
	/**
	 * @Description comxiaoleiname的中文含义是： 企业小类汉字描述
	 */
	@Column
	@Readonly
	private String comxiaoleiname;
	
	//扩展结束
	/**
	 * @Description pcomxiaoleiid的中文含义是： 企业小类表id
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_pcomxiaoleiid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_pcomxiaoleiid.nextval from dual"))
	private String pcomxiaoleiid;

	/**
	 * @Description comid的中文含义是： 企业id
	 */
	@Column
	private String comid;

	/**
	 * @Description comdalei的中文含义是： 企业大类编号
	 */
	@Column
	private String comdalei;

	/**
	 * @Description comxiaolei的中文含义是： 企业小类编号
	 */
	@Column
	private String comxiaolei;

	
		/**
	 * @Description pcomxiaoleiid的中文含义是： 企业小类表id
	 */
	public void setPcomxiaoleiid(String pcomxiaoleiid){ 
		this.pcomxiaoleiid = pcomxiaoleiid;
	}
	/**
	 * @Description pcomxiaoleiid的中文含义是： 企业小类表id
	 */
	public String getPcomxiaoleiid(){
		return pcomxiaoleiid;
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
	/**
	 * @Description comdalei的中文含义是： 企业大类编号
	 */
	public void setComdalei(String comdalei){ 
		this.comdalei = comdalei;
	}
	/**
	 * @Description comdalei的中文含义是： 企业大类编号
	 */
	public String getComdalei(){
		return comdalei;
	}
	/**
	 * @Description comxiaolei的中文含义是： 企业小类编号
	 */
	public void setComxiaolei(String comxiaolei){ 
		this.comxiaolei = comxiaolei;
	}
	/**
	 * @Description comxiaolei的中文含义是： 企业小类编号
	 */
	public String getComxiaolei(){
		return comxiaolei;
	}
	public String getComxiaoleiname() {
		return comxiaoleiname;
	}
	public void setComxiaoleiname(String comxiaoleiname) {
		this.comxiaoleiname = comxiaoleiname;
	}

	
}