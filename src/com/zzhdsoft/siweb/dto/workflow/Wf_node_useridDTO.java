package com.zzhdsoft.siweb.dto.workflow;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  WF_NODE_USERID的中文含义是: 节点操作员关系表DTO
 * @Creation     2016/09/02 16:51:34
 * @Written      Create Tool By zjf 
 **/
public class Wf_node_useridDTO {
	/**
	 * @Description nodeuserid的中文含义是： 节点角色表ID
	 */
	private String nodeuserid;

	/**
	 * @Description psbh的中文含义是： 工作流编号
	 */
	private String psbh;

	/**
	 * @Description nodeid的中文含义是： 节点ID
	 */
	private String nodeid;

	/**
	 * @Description userid的中文含义是： 角色ID
	 */
	private String userid;

	
		/**
	 * @Description nodeuserid的中文含义是： 节点角色表ID
	 */
	public void setNodeuserid(String nodeuserid){ 
		this.nodeuserid = nodeuserid;
	}
	/**
	 * @Description nodeuserid的中文含义是： 节点角色表ID
	 */
	public String getNodeuserid(){
		return nodeuserid;
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
	 * @Description nodeid的中文含义是： 节点ID
	 */
	public void setNodeid(String nodeid){ 
		this.nodeid = nodeid;
	}
	/**
	 * @Description nodeid的中文含义是： 节点ID
	 */
	public String getNodeid(){
		return nodeid;
	}
	/**
	 * @Description userid的中文含义是： 角色ID
	 */
	public void setUserid(String userid){ 
		this.userid = userid;
	}
	/**
	 * @Description userid的中文含义是： 角色ID
	 */
	public String getUserid(){
		return userid;
	}

	
}