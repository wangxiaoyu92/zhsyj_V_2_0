package com.askj.zx.dto;

import java.io.Serializable;
import java.sql.Date;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;

/**
 * @Description NEWS的中文含义是: 诚信评估
 * @Creation 2015/07/16 15:14:21
 * @Written Create Tool By lfy
 **/
public class ZxIntegrityDTO implements Serializable{
	private static final long serialVersionUID = -3194688219709192779L;

	/****Zxbusinesscode*********************/
	
	private Integer bcid;

	/**
	 * @Description bcname的中文含义是： 名称
	 */
	
	private String bcname;

	/**
	 * @Description bcparentcode的中文含义是： 父节点编码
	 */
	
	private String bcparentcode;

	/**
	 * @Description bclevel的中文含义是： 级别，1：子系统；2：业务；3：项目；4：级别
	 */
	
	private String bclevel;

	/**
	 * @Description bcpublicity的中文含义是： 是否作为公示选项。 0:不公示；1：公示
	 */
	
	private String bcpublicity;

	/**
	 * @Description bctreecode的中文含义是： 树编码 子系统、业务、项目、级别，均是二位。如01010101,代表一个系统一个业务一个项目一个级别。
	 */
	
	private String bctreecode;

	/**
	 * @Description bcenable的中文含义是： 是否启用 0：不启用。1：启用
	 */
	
	private String bcenable;
	
	
	/*******ZxIntegrityAssess********************/
	private Integer iaid;

	/**
	 * @Description comid的中文含义是： 企业ID
	 */
	private Integer comid;

	/**
	 * @Description taskid的中文含义是： 评估任务ID （评估由哪里发起）
	 */
	private Integer taskid;

	/**
	 * @Description userid的中文含义是： 录入人员ID
	 */
	private Integer userid;

	/**
	 * @Description spyear的中文含义是： 年度
	 */
	private String spyear;

	/**
	 * @Description iaaccessdate的中文含义是： 评估日期
	 */
	private Date iaaccessdate;

	/**
	 * @Description logid的中文含义是： 业务日志ID
	 */
	private Integer logid;

	/**
	 * @Description iascore的中文含义是： 得分
	 */
	private String iascore;

	/**
	 * @Description spzxgrade的中文含义是： 企业诚信级别名称
	 */
	private String spzxgrade;

	/**
	 * @Description bccode的中文含义是： 采用的业务参数编码 zxBusinessCode,业务级别
	 */
	private String bccode;
	
	
	/*******************ZxIntegrityPublicity**************/
	private Integer ipid;


	/**
	 * @Description ipdate的中文含义是： 评估日期
	 */
	private Date ipdate;

	/**
	 * @Description ipupdate的中文含义是： 上榜时间
	 */
	private Date ipupdate;

	/**
	 * @Description ipuserid的中文含义是： 操作员ID
	 */
	private Integer ipuserid;


	/**
	 * @Description ipenable的中文含义是： 是否启用; 0:不启用； 1：启用
	 */
	private String ipenable;

	/**
	 * @Description ipnote的中文含义是： 备注
	 */
	private String ipnote;
	
	
	/*************Prompany***********************************/

	/**
	 * @Description username的中文含义是： 登录用户名
	 */

	private String username;

	/**
	 * @Description comdm的中文含义是： 企业代码：企业类型字母+6位行政区域代码+9位序列号
	 */

	private String comdm;

	/**
	 * @Description commc的中文含义是： 企业名称
	 */
	private String commc;

	/**
	 * @Description comdalei的中文含义是： 企业分类,代码表comdalei如食品生产，食品经营，药品生产，药品经营
	 */
	private String comdalei;

	/************aa10************/
	/**
	 * @Description aaa100的中文含义是 代码类别
	 */
	private String aaa100;

	/**
	 * @Description aaa102的中文含义是 代码值
	 */
	
	private String aaa102;

	/**
	 * @Description aaa103的中文含义是 代码名称
	 */
	
	private String aaa103;

	/**
	 * @Description aae030的中文含义是 开始日期
	 */
	
