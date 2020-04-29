package com.zzhdsoft.siweb.entity.workflow;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  WF_YWLCLOG的中文含义是: 业务流程日志表
 * @Creation     2016/03/20 21:21:03
 * @Written      Create Tool By zjf 
 **/
@Table(value = "WF_YWLCLOG")
public class Wf_ywlclog {
	/**
	 * @Description ywlclogid的中文含义是： 工作流日志ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_ywlclogid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_ywlclogid.nextval from dual"))
	private String ywlclogid;

	/**
	 * @Description ywbh的中文含义是： 业务编号
	 */
	@Column
	private String ywbh;

	/**
	 * @Description ywbljg的中文含义是： 办理结果 01通过 02不通过  03打回
	 */
	@Column
	private String ywbljg;

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
	 * @Description nodepym的中文含义是： 节点名称拼音码
	 */
	@Column
	private String nodepym;

	/**
	 * @Description sftzjd的中文含义是： 是否是跳转节点1是0否
	 */
	@Column
	private String sftzjd;

	/**
	 * @Description nodesx的中文含义是： 节点时限
	 */
	@Column
	private String nodesx;

	/**
	 * @Description nodesxbegin的中文含义是： 时限开始时间
	 */
	@Column
	private Timestamp nodesxbegin;

	/**
	 * @Description nodesxend的中文含义是： 时限结束时间
	 */
	@Column
	private Timestamp nodesxend;
	/**
	 * @Description transname的中文含义是： 流向名称
	 */
	@Column
	private String transname;

	/**
	 * @Description transyy的中文含义是： 流向原因
	 */
	@Column
	private String transyy;
	/**
	 * @Description comdm的中文含义是： 企业代码：企业类型字母+6位行政区域代码+9位序列号
	 */
	@Column
	private String comdm;

	/**
	 * @Description commc的中文含义是： 企业名称
	 */
	@Column
	private String commc;
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
	 * @Description ywlclogid的中文含义是： 工作流日志ID
	 */
	public void setYwlclogid(String ywlclogid){ 
		this.ywlclogid = ywlclogid;
	}
	/**
	 * @Description ywlclogid的中文含义是： 工作流日志ID
	 */
	public String getYwlclogid(){
		return ywlclogid;
	}
	/**
	 * @Description ywbh的中文含义是： 业务编号
	 */
	public void setYwbh(String ywbh){ 
		this.ywbh = ywbh;
	}
	/**
	 * @Description ywbh的中文含义是： 业务编号
	 */
	public String getYwbh(){
		return ywbh;
	}
	
	/**
	 * @Description ywbljg的中文含义是： 办理结果 01通过 02不通过  03打回
	 */
	public void setYwbljg(String ywbljg){ 
		this.ywbljg = ywbljg;
	}
	/**
	 * @Description ywbljg的中文含义是： 办理结果 01通过 02不通过  03打回
	 */
	public String getYwbljg(){
		return ywbljg;
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
	 * @Description nodepym的中文含义是： 节点名称拼音码
	 */
	public void setNodepym(String nodepym){ 
		this.nodepym = nodepym;
	}
	/**
	 * @Description nodepym的中文含义是： 节点名称拼音码
	 */
	public String getNodepym(){
		return nodepym;
	}
	/**
	 * @Description sftzjd的中文含义是： 是否是跳转节点1是0否
	 */
	public void setSftzjd(String sftzjd){ 
		this.sftzjd = sftzjd;
	}
	/**
	 * @Description sftzjd的中文含义是： 是否是跳转节点1是0否
	 */
	public String getSftzjd(){
		return sftzjd;
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
	 * @Description nodesxbegin的中文含义是： 时限开始时间
	 */
	public void setNodesxbegin(Timestamp nodesxbegin){ 
		this.nodesxbegin = nodesxbegin;
	}
	/**
	 * @Description nodesxbegin的中文含义是： 时限开始时间
	 */
	public Timestamp getNodesxbegin(){
		return nodesxbegin;
	}
	/**
	 * @Description nodesxend的中文含义是： 时限结束时间
	 */
	public void setNodesxend(Timestamp nodesxend){ 
		this.nodesxend = nodesxend;
	}
	/**
	 * @Description nodesxend的中文含义是： 时限结束时间
	 */
	public Timestamp getNodesxend(){
		return nodesxend;
	}
	/**
	 * @Description transname的中文含义是： 流向名称
	 */
	public void setTransname(String transname){ 
		this.transname = transname;
	}
	/**
	 * @Description transname的中文含义是： 流向名称
	 */
	public String getTransname(){
		return transname;
	}
	/**
	 * @Description transyy的中文含义是： 流向原因
	 */
	public void setTransyy(String transyy){ 
		this.transyy = transyy;
	}
	/**
	 * @Description transyy的中文含义是： 流向原因
	 */
	public String getTransyy(){
		return transyy;
	}
	/**
	 * @Description comdm的中文含义是： 企业代码：企业类型字母+6位行政区域代码+9位序列号
	 */
	public void setComdm(String comdm){ 
		this.comdm = comdm;
	}
	/**
	 * @Description comdm的中文含义是： 企业代码：企业类型字母+6位行政区域代码+9位序列号
	 */
	public String getComdm(){
		return comdm;
	}
	/**
	 * @Description commc的中文含义是： 企业名称
	 */
	public void setCommc(String commc){ 
		this.commc = commc;
	}
	/**
	 * @Description commc的中文含义是： 企业名称
	 */
	public String getCommc(){
		return commc;
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