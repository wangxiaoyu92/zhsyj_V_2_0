package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;
/**
 * @Description  ZFWSMSWPCLQD31的中文含义是: 没收物品处理清单31; InnoDB free: 2721792 kB
 * @Creation     2016/06/20 10:11:00
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSMSWPCLQD31")
public class Zfwsmswpclqd31 {
	
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
	 * @Description mswpclqdid的中文含义是： 没收物品处理清单ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_mswpclqdid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_mswpclqdid.nextval from dual"))
	private String mswpclqdid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description msclwsbh的中文含义是： 文书编号
	 */
	@Column
	private String msclwsbh;

	/**
	 * @Description msclzxczdw的中文含义是： 执行处置单位
	 */
	@Column
	private String msclzxczdw;

	/**
	 * @Description msclczdwdz的中文含义是： 处置单位地址
	 */
	@Column
	private String msclczdwdz;

	/**
	 * @Description msclczdwdh的中文含义是： 处置单位电话
	 */
	@Column
	private String msclczdwdh;

	/**
	 * @Description mscltycjr的中文含义是： 特邀参加人
	 */
	@Column
	private String mscltycjr;

	/**
	 * @Description mscltycjrrq的中文含义是： 特邀参加人签字日期
	 */
	@Column
	private String mscltycjrrq;

	/**
	 * @Description msclcbr的中文含义是： 承办人1
	 */
	@Column
	private String msclcbr;

	/**
	 * @Description msclcbrrq的中文含义是： 承办人签字日期
	 */
	@Column
	private String msclcbrrq;

	/**
	 * @Description msclxzcfjdsbh的中文含义是： 行政处罚决定书编号
	 */
	@Column
	private String msclxzcfjdsbh;

	/**
	 * @Description mscldsr的中文含义是： 当事人
	 */
	@Column
	private String mscldsr;

	/**
	 * @Description mscldsrdz的中文含义是： 当事人地址
	 */
	@Column
	private String mscldsrdz;

	/**
	 * @Description mscldsrdh的中文含义是： 当事人电话
	 */
	@Column
	private String mscldsrdh;

	/**
	 * @Description msclcbr2的中文含义是： 承办人2
	 */
	@Column
	private String msclcbr2;

	
		/**
	 * @Description mswpclqdid的中文含义是： 没收物品处理清单ID
	 */
	public void setMswpclqdid(String mswpclqdid){ 
		this.mswpclqdid = mswpclqdid;
	}
	/**
	 * @Description mswpclqdid的中文含义是： 没收物品处理清单ID
	 */
	public String getMswpclqdid(){
		return mswpclqdid;
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
	 * @Description msclwsbh的中文含义是： 文书编号
	 */
	public void setMsclwsbh(String msclwsbh){ 
		this.msclwsbh = msclwsbh;
	}
	/**
	 * @Description msclwsbh的中文含义是： 文书编号
	 */
	public String getMsclwsbh(){
		return msclwsbh;
	}
	/**
	 * @Description msclzxczdw的中文含义是： 执行处置单位
	 */
	public void setMsclzxczdw(String msclzxczdw){ 
		this.msclzxczdw = msclzxczdw;
	}
	/**
	 * @Description msclzxczdw的中文含义是： 执行处置单位
	 */
	public String getMsclzxczdw(){
		return msclzxczdw;
	}
	/**
	 * @Description msclczdwdz的中文含义是： 处置单位地址
	 */
	public void setMsclczdwdz(String msclczdwdz){ 
		this.msclczdwdz = msclczdwdz;
	}
	/**
	 * @Description msclczdwdz的中文含义是： 处置单位地址
	 */
	public String getMsclczdwdz(){
		return msclczdwdz;
	}
	/**
	 * @Description msclczdwdh的中文含义是： 处置单位电话
	 */
	public void setMsclczdwdh(String msclczdwdh){ 
		this.msclczdwdh = msclczdwdh;
	}
	/**
	 * @Description msclczdwdh的中文含义是： 处置单位电话
	 */
	public String getMsclczdwdh(){
		return msclczdwdh;
	}
	/**
	 * @Description mscltycjr的中文含义是： 特邀参加人
	 */
	public void setMscltycjr(String mscltycjr){ 
		this.mscltycjr = mscltycjr;
	}
	/**
	 * @Description mscltycjr的中文含义是： 特邀参加人
	 */
	public String getMscltycjr(){
		return mscltycjr;
	}
	/**
	 * @Description mscltycjrrq的中文含义是： 特邀参加人签字日期
	 */
	public void setMscltycjrrq(String mscltycjrrq){ 
		this.mscltycjrrq = mscltycjrrq;
	}
	/**
	 * @Description mscltycjrrq的中文含义是： 特邀参加人签字日期
	 */
	public String getMscltycjrrq(){
		return mscltycjrrq;
	}
	/**
	 * @Description msclcbr的中文含义是： 承办人1
	 */
	public void setMsclcbr(String msclcbr){ 
		this.msclcbr = msclcbr;
	}
	/**
	 * @Description msclcbr的中文含义是： 承办人1
	 */
	public String getMsclcbr(){
		return msclcbr;
	}
	/**
	 * @Description msclcbrrq的中文含义是： 承办人签字日期
	 */
	public void setMsclcbrrq(String msclcbrrq){ 
		this.msclcbrrq = msclcbrrq;
	}
	/**
	 * @Description msclcbrrq的中文含义是： 承办人签字日期
	 */
	public String getMsclcbrrq(){
		return msclcbrrq;
	}
	/**
	 * @Description msclxzcfjdsbh的中文含义是： 行政处罚决定书编号
	 */
	public void setMsclxzcfjdsbh(String msclxzcfjdsbh){ 
		this.msclxzcfjdsbh = msclxzcfjdsbh;
	}
	/**
	 * @Description msclxzcfjdsbh的中文含义是： 行政处罚决定书编号
	 */
	public String getMsclxzcfjdsbh(){
		return msclxzcfjdsbh;
	}
	/**
	 * @Description mscldsr的中文含义是： 当事人
	 */
	public void setMscldsr(String mscldsr){ 
		this.mscldsr = mscldsr;
	}
	/**
	 * @Description mscldsr的中文含义是： 当事人
	 */
	public String getMscldsr(){
		return mscldsr;
	}
	/**
	 * @Description mscldsrdz的中文含义是： 当事人地址
	 */
	public void setMscldsrdz(String mscldsrdz){ 
		this.mscldsrdz = mscldsrdz;
	}
	/**
	 * @Description mscldsrdz的中文含义是： 当事人地址
	 */
	public String getMscldsrdz(){
		return mscldsrdz;
	}
	/**
	 * @Description mscldsrdh的中文含义是： 当事人电话
	 */
	public void setMscldsrdh(String mscldsrdh){ 
		this.mscldsrdh = mscldsrdh;
	}
	/**
	 * @Description mscldsrdh的中文含义是： 当事人电话
	 */
	public String getMscldsrdh(){
		return mscldsrdh;
	}
	/**
	 * @Description msclcbr2的中文含义是： 承办人2
	 */
	public void setMsclcbr2(String msclcbr2){ 
		this.msclcbr2 = msclcbr2;
	}
	/**
	 * @Description msclcbr2的中文含义是： 承办人2
	 */
	public String getMsclcbr2(){
		return msclcbr2;
	}

	
}