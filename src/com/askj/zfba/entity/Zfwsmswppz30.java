package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  ZFWSMSWPPZ30的中文含义是: 没收物品凭证; InnoDB free: 2726912 kB
 * @Creation     2016/06/13 17:04:52
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSMSWPPZ30")
public class Zfwsmswppz30 {
	
	
	/**
	 * @Description mswppzid的中文含义是： 没收物品凭证ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_mswppzid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_mswppzid.nextval from dual"))
	private String mswppzid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description mspzwsbh的中文含义是： 文书编号
	 */
	@Column
	private String mspzwsbh;

	/**
	 * @Description mspzgzrq的中文含义是： 盖章日期
	 */
	@Column
	private String mspzgzrq;

	/**
	 * @Description cfjdwsbh的中文含义是： 处罚决定文书编号(行政处罚决定书中的编号)
	 */
	@Column
	private String cfjdwsbh;

	/**
	 * @Description ajdjay的中文含义是： 案由
	 */
	@Column
	private String ajdjay;

	/**
	 * @Description mswpdsr的中文含义是： 当事人
	 */
	@Column
	private String mswpdsr;

	/**
	 * @Description mswpdz的中文含义是： 地址
	 */
	@Column
	private String mswpdz;

	/**
	 * @Description mswpzxjg的中文含义是： 没收物品执行机关
	 */
	@Column
	private String mswpzxjg;

	/**
	 * @Description mswpfj的中文含义是： 附件
	 */
	@Column
	private String mswpfj;

	/**
	 * @Description qzzzrmfy的中文含义是： 强制执行人民法院
	 */
	@Column
	private String qzzzrmfy;
	
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
	 * @Description mswppzid的中文含义是： 没收物品凭证ID
	 */
	public void setMswppzid(String mswppzid){ 
		this.mswppzid = mswppzid;
	}
	/**
	 * @Description mswppzid的中文含义是： 没收物品凭证ID
	 */
	public String getMswppzid(){
		return mswppzid;
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
	 * @Description mspzwsbh的中文含义是： 文书编号
	 */
	public void setMspzwsbh(String mspzwsbh){ 
		this.mspzwsbh = mspzwsbh;
	}
	/**
	 * @Description mspzwsbh的中文含义是： 文书编号
	 */
	public String getMspzwsbh(){
		return mspzwsbh;
	}
	/**
	 * @Description mspzgzrq的中文含义是： 盖章日期
	 */
	public void setMspzgzrq(String mspzgzrq){ 
		this.mspzgzrq = mspzgzrq;
	}
	/**
	 * @Description mspzgzrq的中文含义是： 盖章日期
	 */
	public String getMspzgzrq(){
		return mspzgzrq;
	}
	/**
	 * @Description cfjdwsbh的中文含义是： 处罚决定文书编号(行政处罚决定书中的编号)
	 */
	public void setCfjdwsbh(String cfjdwsbh){ 
		this.cfjdwsbh = cfjdwsbh;
	}
	/**
	 * @Description cfjdwsbh的中文含义是： 处罚决定文书编号(行政处罚决定书中的编号)
	 */
	public String getCfjdwsbh(){
		return cfjdwsbh;
	}
	/**
	 * @Description ajdjay的中文含义是： 案由
	 */
	public void setAjdjay(String ajdjay){ 
		this.ajdjay = ajdjay;
	}
	/**
	 * @Description ajdjay的中文含义是： 案由
	 */
	public String getAjdjay(){
		return ajdjay;
	}
	/**
	 * @Description mswpdsr的中文含义是： 当事人
	 */
	public void setMswpdsr(String mswpdsr){ 
		this.mswpdsr = mswpdsr;
	}
	/**
	 * @Description mswpdsr的中文含义是： 当事人
	 */
	public String getMswpdsr(){
		return mswpdsr;
	}
	/**
	 * @Description mswpdz的中文含义是： 地址
	 */
	public void setMswpdz(String mswpdz){ 
		this.mswpdz = mswpdz;
	}
	/**
	 * @Description mswpdz的中文含义是： 地址
	 */
	public String getMswpdz(){
		return mswpdz;
	}
	/**
	 * @Description mswpzxjg的中文含义是： 没收物品执行机关
	 */
	public void setMswpzxjg(String mswpzxjg){ 
		this.mswpzxjg = mswpzxjg;
	}
	/**
	 * @Description mswpzxjg的中文含义是： 没收物品执行机关
	 */
	public String getMswpzxjg(){
		return mswpzxjg;
	}
	/**
	 * @Description mswpfj的中文含义是： 附件
	 */
	public void setMswpfj(String mswpfj){ 
		this.mswpfj = mswpfj;
	}
	/**
	 * @Description mswpfj的中文含义是： 附件
	 */
	public String getMswpfj(){
		return mswpfj;
	}
	/**
	 * @Description qzzzrmfy的中文含义是： 强制执行人民法院
	 */
	public void setQzzzrmfy(String qzzzrmfy){ 
		this.qzzzrmfy = qzzzrmfy;
	}
	/**
	 * @Description qzzzrmfy的中文含义是： 强制执行人民法院
	 */
	public String getQzzzrmfy(){
		return qzzzrmfy;
	}

	
}