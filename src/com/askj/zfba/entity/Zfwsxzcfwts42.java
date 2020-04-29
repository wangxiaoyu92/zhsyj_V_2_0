package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  ZFWSXZCFWTS42的中文含义是: 行政处罚委托书42; InnoDB free: 2669568 kB
 * @Creation     2016/09/09 16:41:05
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSXZCFWTS42")
public class Zfwsxzcfwts42 {
	/**
	 * @Description xzcfwtsid的中文含义是： id
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_xzcfwtsid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_xzcfwtsid.nextval from dual"))
	private String xzcfwtsid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记id
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description zfwsbh的中文含义是： 执法文书编号
	 */
	@Column
	private String zfwsbh;

	/**
	 * @Description wtjg的中文含义是： 委托机关
	 */
	@Column
	private String wtjg;

	/**
	 * @Description wtjgfrdb的中文含义是： 委托机关法人代表
	 */
	@Column
	private String wtjgfrdb;

	/**
	 * @Description wtjgfrdbzw的中文含义是： 委托机关法人代表职务
	 */
	@Column
	private String wtjgfrdbzw;

	/**
	 * @Description wtjgfrdbdwdz的中文含义是： 委托机关法人代表单位地址
	 */
	@Column
	private String wtjgfrdbdwdz;

	/**
	 * @Description swtjg的中文含义是： 受委托机关
	 */
	@Column
	private String swtjg;

	/**
	 * @Description swtjgfrdb的中文含义是： 受委托机关法人代表
	 */
	@Column
	private String swtjgfrdb;

	/**
	 * @Description swtjgfrdbzw的中文含义是： 受委托机关法人代表职务
	 */
	@Column
	private String swtjgfrdbzw;

	/**
	 * @Description swtjgfrdbdwdz的中文含义是： 受委托机关法人代表单位地址
	 */
	@Column
	private String swtjgfrdbdwdz;

	/**
	 * @Description gjflfggd的中文含义是： 根据法律法规规定
	 */
	@Column
	private String gjflfggd;

	/**
	 * @Description jjmc的中文含义是： 经局名称
	 */
	@Column
	private String jjmc;

	/**
	 * @Description jdwmc的中文含义是： 经单位名称
	 */
	@Column
	private String jdwmc;

	/**
	 * @Description yjmc的中文含义是： 由局名称
	 */
	@Column
	private String yjmc;

	/**
	 * @Description wtdwmc的中文含义是： 委托单位名称
	 */
	@Column
	private String wtdwmc;

	/**
	 * @Description cfsxssfw的中文含义是： 处罚事项实施范围
	 */
	@Column
	private String cfsxssfw;

	/**
	 * @Description wtksrq的中文含义是： 委托开始日期
	 */
	@Column
	private String wtksrq;

	/**
	 * @Description wtjsrq的中文含义是： 委托结束日期
	 */
	@Column
	private String wtjsrq;

	/**
	 * @Description wtqjdwmc的中文含义是： 委托期间单位名称
	 */
	@Column
	private String wtqjdwmc;

	/**
	 * @Description wtqjyjmc的中文含义是： 委托期间以局名称
	 */
	@Column
	private String wtqjyjmc;

	/**
	 * @Description jsjjdmc的中文含义是： 接受局监督名称
	 */
	@Column
	private String jsjjdmc;

	/**
	 * @Description yjcdmc的中文含义是： 由局承担名称
	 */
	@Column
	private String yjcdmc;

	/**
	 * @Description wtdw的中文含义是： 委托单位
	 */
	@Column
	private String wtdw;

	/**
	 * @Description wtjgdbrqz的中文含义是： 委托机关代表人签字
	 */
	@Column
	private String wtjgdbrqz;

	/**
	 * @Description wtjgdbrqzrq的中文含义是： 委托机关代表人签字日期
	 */
	@Column
	private String wtjgdbrqzrq;

	/**
	 * @Description swtjgdbrqz的中文含义是： 受委托机关代表人签字
	 */
	@Column
	private String swtjgdbrqz;

