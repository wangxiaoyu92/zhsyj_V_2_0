package com.zzhdsoft.siweb.entity.workflow;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  WF_NODE的中文含义是: 工作流节点表
 * @Creation     2016/03/12 19:50:13
 * @Written      Create Tool By zjf 
 **/
@Table(value = "WF_NODE")
public class Wf_node {
	/**
	 * @Description wfnodeid的中文含义是： 工作流节点表ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_wfnodeid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_wfnodeid.nextval from dual"))
	private String wfnodeid;

	/**
	 * @Description psbh的中文含义是： 节点所属的流程编号
	 */
	@Column
	private String psbh;

	/**
	 * @Description nodeid的中文含义是： 节点ID
	 */
	@Column
	private String nodeid;

	/**
	 * @Description nodetype的中文含义是： 节点类型：START_NODE、NODE、FORK_NODE、JOIN_NODE、END_NODE
	 */
	@Column
	private String nodetype;

	/**
	 * @Description nodename的中文含义是： 节点名称
	 */
	@Column
	private String nodename;

	/**
	 * @Description nodex的中文含义是： 节点x坐标值
	 */
	@Column
	private String nodex;

	/**
	 * @Description nodey的中文含义是： 节点y坐标值
	 */
	@Column
	private String nodey;

	/**
	 * @Description nodewidth的中文含义是： 节点宽度
	 */
	@Column
	private String nodewidth;

	/**
	 * @Description nodeheight的中文含义是： 节点高度
	 */
	@Column
	private String nodeheight;

	/**
	 * @Description nodesx的中文含义是： 节点时限
	 */
	@Column
	private String nodesx;

	/**
	 * @Description nodeurl的中文含义是： 节点URL
	 */
	@Column
	private String nodeurl;

	/**
	 * @Description nodecl的中文含义是： 节点是否需要实际处理(0不需要;1需要)
	 */
	@Column
	private String nodecl;

	/**
	 * @Description nodepym的中文含义是： 节点名称拼音字母
	 */
	@Column
	private String nodepym;
	
	/**
	 * @Description fjcsdmlb的中文含义是： 附件参数代码类别
	 */
	@Column
	private String fjcsdmlb;
	
	/**
	 * @Description fjcsdlbh的中文含义是： 附件参数大类编号
	 */
	@Column
	private String fjcsdlbh;	

	
		/**
	 * @Description wfnodeid的中文含义是： 工作流节点表ID
	 */
	public void setWfnodeid(String wfnodeid){ 
		this.wfnodeid = wfnodeid;
	}
	/**
	 * @Description wfnodeid的中文含义是： 工作流节点表ID
	 */
	public String getWfnodeid(){
		return wfnodeid;
	}
	/**
	 * @Description psbh的中文含义是： 节点所属的流程编号
	 */
	public void setPsbh(String psbh){ 
		this.psbh = psbh;
	}
	/**
	 * @Description psbh的中文含义是： 节点所属的流程编号
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
	 * @Description nodetype的中文含义是： 节点类型：START_NODE、NODE、FORK_NODE、JOIN_NODE、END_NODE
	 */
	public void setNodetype(String nodetype){ 
		this.nodetype = nodetype;
	}
	/**
	 * @Description nodetype的中文含义是： 节点类型：START_NODE、NODE、FORK_NODE、JOIN_NODE、END_NODE
	 */
	public String getNodetype(){
		return nodetype;
	}
	/**
	 * @Description nodename的中文含义是： 节点名称
	 */
	public void setNodename(String nodename){ 
		this.nodename = nodename;
	}
	/**
	 * @Description nodename的中文含义是： 节点名称
	 */
	public String getNodename(){
		return nodename;
	}
	/**
	 * @Description nodex的中文含义是： 节点x坐标值
	 */
	public void setNodex(String nodex){ 
		this.nodex = nodex;
	}
	/**
	 * @Description nodex的中文含义是： 节点x坐标值
	 */
	public String getNodex(){
		return nodex;
	}
	/**
	 * @Description nodey的中文含义是： 节点y坐标值
	 */
	public void setNodey(String nodey){ 
		this.nodey = nodey;
	}
	/**
	 * @Description nodey的中文含义是： 节点y坐标值
	 */
	public String getNodey(){
		return nodey;
	}
	/**
	 * @Description nodewidth的中文含义是： 节点宽度
	 */
	public void setNodewidth(String nodewidth){ 
		this.nodewidth = nodewidth;
	}
	/**
	 * @Description nodewidth的中文含义是： 节点宽度
	 */
	public String getNodewidth(){
		return nodewidth;
	}
	/**
	 * @Description nodeheight的中文含义是： 节点高度
	 */
	public void setNodeheight(String nodeheight){ 
		this.nodeheight = nodeheight;
	}
	/**
	 * @Description nodeheight的中文含义是： 节点高度
	 */
	public String getNodeheight(){
		return nodeheight;
	}
	/**
	 * @Description nodesx的中文含义是： 节点时限
	 */
	public void setNodesx(String nodesx){ 
		this.nodesx = nodesx;
	}
	/**
	 * @Description nodesx的中文含义是： 节点时限
	 */
	public String getNodesx(){
		return nodesx;
	}
	/**
	 * @Description nodeurl的中文含义是： 节点URL
	 */
	public void setNodeurl(String nodeurl){ 
		this.nodeurl = nodeurl;
	}
	/**
	 * @Description nodeurl的中文含义是： 节点URL
	 */
	public String getNodeurl(){
		return nodeurl;
	}
	/**
	 * @Description nodecl的中文含义是： 节点是否需要实际处理(0不需要;1需要)
	 */
	public void setNodecl(String nodecl){ 
		this.nodecl = nodecl;
	}
	/**
	 * @Description nodecl的中文含义是： 节点是否需要实际处理(0不需要;1需要)
	 */
	public String getNodecl(){
		return nodecl;
	}
	/**
	 * @Description nodepym的中文含义是： 节点名称拼音字母
	 */
	public void setNodepym(String nodepym){ 
		this.nodepym = nodepym;
	}
	/**
	 * @Description nodepym的中文含义是： 节点名称拼音字母
	 */
	public String getNodepym(){
		return nodepym;
	}
	public String getFjcsdmlb() {
		return fjcsdmlb;
	}
	public void setFjcsdmlb(String fjcsdmlb) {
		this.fjcsdmlb = fjcsdmlb;
	}
	public String getFjcsdlbh() {
		return fjcsdlbh;
	}
	public void setFjcsdlbh(String fjcsdlbh) {
		this.fjcsdlbh = fjcsdlbh;
	}
	
	

	
}