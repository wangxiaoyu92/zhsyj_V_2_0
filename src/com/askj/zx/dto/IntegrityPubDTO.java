package com.askj.zx.dto;

import java.io.Serializable;
import java.sql.Date;
 

public class IntegrityPubDTO implements Serializable{
	 
         /*****Zxintegrityassess******/
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

	
	
	
	
	
	
	/****************Integritypub*************************/
	private Integer ipid;

	/**
	 * @Description comid的中文含义是： 企业ID
	 */
	
	private String comid;

	/**
	 * @Description iaid的中文含义是： 评估ID
	 */
	
	private Integer iaid;

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
	 * @Description logid的中文含义是： 日志ID
	 */
	
	private Integer logid;

	/**
	 * @Description ipenable的中文含义是： 是否启用; 0:不启用； 1：启用
	 */
	
	private String ipenable;

	/**
	 * @Description ipnote的中文含义是： 备注
	 */
	
	private String ipnote;

	
	
	
/******************pcompany**********************/
	 

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

	/**
	 * @Description comxkzbh的中文含义是： 许可证编号
	 */
	private String comxkzbh;

	/**
	 * @Description comfrhyz的中文含义是： 企业法人/业主
	 */
	
	private String comfrhyz;

	/**
	 * @Description comfrsfzh的中文含义是： 企业法人/业主身份证号
	 */
	
	private String comfrsfzh;

	/**
	 * @Description comfrxb的中文含义是： 企业法人/业主性别
	 */
	
	private String comfrxb;

	/**
	 * @Description comfrzw的中文含义是： 企业法人/业主职务
	 */
	
	private String comfrzw;

	/**
	 * @Description comfzr的中文含义是： 企业负责人
	 */
	
	private String comfzr;

	/**
	 * @Description comgddh的中文含义是： 固定电话
	 */
	
	private String comgddh;

	/**
	 * @Description comyddh的中文含义是： 移动电话
	 */
	
	private String comyddh;

	/**
	 * @Description comdz的中文含义是： 企业地址
	 */
	
	private String comdz;

	/**
	 * @Description comqq的中文含义是： 企业QQ
	 */
	
	private String comqq;

	/**
	 * @Description comemail的中文含义是： 企业电子邮件
	 */
	
	private String comemail;

	/**
	 * @Description comyzbm的中文含义是： 企业邮政编码
	 */
	
	private String comyzbm;

	/**
	 * @Description comwz的中文含义是： 网址
	 */
	
	private String comwz;

	/**
	 * @Description comcz的中文含义是： 传真
	 */
	
	private String comcz;

	/**
	 * @Description comxkfw的中文含义是： 许可范围
	 */
	
	private String comxkfw;

	/**
	 * @Description comxkyxqq的中文含义是： 许可有效期起
	 */
	
	private String comxkyxqq;

	/**
	 * @Description comxkyxqz的中文含义是： 许可有效期止
	 */
	
	private String comxkyxqz;

	/**
	 * @Description comctmj的中文含义是： 餐厅面积
	 */
	
	private String comctmj;

	/**
	 * @Description comcfmj的中文含义是： 厨房面积
	 */
	
	private String comcfmj;

	/**
	 * @Description comzmj的中文含义是： 总面积
	 */
	
	private String comzmj;

	/**
	 * @Description comjcrs的中文含义是： 就餐人数
	 */
	
	private Integer comjcrs;

	/**
	 * @Description comcyrs的中文含义是： 从业人数
	 */
	
	private Integer comcyrs;

	/**
	 * @Description comcjkzrs的中文含义是： 持健康证人数
	 */
	
	private Integer comcjkzrs;

	/**
	 * @Description comzjzglrs的中文含义是： 专（兼）职管理人员数
	 */
	
	private Integer comzjzglrs;

	/**
	 * @Description comxiaolei的中文含义是： 企业小类，代码表comxiaolei如特大型餐馆
	 */
	
	private String comxiaolei;

