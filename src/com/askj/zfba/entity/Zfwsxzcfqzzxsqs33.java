package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  ZFWSXZCFQZZXSQS33的中文含义是: 行政处罚强制执行申请书; InnoDB free: 2725888 kB
 * @Creation     2016/06/23 16:45:15
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSXZCFQZZXSQS33")
public class Zfwsxzcfqzzxsqs33 {
	
	/**
	 * @Description xzjgmc的中文含义是： 行政机关名称
	 */
	@Column
	private String xzjgmc;

	/**
	 * @Description xzjgmc的中文含义是： 行政机关名称
	 */
	public String getXzjgmc() {
		return xzjgmc;
	}
	/**
	 * @Description xzjgmc的中文含义是： 行政机关名称
	 */
	public void setXzjgmc(String xzjgmc) {
		this.xzjgmc = xzjgmc;
	}
	/**
	 * @Description xzcfqzzxsqsid的中文含义是： 行政处罚强制执行申请书ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_xzcfqzzxsqsid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_xzcfqzzxsqsid.nextval from dual"))
	private String xzcfqzzxsqsid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description qzsqwsbh的中文含义是： 文书编号
	 */
	@Column
	private String qzsqwsbh;

	/**
	 * @Description qzsqsqr的中文含义是： 申请人
	 */
	@Column
	private String qzsqsqr;

	/**
	 * @Description qzsqsqrdz的中文含义是： 申请人地址
	 */
	@Column
	private String qzsqsqrdz;

	/**
	 * @Description qzsqsqrlxr的中文含义是： 申请人联系人
	 */
	@Column
	private String qzsqsqrlxr;

	/**
	 * @Description qzsqsqrlxfs的中文含义是： 申请人联系方式
	 */
	@Column
	private String qzsqsqrlxfs;

	/**
	 * @Description qzsqsqrfddbr的中文含义是： 申请人法定代表人
	 */
	@Column
	private String qzsqsqrfddbr;

	/**
	 * @Description qzsqsqrfddbrzw的中文含义是： 申请人法定代表人职务
	 */
	@Column
	private String qzsqsqrfddbrzw;

	/**
	 * @Description qzsqwtdlr的中文含义是： 委托代理人
	 */
	@Column
	private String qzsqwtdlr;

	/**
	 * @Description qzsqwtdlrzw的中文含义是： 委托代理人职务
	 */
	@Column
	private String qzsqwtdlrzw;

	/**
	 * @Description qzsqbsqr的中文含义是： 被申请人
	 */
	@Column
	private String qzsqbsqr;

	/**
	 * @Description qzsqbsqrfddbr的中文含义是： 被申请人法定代表人
	 */
	@Column
	private String qzsqbsqrfddbr;

	/**
	 * @Description qzsqbsqrzw的中文含义是： 被申请人职务
	 */
	@Column
	private String qzsqbsqrzw;

	/**
	 * @Description qzsqbsqrlxdh的中文含义是： 被申请人联系电话
	 */
	@Column
	private String qzsqbsqrlxdh;

	/**
	 * @Description qzsqxzjgfzr的中文含义是： 行政机关负责人
	 */
	@Column
	private String qzsqxzjgfzr;

	/**
	 * @Description qzsqgzrq的中文含义是： 盖章日期
	 */
	@Column
	private String qzsqgzrq;

	/**
	 * @Description qzsqrmfymc的中文含义是： 人民法院名称
	 */
	@Column
	private String qzsqrmfymc;

	/**
	 * @Description qzsqsqrzcxzcfrq的中文含义是： 申请人做出行政处罚日期
	 */
	@Column
	private String qzsqsqrzcxzcfrq;

	/**
	 * @Description qzsqxzcfjdbh的中文含义是： 行政处罚决定编号
	 */
	@Column
	private String qzsqxzcfjdbh;

	/**
	 * @Description qzsqsdbsqrrq的中文含义是： 送达被申请人日期
	 */
	@Column
	private String qzsqsdbsqrrq;

	/**
	 * @Description qzsqsqrcgrq的中文含义是： 申请人催告日期
	 */
	@Column
	private String qzsqsqrcgrq;

