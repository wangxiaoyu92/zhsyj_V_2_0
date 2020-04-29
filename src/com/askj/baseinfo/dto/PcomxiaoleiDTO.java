package com.askj.baseinfo.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  PcomxiaoleiDTO 的中文含义是: 企业小类表; InnoDB free: 485376 kB
 * @Creation     2017/03/25 10:14:27
 * @Written      Create Tool By zjf 
 **/
public class PcomxiaoleiDTO {
	/**
	 * @Description pcomxiaoleiid的中文含义是： 企业小类表id
	 */
	private String pcomxiaoleiid;

	/**
	 * @Description comid的中文含义是： 企业id
	 */
	private String comid;

	/**
	 * @Description comdalei的中文含义是： 企业大类编号
	 */
	private String comdalei;

	/**
	 * @Description comxiaolei的中文含义是： 企业小类编号
	 */
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

	
}