	/**
	 * @Description comdmlx的中文含义是： 店面类型，代码表comdmlx如蛋糕店、火锅店
	 */
	
	private String comdmlx;

	/**
	 * @Description comshengdm的中文含义是： 省份代码
	 */
	
	private String comshengdm;

	/**
	 * @Description comshengmc的中文含义是： 省份名称
	 */
	
	private String comshengmc;

	/**
	 * @Description comshidm的中文含义是： 市代码
	 */
	
	private String comshidm;

	/**
	 * @Description comshimc的中文含义是： 市名称
	 */
	
	private String comshimc;

	/**
	 * @Description comxiandm的中文含义是： 县代码
	 */
	
	private String comxiandm;

	/**
	 * @Description comxianmc的中文含义是： 县名称
	 */
	
	private String comxianmc;

	/**
	 * @Description comxiangdm的中文含义是： 街道办/乡镇代码
	 */
	
	private String comxiangdm;

	/**
	 * @Description comxiangmc的中文含义是： 街道办/乡镇名称
	 */
	
	private String comxiangmc;

	/**
	 * @Description comcundm的中文含义是： 社区/行政村代码
	 */
	
	private String comcundm;

	/**
	 * @Description comcunmc的中文含义是： 社区/行政村名称
	 */
	
	private String comcunmc;

	/**
	 * @Description comtscx的中文含义是： 特色菜系，代表表comtscx如豫菜
	 */
	
	private String comtscx;

	/**
	 * @Description comtsc的中文含义是： 特色菜
	 */
	
	private String comtsc;

	/**
	 * @Description comzzzm的中文含义是： 资质证明
	 */
	
	private String comzzzm;

	/**
	 * @Description comzzzmbh的中文含义是： 资质证明编号
	 */
	
	private String comzzzmbh;

	/**
	 * @Description comzzjgdm的中文含义是： 组织机构代码
	 */
	
	private String comzzjgdm;

	/**
	 * @Description comclrq的中文含义是： 企业成立日期
	 */
	
	private String comclrq;

	/**
	 * @Description comzczj的中文含义是： 注册资金（万元）
	 */
	
	private Integer comzczj;

	/**
	 * @Description comzclb的中文含义是： 1企业自行注册2 操作员添加注册
	 */
	
	private String comzclb;

	/**
	 * @Description comdzcczymc的中文含义是： 代企业注册的操作人
	 */
	
	private String comdzcczymc;

	/**
	 * @Description comdzcsj的中文含义是： 代注册时间
	 */
	
	private String comdzcsj;

	/**
	 * @Description comshbz的中文含义是： 审核标志 1通过 2未通过 0 等待审核
	 */
	
	private String comshbz;

	/**
	 * @Description comshr的中文含义是： 审核人
	 */
	
	private String comshr;

	/**
	 * @Description comshsj的中文含义是： 审核时间
	 */
	
	private String comshsj;

	/**
	 * @Description comshwtgyy的中文含义是： 审核未通过原因
	 */
	
	private String comshwtgyy;

	/**
	 * @Description comjianjie的中文含义是： 企业简介
	 */
	  
	private String comjianjie;
	/**
	 * @Description comqyxz的中文含义是： 企业性质
	 */

	private String comqyxz;
	/***********zxintegrityassessdetail**************/
	/**
	 * @Description iadid的中文含义是： 评估明细ID
	 */
	
	private Integer iadid;

	 

 

	 
	 

	/****************** Zxbusinesscode*********************/

	/**
	 * @Description bcid的中文含义是： ID
	 */
	
	private Integer bcid;

	/**
	 * @Description bccode的中文含义是： 编码
	 */
	 

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

	/**********zxbusinesspara********/
	/**
	 * @Description bpid的中文含义是： ID
	 */

	private Integer bpid;

	/**
	 * @Description bpcodesubsys的中文含义是： 参数编码 子系统编码
	 */

	private String bpcodesubsys;

	/**
	 * @Description bpcodebusiness的中文含义是： 参数编码 业务名称
	 */

