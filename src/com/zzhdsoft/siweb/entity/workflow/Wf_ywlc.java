package com.zzhdsoft.siweb.entity.workflow;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  WF_YWLC的中文含义是: 业务流程表
 * @Creation     2016/03/20 21:20:38
 * @Written      Create Tool By zjf 
 **/
@Table(value = "WF_YWLC")
public class Wf_ywlc {
	
	/**
	 * @Description ywlcid的中文含义是： 业务流程ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_ywlcid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_ywlcid.nextval from dual"))
	private String ywlcid;

	/**
	 * @Description ywbh的中文含义是： 业务编号
	 */
	@Column
	private String ywbh;

	/**
	 * @Description psbh的中文含义是： 工作流编号
	 */
	@Column
	private String psbh;

	/**
	 * @Description ywlccurnode的中文含义是： 当前节点
	 */
	@Column
	private String ywlccurnode;

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
	 * @Description ywlcjsbz的中文含义是： 流程结束标志(0未结束,1已结束)
	 */
	@Column
	private String ywlcjsbz;

	/**
	 * @Description ywlczcjsbz的中文含义是： 流程正常结束标志(0处理中,1正常结束,2非正常结束)
	 */
	@Column
	private String ywlczcjsbz;

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
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	@Column
	private String aaa027;

//	/**
//	 * @Description type的中文含义是： 业务类型
//	 */
//	@Column
//	private String type;
//
//	/**
//	 * @Description ywlcuserid的中文含义是： 可见人id
//	 */
//	@Column
//	private String ywlcuserid;
	
		/**
	 * @Description ywlcid的中文含义是： 业务流程ID
	 */
	public void setYwlcid(String ywlcid){ 
		this.ywlcid = ywlcid;
	}
	/**
	 * @Description ywlcid的中文含义是： 业务流程ID
	 */
	public String getYwlcid(){
		return ywlcid;
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
	 * @Description ywlccurnode的中文含义是： 当前节点
	 */
	public void setYwlccurnode(String ywlccurnode){ 
		this.ywlccurnode = ywlccurnode;
	}
	/**
	 * @Description ywlccurnode的中文含义是： 当前节点
	 */
	public String getYwlccurnode(){
		return ywlccurnode;
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
	 * @Description ywlcjsbz的中文含义是： 流程结束标志(0未结束,1已结束)
	 */
	public void setYwlcjsbz(String ywlcjsbz){ 
		this.ywlcjsbz = ywlcjsbz;
	}
	/**
	 * @Description ywlcjsbz的中文含义是： 流程结束标志(0未结束,1已结束)
	 */
	public String getYwlcjsbz(){
		return ywlcjsbz;
	}
	/**
	 * @Description ywlczcjsbz的中文含义是： 流程正常结束标志(0处理中,1正常结束,2非正常结束)
	 */
	public void setYwlczcjsbz(String ywlczcjsbz){ 
		this.ywlczcjsbz = ywlczcjsbz;
	}
	/**
	 * @Description ywlczcjsbz的中文含义是： 流程正常结束标志(0处理中,1正常结束,2非正常结束)
	 */
	public String getYwlczcjsbz(){
		return ywlczcjsbz;
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
	public String getComdm() {
		return comdm;
	}
	public void setComdm(String comdm) {
		this.comdm = comdm;
	}
	public String getCommc() {
		return commc;
	}
	public void setCommc(String commc) {
		this.commc = commc;
	}
	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	public void setAaa027(String aaa027) {
		this.aaa027 = aaa027;
	}

	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	public String getAaa027() {
		return aaa027;
	}

//	public String getType() {
//		return type;
//	}
//
//	public void setType(String type) {
//		this.type = type;
//	}

//	public String getYwlcuserid() {
//		return ywlcuserid;
//	}
//
//	public void setYwlcuserid(String ywlcuserid) {
//		this.ywlcuserid = ywlcuserid;
//	}
}