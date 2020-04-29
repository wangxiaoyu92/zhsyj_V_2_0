package com.zzhdsoft.siweb.dto.workflow;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description WorkflowDTO的中文含义是: 工作流DTO
 * @Creation 2016/01/28 11:26:03
 * @Written Create Tool By zjf
 **/
public class WorkflowDTO {
	//扩展开始
	/**
	 * @Description mygridrows 的中文含义是： 前台需要往后台传的rows数据
	 */
	private String mygridrows;
	
	//扩展结束
	/**
	 * @Description userrows 的中文含义是： 
	 */
	private String userrows;
	
	/**
	 * @Description userid 的中文含义是： 操作员ID
	 */
	private String userid;
	/**
	 * @Description description 的中文含义是： 操作员姓名
	 */
	private String description;
	/**
	 * @Description nodeuserid 的中文含义是： 节点操作员关系表主键
	 */
	private String nodeuserid;
	/**
	 * @Description orgname 的中文含义是： 操作员所属机构名称
	 */
	private String orgname;	
	/**
	 * @Description username 的中文含义是： 用户名
	 */
	private String username;		
	
	
	
	/**
	 * @Description fjcsdmlb 的中文含义是： 附件参数代码类别
	 */
	private String fjcsdmlb;
	/**
	 * @Description fjcsdlbh 的中文含义是： 附件参数大类编号
	 */
	private String fjcsdlbh;
	
	
	/**
	 * @Description yewutablename 的中文含义是： 业务表名称 为了更新受理标志用
	 */
	private String yewutablename;
	/**
	 * @Description yewucolname 的中文含义是： 业务表名称 为了更新受理标志用
	 */
	private String yewucolname;	
	
	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	private String aaa027;
	/**
	 * @Description aaa027name的中文含义是： 统筹区名称
	 */
	private String aaa027name;
	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	private String aae011;

	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	private String aae036;
	/**
	 * @Description bz的中文含义是： 备注
	 */
	private String aae013;
	/**
	 * @Description startDate的中文含义是： 起始日期
	 */
	private String startDate;
	/**
	 * @Description endDate的中文含义是： 截至日期
	 */
	private String endDate;
	private String fjpath;

	public String getFjpath() {
		return fjpath;
	}