	private String bpcodebusiness;

	/**
	 * @Description bpcodeitem的中文含义是： 参数编码 项目名称
	 */

	private String bpcodeitem;

	/**
	 * @Description bpcodelevel的中文含义是： 参数编码 级别
	 */

	private String bpcodelevel;

	/**
	 * @Description bpscore的中文含义是： 得分
	 */

	private String bpscore;

	/**
	 * @Description bpratio的中文含义是： 加乘系数
	 */

	private String bpratio;

	/**
	 * @Description bpyear的中文含义是： 业务年度
	 */

	private String bpyear;

	/**
	 * @Description bpdatebegin的中文含义是： 开始日期
	 */

	private Date bpdatebegin;

	/**
	 * @Description bpdateend的中文含义是： 结束日期。  为空则在用
	 */

	private Date bpdateend;

	/**
	 * @Description bpenable的中文含义是： 是否启用. 0:未启用；1：启用
	 */

	private String bpenable;
 

	/**
	 * @Description bplevel的中文含义是： 当前级别 (冗余)
	 */

	private String bplevel;

	 

	
	
	public Integer getBcid() {
		return bcid;
	}

	public void setBcid(Integer bcid) {
		this.bcid = bcid;
	}

	public String getBpcodesubsys() {
		return bpcodesubsys;
	}

	public void setBpcodesubsys(String bpcodesubsys) {
		this.bpcodesubsys = bpcodesubsys;
	}

	public String getBpcodebusiness() {
		return bpcodebusiness;
	}

	public void setBpcodebusiness(String bpcodebusiness) {
		this.bpcodebusiness = bpcodebusiness;
	}

	public String getBpcodeitem() {
		return bpcodeitem;
	}

	public void setBpcodeitem(String bpcodeitem) {
		this.bpcodeitem = bpcodeitem;
	}

	public String getBpcodelevel() {
		return bpcodelevel;
	}

	public void setBpcodelevel(String bpcodelevel) {
		this.bpcodelevel = bpcodelevel;
	}

	public String getBpscore() {
		return bpscore;
	}

	public void setBpscore(String bpscore) {
		this.bpscore = bpscore;
	}

	public String getBpratio() {
		return bpratio;
	}

	public void setBpratio(String bpratio) {
		this.bpratio = bpratio;
	}

	public String getBpyear() {
		return bpyear;
	}

	public void setBpyear(String bpyear) {
		this.bpyear = bpyear;
	}

	public Date getBpdatebegin() {
		return bpdatebegin;
	}

	public void setBpdatebegin(Date bpdatebegin) {
		this.bpdatebegin = bpdatebegin;
	}

	public Date getBpdateend() {
		return bpdateend;
	}

	public void setBpdateend(Date bpdateend) {
		this.bpdateend = bpdateend;
	}

	public String getBpenable() {
		return bpenable;
	}

	public void setBpenable(String bpenable) {
		this.bpenable = bpenable;
	}

	public String getBplevel() {
		return bplevel;
	}

	public void setBplevel(String bplevel) {
		this.bplevel = bplevel;
	}

	public Integer getIadid() {
		return iadid;
	}

	public void setIadid(Integer iadid) {
		this.iadid = iadid;
	}

	public Integer getBpid() {
		return bpid;
	}