	/**
	 * @Description swtjgdbrqzrq的中文含义是： 受委托机关代表人签字日期
	 */
	@Column
	private String swtjgdbrqzrq;

	
		/**
	 * @Description xzcfwtsid的中文含义是： id
	 */
	public void setXzcfwtsid(String xzcfwtsid){ 
		this.xzcfwtsid = xzcfwtsid;
	}
	/**
	 * @Description xzcfwtsid的中文含义是： id
	 */
	public String getXzcfwtsid(){
		return xzcfwtsid;
	}
	/**
	 * @Description ajdjid的中文含义是： 案件登记id
	 */
	public void setAjdjid(String ajdjid){ 
		this.ajdjid = ajdjid;
	}
	/**
	 * @Description ajdjid的中文含义是： 案件登记id
	 */
	public String getAjdjid(){
		return ajdjid;
	}
	/**
	 * @Description zfwsbh的中文含义是： 执法文书编号
	 */
	public void setZfwsbh(String zfwsbh){ 
		this.zfwsbh = zfwsbh;
	}
	/**
	 * @Description zfwsbh的中文含义是： 执法文书编号
	 */
	public String getZfwsbh(){
		return zfwsbh;
	}
	/**
	 * @Description wtjg的中文含义是： 委托机关
	 */
	public void setWtjg(String wtjg){ 
		this.wtjg = wtjg;
	}
	/**
	 * @Description wtjg的中文含义是： 委托机关
	 */
	public String getWtjg(){
		return wtjg;
	}
	/**
	 * @Description wtjgfrdb的中文含义是： 委托机关法人代表
	 */
	public void setWtjgfrdb(String wtjgfrdb){ 
		this.wtjgfrdb = wtjgfrdb;
	}
	/**
	 * @Description wtjgfrdb的中文含义是： 委托机关法人代表
	 */
	public String getWtjgfrdb(){
		return wtjgfrdb;
	}
	/**
	 * @Description wtjgfrdbzw的中文含义是： 委托机关法人代表职务
	 */
	public void setWtjgfrdbzw(String wtjgfrdbzw){ 
		this.wtjgfrdbzw = wtjgfrdbzw;
	}
	/**
	 * @Description wtjgfrdbzw的中文含义是： 委托机关法人代表职务
	 */
	public String getWtjgfrdbzw(){
		return wtjgfrdbzw;
	}
	/**
	 * @Description wtjgfrdbdwdz的中文含义是： 委托机关法人代表单位地址
	 */
	public void setWtjgfrdbdwdz(String wtjgfrdbdwdz){ 
		this.wtjgfrdbdwdz = wtjgfrdbdwdz;
	}
	/**
	 * @Description wtjgfrdbdwdz的中文含义是： 委托机关法人代表单位地址
	 */
	public String getWtjgfrdbdwdz(){
		return wtjgfrdbdwdz;
	}
	/**
	 * @Description swtjg的中文含义是： 受委托机关
	 */
	public void setSwtjg(String swtjg){ 
		this.swtjg = swtjg;
	}
	/**
	 * @Description swtjg的中文含义是： 受委托机关
	 */
	public String getSwtjg(){
		return swtjg;
	}
	/**
	 * @Description swtjgfrdb的中文含义是： 受委托机关法人代表
	 */
	public void setSwtjgfrdb(String swtjgfrdb){ 
		this.swtjgfrdb = swtjgfrdb;
	}
	/**
	 * @Description swtjgfrdb的中文含义是： 受委托机关法人代表
	 */
	public String getSwtjgfrdb(){
		return swtjgfrdb;
	}
	/**
	 * @Description swtjgfrdbzw的中文含义是： 受委托机关法人代表职务
	 */
	public void setSwtjgfrdbzw(String swtjgfrdbzw){ 
		this.swtjgfrdbzw = swtjgfrdbzw;
	}
	/**
	 * @Description swtjgfrdbzw的中文含义是： 受委托机关法人代表职务
	 */
	public String getSwtjgfrdbzw(){
		return swtjgfrdbzw;
	}
	/**
	 * @Description swtjgfrdbdwdz的中文含义是： 受委托机关法人代表单位地址
	 */
	public void setSwtjgfrdbdwdz(String swtjgfrdbdwdz){ 
		this.swtjgfrdbdwdz = swtjgfrdbdwdz;
	}
	/**
	 * @Description swtjgfrdbdwdz的中文含义是： 受委托机关法人代表单位地址
	 */
	public String getSwtjgfrdbdwdz(){
		return swtjgfrdbdwdz;
	}
	/**
	 * @Description gjflfggd的中文含义是： 根据法律法规规定
	 */
	public void setGjflfggd(String gjflfggd){ 
		this.gjflfggd = gjflfggd;
	}
	/**
	 * @Description gjflfggd的中文含义是： 根据法律法规规定
	 */
	public String getGjflfggd(){
		return gjflfggd;
	}
	/**
	 * @Description jjmc的中文含义是： 经局名称
	 */
	public void setJjmc(String jjmc){ 
		this.jjmc = jjmc;
	}
	/**
	 * @Description jjmc的中文含义是： 经局名称
	 */
	public String getJjmc(){
		return jjmc;
	}
	/**
	 * @Description jdwmc的中文含义是： 经单位名称
	 */
	public void setJdwmc(String jdwmc){ 
		this.jdwmc = jdwmc;
	}
	/**
	 * @Description jdwmc的中文含义是： 经单位名称
	 */
	public String getJdwmc(){
		return jdwmc;
	}
	/**
	 * @Description yjmc的中文含义是： 由局名称
	 */
	public void setYjmc(String yjmc){ 
		this.yjmc = yjmc;
	}
	/**
	 * @Description yjmc的中文含义是： 由局名称
	 */
	public String getYjmc(){
		return yjmc;
	}
	/**
	 * @Description wtdwmc的中文含义是： 委托单位名称
	 */
	public void setWtdwmc(String wtdwmc){ 
		this.wtdwmc = wtdwmc;
	}
	/**
	 * @Description wtdwmc的中文含义是： 委托单位名称
	 */
	public String getWtdwmc(){
		return wtdwmc;
	}
	/**
	 * @Description cfsxssfw的中文含义是： 处罚事项实施范围
	 */
	public void setCfsxssfw(String cfsxssfw){ 
		this.cfsxssfw = cfsxssfw;
	}
	/**
	 * @Description cfsxssfw的中文含义是： 处罚事项实施范围
	 */
	public String getCfsxssfw(){
		return cfsxssfw;
	}
	/**
	 * @Description wtksrq的中文含义是： 委托开始日期
	 */
	public void setWtksrq(String wtksrq){ 
		this.wtksrq = wtksrq;
	}
	/**
	 * @Description wtksrq的中文含义是： 委托开始日期
	 */
	public String getWtksrq(){
		return wtksrq;
	}
	/**
	 * @Description wtjsrq的中文含义是： 委托结束日期
	 */
	public void setWtjsrq(String wtjsrq){ 
		this.wtjsrq = wtjsrq;
	}
	/**
	 * @Description wtjsrq的中文含义是： 委托结束日期
	 */
	public String getWtjsrq(){
		return wtjsrq;
	}
	/**
	 * @Description wtqjdwmc的中文含义是： 委托期间单位名称
	 */
	public void setWtqjdwmc(String wtqjdwmc){ 
		this.wtqjdwmc = wtqjdwmc;
	}
	/**
	 * @Description wtqjdwmc的中文含义是： 委托期间单位名称
	 */
	public String getWtqjdwmc(){
		return wtqjdwmc;
	}
	/**
	 * @Description wtqjyjmc的中文含义是： 委托期间以局名称
	 */
	public void setWtqjyjmc(String wtqjyjmc){ 
		this.wtqjyjmc = wtqjyjmc;
	}
	/**
	 * @Description wtqjyjmc的中文含义是： 委托期间以局名称
	 */
	public String getWtqjyjmc(){
		return wtqjyjmc;
	}
	/**
	 * @Description jsjjdmc的中文含义是： 接受局监督名称
	 */
	public void setJsjjdmc(String jsjjdmc){ 
		this.jsjjdmc = jsjjdmc;
	}
	/**
	 * @Description jsjjdmc的中文含义是： 接受局监督名称
	 */
	public String getJsjjdmc(){
		return jsjjdmc;
	}
	/**
	 * @Description yjcdmc的中文含义是： 由局承担名称
	 */
	public void setYjcdmc(String yjcdmc){ 
		this.yjcdmc = yjcdmc;
	}
	/**
	 * @Description yjcdmc的中文含义是： 由局承担名称
	 */
	public String getYjcdmc(){
		return yjcdmc;
	}
	/**
	 * @Description wtdw的中文含义是： 委托单位
	 */
	public void setWtdw(String wtdw){ 
		this.wtdw = wtdw;
	}
	/**
	 * @Description wtdw的中文含义是： 委托单位
	 */
	public String getWtdw(){
		return wtdw;
	}
	/**
	 * @Description wtjgdbrqz的中文含义是： 委托机关代表人签字
	 */
	public void setWtjgdbrqz(String wtjgdbrqz){ 
		this.wtjgdbrqz = wtjgdbrqz;
	}
	/**
	 * @Description wtjgdbrqz的中文含义是： 委托机关代表人签字
	 */
	public String getWtjgdbrqz(){
		return wtjgdbrqz;
	}
	/**
	 * @Description wtjgdbrqzrq的中文含义是： 委托机关代表人签字日期
	 */
	public void setWtjgdbrqzrq(String wtjgdbrqzrq){ 
		this.wtjgdbrqzrq = wtjgdbrqzrq;
	}
	/**
	 * @Description wtjgdbrqzrq的中文含义是： 委托机关代表人签字日期
	 */
	public String getWtjgdbrqzrq(){
		return wtjgdbrqzrq;
	}
	/**
	 * @Description swtjgdbrqz的中文含义是： 受委托机关代表人签字
	 */
	public void setSwtjgdbrqz(String swtjgdbrqz){ 
		this.swtjgdbrqz = swtjgdbrqz;
	}
	/**
	 * @Description swtjgdbrqz的中文含义是： 受委托机关代表人签字
	 */
	public String getSwtjgdbrqz(){
		return swtjgdbrqz;
	}
	/**
	 * @Description swtjgdbrqzrq的中文含义是： 受委托机关代表人签字日期
	 */
	public void setSwtjgdbrqzrq(String swtjgdbrqzrq){ 
		this.swtjgdbrqzrq = swtjgdbrqzrq;
	}
	/**
	 * @Description swtjgdbrqzrq的中文含义是： 受委托机关代表人签字日期
	 */
	public String getSwtjgdbrqzrq(){
		return swtjgdbrqzrq;
	}

	
}