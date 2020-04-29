package com.askj.zx.dto;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Date;

/**
 * @TODO  : 业务参数DTO
 * @author: 翟春磊
 * @DATE  : 2016年1月26日
 */
public class ZxParamDTO implements Serializable{
	private static final long serialVersionUID = -4873698724111110751L;

	private Integer bcid;

	/********BusinessCode*************************/
	/**
	 * @Description bccode的中文含义是： 编码
	 */
	private String bccode;

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
	
	
	/******businessParam****************************/
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

	
	private Integer spid;

	/**
	 * @Description spzxgrade的中文含义是： 企业诚信级别名称
	 */
	private String spzxgrade;

	/**
	 * @Description spscorebegin的中文含义是： 本级别起始分值
	 */
	private String spscorebegin;

	/**
	 * @Description spscoreend的中文含义是： 本级别结束分值
	 */
	private String spscoreend;

	/**
	 * @Description spyear的中文含义是： 业务年度
	 */
	private String spyear;

	/**
	 * @Description spdatebegin的中文含义是： 起始日期
	 */
	private Date spdatebegin;

	/**
	 * @Description spdateend的中文含义是： 结束日期
	 */
	private Date spdateend;

	/**
	 * @Description spenable的中文含义是： 当前是否启用（年度唯一）。0：未启用；1：启用 
	 */
	private String spenable;

	/**
	 * @Description logid的中文含义是： 操作日志ID
	 */
	private Integer logid;
	
	/*****其它字段******************************/
	private Long num;
	
	/**
	 * 是否父节点
	 */
	private Boolean isParent;
	
	private String parent;
	
	/**
	 * 子系统、业务、项目、级别、分值、系数
	 */
	private String subsys;
	private String business;
	private String item;
	private String level;
	private BigDecimal score;
	private BigDecimal ratio;
	public Integer getBcid() {
		return bcid;
	}
	public void setBcid(Integer bcid) {
		this.bcid = bcid;
	}
	public String getBccode() {
		return bccode;
	}
	public void setBccode(String bccode) {
		this.bccode = bccode;
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
	public Integer getBpid() {
		return bpid;
	}
	public void setBpid(Integer bpid) {
		this.bpid = bpid;
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
	public Integer getSpid() {
		return spid;
	}
	public void setSpid(Integer spid) {
		this.spid = spid;
	}
	public String getSpzxgrade() {
		return spzxgrade;
	}
	public void setSpzxgrade(String spzxgrade) {
		this.spzxgrade = spzxgrade;
	}
	public String getSpscorebegin() {
		return spscorebegin;
	}
	public void setSpscorebegin(String spscorebegin) {
		this.spscorebegin = spscorebegin;
	}
	public String getSpscoreend() {
		return spscoreend;
	}
	public void setSpscoreend(String spscoreend) {
		this.spscoreend = spscoreend;
	}
	public String getSpyear() {
		return spyear;
	}
	public void setSpyear(String spyear) {
		this.spyear = spyear;
	}
	public Date getSpdatebegin() {
		return spdatebegin;
	}
	public void setSpdatebegin(Date spdatebegin) {
		this.spdatebegin = spdatebegin;
	}
	public Date getSpdateend() {
		return spdateend;
	}
	public void setSpdateend(Date spdateend) {
		this.spdateend = spdateend;
	}
	public String getSpenable() {
		return spenable;
	}
	public void setSpenable(String spenable) {
		this.spenable = spenable;
	}
	public Integer getLogid() {
		return logid;
	}
	public void setLogid(Integer logid) {
		this.logid = logid;
	}
	public Long getNum() {
		return num;
	}
	public void setNum(Long num) {
		this.num = num;
	}
	public Boolean getIsParent() {
		return isParent;
	}
	public void setIsParent(Boolean isParent) {
		this.isParent = isParent;
	}
	public String getParent() {
		return parent;
	}
	public void setParent(String parent) {
		this.parent = parent;
		if(parent != null && ("true".equalsIgnoreCase(parent) || "false".equalsIgnoreCase(parent))){
			isParent = Boolean.valueOf(parent);
		}
	}
	public String getSubsys() {
		return subsys;
	}
	public void setSubsys(String subsys) {
		this.subsys = subsys;
	}
	public String getBusiness() {
		return business;
	}
	public void setBusiness(String business) {
		this.business = business;
	}
	public String getItem() {
		return item;
	}
	public void setItem(String item) {
		this.item = item;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public BigDecimal getScore() {
		return score;
	}
	public void setScore(BigDecimal score) {
		this.score = score;
	}
	public BigDecimal getRatio() {
		return ratio;
	}
	public void setRatio(BigDecimal ratio) {
		this.ratio = ratio;
	}

}