	public void setBpid(Integer bpid) {
		this.bpid = bpid;
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

	public String getComqyxz() {
		return comqyxz;
	}

	public void setComqyxz(String comqyxz) {
		this.comqyxz = comqyxz;
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

	public String getComid() {
		return comid;
	}

	public void setComid(String  comid) {
		this.comid = comid;
	}

	public Integer getIaid() {
		return iaid;
	}

	public void setIaid(Integer iaid) {
		this.iaid = iaid;
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

	public Integer getLogid() {
		return logid;
	}

	public void setLogid(Integer logid) {
		this.logid = logid;
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

	public String getComxkzbh() {
		return comxkzbh;
	}

	public void setComxkzbh(String comxkzbh) {
		this.comxkzbh = comxkzbh;
	}

	public String getComfrhyz() {
		return comfrhyz;
	}

	public void setComfrhyz(String comfrhyz) {
		this.comfrhyz = comfrhyz;
	}

	public String getComfrsfzh() {
		return comfrsfzh;
	}

	public void setComfrsfzh(String comfrsfzh) {
		this.comfrsfzh = comfrsfzh;
	}

	public String getComfrxb() {
		return comfrxb;
	}

	public void setComfrxb(String comfrxb) {
		this.comfrxb = comfrxb;
	}

	public String getComfrzw() {
		return comfrzw;
	}

	public void setComfrzw(String comfrzw) {
		this.comfrzw = comfrzw;
	}

	public String getComfzr() {
		return comfzr;
	}

	public void setComfzr(String comfzr) {
		this.comfzr = comfzr;
	}

	public String getComgddh() {
		return comgddh;
	}

	public void setComgddh(String comgddh) {
		this.comgddh = comgddh;
	}

	public String getComyddh() {
		return comyddh;
	}

	public void setComyddh(String comyddh) {
		this.comyddh = comyddh;
	}

	public String getComdz() {
		return comdz;
	}

	public void setComdz(String comdz) {
		this.comdz = comdz;
	}

	public String getComqq() {
		return comqq;
	}

	public void setComqq(String comqq) {
		this.comqq = comqq;
	}

	public String getComemail() {
		return comemail;
	}

	public void setComemail(String comemail) {
		this.comemail = comemail;
	}

	public String getComyzbm() {
		return comyzbm;
	}

	public void setComyzbm(String comyzbm) {
		this.comyzbm = comyzbm;
	}

	public String getComwz() {
		return comwz;
	}

	public void setComwz(String comwz) {
		this.comwz = comwz;
	}

	public String getComcz() {
		return comcz;
	}

	public void setComcz(String comcz) {
		this.comcz = comcz;
	}

	public String getComxkfw() {
		return comxkfw;
	}

	public void setComxkfw(String comxkfw) {
		this.comxkfw = comxkfw;
	}

	public String getComxkyxqq() {
		return comxkyxqq;
	}

	public void setComxkyxqq(String comxkyxqq) {
		this.comxkyxqq = comxkyxqq;
	}

	public String getComxkyxqz() {
		return comxkyxqz;
	}

	public void setComxkyxqz(String comxkyxqz) {
		this.comxkyxqz = comxkyxqz;
	}

	public String getComctmj() {
		return comctmj;
	}

	public void setComctmj(String comctmj) {
		this.comctmj = comctmj;
	}

	public String getComcfmj() {
		return comcfmj;
	}

	public void setComcfmj(String comcfmj) {
		this.comcfmj = comcfmj;
	}

	public String getComzmj() {
		return comzmj;
	}

	public void setComzmj(String comzmj) {
		this.comzmj = comzmj;
	}

	public Integer getComjcrs() {
		return comjcrs;
	}

	public void setComjcrs(Integer comjcrs) {
		this.comjcrs = comjcrs;
	}

	public Integer getComcyrs() {
		return comcyrs;
	}

	public void setComcyrs(Integer comcyrs) {
		this.comcyrs = comcyrs;
	}

	public Integer getComcjkzrs() {
		return comcjkzrs;
	}

	public void setComcjkzrs(Integer comcjkzrs) {
		this.comcjkzrs = comcjkzrs;
	}

	public Integer getComzjzglrs() {
		return comzjzglrs;
	}

	public void setComzjzglrs(Integer comzjzglrs) {
		this.comzjzglrs = comzjzglrs;
	}

	public String getComxiaolei() {
		return comxiaolei;
	}

	public void setComxiaolei(String comxiaolei) {
		this.comxiaolei = comxiaolei;
	}

	public String getComdmlx() {
		return comdmlx;
	}

	public void setComdmlx(String comdmlx) {
		this.comdmlx = comdmlx;
	}

	public String getComshengdm() {
		return comshengdm;
	}

	public void setComshengdm(String comshengdm) {
		this.comshengdm = comshengdm;
	}

	public String getComshengmc() {
		return comshengmc;
	}

	public void setComshengmc(String comshengmc) {
		this.comshengmc = comshengmc;
	}

	public String getComshidm() {
		return comshidm;
	}

	public void setComshidm(String comshidm) {
		this.comshidm = comshidm;
	}

	public String getComshimc() {
		return comshimc;
	}

	public void setComshimc(String comshimc) {
		this.comshimc = comshimc;
	}

	public String getComxiandm() {
		return comxiandm;
	}

	public void setComxiandm(String comxiandm) {
		this.comxiandm = comxiandm;
	}

	public String getComxianmc() {
		return comxianmc;
	}

	public void setComxianmc(String comxianmc) {
		this.comxianmc = comxianmc;
	}

	public String getComxiangdm() {
		return comxiangdm;
	}

	public void setComxiangdm(String comxiangdm) {
		this.comxiangdm = comxiangdm;
	}

	public String getComxiangmc() {
		return comxiangmc;
	}

	public void setComxiangmc(String comxiangmc) {
		this.comxiangmc = comxiangmc;
	}

	public String getComcundm() {
		return comcundm;
	}

	public void setComcundm(String comcundm) {
		this.comcundm = comcundm;
	}

	public String getComcunmc() {
		return comcunmc;
	}

	public void setComcunmc(String comcunmc) {
		this.comcunmc = comcunmc;
	}

	public String getComtscx() {
		return comtscx;
	}

	public void setComtscx(String comtscx) {
		this.comtscx = comtscx;
	}

	public String getComtsc() {
		return comtsc;
	}

	public void setComtsc(String comtsc) {
		this.comtsc = comtsc;
	}

	public String getComzzzm() {
		return comzzzm;
	}

	public void setComzzzm(String comzzzm) {
		this.comzzzm = comzzzm;
	}

	public String getComzzzmbh() {
		return comzzzmbh;
	}

	public void setComzzzmbh(String comzzzmbh) {
		this.comzzzmbh = comzzzmbh;
	}

	public String getComzzjgdm() {
		return comzzjgdm;
	}

	public void setComzzjgdm(String comzzjgdm) {
		this.comzzjgdm = comzzjgdm;
	}

	public String getComclrq() {
		return comclrq;
	}

	public void setComclrq(String comclrq) {
		this.comclrq = comclrq;
	}

	public Integer getComzczj() {
		return comzczj;
	}

	public void setComzczj(Integer comzczj) {
		this.comzczj = comzczj;
	}

	public String getComzclb() {
		return comzclb;
	}

	public void setComzclb(String comzclb) {
		this.comzclb = comzclb;
	}

	public String getComdzcczymc() {
		return comdzcczymc;
	}

	public void setComdzcczymc(String comdzcczymc) {
		this.comdzcczymc = comdzcczymc;
	}

	public String getComdzcsj() {
		return comdzcsj;
	}

	public void setComdzcsj(String comdzcsj) {
		this.comdzcsj = comdzcsj;
	}

	public String getComshbz() {
		return comshbz;
	}

	public void setComshbz(String comshbz) {
		this.comshbz = comshbz;
	}

	public String getComshr() {
		return comshr;
	}

	public void setComshr(String comshr) {
		this.comshr = comshr;
	}

	public String getComshsj() {
		return comshsj;
	}

	public void setComshsj(String comshsj) {
		this.comshsj = comshsj;
	}

	public String getComshwtgyy() {
		return comshwtgyy;
	}

	public void setComshwtgyy(String comshwtgyy) {
		this.comshwtgyy = comshwtgyy;
	}

	public String getComjianjie() {
		return comjianjie;
	}

	public void setComjianjie(String comjianjie) {
		this.comjianjie = comjianjie;
	}

	
}