	/**
	 * @Description qzsqqzzznr的中文含义是： 强制执行内容
	 */
	@Column
	private String qzsqqzzznr;

	
		/**
	 * @Description xzcfqzzxsqsid的中文含义是： 行政处罚强制执行申请书ID
	 */
	public void setXzcfqzzxsqsid(String xzcfqzzxsqsid){ 
		this.xzcfqzzxsqsid = xzcfqzzxsqsid;
	}
	/**
	 * @Description xzcfqzzxsqsid的中文含义是： 行政处罚强制执行申请书ID
	 */
	public String getXzcfqzzxsqsid(){
		return xzcfqzzxsqsid;
	}
	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	public void setAjdjid(String ajdjid){ 
		this.ajdjid = ajdjid;
	}
	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	public String getAjdjid(){
		return ajdjid;
	}
	/**
	 * @Description qzsqwsbh的中文含义是： 文书编号
	 */
	public void setQzsqwsbh(String qzsqwsbh){ 
		this.qzsqwsbh = qzsqwsbh;
	}
	/**
	 * @Description qzsqwsbh的中文含义是： 文书编号
	 */
	public String getQzsqwsbh(){
		return qzsqwsbh;
	}
	/**
	 * @Description qzsqsqr的中文含义是： 申请人
	 */
	public void setQzsqsqr(String qzsqsqr){ 
		this.qzsqsqr = qzsqsqr;
	}
	/**
	 * @Description qzsqsqr的中文含义是： 申请人
	 */
	public String getQzsqsqr(){
		return qzsqsqr;
	}
	/**
	 * @Description qzsqsqrdz的中文含义是： 申请人地址
	 */
	public void setQzsqsqrdz(String qzsqsqrdz){ 
		this.qzsqsqrdz = qzsqsqrdz;
	}
	/**
	 * @Description qzsqsqrdz的中文含义是： 申请人地址
	 */
	public String getQzsqsqrdz(){
		return qzsqsqrdz;
	}
	/**
	 * @Description qzsqsqrlxr的中文含义是： 申请人联系人
	 */
	public void setQzsqsqrlxr(String qzsqsqrlxr){ 
		this.qzsqsqrlxr = qzsqsqrlxr;
	}
	/**
	 * @Description qzsqsqrlxr的中文含义是： 申请人联系人
	 */
	public String getQzsqsqrlxr(){
		return qzsqsqrlxr;
	}
	/**
	 * @Description qzsqsqrlxfs的中文含义是： 申请人联系方式
	 */
	public void setQzsqsqrlxfs(String qzsqsqrlxfs){ 
		this.qzsqsqrlxfs = qzsqsqrlxfs;
	}
	/**
	 * @Description qzsqsqrlxfs的中文含义是： 申请人联系方式
	 */
	public String getQzsqsqrlxfs(){
		return qzsqsqrlxfs;
	}
	/**
	 * @Description qzsqsqrfddbr的中文含义是： 申请人法定代表人
	 */
	public void setQzsqsqrfddbr(String qzsqsqrfddbr){ 
		this.qzsqsqrfddbr = qzsqsqrfddbr;
	}
	/**
	 * @Description qzsqsqrfddbr的中文含义是： 申请人法定代表人
	 */
	public String getQzsqsqrfddbr(){
		return qzsqsqrfddbr;
	}
	/**
	 * @Description qzsqsqrfddbrzw的中文含义是： 申请人法定代表人职务
	 */
	public void setQzsqsqrfddbrzw(String qzsqsqrfddbrzw){ 
		this.qzsqsqrfddbrzw = qzsqsqrfddbrzw;
	}
	/**
	 * @Description qzsqsqrfddbrzw的中文含义是： 申请人法定代表人职务
	 */
	public String getQzsqsqrfddbrzw(){
		return qzsqsqrfddbrzw;
	}
	/**
	 * @Description qzsqwtdlr的中文含义是： 委托代理人
	 */
	public void setQzsqwtdlr(String qzsqwtdlr){ 
		this.qzsqwtdlr = qzsqwtdlr;
	}
	/**
	 * @Description qzsqwtdlr的中文含义是： 委托代理人
	 */
	public String getQzsqwtdlr(){
		return qzsqwtdlr;
	}
	/**
	 * @Description qzsqwtdlrzw的中文含义是： 委托代理人职务
	 */
	public void setQzsqwtdlrzw(String qzsqwtdlrzw){ 
		this.qzsqwtdlrzw = qzsqwtdlrzw;
	}
	/**
	 * @Description qzsqwtdlrzw的中文含义是： 委托代理人职务
	 */
	public String getQzsqwtdlrzw(){
		return qzsqwtdlrzw;
	}
	/**
	 * @Description qzsqbsqr的中文含义是： 被申请人
	 */
	public void setQzsqbsqr(String qzsqbsqr){ 
		this.qzsqbsqr = qzsqbsqr;
	}
	/**
	 * @Description qzsqbsqr的中文含义是： 被申请人
	 */
	public String getQzsqbsqr(){
		return qzsqbsqr;
	}
	/**
	 * @Description qzsqbsqrfddbr的中文含义是： 被申请人法定代表人
	 */
	public void setQzsqbsqrfddbr(String qzsqbsqrfddbr){ 
		this.qzsqbsqrfddbr = qzsqbsqrfddbr;
	}
	/**
	 * @Description qzsqbsqrfddbr的中文含义是： 被申请人法定代表人
	 */
	public String getQzsqbsqrfddbr(){
		return qzsqbsqrfddbr;
	}
	/**
	 * @Description qzsqbsqrzw的中文含义是： 被申请人职务
	 */
	public void setQzsqbsqrzw(String qzsqbsqrzw){ 
		this.qzsqbsqrzw = qzsqbsqrzw;
	}
	/**
	 * @Description qzsqbsqrzw的中文含义是： 被申请人职务
	 */
	public String getQzsqbsqrzw(){
		return qzsqbsqrzw;
	}
	/**
	 * @Description qzsqbsqrlxdh的中文含义是： 被申请人联系电话
	 */
	public void setQzsqbsqrlxdh(String qzsqbsqrlxdh){ 
		this.qzsqbsqrlxdh = qzsqbsqrlxdh;
	}
	/**
	 * @Description qzsqbsqrlxdh的中文含义是： 被申请人联系电话
	 */
	public String getQzsqbsqrlxdh(){
		return qzsqbsqrlxdh;
	}
	/**
	 * @Description qzsqxzjgfzr的中文含义是： 行政机关负责人
	 */
	public void setQzsqxzjgfzr(String qzsqxzjgfzr){ 
		this.qzsqxzjgfzr = qzsqxzjgfzr;
	}
	/**
	 * @Description qzsqxzjgfzr的中文含义是： 行政机关负责人
	 */
	public String getQzsqxzjgfzr(){
		return qzsqxzjgfzr;
	}
	/**
	 * @Description qzsqgzrq的中文含义是： 盖章日期
	 */
	public void setQzsqgzrq(String qzsqgzrq){ 
		this.qzsqgzrq = qzsqgzrq;
	}
	/**
	 * @Description qzsqgzrq的中文含义是： 盖章日期
	 */
	public String getQzsqgzrq(){
		return qzsqgzrq;
	}
	/**
	 * @Description qzsqrmfymc的中文含义是： 人民法院名称
	 */
	public void setQzsqrmfymc(String qzsqrmfymc){ 
		this.qzsqrmfymc = qzsqrmfymc;
	}
	/**
	 * @Description qzsqrmfymc的中文含义是： 人民法院名称
	 */
	public String getQzsqrmfymc(){
		return qzsqrmfymc;
	}
	/**
	 * @Description qzsqsqrzcxzcfrq的中文含义是： 申请人做出行政处罚日期
	 */
	public void setQzsqsqrzcxzcfrq(String qzsqsqrzcxzcfrq){ 
		this.qzsqsqrzcxzcfrq = qzsqsqrzcxzcfrq;
	}
	/**
	 * @Description qzsqsqrzcxzcfrq的中文含义是： 申请人做出行政处罚日期
	 */
	public String getQzsqsqrzcxzcfrq(){
		return qzsqsqrzcxzcfrq;
	}
	/**
	 * @Description qzsqxzcfjdbh的中文含义是： 行政处罚决定编号
	 */
	public void setQzsqxzcfjdbh(String qzsqxzcfjdbh){ 
		this.qzsqxzcfjdbh = qzsqxzcfjdbh;
	}
	/**
	 * @Description qzsqxzcfjdbh的中文含义是： 行政处罚决定编号
	 */
	public String getQzsqxzcfjdbh(){
		return qzsqxzcfjdbh;
	}
	/**
	 * @Description qzsqsdbsqrrq的中文含义是： 送达被申请人日期
	 */
	public void setQzsqsdbsqrrq(String qzsqsdbsqrrq){ 
		this.qzsqsdbsqrrq = qzsqsdbsqrrq;
	}
	/**
	 * @Description qzsqsdbsqrrq的中文含义是： 送达被申请人日期
	 */
	public String getQzsqsdbsqrrq(){
		return qzsqsdbsqrrq;
	}
	/**
	 * @Description qzsqsqrcgrq的中文含义是： 申请人催告日期
	 */
	public void setQzsqsqrcgrq(String qzsqsqrcgrq){ 
		this.qzsqsqrcgrq = qzsqsqrcgrq;
	}
	/**
	 * @Description qzsqsqrcgrq的中文含义是： 申请人催告日期
	 */
	public String getQzsqsqrcgrq(){
		return qzsqsqrcgrq;
	}
	/**
	 * @Description qzsqqzzznr的中文含义是： 强制执行内容
	 */
	public void setQzsqqzzznr(String qzsqqzzznr){ 
		this.qzsqqzzznr = qzsqqzzznr;
	}
	/**
	 * @Description qzsqqzzznr的中文含义是： 强制执行内容
	 */
	public String getQzsqqzzznr(){
		return qzsqqzzznr;
	}

	
}