	private Integer aae030;

	public Integer getBcid() {
		return bcid;
	}

	public void setBcid(Integer bcid) {
		this.bcid = bcid;
	}

	public String getBcname() {
		return bcname;
	}

	public void setBcname(String bcname) {
		this.bcname = bcname;
	}

	public String getBcparentcode() {
		return bcparentcode;
	}

	public void setBcparentcode(String bcparentcode) {
		this.bcparentcode = bcparentcode;
	}

	public String getBclevel() {
		return bclevel;
	}

	public void setBclevel(String bclevel) {
		this.bclevel = bclevel;
	}

	public String getBcpublicity() {
		return bcpublicity;
	}

	public void setBcpublicity(String bcpublicity) {
		this.bcpublicity = bcpublicity;
	}

	public String getBctreecode() {
		return bctreecode;
	}

	public void setBctreecode(String bctreecode) {
		this.bctreecode = bctreecode;
	}

	public String getBcenable() {
		return bcenable;
	}

	public void setBcenable(String bcenable) {
		this.bcenable = bcenable;
	}

	public Integer getIaid() {
		return iaid;
	}

	public void setIaid(Integer iaid) {
		this.iaid = iaid;
	}

	public Integer getComid() {
		return comid;
	}

	public void setComid(Integer comid) {
		this.comid = comid;
	}

	public Integer getTaskid() {
		return taskid;
	}

	public void setTaskid(Integer taskid) {
		this.taskid = taskid;
	}

	public Integer getUserid() {
		return userid;
	}

	public void setUserid(Integer userid) {
		this.userid = userid;
	}

	public String getSpyear() {
		return spyear;
	}

	public void setSpyear(String spyear) {
		this.spyear = spyear;
	}

	public Date getIaaccessdate() {
		return iaaccessdate;
	}

	public void setIaaccessdate(Date iaaccessdate) {
		this.iaaccessdate = iaaccessdate;
	}

	public Integer getLogid() {
		return logid;
	}

	public void setLogid(Integer logid) {
		this.logid = logid;
	}

	public String getIascore() {
		return iascore;
	}

	public void setIascore(String iascore) {
		this.iascore = iascore;
	}

	public String getSpzxgrade() {
		return spzxgrade;
	}

	public void setSpzxgrade(String spzxgrade) {
		this.spzxgrade = spzxgrade;
	}

	public String getBccode() {
		return bccode;
	}

	public void setBccode(String bccode) {
		this.bccode = bccode;
	}

	public Integer getIpid() {
		return ipid;
	}

	public void setIpid(Integer ipid) {
		this.ipid = ipid;
	}

	public Date getIpdate() {
		return ipdate;
	}

	public void setIpdate(Date ipdate) {
		this.ipdate = ipdate;
	}

	public Date getIpupdate() {
		return ipupdate;
	}

	public void setIpupdate(Date ipupdate) {
		this.ipupdate = ipupdate;
	}

	public Integer getIpuserid() {
		return ipuserid;
	}

	public void setIpuserid(Integer ipuserid) {
		this.ipuserid = ipuserid;
	}

	public String getIpenable() {
		return ipenable;
	}

	public void setIpenable(String ipenable) {
		this.ipenable = ipenable;
	}

	public String getIpnote() {
		return ipnote;
	}

	public void setIpnote(String ipnote) {
		this.ipnote = ipnote;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
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

	public String getComdalei() {
		return comdalei;
	}

	public void setComdalei(String comdalei) {
		this.comdalei = comdalei;
	}

	public String getAaa100() {
		return aaa100;
	}

	public void setAaa100(String aaa100) {
		this.aaa100 = aaa100;
	}

	public String getAaa102() {
		return aaa102;
	}

	public void setAaa102(String aaa102) {
		this.aaa102 = aaa102;
	}

	public String getAaa103() {
		return aaa103;
	}

	public void setAaa103(String aaa103) {
		this.aaa103 = aaa103;
	}

	public Integer getAae030() {
		return aae030;
	}

	public void setAae030(Integer aae030) {
		this.aae030 = aae030;
	}


}
