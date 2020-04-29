package com.zzhdsoft.siweb.entity.workflow;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  WF_FORKSET的中文含义是: 分支流向设置表
 * @Creation     2016/03/17 17:14:11
 * @Written      Create Tool By zjf 
 **/
@Table(value = "WF_FORKSET")
public class Wf_forkset {
	/**
	 * @Description forksetid的中文含义是： 分支流向设置ID
	 */
	@Column
	@Id(auto=false)
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_forksetid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_forksetid.nextval from dual"))
	private Integer forksetid;

	/**
	 * @Description psbh的中文含义是： 工作流编号
	 */
	@Column
	private String psbh;

	/**
	 * @Description nodeid的中文含义是： 当前FORK节点nodeid
	 */
	@Column
	private Integer nodeid;

	/**
	 * @Description forksetdesc的中文含义是： 描述
	 */
	@Column
	private String forksetdesc;

	/**
	 * @Description forksetdescval的中文含义是： 描述值
	 */
	@Column
	private String forksetdescval;

	/**
	 * @Description forktonodeid的中文含义是： 分支流向节点ID
	 */
	@Column
	private Integer forktonodeid;

	
		/**
	 * @Description forksetid的中文含义是： 分支流向设置ID
	 */
	public void setForksetid(Integer forksetid){ 
		this.forksetid = forksetid;
	}
	/**
	 * @Description forksetid的中文含义是： 分支流向设置ID
	 */
	public Integer getForksetid(){
		return forksetid;
	}
	/**
	 * @Description psbh的中文含义是： 工作流编号
	 */
	public void setPsbh(String psbh){ 
		this.psbh = psbh;
	}
	/**
	 * @Description psbh的中文含义是： 工作流编号
	 */
	public String getPsbh(){
		return psbh;
	}
	/**
	 * @Description nodeid的中文含义是： 当前FORK节点nodeid
	 */
	public void setNodeid(Integer nodeid){ 
		this.nodeid = nodeid;
	}
	/**
	 * @Description nodeid的中文含义是： 当前FORK节点nodeid
	 */
	public Integer getNodeid(){
		return nodeid;
	}
	/**
	 * @Description forksetdesc的中文含义是： 描述
	 */
	public void setForksetdesc(String forksetdesc){ 
		this.forksetdesc = forksetdesc;
	}
	/**
	 * @Description forksetdesc的中文含义是： 描述
	 */
	public String getForksetdesc(){
		return forksetdesc;
	}
	/**
	 * @Description forksetdescval的中文含义是： 描述值
	 */
	public void setForksetdescval(String forksetdescval){ 
		this.forksetdescval = forksetdescval;
	}
	/**
	 * @Description forksetdescval的中文含义是： 描述值
	 */
	public String getForksetdescval(){
		return forksetdescval;
	}
	/**
	 * @Description forktonodeid的中文含义是： 分支流向节点ID
	 */
	public void setForktonodeid(Integer forktonodeid){ 
		this.forktonodeid = forktonodeid;
	}
	/**
	 * @Description forktonodeid的中文含义是： 分支流向节点ID
	 */
	public Integer getForktonodeid(){
		return forktonodeid;
	}

	
}