	public void setFjpath(String fjpath) {
		this.fjpath = fjpath;
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

	/**
	 * @Description aaa027name的中文含义是： 统筹区名称
	 */
	public String getAaa027name() {
		return aaa027name;
	}

	/**
	 * @Description aaa027name的中文含义是： 统筹区名称
	 */
	public void setAaa027name(String aaa027name) {
		this.aaa027name = aaa027name;
	}
	
	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	public void setAae011(String aae011) {
		this.aae011 = aae011;
	}

	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	public String getAae011() {
		return aae011;
	}

	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	public void setAae036(String aae036) {
		this.aae036 = aae036;
	}

	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	public String getAae036() {
		return aae036;
	}

	/**
	 * @Description aae013的中文含义是： 备注
	 */
	public void setAae013(String aae013) {
		this.aae013 = aae013;
	}

	/**
	 * @Description aae013的中文含义是： 备注
	 */
	public String getAae013() {
		return aae013;
	}

	/**
	 * @Description startDate的中文含义是： 起始日期
	 */
	public String getStartDate() {
		return startDate;
	}

	/**
	 * @Description startDate的中文含义是： 起始日期
	 */
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	/**
	 * @Description endDate的中文含义是： 截至日期
	 */
	public String getEndDate() {
		return endDate;
	}

	/**
	 * @Description endDate的中文含义是： 截至日期
	 */
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	/**
	 * @Description wdid的中文含义是：年度工作日ID
	 */
	private String wdid;

	/**
	 * @Description wdyear的中文含义是： 年度
	 */
	private String wdyear;

	/**
	 * @Description wdday的中文含义是： 年度工作日
	 */
	private String wdday;

	/**
	 * @Description wdid的中文含义是：年度工作日ID
	 */
	public void setWdid(String wdid) {
		this.wdid = wdid;
	}

	/**
	 * @Description wdid的中文含义是：年度工作日ID
	 */
	public String getWdid() {
		return wdid;
	}

	/**
	 * @Description wdyear的中文含义是： 年度
	 */
	public void setWdyear(String wdyear) {
		this.wdyear = wdyear;
	}

	/**
	 * @Description wdyear的中文含义是： 年度
	 */
	public String getWdyear() {
		return wdyear;
	}

	/**
	 * @Description wdday的中文含义是： 年度工作日
	 */
	public void setWdday(String wdday) {
		this.wdday = wdday;
	}

	/**
	 * @Description wdday的中文含义是： 年度工作日
	 */
	public String getWdday() {
		return wdday;
	}

	/**
	 * @Description psid的中文含义是： 工作流流程ID
	 */
	private String psid;

	/**
	 * @Description psbh的中文含义是： 工作流流程编号
	 */
	private String psbh;

	/**
	 * @Description psmc的中文含义是： 工作流流程名称
	 */
	private String psmc;

	/**
	 * @Description psxml的中文含义是： 工作流流程图
	 */
	private String psxml;

	/**
	 * @Description pszt的中文含义是： 工作流状态
	 */
	private String pszt;

	/**
	 * @Description psid的中文含义是： 工作流流程ID
	 */
	public void setPsid(String psid) {
		this.psid = psid;
	}

	/**
	 * @Description psid的中文含义是： 工作流流程ID
	 */
	public String getPsid() {
		return psid;
	}

	/**
	 * @Description psbh的中文含义是： 工作流流程编号
	 */
	public void setPsbh(String psbh) {
		this.psbh = psbh;
	}

	/**
	 * @Description psbh的中文含义是： 工作流流程编号
	 */
	public String getPsbh() {
		return psbh;
	}

	/**
	 * @Description psmc的中文含义是： 工作流流程名称
	 */
	public void setPsmc(String psmc) {
		this.psmc = psmc;
	}

	/**
	 * @Description psmc的中文含义是： 工作流流程名称
	 */
	public String getPsmc() {
		return psmc;
	}

	/**
	 * @Description psxml的中文含义是： 工作流流程图
	 */
	public void setPsxml(String psxml) {
		this.psxml = psxml;
	}

	/**
	 * @Description psxml的中文含义是： 工作流流程图
	 */
	public String getPsxml() {
		return psxml;
	}

	/**
	 * @Description pszt的中文含义是： 工作流状态
	 */
	public void setPszt(String pszt) {
		this.pszt = pszt;
	}

	/**
	 * @Description pszt的中文含义是： 工作流状态
	 */
	public String getPszt() {
		return pszt;
	}

	/**
	 * @Description yewuprocessid的中文含义是： 业务工作流关系表ID
	 */
	private String yewuprocessid;

	/**
	 * @Description yewumc的中文含义是： 业务名称
	 */
	private String yewumc;

	/**
	 * @Description yewumcpym的中文含义是： 业务名称拼音码
	 */
	private String yewumcpym;

	/**
	 * @Description sfqygzl的中文含义是： 是否启用工作流
	 */
	private String sfqygzl;

	/**
	 * @Description yewuprocessid的中文含义是： 业务工作流关系表ID
	 */
	public void setYewuprocessid(String yewuprocessid) {
		this.yewuprocessid = yewuprocessid;
	}

	/**
	 * @Description yewuprocessid的中文含义是： 业务工作流关系表ID
	 */
	public String getYewuprocessid() {
		return yewuprocessid;
	}

	/**
	 * @Description yewumc的中文含义是： 业务名称
	 */
	public void setYewumc(String yewumc) {
		this.yewumc = yewumc;
	}

	/**
	 * @Description yewumc的中文含义是： 业务名称
	 */
	public String getYewumc() {
		return yewumc;
	}

	/**
	 * @Description yewumcpym的中文含义是： 业务名称拼音码
	 */
	public void setYewumcpym(String yewumcpym) {
		this.yewumcpym = yewumcpym;
	}

	/**
	 * @Description yewumcpym的中文含义是： 业务名称拼音码
	 */
	public String getYewumcpym() {
		return yewumcpym;
	}

	/**
	 * @Description sfqygzl的中文含义是： 是否启用工作流
	 */
	public void setSfqygzl(String sfqygzl) {
		this.sfqygzl = sfqygzl;
	}

	/**
	 * @Description sfqygzl的中文含义是： 是否启用工作流
	 */
	public String getSfqygzl() {
		return sfqygzl;
	}

	/**
	 * @Description wfnodeid的中文含义是： 工作流节点表ID
	 */
	private String wfnodeid;

	/**
	 * @Description nodeid的中文含义是： 节点ID
	 */
	private String nodeid;

	/**
	 * @Description nodetype的中文含义是：
	 *              节点类型：START_NODE、NODE、FORK_NODE、JOIN_NODE、END_NODE
	 */
	private String nodetype;

	/**
	 * @Description nodename的中文含义是： 节点名称
	 */
	private String nodename;

	/**
	 * @Description nodex的中文含义是： 节点x坐标值
	 */
	private String nodex;

	/**
	 * @Description nodey的中文含义是： 节点y坐标值
	 */
	private String nodey;

	/**
	 * @Description nodewidth的中文含义是： 节点宽度
	 */
	private String nodewidth;

	/**
	 * @Description nodeheight的中文含义是： 节点高度
	 */
	private String nodeheight;

	/**
	 * @Description nodesx的中文含义是： 节点时限
	 */
	private String nodesx;

	/**
	 * @Description nodeurl的中文含义是： 节点URL
	 */
	private String nodeurl;

	/**
	 * @Description nodecl的中文含义是： 节点是否需要实际处理(0不需要;1需要)
	 */
	private String nodecl;

	/**
	 * @Description nodepym的中文含义是： 节点名称拼音字母
	 */
	private String nodepym;

	/**
	 * @Description wfnodeid的中文含义是： 工作流节点表ID
	 */
	public void setWfnodeid(String wfnodeid) {
		this.wfnodeid = wfnodeid;
	}

	/**
	 * @Description wfnodeid的中文含义是： 工作流节点表ID
	 */
	public String getWfnodeid() {
		return wfnodeid;
	}

	/**
	 * @Description nodeid的中文含义是： 节点ID
	 */
	public void setNodeid(String nodeid) {
		this.nodeid = nodeid;
	}

	/**
	 * @Description nodeid的中文含义是： 节点ID
	 */
	public String getNodeid() {
		return nodeid;
	}

	/**
	 * @Description nodetype的中文含义是：
	 *              节点类型：START_NODE、NODE、FORK_NODE、JOIN_NODE、END_NODE
	 */
	public void setNodetype(String nodetype) {
		this.nodetype = nodetype;
	}

	/**
	 * @Description nodetype的中文含义是：
	 *              节点类型：START_NODE、NODE、FORK_NODE、JOIN_NODE、END_NODE
	 */
	public String getNodetype() {
		return nodetype;
	}

	/**
	 * @Description nodename的中文含义是： 节点名称
	 */
	public void setNodename(String nodename) {
		this.nodename = nodename;
	}

	/**
	 * @Description nodename的中文含义是： 节点名称
	 */
	public String getNodename() {
		return nodename;
	}

	/**
	 * @Description nodex的中文含义是： 节点x坐标值
	 */
	public void setNodex(String nodex) {
		this.nodex = nodex;
	}

	/**
	 * @Description nodex的中文含义是： 节点x坐标值
	 */
	public String getNodex() {
		return nodex;
	}

	/**
	 * @Description nodey的中文含义是： 节点y坐标值
	 */
	public void setNodey(String nodey) {
		this.nodey = nodey;
	}

	/**
	 * @Description nodey的中文含义是： 节点y坐标值
	 */
	public String getNodey() {
		return nodey;
	}

	/**
	 * @Description nodewidth的中文含义是： 节点宽度
	 */
	public void setNodewidth(String nodewidth) {
		this.nodewidth = nodewidth;
	}

	/**
	 * @Description nodewidth的中文含义是： 节点宽度
	 */
	public String getNodewidth() {
		return nodewidth;
	}

	/**
	 * @Description nodeheight的中文含义是： 节点高度
	 */
	public void setNodeheight(String nodeheight) {
		this.nodeheight = nodeheight;
	}

	/**
	 * @Description nodeheight的中文含义是： 节点高度
	 */
	public String getNodeheight() {
		return nodeheight;
	}

	/**
	 * @Description nodesx的中文含义是： 节点时限
	 */
	public void setNodesx(String nodesx) {
		this.nodesx = nodesx;
	}

	/**
	 * @Description nodesx的中文含义是： 节点时限
	 */
	public String getNodesx() {
		return nodesx;
	}

	/**
	 * @Description nodeurl的中文含义是： 节点URL
	 */
	public void setNodeurl(String nodeurl) {
		this.nodeurl = nodeurl;
	}

	/**
	 * @Description nodeurl的中文含义是： 节点URL
	 */
	public String getNodeurl() {
		return nodeurl;
	}

	/**
	 * @Description nodecl的中文含义是： 节点是否需要实际处理(0不需要;1需要)
	 */
	public void setNodecl(String nodecl) {
		this.nodecl = nodecl;
	}

	/**
	 * @Description nodecl的中文含义是： 节点是否需要实际处理(0不需要;1需要)
	 */
	public String getNodecl() {
		return nodecl;
	}

	/**
	 * @Description nodepym的中文含义是： 节点名称拼音字母
	 */
	public void setNodepym(String nodepym) {
		this.nodepym = nodepym;
	}

	/**
	 * @Description nodepym的中文含义是： 节点名称拼音字母
	 */
	public String getNodepym() {
		return nodepym;
	}

	/**
	 * @Description nodetransid的中文含义是： 节点流向表ID
	 */
	private String nodetransid;

	/**
	 * @Description transid的中文含义是： 流向ID
	 */
	private String transid;

	/**
	 * @Description transname的中文含义是： 流向名称
	 */
	private String transname;

	/**
	 * @Description transval的中文含义是： 流向值
	 */
	private String transval;

	/**
	 * @Description transfrom的中文含义是： 流向from
	 */
	private String transfrom;

	/**
	 * @Description transto的中文含义是： 流向to
	 */
	private String transto;

	/**
	 * @Description nodetransid的中文含义是： 节点流向表ID
	 */
	public void setNodetransid(String nodetransid) {
		this.nodetransid = nodetransid;
	}

	/**
	 * @Description nodetransid的中文含义是： 节点流向表ID
	 */
	public String getNodetransid() {
		return nodetransid;
	}

	/**
	 * @Description transid的中文含义是： 流向ID
	 */
	public void setTransid(String transid) {
		this.transid = transid;
	}

	/**
	 * @Description transid的中文含义是： 流向ID
	 */
	public String getTransid() {
		return transid;
	}

	/**
	 * @Description transname的中文含义是： 流向名称
	 */
	public void setTransname(String transname) {
		this.transname = transname;
	}

	/**
	 * @Description transname的中文含义是： 流向名称
	 */
	public String getTransname() {
		return transname;
	}

	/**
	 * @Description transval的中文含义是： 流向值
	 */
	public void setTransval(String transval) {
		this.transval = transval;
	}

	/**
	 * @Description transval的中文含义是： 流向值
	 */
	public String getTransval() {
		return transval;
	}

	/**
	 * @Description transfrom的中文含义是： 流向from
	 */
	public void setTransfrom(String transfrom) {
		this.transfrom = transfrom;
	}

	/**
	 * @Description transfrom的中文含义是： 流向from
	 */
	public String getTransfrom() {
		return transfrom;
	}

	/**
	 * @Description transto的中文含义是： 流向to
	 */
	public void setTransto(String transto) {
		this.transto = transto;
	}

	/**
	 * @Description transto的中文含义是： 流向to
	 */
	public String getTransto() {
		return transto;
	}

	/**
	 * @Description noderoleid的中文含义是： 节点角色表ID
	 */
	private String noderoleid;

	/**
	 * @Description roleid的中文含义是： 角色ID
	 */
	private String roleid;

	/**
	 * @Description noderoleid的中文含义是： 节点角色表ID
	 */
	public void setNoderoleid(String noderoleid) {
		this.noderoleid = noderoleid;
	}

	/**
	 * @Description noderoleid的中文含义是： 节点角色表ID
	 */
	public String getNoderoleid() {
		return noderoleid;
	}

	/**
	 * @Description roleid的中文含义是： 角色ID
	 */
	public void setRoleid(String roleid) {
		this.roleid = roleid;
	}

	/**
	 * @Description roleid的中文含义是： 角色ID
	 */
	public String getRoleid() {
		return roleid;
	}


	/**
	 * @Description ywlcid的中文含义是： 业务流程ID
	 */
	private String ywlcid;

	/**
	 * @Description ywbh的中文含义是： 业务编号
	 */
	private String ywbh;

	/**
	 * @Description ywlccurnode的中文含义是： 当前节点
	 */
	private String ywlccurnode;

	/**
	 * @Description nodesxbegin的中文含义是： 时限开始时间
	 */
	private String nodesxbegin;

	/**
	 * @Description nodesxend的中文含义是： 时限结束时间
	 */
	private String nodesxend;

	/**
	 * @Description ywlcjsbz的中文含义是： 流程结束标志(0未结束,1已结束)
	 */
	private String ywlcjsbz;

	/**
	 * @Description ywlczcjsbz的中文含义是： 流程正常结束标志(0处理中,1正常结束,2非正常结束)
	 */
	private String ywlczcjsbz;

	/**
	 * @Description ywlcid的中文含义是： 业务流程ID
	 */
	public void setYwlcid(String ywlcid) {
		this.ywlcid = ywlcid;
	}

	/**
	 * @Description ywlcid的中文含义是： 业务流程ID
	 */
	public String getYwlcid() {
		return ywlcid;
	}

	/**
	 * @Description ywbh的中文含义是： 业务编号
	 */
	public void setYwbh(String ywbh) {
		this.ywbh = ywbh;
	}

	/**
	 * @Description ywbh的中文含义是： 业务编号
	 */
	public String getYwbh() {
		return ywbh;
	}

	/**
	 * @Description ywlccurnode的中文含义是： 当前节点
	 */
	public void setYwlccurnode(String ywlccurnode) {
		this.ywlccurnode = ywlccurnode;
	}

	/**
	 * @Description ywlccurnode的中文含义是： 当前节点
	 */
	public String getYwlccurnode() {
		return ywlccurnode;
	}

	/**
	 * @Description nodesxbegin的中文含义是： 时限开始时间
	 */
	public void setNodesxbegin(String nodesxbegin) {
		this.nodesxbegin = nodesxbegin;
	}

	/**
	 * @Description nodesxbegin的中文含义是： 时限开始时间
	 */
	public String getNodesxbegin() {
		return nodesxbegin;
	}

	/**
	 * @Description nodesxend的中文含义是： 时限结束时间
	 */
	public void setNodesxend(String nodesxend) {
		this.nodesxend = nodesxend;
	}

	/**
	 * @Description nodesxend的中文含义是： 时限结束时间
	 */
	public String getNodesxend() {
		return nodesxend;
	}

	/**
	 * @Description ywlcjsbz的中文含义是： 流程结束标志(0未结束,1已结束)
	 */
	public void setYwlcjsbz(String ywlcjsbz) {
		this.ywlcjsbz = ywlcjsbz;
	}

	/**
	 * @Description ywlcjsbz的中文含义是： 流程结束标志(0未结束,1已结束)
	 */
	public String getYwlcjsbz() {
		return ywlcjsbz;
	}

	/**
	 * @Description ywlczcjsbz的中文含义是： 流程正常结束标志(0处理中,1正常结束,2非正常结束)
	 */
	public void setYwlczcjsbz(String ywlczcjsbz) {
		this.ywlczcjsbz = ywlczcjsbz;
	}

	/**
	 * @Description ywlczcjsbz的中文含义是： 流程正常结束标志(0处理中,1正常结束,2非正常结束)
	 */
	public String getYwlczcjsbz() {
		return ywlczcjsbz;
	}

	/**
	 * @Description ywlclogid的中文含义是： 工作流日志ID
	 */
	private String ywlclogid;

	/**
	 * @Description ywmcpym的中文含义是： 业务名称拼音码
	 */
	private String ywmcpym;

	/**
	 * @Description ywbljg的中文含义是： 办理结果 01通过 02不通过 03打回
	 */
	private String ywbljg;

	/**
	 * @Description sftzjd的中文含义是： 是否是跳转节点1是0否
	 */
	private String sftzjd;
	/**
	 * @Description transyy的中文含义是： 流向原因
	 */
	private String transyy;
	
	/**
	 * @Description comdm的中文含义是： 企业代码：企业类型字母+6位行政区域代码+9位序列号
	 */
	private String comdm;

	/**
	 * @Description commc的中文含义是： 企业名称
	 */
	private String commc;
	/**
	 * @Description ywlclogid的中文含义是： 工作流日志ID
	 */
	public void setYwlclogid(String ywlclogid) {
		this.ywlclogid = ywlclogid;
	}

	/**
	 * @Description ywlclogid的中文含义是： 工作流日志ID
	 */
	public String getYwlclogid() {
		return ywlclogid;
	}

	/**
	 * @Description ywmcpym的中文含义是： 业务名称拼音码
	 */
	public void setYwmcpym(String ywmcpym) {
		this.ywmcpym = ywmcpym;
	}

	/**
	 * @Description ywmcpym的中文含义是： 业务名称拼音码
	 */
	public String getYwmcpym() {
		return ywmcpym;
	}

	/**
	 * @Description ywbljg的中文含义是： 办理结果 01通过 02不通过 03打回
	 */
	public void setYwbljg(String ywbljg) {
		this.ywbljg = ywbljg;
	}

	/**
	 * @Description ywbljg的中文含义是： 办理结果 01通过 02不通过 03打回
	 */
	public String getYwbljg() {
		return ywbljg;
	}

	/**
	 * @Description sftzjd的中文含义是： 是否是跳转节点1是0否
	 */
	public void setSftzjd(String sftzjd) {
		this.sftzjd = sftzjd;
	}

	/**
	 * @Description sftzjd的中文含义是： 是否是跳转节点1是0否
	 */
	public String getSftzjd() {
		return sftzjd;
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
	 * @Description zfajzfwsnodeid的中文含义是： 执法案件执法文书和流程节点对照表ID
	 */
	private String zfajzfwsnodeid;
	
	/**
	 * @Description zfwsdmz的中文含义是： 执法文书编号，代码表中的编号
	 */
	private String zfwsdmz;
	
	/**
	 * @Description zfwsdmmc的中文含义是： 执法文书名称
	 */
	private String zfwsdmmc;

	/**
	 * @Description type的中文含义是： 业务类型
	 */
	private String type;

	/**
	 * @Description ywlcuserid的中文含义是： 可见人id
	 */
	private String ywlcuserid;

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getYwlcuserid() {
		return ywlcuserid;
	}

	public void setYwlcuserid(String ywlcuserid) {
		this.ywlcuserid = ywlcuserid;
	}

	/**
	 * @Description zfajzfwsnodeid的中文含义是： 执法案件执法文书和流程节点对照表ID
	 */
	public void setZfajzfwsnodeid(String zfajzfwsnodeid){ 
		this.zfajzfwsnodeid = zfajzfwsnodeid;
	}
	/**
	 * @Description zfajzfwsnodeid的中文含义是： 执法案件执法文书和流程节点对照表ID
	 */
	public String getZfajzfwsnodeid(){
		return zfajzfwsnodeid;
	}
	
	/**
	 * @Description zfwsdmz的中文含义是： 执法文书编号，代码表中的编号
	 */
	public void setZfwsdmz(String zfwsdmz){ 
		this.zfwsdmz = zfwsdmz;
	}
	/**
	 * @Description zfwsdmz的中文含义是： 执法文书编号，代码表中的编号
	 */
	public String getZfwsdmz(){
		return zfwsdmz;
	}
	
	/**
	 * @Description zfwsdmmc的中文含义是： 执法文书名称
	 */
	public void setZfwsdmmc(String zfwsdmmc){ 
		this.zfwsdmmc = zfwsdmmc;
	}
	/**
	 * @Description zfwsdmmc的中文含义是： 执法文书名称
	 */
	public String getZfwsdmmc(){
		return zfwsdmmc;
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

	public String getYewutablename() {
		return yewutablename;
	}

	public void setYewutablename(String yewutablename) {
		this.yewutablename = yewutablename;
	}

	public String getYewucolname() {
		return yewucolname;
	}

	public void setYewucolname(String yewucolname) {
		this.yewucolname = yewucolname;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getNodeuserid() {
		return nodeuserid;
	}

	public void setNodeuserid(String nodeuserid) {
		this.nodeuserid = nodeuserid;
	}

	public String getOrgname() {
		return orgname;
	}

	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getUserrows() {
		return userrows;
	}

	public void setUserrows(String userrows) {
		this.userrows = userrows;
	}

	public String getMygridrows() {
		return mygridrows;
	}

	public void setMygridrows(String mygridrows) {
		this.mygridrows = mygridrows;
	}
	
}