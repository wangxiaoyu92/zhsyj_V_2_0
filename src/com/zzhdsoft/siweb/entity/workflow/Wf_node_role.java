package com.zzhdsoft.siweb.entity.workflow;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  WF_NODE_ROLE的中文含义是: 节点角色关系表
 * @Creation     2016/03/17 17:13:36
 * @Written      Create Tool By zjf 
 **/
@Table(value = "WF_NODE_ROLE")
public class Wf_node_role {
	/**
	 * @Description noderoleid的中文含义是： 节点角色表ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_noderoleid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_noderoleid.nextval from dual"))
	private String noderoleid;

	/**
	 * @Description psbh的中文含义是： 工作流编号
	 */
	@Column
	private String psbh;

	/**
	 * @Description nodeid的中文含义是： 节点ID
	 */
	@Column
	private String nodeid;

	/**
	 * @Description roleid的中文含义是： 角色ID
	 */
	@Column
	private String roleid;

	
		/**
	 * @Description noderoleid的中文含义是： 节点角色表ID
	 */
	public void setNoderoleid(String noderoleid){ 
		this.noderoleid = noderoleid;
	}
	/**
	 * @Description noderoleid的中文含义是： 节点角色表ID
	 */
	public String getNoderoleid(){
		return noderoleid;
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
	 * @Description roleid的中文含义是： 角色ID
	 */
	public void setRoleid(String roleid){ 
		this.roleid = roleid;
	}
	/**
	 * @Description roleid的中文含义是： 角色ID
	 */
	public String getRoleid(){
		return roleid;
	}

	
}